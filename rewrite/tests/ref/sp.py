# SPDX-License-Identifier: AGPL-3.0-or-later
"""Доступ в DTI по расписанию (802.11-2020): правила SP (10.39.6.2) — кто передаёт, источник начинает обмен в начале
SP, Heartbeat (DMG Control первым кадром), BF в начале SP по Beamforming Training (10.39.6.2, 9.5.5, 10.42), конец
обмена до конца SP, повтор источника через PIFS, PCP Active = 0, LP SC только в SP с LP SC Used (10.39.4), уступка
остатка SP Grant-ом с обменом ролей (10.39.6.2, 10.39.7.3); восстановление SP (10.39.6.7, dot11SPIdleTimeout);
усечение SP (10.39.8.1: CF-End к AP, широковещательный Grant с CBAP, CF-End пиру, только в Truncatable SP, только
источник); продление SP (10.39.9: SPR в Extendable SP, ответ AP Grant-ом, пересылка партнёру, условие следующего SP
broadcast/broadcast; продление SP своим Grant-ом AP-источника); доступ в CBAP-распределениях расписания (10.39.5:
кто начинает обмен, конец обмена до конца CBAP) — не только CBAP Only.

check_dti — судья журнала одного BI: расписание (schedule.Entry) → периоды (bi.layout) → правила SP/CBAP этого модуля
+ динамическое распределение (dynalloc.check_dyn_log) с обменом окнами: время, возвращённое усечением, — AP для PP/GP;
окна Grant — допуск передач в SP. Генераторы: sp_exchange (обмен источника в SP по правилам), truncation_cf_end,
truncation_grant, extension.

Reverse direction (10.29) у нас выключен намеренно (PLAN.md, COVERAGE.md): RD-ответ получателя в SP (исключение
10.39.6.2) не моделируется — ответы получателя допускаются только как ответы через SIFS.

Не моделируется: DMG protected period (10.39.6.6, DTS), MMSL-кластеры, CMMG/CDMG (10.39.8.2), spatial sharing; число
SSW в RXSS по RXSS Length (СПОРНО: чьи приёмные секторы считает поле в расписании — не проверяется)."""
from fractions import Fraction as Fr

from . import bi as BI
from . import duration as D
from . import dynalloc as DA
from . import fields as F
from .cbap import Violation
from .schedule import BF_NONE, CBAP, events, SP
from .timing import (AID_AP_PCP, AID_BROADCAST, ALLOC_CBAP, ALLOC_SP, BCAST, DOT11_SP_IDLE_TIMEOUT, MBIFS, PIFS,
                     SIFS, SIFS_TOL)

T_CF_END = D.tx('cf_end')
# 20.6: DMG low-power SC — MCS 25…31 (табл. 20-23)
LP_SC_MCS = frozenset(range(25, 32))
BF_KINDS = frozenset({'SSW', 'SSW-Feedback', 'SSW-Ack', 'BRP'})
# Кадры, после которых источник ждёт ответ (повтор — PIFS, 10.39.6.2)
ELICIT = frozenset({'RTS', 'Data', 'A-MPDU', 'BlockAckReq', 'Mgmt', 'Action', 'Probe Request', 'Association Request',
                    'Association Response', 'Reassociation Request', 'Reassociation Response', 'Authentication',
                    'Disassociation', 'Deauthentication', 'Poll', 'SPR', 'EAPOL'})
RESPONSES = frozenset({'Ack', 'BlockAck', 'DMG CTS', 'Grant Ack', 'SSW-Feedback', 'SSW-Ack', 'SPR'})


class SpState:
    """Состояние одного SP по журналу: src/dst — текущие роли (меняются уступкой Grant-ом с BT = 0), end — конец SP
    (с продлением), released — момент, с которого остаток возвращён AP (усечение/восстановление), cbap — окно CBAP из
    широковещательного Grant усечения, ended — пара закончила SP CF-End-ом."""
    def __init__(self, p, src, dst):
        self.p, self.src, self.dst, self.end = p, src, dst, p.end
        self.pair = {src, dst} - {None}
        self.released, self.cbap, self.ended, self.ext = None, None, None, Fr(0)
        self.first_src = None
        self.ext_window = None
        self.advertised = False                    # усечение объявлено AP (CF-End к AP / Grant broadcast) в Truncatable


def _following_sp(periods, p):
    nx = [x for x in periods if x.kind == SP and x.start >= p.end]
    return min(nx, key=lambda x: x.start) if nx else None


def _bcast_sp(p):
    return p is not None and p.kind == SP and p.src_aid == AID_BROADCAST and p.dst_aid == AID_BROADCAST


def _resp_to(ev, j, sifs_tol, q):
    """ev[j] — ответ через SIFS на предыдущий кадр, адресованный передатчику ev[j]."""
    r = ev[j]
    prev = [y for y in ev[:j] if y['te'] <= r['ts'] + q]
    if not prev:
        return None
    p = max(prev, key=lambda y: y['te'])
    if p['dst'] == r['src'] and SIFS - q <= r['ts'] - p['te'] <= SIFS + sifs_tol + q:
        return p
    return None


def _answers_poll(ev, j, ap, q):
    """SPR ev[j] — ответ на Poll AP к его передатчику (через Response Offset, 10.39.7.2, или SIFS в ATI)."""
    r = ev[j]
    for y in reversed(ev[max(0, j - 40):j]):
        if y['kind'] == 'Poll' and y['src'] == ap and y['dst'] == r['src']:
            ro = y['frame'].response_offset if y['frame'] is not None else None
            return ro is None or r['ts'] - y['te'] <= ro + 2 * SIFS + q
    return False


def check_sp(ev, p, bfc, mac_of, ap, caps, periods, sifs_tol=SIFS_TOL, q=0, idle_timeout=DOT11_SP_IDLE_TIMEOUT):
    """Правила одного SP с индивидуальным Source AID (ev — schedule.events всего BI). → (нарушения, SpState).

    rule:
      'sp_first_src'   — первый кадр SP не от источника (10.39.6.2: «shall initiate the frame exchange … at the start
                         of the SP»), кроме восстановления/усечения получателем после dot11SPIdleTimeout (10.39.6.7,
                         10.39.8.1);
      'sp_heartbeat'   — первый кадр источника к получателю (получателя к источнику) не DMG Control при Heartbeat = 1
                         у адресата (10.39.6.2);
      'sp_bf'          — Beamforming Training = 1: первый кадр источника не SSW ISS (Direction 0), первый кадр
                         получателя не SSW RSS (Direction 1) (10.39.6.2, 9.5.5, 10.42.2);
      'sp_end'         — кадр кончается после конца SP (с продлением) (10.39.6.2: «In no case … beyond the end»);
      'sp_retx'        — повтор источника раньше PIFS после кадра без ответа (10.39.6.2), кроме BF-кадров;
      'sp_lp_sc'       — MCS low-power SC в SP с LP SC Used = 0 (10.39.4);
      'sp_relinquish'  — Grant уступки: DAI (Source AID = получатель, Destination AID = источник, SP, 32 768) или
                         Duration ≠ остаток − TXTIME(Grant) − aSIFSTime (10.39.7.3, 9.5.2);
      'sp_trunc'       — усечение (CF-End к AP / Grant broadcast) в SP с Truncatable = 0 или не источником; Grant
                         усечения: DAI не broadcast/broadcast CBAP, Duration (10.39.8.1), Allocation Duration >
                         остаток − Duration; после него нет CF-End пиру;
      'sp_after_trunc' — передача пары после усечения/CF-End вне выделенного (10.39.8.1);
      'sp_recovery'    — AP-получатель начинает передачи в SP раньше dot11SPIdleTimeout или в неусекаемом SP
                         (10.39.6.7);
      'sp_ext'         — SPR в SP: не Extendable (кроме ответа на Poll), не от источника/получателя, не к AP,
                         Duration ≠ остаток SP (10.39.9, 9.3.1.11);
      'sp_ext_grant'   — ответ AP: не через SIFS, RA ≠ TA SPR, Duration ≠ SPR − SIFS − TXTIME(Grant), грант > 0 при
                         следующем SP не broadcast/broadcast или не длиннее запрошенного; пересылка партнёру —
                         не через SIFS, Duration, Allocation Duration (10.39.9);
      'sp_ap_ext'      — продление AP-источником: Duration ≠ остаток SP; продлённое перекрывает SP с индивидуальным
                         AID (10.39.9)."""
    out = []
    a = p.alloc
    src, dst = mac_of.get(p.src_aid), (mac_of.get(p.dst_aid) if p.dst_aid != AID_BROADCAST else None)
    st = SpState(p, src, dst)
    caps = caps or {}
    bfc = bfc or BF_NONE

    def v(r, rule, msg):
        out.append(Violation(r['i'], rule, msg))

    idx = [j for j, r in enumerate(ev) if p.start <= r['ts'] < p.end + 40000]
    first = True
    first_by = {}
    expect_peer_cf_end = None
    j_pos = 0
    while j_pos < len(idx):
        j = idx[j_pos]
        j_pos += 1
        r = ev[j]
        if r['ts'] >= st.end + q:
            break
        x, kind, f = r['src'], r['kind'], r['frame']
        resp = _resp_to(ev, j, sifs_tol, q)
        in_cbap = st.cbap is not None and st.cbap.has(r['ts'])
        if in_cbap:
            continue                                   # CBAP после усечения — правила 10.39.5 (любая STA)
        if st.released is not None and r['ts'] >= st.released and x == ap:
            continue                                   # возвращённое время — AP (dynalloc)
        if x not in st.pair:
            continue                                   # чужой — правило sp_foreign (check_dti)
        # ---- первый кадр SP
        if first:
            first = False
            late = r['ts'] - p.start >= idle_timeout - q
            if x == st.src:
                st.first_src = r['ts']
            elif x == ap and ap == st.dst:
                if not late:
                    v(r, 'sp_recovery', f'AP-получатель передаёт через {float(r["ts"] - p.start)} мкс от начала SP < '
                                        f'dot11SPIdleTimeout {float(idle_timeout)} (10.39.6.7)')
                elif not a.truncatable:
                    v(r, 'sp_recovery', 'AP-получатель забирает неусекаемый SP (10.39.6.7: «provided that it was a '
                                        'truncatable SP»)')
                st.released = r['ts']
                continue
            elif x == st.dst and late and kind == 'CF-End' and r['dst'] == ap:
                pass                                   # 10.39.8.1: усечение получателем без кадров источника
            else:
                v(r, 'sp_first_src', f'первый кадр SP {kind} от получателя {x}, не от источника {st.src} (10.39.6.2)')
        # ---- первый кадр к партнёру: Heartbeat, BF
        peer = st.dst if x == st.src else st.src
        if x not in first_by and r['dst'] == peer:
            first_by[x] = r
            hb = caps.get(peer, {}).get('heartbeat')
            if hb and r['mcs'] is not None and r['mcs'] != 0:
                v(r, 'sp_heartbeat', f'первый кадр {x} к {peer} на MCS {r["mcs"]}, у адресата Heartbeat = 1 '
                                     f'(10.39.6.2: DMG Control первым)')
            if bfc.bt and st.ext == 0:
                want = 0 if x == src else 1
                if kind != 'SSW' or (r['direction'] is not None and r['direction'] != want):
                    v(r, 'sp_bf', f'Beamforming Training = 1: первый кадр {"источника" if x == src else "получателя"}'
                                  f' {kind} (direction {r["direction"]}) — ждали SSW {"ISS" if want == 0 else "RSS"} '
                                  f'(10.39.6.2, 10.42.2)')
        # ---- конец SP, LP SC
        if r['te'] > st.end + q:
            v(r, 'sp_end', f'{kind} {x} кончается в {float(r["te"])} > конца SP {float(st.end)} (10.39.6.2)')
        if r['mcs'] in LP_SC_MCS and not a.lp_sc:
            v(r, 'sp_lp_sc', f'MCS {r["mcs"]} (low-power SC) в SP с LP SC Used = 0 (10.39.4)')
        # ---- после усечения / CF-End
        if st.ended is not None and r['ts'] >= st.ended and kind != 'CF-End' and resp is None:
            v(r, 'sp_after_trunc', f'{kind} {x} после усечения SP в {float(st.ended)} (10.39.8.1)')
        # ---- повтор через PIFS
        if x == st.src and kind not in BF_KINDS:
            prev = [y for y in ev[:j] if y['te'] <= r['ts'] + q]
            if prev:
                pr = max(prev, key=lambda y: y['te'])
                if pr['src'] == x and pr['kind'] in ELICIT and not pr['noack'] and pr['dst'] == peer and \
                        r['ts'] - pr['te'] < PIFS - q:
                    v(r, 'sp_retx', f'{kind} источника через {float(r["ts"] - pr["te"])} мкс после {pr["kind"]} без '
                                    f'ответа (< PIFS, 10.39.6.2)')
        # ---- Grant
        if kind == 'Grant' and f is not None:
            d = f.dai
            if r['dst'] in (BCAST, None):
                # 10.39.8.1: усечение с CBAP. СПОРНО: Duration — с ответным CF-End или без («if required»): оба
                if not a.truncatable:
                    v(r, 'sp_trunc', 'Grant усечения в SP с Truncatable = 0 (10.39.8.1)')
                if x != src and not (x == dst and st.first_src is None):
                    v(r, 'sp_trunc', f'усекает {x}, не источник (10.39.8.1)')
                if (d.src_aid, d.dst_aid, d.alloc_type) != (AID_BROADCAST, AID_BROADCAST, ALLOC_CBAP):
                    v(r, 'sp_trunc', f'Grant усечения: DAI ({d.src_aid}, {d.dst_aid}, тип {d.alloc_type}) ≠ '
                                     f'broadcast/broadcast CBAP (10.39.8.1)')
                one = D.field(SIFS + T_CF_END)
                two = D.field(2 * SIFS + 2 * T_CF_END)
                if r['dur'] is not None and not any(abs(r['dur'] - w) <= q for w in (one, two)):
                    v(r, 'sp_trunc', f'Duration Grant усечения {r["dur"]} ∉ {{{one}, {two}}} (SIFS + CF-End '
                                     f'[+ ответный CF-End], 10.39.8.1)')
                rem = st.end - r['te']
                if r['dur'] is not None and d.alloc_duration > rem - r['dur'] + q:
                    v(r, 'sp_trunc', f'Allocation Duration {d.alloc_duration} > остаток SP − Duration = '
                                     f'{float(rem - r["dur"])} (10.39.8.1)')
                if r['dur'] is not None:
                    s0 = r['te'] + r['dur']
                    st.cbap = DA.Window(s0, s0 + d.alloc_duration, set(), CBAP, everyone=True, why='усечение')
                    if a.truncatable:
                        st.released = st.cbap.end         # не отданное в CBAP — AP (10.39.8.1)
                expect_peer_cf_end = (r, x)
                st.ended = r['te']
                st.advertised = bool(a.truncatable)
            elif d.alloc_duration == F.ALLOC_DUR_SPECIAL and x == st.src and r['dst'] == st.dst:
                # 10.39.7.3: уступка остатка SP получателю
                aid = {v_: k for k, v_ in mac_of.items()}
                want = (aid.get(st.dst), aid.get(st.src), ALLOC_SP)
                got = (d.src_aid, d.dst_aid, d.alloc_type)
                if None not in want and got != want:
                    v(r, 'sp_relinquish', f'Grant уступки: (Source AID, Destination AID, тип) = {got} ≠ {want} '
                                          f'(10.39.7.3)')
                w = D.duration_grant_relinquish(st.end - r['ts'], r['te'] - r['ts'])
                if r['dur'] is not None and abs(r['dur'] - w) > q:
                    v(r, 'sp_relinquish', f'Duration Grant уступки {r["dur"]} ≠ {w} (10.39.7.3)')
                if not f.bfc.bt:
                    st.src, st.dst = st.dst, st.src  # «the roles of source … and destination … are swapped»
            elif x == ap and ap == src and r['dst'] == st.dst and d.alloc_duration < F.ALLOC_DUR_SPECIAL and \
                    not (resp is not None and resp['kind'] == 'SPR'):
                # 10.39.9: AP-источник продлевает свой SP
                w = D.field(st.end - r['te'])
                if r['dur'] is not None and abs(r['dur'] - w) > q:
                    v(r, 'sp_ap_ext', f'Duration Grant продления {r["dur"]} ≠ остаток SP {w} (10.39.9)')
                new_end = st.end + d.alloc_duration
                for o in periods:
                    if o is not p and o.kind == SP and not _bcast_sp(o) and o.start < new_end and st.end <= o.start:
                        v(r, 'sp_ap_ext', f'продление до {float(new_end)} перекрывает {o} (10.39.9)')
                st.end, st.ext = new_end, st.ext + d.alloc_duration
                st.ext_window = DA.Window(p.end, st.end, st.pair, SP, src=st.src, why='продление')
        # ---- CF-End
        if kind == 'CF-End':
            if r['dst'] == ap and ap not in st.pair:
                if not a.truncatable:
                    v(r, 'sp_trunc', 'CF-End к AP в SP с Truncatable = 0 (10.39.8.1)')
                if x != src and not (x == dst and st.first_src is None and r['ts'] - p.start >= idle_timeout - q):
                    v(r, 'sp_trunc', f'усекает {x}, не источник (10.39.8.1)')
                expect_peer_cf_end = (r, x)
                st.ended = r['te']
                st.advertised = bool(a.truncatable)
            elif r['dst'] == peer and resp is None:
                if expect_peer_cf_end is not None and expect_peer_cf_end[1] == x:
                    expect_peer_cf_end = None
                st.ended = r['te'] if st.ended is None else st.ended
                # СПОРНО → принято (PLAN.md №51): время возвращается AP, только если усечение ему объявлено (или AP —
                # пир) в Truncatable SP
                if st.released is None and (st.advertised or (peer == ap and a.truncatable)):
                    st.released = r['te'] + (SIFS + T_CF_END if r['dur'] else 0)
        if expect_peer_cf_end is not None and kind not in ('CF-End', 'Grant') and x == expect_peer_cf_end[1]:
            v(r, 'sp_trunc', f'после {expect_peer_cf_end[0]["kind"]} усечения {x} передаёт {kind}, а не CF-End '
                             f'пиру (10.39.8.1)')
            expect_peer_cf_end = None
        # ---- SPR: продление (10.39.9)
        if kind == 'SPR':
            if _answers_poll(ev, j, ap, q):
                continue
            if not a.extendable:
                v(r, 'sp_ext', 'SPR в SP с Extendable = 0 не в ответ на Poll (10.39.9)')
            if r['dst'] != ap:
                v(r, 'sp_ext', 'SPR не к AP (10.39.9: «RA field to the address of the AP or PCP»)')
            w = D.field(st.end - r['te'])
            if r['dur'] is not None and abs(r['dur'] - w) > q:
                v(r, 'sp_ext', f'Duration SPR {r["dur"]} ≠ остаток SP {w} (10.39.9, 9.3.1.11)')
            # ответ AP
            nxt = [y for y in ev[j + 1:j + 3] if y['src'] == ap and y['kind'] == 'Grant']
            if not nxt:
                continue
            g = nxt[0]
            gf = g['frame']
            if not SIFS - q <= g['ts'] - r['te'] <= SIFS + sifs_tol + q:
                v(g, 'sp_ext_grant', f'Grant AP через {float(g["ts"] - r["te"])} мкс после SPR ≠ SIFS (10.39.9)')
            if g['dst'] != x:
                v(g, 'sp_ext_grant', 'RA Grant AP ≠ TA SPR (10.39.9)')
            if r['dur'] is not None and g['dur'] is not None:
                w = D.duration_grant_ext_reply(r['dur'], g['te'] - g['ts'])
                if abs(g['dur'] - w) > q:
                    v(g, 'sp_ext_grant', f'Duration Grant AP {g["dur"]} ≠ {w} (10.39.9)')
            if gf is None or gf.dai.alloc_duration == 0:
                continue
            req = f.dai.alloc_duration if f is not None else None
            fol = _following_sp(periods, p)
            if fol is None or not _bcast_sp(fol) or (req is not None and fol.end - fol.start <= req):
                v(g, 'sp_ext_grant', f'продление гарантировано, хотя следующий SP {fol} не broadcast/broadcast или не '
                                     f'длиннее запрошенного {req} (10.39.9)')
            partner = peer
            if partner != ap:
                gi = ev.index(g)
                nx2 = ev[gi + 1:gi + 3]
                # СПОРНО → принято (PLAN.md №49): при Grant Ack Supported = 1 Grant Ack занимает «SIFS после Grant»
                # (10.39.4), пересылка — через SIFS после Grant Ack
                ga = nx2[0] if nx2 and nx2[0]['kind'] == 'Grant Ack' and nx2[0]['src'] == x else None
                fw = [y for y in nx2 if y['src'] == x and y['kind'] == 'Grant']
                if not fw:
                    v(g, 'sp_ext_grant', f'{x} не переслал Grant партнёру {partner} (10.39.9)')
                else:
                    h = fw[0]
                    hf = h['frame']
                    ref_end = ga['te'] if ga is not None else g['te']
                    if not SIFS - q <= h['ts'] - ref_end <= SIFS + sifs_tol + q:
                        v(h, 'sp_ext_grant', 'пересылка Grant партнёру не через SIFS (10.39.9)')
                    if h['dst'] != partner:
                        v(h, 'sp_ext_grant', f'пересылка Grant к {h["dst"]}, не партнёру {partner} (10.39.9)')
                    if g['dur'] is not None and h['dur'] is not None:
                        w = D.duration_grant_ext_forward(g['dur'], h['te'] - h['ts'])
                        if abs(h['dur'] - w) > q:
                            v(h, 'sp_ext_grant', f'Duration пересланного Grant {h["dur"]} ≠ {w} (10.39.9)')
                    if hf is not None and hf.dai.alloc_duration != gf.dai.alloc_duration:
                        v(h, 'sp_ext_grant', 'Allocation Duration пересланного Grant ≠ гранта AP (10.39.9)')
            st.end += gf.dai.alloc_duration
            st.ext += gf.dai.alloc_duration
            st.ext_window = DA.Window(p.end, st.end, st.pair | {ap}, SP, src=st.src, why='продление')
    if expect_peer_cf_end is not None:
        v(expect_peer_cf_end[0], 'sp_trunc', 'после усечения нет CF-End пиру (10.39.8.1)')
    if st.ended is not None and st.released is None and st.advertised:
        st.released = st.ended
    return out, st


def cbap_may_initiate(aid, p, cbap_only=False, cbap_source=False, is_ap=False):
    """10.39.5: условия начала обмена в CBAP (любое из списка)."""
    if cbap_only:
        # СПОРНО → как bi.check_air_log: при CBAP Source = 1 non-AP явно не допущен ни одним условием, но 9.4.1.46
        # говорит лишь о «higher priority» AP (PIFS-доступ); принято: CBAP Only — доступ всем
        return True
    return p.src_aid == AID_BROADCAST or aid in (p.src_aid, p.dst_aid)


def check_dti(evs, k, bi_tu, entries, aids, ap, bti_end=None, bic=None, params=None, caps=None, pp_available=None,
              sifs_tol=SIFS_TOL, q=0, idle_timeout=DOT11_SP_IDLE_TIMEOUT, ati_start=None, ati_duration=0,
              ant_switch=0):
    """Судья DTI одного BI k по расписанию entries ([schedule.Entry]). Возвращает (нарушения, окна, периоды).
    Сверх check_sp и dynalloc.check_dyn_log:
      'sp_foreign'      — в SP передаёт не источник/получатель, не в выделенном Grant окне, не AP во возвращённом
                          времени и не ответ (10.39.6.2, 10.39.4 b));
      'sp_pcp_inactive' — передача к PCP в SP с PCP Active = 0, где PCP не участник (10.39.6.2);
      'cbap_member'     — начало обмена в CBAP расписания STA, не допущенной 10.39.5;
      'cbap_end'        — кадр кончается после конца CBAP (10.39.5)."""
    ev = events(evs)
    cfg = BI.BiConfig(bic=bic, params=params, allocations=[e.alloc for e in entries], ati_start=ati_start,
                      ati_duration=ati_duration)
    periods = BI.layout(k, bi_tu, cfg, bti_end)
    mac_of = {a: m for m, a in aids.items()}
    mac_of.setdefault(AID_AP_PCP, ap)
    bfc_of = {id(e.alloc): e.bfc for e in entries}
    out, states = [], []
    for p in periods:
        if p.kind == SP and p.src_aid != AID_BROADCAST and p.alloc is not None:
            vv, st = check_sp(ev, p, bfc_of.get(id(p.alloc)), mac_of, ap, caps, periods, sifs_tol, q, idle_timeout)
            out += vv
            states.append(st)
    relq = [(st.released, st.end) for st in states if st.released is not None]
    pre = [st.ext_window for st in states if st.ext_window is not None]
    dv, wins = DA.check_dyn_log(evs, periods, aids, ap, caps, pp_available, relq, sifs_tol, q, ant_switch, pre)
    out += dv
    wins += [st.cbap for st in states if st.cbap is not None]
    st_of = {id(st.p): st for st in states}
    co = bool(cfg.params.cbap_only)
    for j, r in enumerate(ev):
        p = BI.period_at(periods, r['ts'])
        st = st_of.get(id(p)) if p is not None else None
        x = r['src']
        if any(w.has(r['ts']) and w.allows(x) for w in wins):
            continue
        if p is not None and p.kind == SP and st is not None:
            if x in st.pair or _resp_to(ev, j, sifs_tol, q) is not None:
                pass
            elif x == ap and st.released is not None and r['ts'] >= st.released:
                pass
            else:
                out.append(Violation(r['i'], 'sp_foreign', f'{r["kind"]} от {x} (AID {aids.get(x)}) в {p} '
                                                          f'(10.39.6.2)'))
            al = p.alloc
            if not al.pcp_active and ap not in st.pair and r['dst'] == ap and x != ap:
                out.append(Violation(r['i'], 'sp_pcp_inactive', f'{r["kind"]} к PCP в {p} при PCP Active = 0 '
                                                                f'(10.39.6.2)'))
        elif p is not None and p.kind == CBAP:
            if r['te'] > p.end + q:
                out.append(Violation(r['i'], 'cbap_end', f'{r["kind"]} {x} кончается после конца {p} (10.39.5)'))
            if _resp_to(ev, j, sifs_tol, q) is not None or r['kind'] in RESPONSES:
                continue
            if not cbap_may_initiate(aids.get(x), p, co, bool(cfg.params.cbap_source), x == ap):
                out.append(Violation(r['i'], 'cbap_member', f'{r["kind"]} от {x} (AID {aids.get(x)}) начинает обмен '
                                                            f'в {p} (10.39.5)'))
    out.sort(key=lambda w: w.idx)
    return out, wins, periods


# ============================================================================================ генераторы
def _ev(ts, kind, src, dst, length, mcs=0, dur=None, frame=None, **info):
    t = Fr(ts)
    te = t + D.T.txtime(length, mcs)
    return (t, te, src, dst, kind, dur, dict(mcs=mcs, frame=frame, **info))


def sp_exchange(p, src, dst, n_data, data_len=1500, data_mcs=8, heartbeat=False, bf=None, t_ssw=None):
    """Эталонный обмен источника в SP по правилам 10.39.6.2: при Heartbeat = 1 у получателя первым — RTS/DMG CTS
    (DMG Control); при bf (BfControl с BT = 1) первым — SSW ISS источника и SSW RSS получателя (по одному кадру —
    минимальный свип, SBIFS/MBIFS по 10.42.2), затем n_data пар Data → Ack через SIFS, каждый следующий Data через
    SIFS после Ack; всё — до конца SP. Возвращает список событий."""
    out = []
    t = p.start
    end = p.end
    if bf is not None and bf.bt:
        out.append(_ev(t, 'SSW', src, dst, D.LEN['ssw'], direction=0, dur=0))
        t = out[-1][1] + MBIFS
        out.append(_ev(t, 'SSW', dst, src, D.LEN['ssw'], direction=1, dur=0))
        t = out[-1][1] + MBIFS
    if heartbeat:
        rts = _ev(t, 'RTS', src, dst, D.LEN['rts'])
        cts = _ev(rts[1] + SIFS, 'DMG CTS', dst, src, D.LEN['dmg_cts'])
        out += [rts, cts]
        t = cts[1] + SIFS
    for _ in range(n_data):
        d = _ev(t, 'Data', src, dst, data_len, data_mcs)
        a = _ev(d[1] + SIFS, 'Ack', dst, src, 14, 1)
        if a[1] > end:
            break
        out += [d, a]
        t = a[1] + SIFS
    for e in out:
        if e[1] > end:
            raise ValueError('обмен не умещается в SP')
    return out


def truncation_cf_end(t, sta, ap, peer, peer_reply=True):
    """10.39.8.1: CF-End к AP (объявить возвращаемое время), затем CF-End пиру (Duration ≠ 0 — пир отвечает CF-End
    через SIFS, если peer_reply; 9.3.1.6: Duration = (i − 1)·(TXTIME(CF-End) + SIFS))."""
    a = _ev(t, 'CF-End', sta, ap, 20, dur=0)
    b = _ev(a[1] + SIFS, 'CF-End', sta, peer, 20, dur=D.duration_cf_end(2) if peer_reply else 0)
    out = [a, b]
    if peer_reply:
        out.append(_ev(b[1] + SIFS, 'CF-End', peer, sta, 20, dur=0))
    return out


def truncation_grant(t, sta, peer, sp_end, cbap_dur=None, peer_reply=True):
    """10.39.8.1: широковещательный Grant (Source/Destination AID broadcast, CBAP), Duration = SIFS + CF-End [+ SIFS +
    ответный CF-End]; Allocation Duration ≤ остаток − Duration (по умолчанию — весь остаток); затем CF-End пиру."""
    t = Fr(t)
    tg = D.tx('grant')
    dur = D.field(SIFS + T_CF_END + ((SIFS + T_CF_END) if peer_reply else 0))
    rem = Fr(sp_end) - (t + tg) - dur
    ad = int(rem) if cbap_dur is None else cbap_dur
    dai = F.Dai(0, ALLOC_CBAP, AID_BROADCAST, AID_BROADCAST, ad)
    g = F.Grant(dur, BCAST, sta, dai, BF_NONE)
    out = [_ev(t, 'Grant', sta, BCAST, D.LEN['grant'], dur=dur, frame=g)]
    b = _ev(out[0][1] + SIFS, 'CF-End', sta, peer, 20, dur=D.duration_cf_end(2) if peer_reply else 0)
    out.append(b)
    if peer_reply:
        out.append(_ev(b[1] + SIFS, 'CF-End', peer, sta, 20, dur=0))
    return out


def extension(t, sta, ap, partner, sp_end, request, granted, sta_aid=1, partner_aid=2, grant_ack=False):
    """10.39.9: SPR STA → AP (Duration = остаток SP после SPR, Allocation Duration = запрошенное), Grant AP через SIFS
    (Duration = SPR − SIFS − TXTIME(Grant), Allocation Duration = granted; 0 — отказ), при granted > 0 и партнёре ≠ AP —
    Grant STA партнёру через SIFS (Duration = Grant AP − TXTIME − SIFS, Allocation Duration = granted)."""
    t = Fr(t)
    ts = D.tx('spr')
    spr_dur = D.field(Fr(sp_end) - (t + ts))
    spr = F.Spr(spr_dur, ap, sta, F.Dai(0, ALLOC_SP, sta_aid, partner_aid, request), BF_NONE)
    out = [_ev(t, 'SPR', sta, ap, D.LEN['spr'], dur=spr_dur, frame=spr)]
    tg = D.tx('grant')
    gd = D.duration_grant_ext_reply(spr_dur, tg)
    g = F.Grant(gd, sta, ap, F.Dai(0, ALLOC_SP, sta_aid, partner_aid, granted), BF_NONE)
    out.append(_ev(out[-1][1] + SIFS, 'Grant', ap, sta, D.LEN['grant'], dur=gd, frame=g))
    if grant_ack:
        # 10.39.9: «If a Grant Ack frame is transmitted … configured as specified in 10.39.4»
        tga = D.tx('grant_ack')
        ga = F.GrantAck(D.duration_grant_ack(gd, tga), ap, sta, BF_NONE)
        out.append(_ev(out[-1][1] + SIFS, 'Grant Ack', sta, ap, D.LEN['grant_ack'], dur=ga.duration, frame=ga))
    if granted and partner != ap:
        hd = D.duration_grant_ext_forward(gd, tg)
        h = F.Grant(hd, partner, sta, F.Dai(0, ALLOC_SP, sta_aid, partner_aid, granted), BF_NONE)
        out.append(_ev(out[-1][1] + SIFS, 'Grant', sta, partner, D.LEN['grant'], dur=hd, frame=h))
    return out
