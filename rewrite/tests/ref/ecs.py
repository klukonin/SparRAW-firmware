# SPDX-License-Identifier: AGPL-3.0-or-later
"""ECS (11.9 [p. 2189–2191]) — части, которых нет в ref/chswitch: Max Channel Switch Time (9.4.2.217 [p. 1367]:
элемент 255/52, Length 4, Switch Time — 3 октета, TU; «optionally present in Beacon and Probe Response frames when a
Channel Switch Announcement or Extended Channel Switch Announcement element is also present»; табл. 9-39 строка 84),
правила 11.9.3.2 о нём и OCV после смены канала (11.9.3.2: «If the STA chooses to perform the specified switch and
dot11RSNAOperatingChannelValidationActivated is true and the AP has indicated OCVC capability, after switching to the
new channel the STA shall wait a random delay uniformly-distributed in the range between zero and 5000 µs, and then
initiate the SA query procedure …»; OCVC — бит 14 RSN Capabilities, 9.4.2.24.4, 12.2.9).

Применимость к DMG (60 ГГц):
  - DSE / enabling STA (11.9.1 абз. 4, 11.9.3.2 абз. 1, 11.11): DSE — регуляторный механизм диапазона 3650 МГц США
    (11.11.1), dot11DSERequired у DMG STA false — не применимо (ВНЕ);
  - IBSS/MBSS (11.9.3.3, 11.9.3.4) — вне охвата open (IBSS — pro, MBSS — нет);
  - Max Channel Switch Time: в табл. 9-45 (DMG Beacon) строки нет — у DMG только в Probe Response; правила 11.9.3.2
    сказаны для Beacon frame. Принято (PLAN.md №104): в Probe Response DMG AP элемент — только вместе с ECSA (табл.
    9-39), при Count 0 — не включается (по аналогии 11.9.3.2), объявленный Switch Time ограничивает промежуток между
    последним DMG Beacon на старом канале и первым на новом (9.4.2.217 — смысл поля; вердикт model); элемент в DMG
    Beacon — не предусмотрен табл. 9-45 (model);
  - OCV/SA Query — применимо (RSNA DMG, MFP; ref/capelems): обязанность STA при OCVC у обеих сторон.

Нарушения — [(текст, вердикт)]."""
from collections import namedtuple

from . import elements as E
from .timing import TU

EID_MCST = E.element_key('Max Channel Switch Time')        # (255, 52)
MCST_LEN = 3                                                # Switch Time, без октета Extension
OCV_DELAY_MAX = 5000                                        # мкс, 11.9.3.2
CAT_SA_QUERY, ACT_SA_QUERY_REQ = 8, 0                       # табл. 9-51, 9-403

Mcst = namedtuple('Mcst', 'switch_time_tu')


def encode_mcst(tu):
    if not 0 <= tu < 1 << 24:
        raise ValueError('Switch Time вне 3 октетов (рис. 9-727)')
    return E.encode_element(EID_MCST[0], tu.to_bytes(3, 'little'), ext=EID_MCST[1])


def parse_mcst(info):
    if len(info) != MCST_LEN:
        raise ValueError(f'Max Channel Switch Time: {len(info) + 1} октетов после Length ≠ 4 (9.4.2.217: «The Length '
                         f'field is set to 4»)')
    return Mcst(int.from_bytes(info, 'little'))


def check_mcst_in_frame(kind, mcst_info, ecsa, csa=False):
    """Max Channel Switch Time в кадре точки: kind — 'DMG Beacon' | E.PROBE_RESP; ecsa — chswitch.Ecsa или None."""
    v = []
    if mcst_info is None:
        return v
    try:
        parse_mcst(mcst_info)
    except ValueError as x:
        v.append((str(x), 'ours'))
    if kind == 'DMG Beacon':
        v.append(('Max Channel Switch Time в DMG Beacon — в табл. 9-45 не предусмотрен (9.4.2.217: Beacon и Probe '
                  'Response)', 'model'))
    if ecsa is None and not csa:
        v.append((f'{kind}: Max Channel Switch Time без ECSA/CSA — «optionally present … when a Channel Switch '
                  f'Announcement or Extended Channel Switch Announcement element is also present» (табл. 9-39)',
                  'ours'))
    elif ecsa is not None and ecsa.count == 0:
        v.append((f'{kind}: Max Channel Switch Time при Channel Switch Count 0 — «shall not include» (11.9.3.2, для '
                  f'Beacon frame; PLAN.md №104)', 'model'))
    return v


def check_switch_gap(t_last_old, t_first_new, switch_time_tu):
    """9.4.2.217 / 11.9.3.2: первый маяк на новом канале не позже Switch Time после последнего на старом."""
    gap = t_first_new - t_last_old
    lim = switch_time_tu * TU
    if gap > lim:
        return [(f'первый DMG Beacon после смены через {float(gap) / 1000:.1f} мс > Switch Time {switch_time_tu} TU '
                 f'(9.4.2.217, 11.9.3.2; PLAN.md №104)', 'model')]
    return []


def ocv_required(ap_ocvc, sta_ocvc, sta_ocv_activated=None):
    """11.9.3.2: SA Query после смены — если у STA dot11RSNAOperatingChannelValidationActivated (по эфиру — OCVC в её
    RSNE, 12.2.9: «shall advertise this capability in RSNE») и AP указал OCVC."""
    act = sta_ocvc if sta_ocv_activated is None else sta_ocv_activated
    return bool(ap_ocvc and act)


def check_after_switch(t_switch, sta_frames, required):
    """sta_frames — [(t, вид, (категория, действие) | None, защищён)] кадров STA к AP после смены. → нарушения.
    SA Query (категория 8 robust) при MFP защищён — тело не видно: защищённый Action — кандидат (вердикт capture)."""
    if not required:
        return []
    after = [f for f in sta_frames if f[0] >= t_switch]
    if not after:
        return []
    for t, kind, ca, prot in after:
        if ca == (CAT_SA_QUERY, ACT_SA_QUERY_REQ):
            return []
    if any(prot and kind in ('Action', 'Action No Ack') for _, kind, _, prot in after):
        return [('после смены канала SA Query Request не опознан (защищённые Action — тело не видно)', 'capture')]
    return [('после смены канала при OCVC у AP и STA нет SA Query Request от STA — «shall … initiate the SA query '
             'procedure» (11.9.3.2)', 'ours')]


def check_sa_query_timing(t_switch, t_sa_query):
    """SA Query для проверки канала — после смены (случайная задержка 0…5000 мкс, затем по условиям доступа):
    раньше смены — нарушение; позже 5000 мкс — допустимо (условия доступа к каналу), заметка."""
    if t_sa_query < t_switch:
        return [('SA Query Request до момента смены канала (11.9.3.2: «after switching to the new channel»)', 'ours')]
    return []
