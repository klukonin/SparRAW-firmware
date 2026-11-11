# SPDX-License-Identifier: AGPL-3.0-or-later
"""Строгий TDMA точки (fw/tdma.c, WMI_SPARRAW_TDMA_CFG mode = 1; uc/ese_dti.c) против эталона 802.11-2020 (tests/ref):

  fw   — Extended Schedule в DMG Beacon (9.4.2.131, рис. 9-562…9-564): общее CBAP и на станцию i SP точка → i и
         SP i → точка; расписание BI — ref/schedule.check (DTI, перекрытия, guard time 10.39.6.5, поле Allocation,
         PCP Active, CBAP Only = 0 при ES 10.39.6.3, aDMGPPMinListeningTime 10.39.6.2 «should»); своя таблица окон
         точки ese_own_tbl (окна, где точка начинает обмен) — то же время, что в маяке;
  uc   — доступ к среде по своей таблице окон (ese_dti_tx_gate): вне своего окна и в хвосте, где TXOP не помещается
         до конца окна, — отказ; урезание лимита TXOP до конца окна; маски передачи по получателю окна;
  air  — живой эфир точки и станции (fw + uc обоих узлов, air.Air): журнал BI с расписанием — ref/sp.check_dti
         (10.39.6.2 доступ в SP, конец SP, 10.39.5 CBAP расписания); негативы — нарушения в журнале ловятся.

Время эфира — мкс TSF точки (ref_bridge2.events: сетка TBTT кратна BI); Allocation Start в маяке — TSF модели MAC,
у моста сдвиг phase (ref_bridge2.time_base) — поля переводятся на ту же ось."""
import struct
from fractions import Fraction as Fr

import pytest

import fwflows as Fl
from test_fw_ese import BI_START, BI_US, BI_TU, HW_MAC_BEACON_INTERVAL, HW_MAC_BI_START_TSF_LO, ap, ese_of, \
    last_beacon, sta_mac
from test_uc_beacon_tx import ctrl_txtime, ss_slot_time

import os
import sys
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
from ref import bi as BI                       # noqa: E402
from ref import fields as F                    # noqa: E402
from ref import schedule as S                  # noqa: E402

WMI_TDMA_CFG = 0x0f10
MODE_EQUAL, MODE_SP = 0, 1
SBIFS, MBIFS = 1, 9
from fwsh_addr import ESE_SLOT_TBL as FWSH_ESE_SLOT_TBL, ESE_OWN_TBL as FWSH_ESE_OWN_TBL, SP_GATE, \
    ESE_OWN_SLOTS_N                                            # noqa: E402  include/fwsh.h
ESE_TBL_MODE_OWN = 3
LISTEN = 150                                                    # aDMGPPMinListeningTime (10.39.6.2)
HW_SCHED_SLOT_CTRL = 0x886f88                                   # include/hw_regs.h: запись массива SP (последней)


def tdma_cfg(enable=1, min_sta=0, mode=MODE_SP):
    """struct wmi_sparraw_tdma_cfg_cmd (include/wmi.h)."""
    return struct.pack('<BBBB', enable, min_sta, mode, 0)


def ap_strict(fw, k, min_sta=1, mode=MODE_SP):
    w = ap(fw)
    fw.wmi(WMI_TDMA_CFG, tdma_cfg(1, min_sta, mode))
    Fl.settle(fw)
    for i in range(k):
        w.ap_sta_join(peer=sta_mac(i + 1), cid=i)
    return w


def entries_of(al, base):
    """Поля ESE (test_fw_ese.alloc_fields) → [schedule.Entry] на оси BI k = 1 (TBTT = BI_US): Allocation Start
    переводится из TSF модели (начало следующего BI = base) в ось эталона."""
    out = []
    for a in al:
        typ = {0: S.SP, 1: S.CBAP}[a['type']]
        start = (a['start'] - base) % (1 << 32) + BI_US
        out.append(S.Entry(BI.Allocation(typ, a['src'], a['dst'], start, a['dur'], a['nblk'], a['period'],
                                         alloc_id=a['id'], pseudo_static=a['pseudo'], truncatable=a['trunc'],
                                         extendable=a['ext'], pcp_active=a['pcp_active'], lp_sc=a['lp_sc']),
                           S.BF_NONE))
    return out


def bti_us(fw, bcn):
    """Конец BTI от TBTT: n маяков развёртки (uc, LMAC 0x0b) Control PHY через SBIFS (10.42.5.1)."""
    sweep = [c for c in fw.lmac_cmds if c.type == 0x0b][-1].body
    n = sweep[4 + 0x48]
    return n * (ctrl_txtime(len(bcn) + 4) + SBIFS) - SBIFS


def own_slots(fw):
    """ese_own_tbl (include/fwsh.h): [(ctrl_b0, peer_cid, src, dst, start, dur)]."""
    t = FWSH_ESE_OWN_TBL
    out = []
    for i in range(fw.r8(t + 1)):
        e = t + 4 + 0xc * i
        out.append((fw.r8(e), fw.r8(e + 1), fw.r8(e + 2), fw.r8(e + 3), fw.r32(e + 4), fw.r16(e + 8)))
    return out


def own_rx_tail(fw):
    """rx_tail_us записей ese_own_tbl (include/fwsh.h struct ese_slot +0x0a)."""
    t = FWSH_ESE_OWN_TBL
    return [fw.r16(t + 4 + 0xc * i + 0xa) for i in range(fw.r8(t + 1))]


def ref_check(fw, al):
    """ref/schedule.check над расписанием маяка: BIC и DMG Parameters — из самого маяка (ref/fields), A-BFT — по BIC
    (ref/bi.layout), конец BTI — bti_us."""
    import ref_bridge2 as RB
    bcn = last_beacon(fw)
    p = F.parse_dmg_beacon(bcn, with_fcs=False)
    ent = entries_of(al, (BI_START + BI_US) & 0xffffffff)
    params = BI.DmgParameters(p.params.bss_type, p.params.cbap_only, p.params.cbap_source, p.params.privacy,
                              p.params.ecapc)
    return S.check(ent, 1, BI_TU, bti_end=BI_US + bti_us(fw, bcn), bic=RB.bic_bi(p.bic), params=params,
                   has_es_in_beacon=True), ent


# =====================================================================================================================
# fw: Extended Schedule строгого TDMA
# =====================================================================================================================
@pytest.mark.parametrize('k', [1, 2, 3, 8])
def test_strict_ese_reference(fw, k):
    """k станций, строгий режим: в маяке общее CBAP 255→255 (Allocation ID 0) и на станцию SP точка (AID 0) →
    станция и SP станция → точка (Allocation Type 0, Table 9-257; Allocation ID ≠ 0); при k = 1 SP упираются в
    32 767 мкс (9.4.2.131) — остаток BI отдан CBAP 255→255. Расписание BI — ref/schedule.check без нарушений
    («should» aDMGPPMinListeningTime тоже соблюдён: у всех SP общая STA — точка)."""
    ap_strict(fw, k)
    al = ese_of(last_beacon(fw))
    assert al is not None, 'строгий TDMA не объявлен'
    sp = [a for a in al if a['type'] == 0]
    assert len(sp) == 2 * k
    assert (al[0]['type'], al[0]['src'], al[0]['dst'], al[0]['id']) == (1, 255, 255, 0)
    aids = sorted({a['src'] for a in sp if a['src'] != 0})
    assert len(aids) == k and all(1 <= x <= 254 for x in aids)
    for x in aids:
        assert [(a['src'], a['dst']) for a in sp if x in (a['src'], a['dst'])] == [(0, x), (x, 0)]
    assert all(a['trunc'] == 0 and a['ext'] == 0 and a['pcp_active'] == 1 and a['pseudo'] == 1 for a in al)
    v, ent = ref_check(fw, al)
    assert v == [], v
    if k == 1:
        assert all(a['dur'] == 32767 for a in sp)
        assert (al[-1]['type'], al[-1]['src'], al[-1]['dst']) == (1, 255, 255)
    durs = {a['dur'] for a in sp}
    assert len(durs) == 1, durs                                     # равное деление


def test_strict_own_table(fw):
    """Своя таблица окон точки (ese_own_tbl, ese_slot_tbl.mode = 3): общее CBAP (получатели — все, 0xff) и SP точка →
    станция i (получатель — cid i), то же начало от начала BI и длительность, что в маяке; SP станций в таблице нет —
    в них точка обмен не начинает (10.39.6.2)."""
    ap_strict(fw, 3)
    al = ese_of(last_beacon(fw))
    base = (BI_START + BI_US) & 0xffffffff
    own = own_slots(fw)
    assert fw.r8(FWSH_ESE_SLOT_TBL) == ESE_TBL_MODE_OWN
    assert fw.r8(FWSH_ESE_SLOT_TBL + 1) == 0
    want = [(a['src'], a['dst'], (a['start'] - base) % (1 << 32), a['dur']) for a in al
            if a['type'] == 1 or a['src'] == 0]
    assert [(s, d, st, du) for _, _, s, d, st, du in own] == want
    assert all(c & 0x80 for c, *_ in own)                          # б7 — точка начинает обмен
    assert own[0][1] == 0xff
    assert [p for _, p, s, *_ in own[1:]] == [1 << i for i in range(3)]
    # rx_tail_us (наведение приёма, uc/ese_dti.c): у SP точка → i — до конца следующего SP i → точка, у CBAP — 0
    sp = [a for a in al if a['type'] == 0]
    want_tail = [0] + [(b['start'] + b['dur'] - a['start'] - a['dur']) % (1 << 32) for a, b in zip(sp[0::2], sp[1::2])]
    assert own_rx_tail(fw) == want_tail + [0] * (len(own) - len(want_tail))
    assert all(sp[2 * i + 1]['src'] == sp[2 * i]['dst'] for i in range(3))


def test_strict_refresh_keeps_layout(fw):
    """Пересборка каждый BI (Allocation Start следующего BI, 10.39.6.4): раскладка окон от начала BI прежняя — своя
    таблица и аппаратный массив SP не трогаются (записи массива закладываются только при смене раскладки); при смене
    (новая станция) — заложены заново."""
    ctrl = []
    fw.mmio_write_hook[HW_SCHED_SLOT_CTRL] = lambda f, a, v: ctrl.append(v)
    w = ap_strict(fw, 2)
    own0 = own_slots(fw)
    assert len(ctrl) == 16                                          # две раскладки (1 и 2 станции) × 2 прохода по 4
    fw.mmio[HW_MAC_BI_START_TSF_LO] = BI_START + BI_US
    fw.call('tdma_ap_update', fw.call('mid_list_by_mid_fw', 0), 0)
    Fl.settle(fw)
    assert own_slots(fw) == own0 and len(ctrl) == 16
    al = ese_of(last_beacon(fw))
    assert al[0]['start'] == (BI_START + 2 * BI_US + own0[0][4]) & 0xffffffff
    w.ap_sta_join(peer=sta_mac(3), cid=2)
    assert len(own_slots(fw)) == 4 and len(ctrl) == 24


def test_strict_to_equal_and_off(fw):
    """Режим строгий → простой (WMI 0x0f10 mode 0): своя таблица снята (ese_slot_tbl.mode ≠ 3), в маяке — CBAP
    станция → точка; выключение — без ESE, CBAP Only = 1; неизвестный режим — команда отвергнута, расписание прежнее."""
    ap_strict(fw, 2)
    assert fw.r8(FWSH_ESE_SLOT_TBL) == ESE_TBL_MODE_OWN
    fw.wmi(WMI_TDMA_CFG, tdma_cfg(1, 1, 7))
    Fl.settle(fw)
    assert fw.r8(FWSH_ESE_SLOT_TBL) == ESE_TBL_MODE_OWN
    fw.wmi(WMI_TDMA_CFG, tdma_cfg(1, 1, MODE_EQUAL))
    Fl.settle(fw)
    assert fw.r8(FWSH_ESE_SLOT_TBL) != ESE_TBL_MODE_OWN
    al = ese_of(last_beacon(fw))
    assert [a['type'] for a in al] == [1, 1, 1]
    fw.wmi(WMI_TDMA_CFG, tdma_cfg(1, 1, MODE_SP))
    Fl.settle(fw)
    assert fw.r8(FWSH_ESE_SLOT_TBL) == ESE_TBL_MODE_OWN
    fw.wmi(WMI_TDMA_CFG, tdma_cfg(0, 1, MODE_SP))
    Fl.settle(fw)
    assert fw.r8(FWSH_ESE_SLOT_TBL) == 0 and fw.r8(FWSH_ESE_OWN_TBL + 1) == 0
    assert ese_of(last_beacon(fw)) is None


def test_strict_default_is_equal(fw):
    """По умолчанию (без команды) — простое деление: при двух станциях только CBAP, своей таблицы нет."""
    w = ap(fw)
    for i in range(2):
        w.ap_sta_join(peer=sta_mac(i + 1), cid=i)
    al = ese_of(last_beacon(fw))
    assert al and all(a['type'] == 1 for a in al)
    assert fw.r8(FWSH_ESE_SLOT_TBL) != ESE_TBL_MODE_OWN


# =====================================================================================================================
# uc: доступ к среде по своей таблице окон (uc/ese_dti.c)
# =====================================================================================================================
UC_ROLE_AP, DTI_QSET_MODE = 0x8014c0, 0x8004f4                  # uc/dccm.h
TXOP_LIMIT_CUR, TXOP_LIMIT_US = 0x800478, 0x80294c
STA_TAB, STA_ENTRY = 0x801104, 0x50                            # struct sta_entry: +2 flags, +0x18 q6, +0x1c q5
TX_DIS_MASK = 0x802a90
HW_TXOP_LIMIT_0, HW_TXOP_LIMIT_1, HW_BI_START = 0x886f70, 0x886f74, 0x886fc4
FWSH_DIAG_ESE_SCHED = 0x857028
TAIL, RETRY, TXOP_MIN = 32, 93, 0x31                            # uc/ese_dti.c ESE_TXOP_*_US
UC_BI0 = 0x10000000                                             # TSF начала BI в тестах uc


def own_table(uc, wins):
    """ese_own_tbl: wins — [(начало от BI, длительность, начинать можно, маска получателей[, rx_tail_us])];
    ese_slot_tbl.mode = 3. Тип окна: получатели 0xff — CBAP, иначе SP."""
    uc.w8(FWSH_ESE_SLOT_TBL, ESE_TBL_MODE_OWN)
    uc.w8(FWSH_ESE_SLOT_TBL + 1, 0)
    uc.w8(FWSH_ESE_OWN_TBL + 1, len(wins))
    for i, w in enumerate(wins):
        st, du, init, peer = w[:4]
        e = FWSH_ESE_OWN_TBL + 4 + 0xc * i
        uc.w8(e, (0x80 if init else 0) | (1 << 4 if peer == 0xff else 0))
        uc.w8(e + 1, peer)
        uc.w32(e + 4, st)
        uc.w16(e + 8, du)
        uc.w16(e + 0xa, w[4] if len(w) > 4 else 0)


def uc_ap(uc, lim=2048, stas=2):
    uc.w32(UC_ROLE_AP, 1)
    uc.w32(DTI_QSET_MODE, 0)
    uc.w32(TXOP_LIMIT_CUR, lim)
    for i in range(4):
        uc.w32(TXOP_LIMIT_US + 4 * i, lim)
    uc.w32(HW_BI_START, UC_BI0)
    for cid in range(8):
        a = STA_TAB + STA_ENTRY * cid
        uc.w16(a + 2, 1 if cid < stas else 0)
        uc.w32(a + 0x18, 1 << cid)
        uc.w32(a + 0x1c, 1 << (cid + 8))
        uc.w16(TX_DIS_MASK + 2 * cid, 0)
    for i in range(0x18):
        uc.w8(SP_GATE + i, 0)


WINS = [(3000, 2000, 1, 0xff), (5026, 8000, 1, 1 << 0), (21326, 8000, 1, 1 << 1)]    # CBAP, SP → cid 0, SP → cid 1


def gate(uc, off):
    return uc.call('ese_dti_tx_gate', stub={'uc_read_tsf_lo': UC_BI0 + off})


def test_uc_gate_no_schedule(uc):
    """Без расписания (станция без ESE своей точки, точка без строгого TDMA) — доступ всегда, лимит TXOP не трогается."""
    uc_ap(uc)
    uc.w8(FWSH_ESE_SLOT_TBL, 0)
    uc.w32(HW_TXOP_LIMIT_0, 0x12345678)
    assert gate(uc, 100) == 1
    uc.w32(UC_ROLE_AP, 0)
    uc.w8(FWSH_DIAG_ESE_SCHED, 0)
    assert gate(uc, 100) == 1
    assert uc.r32(HW_TXOP_LIMIT_0) == 0x12345678


@pytest.mark.parametrize('off, ok', [
    (2999, 0),                      # до общего CBAP (BHI/guard)
    (3000, 1),                      # начало общего CBAP: TXOP 2048 + хвост не помещается в 2000? — см. ниже
    (13026 + 100, 0),               # Tguard/aDMGPPMinListeningTime между SP
    (13176 + 10, 0),                # SP станции 0 → точке (в своей таблице его нет) — точка не начинает обмен
    (21326 + 10, 1),                # своё SP → станция 1
])
def test_uc_gate_windows(uc, off, ok):
    """Точка (строгий TDMA): доступ только внутри своего окна (10.39.6.2: SP начинает источник; 10.39.5: CBAP) и
    если TXOP по лимиту MAC (2048 мкс) с хвостом ESE_TXOP_TAIL_US кончается до конца окна. Общее CBAP 2000 мкс короче
    лимита — в нём доступ только с урезанным лимитом (отказ и урезание, следующий доступ уложится)."""
    uc_ap(uc)
    own_table(uc, WINS)
    r = gate(uc, off)
    if off == 3000:
        assert r == 0
        cap = 2000 - TAIL - RETRY
        assert uc.r32(HW_TXOP_LIMIT_0) == (cap << 16) | cap
        assert uc.r16(SP_GATE) == cap
        assert gate(uc, off + 50) == 1                              # урезанный TXOP помещается
        return
    assert r == ok


def test_uc_gate_window_tail(uc):
    """Хвост своего SP: остаток меньше лимит + хвост — отказ и урезание лимита TXOP до остатка − хвост − запас ожидания
    доступа; остаток меньше хвоста + запаса + наименьшего TXOP — передача закрыта (очереди на паузе) до следующего окна;
    начало окна возвращает лимит LMAC 0x21."""
    uc_ap(uc)
    own_table(uc, WINS)
    end = 5026 + 8000
    left = 1500
    assert gate(uc, end - left) == 0
    cap = left - TAIL - RETRY
    assert uc.r32(HW_TXOP_LIMIT_0) >> 16 == cap and uc.r32(HW_TXOP_LIMIT_1) == cap | cap << 16
    assert gate(uc, end - left + 60) == 1
    small = TAIL + RETRY + TXOP_MIN
    assert gate(uc, end - small) == 0
    assert [uc.r16(TX_DIS_MASK + 2 * c) >> 8 & 1 for c in range(2)] == [1, 1]   # причина 8 у обеих станций
    uc.call('ese_dti_slot_start', 0x80 | (1 << 1) << 8, stub={'uc_read_tsf_lo': UC_BI0 + 21326})
    assert uc.r32(HW_TXOP_LIMIT_0) == (2048 << 16) | 2048 and uc.r16(SP_GATE) == 0
    assert [uc.r16(TX_DIS_MASK + 2 * c) >> 8 & 1 for c in range(2)] == [1, 0]   # открыт только получатель окна


def test_uc_window_masks_ap(uc):
    """Начало своего окна у точки: открыта передача только получателям окна (маска cid из записи), остальным —
    пауза (причина 8); конец окна — пауза всем; начало DTI вне окна — пауза всем; снятие строгого TDMA — снова всем."""
    uc_ap(uc, stas=3)
    own_table(uc, WINS)
    paused = lambda: [uc.r16(TX_DIS_MASK + 2 * c) >> 8 & 1 for c in range(3)]
    uc.call('ese_dti_on_dti_start', stub={'uc_read_tsf_lo': UC_BI0 + 2000})
    assert paused() == [1, 1, 1]
    uc.call('ese_dti_slot_start', 0x90 | 0xff << 8, stub={'uc_read_tsf_lo': UC_BI0 + 3000})
    assert paused() == [0, 0, 0]
    uc.call('ese_dti_slot_end', stub={'uc_read_tsf_lo': UC_BI0 + 5000})
    assert paused() == [1, 1, 1]
    uc.call('ese_dti_slot_start', 0x80 | 1 << 8, stub={'uc_read_tsf_lo': UC_BI0 + 5026})
    assert paused() == [0, 1, 1]
    uc.call('ese_dti_on_dti_start', stub={'uc_read_tsf_lo': UC_BI0 + 5100})
    assert paused() == [0, 1, 1]
    uc.w8(FWSH_ESE_SLOT_TBL, 0)                                     # fw сняла строгий TDMA
    uc.call('ese_dti_slot_end', stub={'uc_read_tsf_lo': UC_BI0 + 13026})
    assert paused() == [0, 0, 0]


def test_uc_window_end_cached_for_sls(uc):
    """Остаток текущего выделения для Duration SSW / SSW-Feedback (9.3.1.15, 9.3.1.16 b) у точки со своей таблицей —
    из конца окна, запомненного на событии массива SP, без обхода таблицы (путь RSS, test_uc_deadlines); вне своего
    окна — «окна нет» (до TBTT)."""
    uc_ap(uc)
    own_table(uc, WINS)
    uc.call('ese_dti_window_now', stub={'uc_read_tsf_lo': UC_BI0 + 6000})
    assert uc.call('ese_dti_us_to_window_end', stub={'uc_read_tsf_lo': UC_BI0 + 6000}) == 5026 + 8000 - 6000
    assert uc.call('ese_dti_us_to_window_end', stub={'uc_read_tsf_lo': UC_BI0 + 13000}) == 26
    assert uc.call('ese_dti_us_to_window_end', stub={'uc_read_tsf_lo': UC_BI0 + 13100}) == 0xffffffff
    uc.call('ese_dti_window_now', stub={'uc_read_tsf_lo': UC_BI0 + 14000})
    assert uc.call('ese_dti_us_to_window_end', stub={'uc_read_tsf_lo': UC_BI0 + 14000}) == 0xffffffff


# ---------------------------------------------------------------------------------------------------------------------
# uc: цикл источника в своём SP (10.39.6.2) и наведение приёма назначения (uc/ese_dti.c, рычаги 3 и 4)
# ---------------------------------------------------------------------------------------------------------------------
RX_SEL, OMNI = 0x6020, 0x0020                                   # sta_entry.rx_sel / omni_rx_sel (стенд, MAC-STAND)
SG_INIT_SP, SG_RX_PEER, SG_RX_END, SG_SRC_END = 0x0a, 0x0b, 0x0c, 0x10   # struct fwsh_sp_gate
SG_SRC_MORE, SG_ROUNDS, SG_ENDS, SG_STEERS = 0x14, 0x15, 0x16, 0x17
BI_PHASE = 0x802f44 + 0x38                                      # bi_ctx.phase (1 — DTI)
RF_CHAIN_WORD, RF_GAIN_CB, RX_FLOW_TIMEOUT_US = 0x801024, 0x8005a8, 0x800518
TXRX_STATE2, TX_CTX0 = 0x8005f8, 0x802978                        # tx_ctx_pool.slot[0]: +0 sta
L_US = 150                                                       # aDMGPPMinListeningTime между SP (fw/tdma.c)
# своя таблица точки: общее CBAP; SP → cid 0, за ним (L) SP cid 0 → точка; SP → cid 1, за ним SP cid 1 → точка
WINS_RX = [(3000, 2000, 1, 0xff, 0), (5026, 8000, 1, 1 << 0, L_US + 8000), (21326, 8000, 1, 1 << 1, L_US + 8000)]


def uc_sel(uc):
    for cid in range(8):
        a = STA_TAB + STA_ENTRY * cid
        uc.w32(a + 4, RX_SEL | cid)
        uc.w32(a + 0xc, OMNI | cid)


def window_now(uc, off):
    uc.calls.clear()
    uc.call('ese_dti_window_now', stub={'uc_read_tsf_lo': UC_BI0 + off, 'rx_mode_configure': 0})
    return [a[:2] for n, a in uc.calls if n == 'rx_mode_configure']


def test_uc_role_src_sp(uc):
    """Роль в окне (рычаг 3): своё SP точки → init_sp = 1 (источник SP — доступ без RTS, конец без CF-End); общее CBAP
    и вне окон — 0; проверка доступа ставит то же на каждом доступе (событие окна могло не дойти)."""
    uc_ap(uc)
    own_table(uc, WINS)
    for off, sp in ((3100, 0), (5100, 1), (13100, 0), (21400, 1)):
        window_now(uc, off)
        assert uc.r8(SP_GATE + SG_INIT_SP) == sp, off
    uc.w8(SP_GATE + SG_INIT_SP, 1)
    gate(uc, 3100)
    assert uc.r8(SP_GATE + SG_INIT_SP) == 0
    gate(uc, 5100)
    assert uc.r8(SP_GATE + SG_INIT_SP) == 1
    uc.w8(FWSH_ESE_SLOT_TBL, 0)                                     # без расписания — всегда 0
    gate(uc, 5100)
    assert uc.r8(SP_GATE + SG_INIT_SP) == 0


def test_uc_rx_steer_ap(uc):
    """Точка — назначение SP станции к ней (рычаг 4): после своего SP к станции i в пределах rx_tail_us приём наводится
    на i (rx_mode_configure(3, i), fwsh_sp_gate.rx_peer = i + 1, rx_end_tsf — конец SP i → точка); в следующем своём
    окне — снято (rx_mode_configure(3, i) без наведения), до первого SP — ничего."""
    uc_ap(uc)
    uc_sel(uc)
    own_table(uc, WINS_RX)
    assert window_now(uc, 2000) == [] and uc.r8(SP_GATE + SG_RX_PEER) == 0
    assert window_now(uc, 5100) == []
    assert window_now(uc, 13026 + 60) == [(3, 0)]
    assert uc.r8(SP_GATE + SG_RX_PEER) == 1
    assert uc.r32(SP_GATE + SG_RX_END) == UC_BI0 + 13026 + L_US + 8000
    assert uc.r8(SP_GATE + SG_INIT_SP) == 0 and uc.r8(SP_GATE + 9) == 1    # init_hold: точка обмен не начинает
    assert window_now(uc, 13176 + 3000) == []                        # тот же SP — без повторной настройки
    assert window_now(uc, 21326 + 10) == [(3, 0)]                    # своё SP к cid 1 — наведение снято
    assert uc.r8(SP_GATE + SG_RX_PEER) == 0 and uc.r8(SP_GATE + SG_INIT_SP) == 1
    assert window_now(uc, 29326 + 10) == [(3, 1)] and uc.r8(SP_GATE + SG_RX_PEER) == 2
    assert uc.r8(SP_GATE + SG_STEERS) == 2
    uc.w8(FWSH_ESE_SLOT_TBL, 0)                                     # строгий TDMA снят — наведения нет
    assert window_now(uc, 29326 + 20) == [(3, 1)] and uc.r8(SP_GATE + SG_RX_PEER) == 0


def test_uc_rx_steer_sta(uc):
    """Станция — назначение SP точки к ней (запись ESE без б7, Allocation Type 0): приём наведён на точку до конца SP;
    в своём SP станция — источник (init_sp = 1), наведение снято; CBAP — ни то, ни другое."""
    uc_ap(uc)
    uc_sel(uc)
    uc.w32(UC_ROLE_AP, 0)
    uc.w8(FWSH_DIAG_ESE_SCHED, 1)
    t = FWSH_ESE_SLOT_TBL
    uc.w8(t, 2)
    uc.w8(t + 1, 3)
    for i, (ctrl, st, du) in enumerate(((0x91, 3000, 2000), (0x01, 5026, 8000), (0x81, 13176, 8000))):
        e = t + 4 + 0xc * i
        uc.w8(e, ctrl)
        uc.w8(e + 1, 1 << 0)                                        # пир — точка (cid 0)
        uc.w32(e + 4, st)
        uc.w16(e + 8, du)
        uc.w16(e + 0xa, 0xffff)                                     # таблица ESE: поле только своей таблицы точки
    assert window_now(uc, 3100) == [] and uc.r8(SP_GATE + SG_INIT_SP) == 0
    assert window_now(uc, 6026) == [(3, 0)]
    assert uc.r8(SP_GATE + SG_RX_PEER) == 1 and uc.r32(SP_GATE + SG_RX_END) == UC_BI0 + 13026
    assert uc.r8(SP_GATE + SG_INIT_SP) == 0
    assert window_now(uc, 13200) == [(3, 0)]
    assert uc.r8(SP_GATE + SG_RX_PEER) == 0 and uc.r8(SP_GATE + SG_INIT_SP) == 1


@pytest.mark.parametrize('peer, end_off, want', [(1, 500, RX_SEL), (0, 500, OMNI), (1, -1, OMNI), (2, 500, OMNI)])
def test_uc_rx_mode_steered_sector(uc, peer, end_off, want):
    """rx_mode_configure (режим прослушивания 3, пир cid 0): при наведении на этот пир до rx_end_tsf — сектор приёма
    rx_sel пира (10.39.6.2: назначение слушает источник), иначе — сектор простоя omni_rx_sel (как прежде)."""
    uc_ap(uc)
    uc_sel(uc)
    uc.w32(RF_GAIN_CB, uc.sym['internal_tx_noop_isr_hook'])
    uc.w8(SP_GATE + SG_RX_PEER, peer)
    uc.w32(SP_GATE + SG_RX_END, UC_BI0 + 1000 + end_off)
    uc.calls.clear()
    uc.call('rx_mode_configure', 3, 0, stub={'uc_read_tsf_lo': UC_BI0 + 1000, 'rf_set_cur_sector_word': 0,
                                             'hwd_phy_rx_set_agc_start_val_and_gain_array_uc': 0,
                                             'phy_set_rx_agc_row': 0})
    assert uc.r32(RF_CHAIN_WORD) == want
    assert [a[0] for n, a in uc.calls if n == 'rf_set_cur_sector_word'] == [want]


def test_uc_sp_exchange_end_no_cf_end(uc):
    """Конец обмена в своём SP (рычаг 3): закрытие TXOP (tx_cca_check_and_send) не передаёт ничего — ни запроса
    итога (QoS Null MAC), ни CF-End (10.39.8.1: CF-End в SP — усечение SP) — и не ждёт слота; tx_send_and_await_rx_frame
    (закрытие из mtp_get_tx_permission) — без CF-End; отмечен конец обмена (src_end_tsf — для SLS, src_ends). Вне своего
    SP — прежнее закрытие (команды MAC)."""
    uc_ap(uc)
    uc.w32(TX_CTX0, 0)
    uc.w8(SP_GATE + SG_INIT_SP, 1)
    uc.w32(TXRX_STATE2, 0)
    uc.call('tx_cca_check_and_send', TX_CTX0, 1, 1, 0, stub={'uc_read_tsf_lo': UC_BI0 + 7000})
    assert uc.mac_cmds == []
    assert uc.r32(TXRX_STATE2) & (1 << 9)                           # закрытие сделано: цикл TXOP выходит
    assert uc.r32(SP_GATE + SG_SRC_END) == UC_BI0 + 7000 and uc.r8(SP_GATE + SG_ENDS) == 1
    # закрытие без запроса итога (путь mtp_get_tx_permission после него — так же): ни CF-End (FIFO 0x33, пуск 0x18,
    # Duration 0x15/0x14), ни ожидания ответа — только чтение остатка TXOP (выбор селектора 0x1d)
    assert uc.call('tx_send_and_await_rx_frame', TX_CTX0, 0, 0, 0, stub={'uc_read_tsf_lo': UC_BI0 + 7100}) == 1
    assert [c for c in uc.mac_cmds if c >> 24 != 0x1d] == [] and uc.r8(SP_GATE + SG_ENDS) == 2
    uc.w8(SP_GATE + SG_INIT_SP, 0)
    uc.ext[40] = 0                                                  # проба CCA не прошла (mac_cca_ok)
    uc.call('tx_cca_check_and_send', TX_CTX0, 1, 1, 0, stub={'mac_select_all_sectors_and_wait': 0})
    assert 0x29000001 in uc.mac_cmds and 0x29000002 in uc.mac_cmds   # прежний путь: проба CCA перед закрытием


def test_uc_sp_source_cycle(uc):
    """Цикл источника: на начале своего SP (событие окна, фаза DTI) источник начинает обмен сам — без отсрочки EDCA
    (10.39.6.2 «at the start of the SP»); не своё SP или не DTI — нет; следующий доступ — пока был доступ (src_more),
    иначе выход."""
    uc_ap(uc)
    run = lambda fn: (uc.calls.clear(), uc.call(fn, stub={'fixed_sched_run_tx_slot': 0}),
                      sum(n == 'fixed_sched_run_tx_slot' for n, _ in uc.calls))[2]
    uc.w32(BI_PHASE, 1)
    uc.w8(SP_GATE + SG_INIT_SP, 1)
    assert run('ese_dti_sp_src_start') == 1                          # стаб доступа src_more не ставит — один круг
    assert uc.r8(SP_GATE + SG_SRC_MORE) == 0 and uc.r8(SP_GATE + SG_ROUNDS) == 1
    uc.w32(BI_PHASE, 2)
    assert run('ese_dti_sp_src_start') == 0
    uc.w32(BI_PHASE, 1)
    uc.w8(SP_GATE + SG_INIT_SP, 0)
    assert run('ese_dti_sp_src_start') == 0
    assert run('ese_dti_sp_src_cycle') == 0
    uc.w8(SP_GATE + SG_SRC_MORE, 1)
    assert run('ese_dti_sp_src_cycle') == 1


def test_uc_sls_after_sp_exchange(uc):
    """SLS-инициатор в своём SP — не раньше rx_flow_timeout_us + шаг цикла после конца своего обмена без CF-End:
    назначение до этого ждёт кадров обмена и SSW за кадр данных (ese_dti_sls_fits); позже — по остатку окна."""
    uc_ap(uc)
    own_table(uc, WINS)
    uc.w32(RX_FLOW_TIMEOUT_US, 300)
    uc.w32(SP_GATE + SG_SRC_END, UC_BI0 + 6000)
    fits = lambda off: uc.call('ese_dti_sls_fits', 500, stub={'uc_read_tsf_lo': UC_BI0 + off})
    assert fits(6000 + 300) == 0
    assert fits(6000 + 401) == 1
    assert fits(13026 - 1000) == 0                                  # 2·ISS + хвост SLS не помещаются до конца окна


# =====================================================================================================================
# эфир: точка + станция, строгий TDMA (fw и uc обоих узлов во времени модели, air.Air)
# =====================================================================================================================
AIR_BI_TU = 100
AIR_NBI = int(os.environ.get('SPARRAW_TDMA_NBI', '2'))          # BI с расписанием под нагрузкой
RESP_KINDS = {'Ack', 'BlockAck', 'DMG CTS', 'SSW-Feedback', 'SSW-Ack'}


def run_strict_air(fw_elf, build_dir, uc_fw, nbi=AIR_NBI, mode=MODE_SP, drop=None, burst=1):
    """Точка (строгий TDMA при одной станции: WMI 0x0f10 enable 1, min_sta 1) и станция: ассоциация в живом эфире,
    кольца TX обеих сторон, затем nbi BI данных в обе стороны (по burst кадров 1200 Б в каждую сторону каждую мс, пока в
    кольце хоста меньше 2·burst). drop(air, src, frame, rec) → True — кадр в эфире не принял никто (только в фазе
    данных)."""
    import fwemu
    import ucemu
    import ref_bridge2 as RB
    from air import Air
    from cosim import CoSim

    def node(mac):
        n = CoSim(fwemu.FW(fw_elf).boot(), ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw), first_tbtt_us=10_000)
        n.mac = mac
        return n
    ap, sta = node(Fl.AP_MAC), node(Fl.STA_MAC)
    ap.bssid = sta.bssid = ap.mac
    with ap:
        Fl.Fw(ap.fw).set_mac(ap.mac)
        Fl.Fw(ap.fw).set_ssid(b'test')
        Fl.Fw(ap.fw).ap_start(bi=AIR_BI_TU)
        ap.fw.wmi(WMI_TDMA_CFG, tdma_cfg(1, 1, mode))
        Fl.settle(ap.fw)
    with sta:
        Fl.Fw(sta.fw).set_mac(sta.mac)
    ap.hw.backoff_seed, sta.hw.backoff_seed = 1, 1001
    ap.live()
    sta.live()
    sta.wmi(Fl.WMI_CONNECT, Fl.connect_cmd(bssid=ap.mac, ssid=b'test'))
    air = Air([ap, sta])
    for _ in range(400):
        air.run_us(500)
        if any(e.id == 0x1002 for e in sta.fw.wmi_evts):
            break
    ce = [e for e in sta.fw.wmi_evts if e.id == 0x1002]
    ace = [e for e in ap.fw.wmi_evts if e.id == 0x1002]
    assert ce and ace, 'нет WMI_CONNECT_EVENT'
    sta.wmi(Fl.WMI_VRING_CFG, Fl.vring_cfg_cmd(0, ce[0].body[0x13]))
    ap.wmi(Fl.WMI_VRING_CFG, Fl.vring_cfg_cmd(0, ace[0].body[0x13]))
    for _ in range(40):
        air.run_us(500)
    # соглашения BA в обе стороны (как под iperf: A-MPDU/BlockAck). Без них данные — Normal Ack, и продолжение TXOP
    # vendor-поиск скорости считает неудачей BA → запрос BF каждые ~3 мс (docs/TDMA.md §2.6) — сценарий был бы о другом
    for a, b in ((sta, ap), (ap, sta)):
        for _try in range(3):
            nb = len(b.fw.wmi_evts)
            a.wmi(Fl.WMI_RING_BA_EN, Fl.ring_ba_en_cmd(0))
            req = []
            for _ in range(40):
                air.run_us(500)
                req = [e for e in b.fw.wmi_evts[nb:] if e.id == Fl.WMI_RCP_ADDBA_REQ_EVENT]
                if req:
                    break
            if req:
                b.wmi(Fl.WMI_RCP_ADDBA_RESP, Fl.rcp_addba_resp_cmd(req[0].body))
                for _ in range(20):
                    air.run_us(500)
                break
    t0 = sta.hw.now
    end = t0 + nbi * AIR_BI_TU * 1024 * 165
    if drop is not None:
        air.drop = lambda src, frame, rec: drop(air, src, frame, rec)
    k = 0
    while sta.hw.now < end:
        for n, peer in ((sta, ap), (ap, sta)):
            for _ in range(burst):
                if len(n.host_ring.get(0, [])) < 2 * burst:
                    n.host_tx(0, peer.mac, bytes([k & 0xff]) * 1200)
            n.pump()
        k += 1
        air.run_us(1000)
    snap = RB.snapshot(air)
    out = os.environ.get('SPARRAW_TDMA_SNAP')
    if out:
        import pickle
        with open(out, 'wb') as fh:
            pickle.dump(snap, fh)
    return dict(air=air, ap=ap, sta=sta, snap=snap, t0=t0,
                gate_mem={n: bytes(x.uc.r8(SP_GATE + i) for i in range(0x18)) for n, x in (('ap', ap), ('sta', sta))})


def air_bis(snap):
    """Журнал эфира → BI с Extended Schedule в маяке точки: dict(k, entries, params, bic, bti_end, log, aids).
    Allocation Start — на ось времени моста (ref_bridge2.time_base: TSF − phase)."""
    import ref_bridge2 as RB
    from ref import elements as E
    ap = RB.mac(Fl.AP_MAC)
    evs = RB.events(snap, Fl.AP_MAC)
    n = snap['nodes'][bytes(Fl.AP_MAC)]
    phase = n['tbtt_us'] % n['bi_us']
    sched = RB.Schedule(evs, ap, AIR_BI_TU)
    aids = {ap: 0}
    for e in evs:
        if e.kind == E.ASSOC_RESP and e.src == ap and e.p and e.p[0].get('status') == 0:
            aids[e.dst] = e.p[0]['aid'] & 0x3fff
    by = {}
    for e in evs:
        if e.kind == 'DMG Beacon' and e.src == ap and e.p is not None:
            by.setdefault(BI.bi_index(e.t, AIR_BI_TU), []).append(e)
    out = []
    for k in sorted(by):
        b = by[k][0]
        ent = S.from_elements(b.p.elements)
        if ent is None:
            continue
        for x in ent:
            x.alloc.start = (x.alloc.start - phase) % (1 << 32)
        t0, t1 = BI.tbtt(k, AIR_BI_TU), BI.tbtt(k + 1, AIR_BI_TU)
        log = [(e.t, e.te, e.src, e.dst or RB.BCAST, e.kind, e.dur,
                dict(mcs=e.mcs, frame=e.p if e.kind in ('Poll', 'SPR', 'Grant', 'Grant Ack') else None))
               for e in evs if t0 <= e.t < t1 and e.kind != 'DMG Beacon']
        p = b.p.params
        out.append(dict(k=k, entries=ent, params=BI.DmgParameters(p.bss_type, p.cbap_only, p.cbap_source, p.privacy,
                                                                    p.ecapc),
                        bic=RB.bic_bi(b.p.bic), bti_end=sched.bti[k][1], log=log, aids=aids, ap=ap,
                        last=k == max(by)))
    return out


def judge_bi(b, log=None):
    """Судьи эталона над BI: ref/schedule.check (расписание), ref/sp.check_dti (SP и CBAP расписания) и «вне
    распределений» — начало обмена в DTI вне всех SP/CBAP (10.39.4: в DTI с расписанием доступ только в
    распределениях; ответы через SIFS не считаются). → [(rule, msg)]."""
    from ref import sp as SPm
    log = b['log'] if log is None else log
    v = [(r, m) for r, m in S.check(b['entries'], b['k'], AIR_BI_TU, bti_end=b['bti_end'], bic=b['bic'],
                                    params=b['params'], has_es_in_beacon=True) if not r.startswith('should_')]
    dv, _, per = SPm.check_dti(log, b['k'], AIR_BI_TU, b['entries'], b['aids'], b['ap'], bti_end=b['bti_end'],
                               bic=b['bic'], params=b['params'], q=Fr(1))
    v += [(x.rule, x.msg) for x in dv]
    dti0 = BI.bhi_end(per, b['k'], AIR_BI_TU)
    for e in log:
        if e[0] < dti0 or e[4] in RESP_KINDS or BI.period_at(per, e[0]) is not None:
            continue
        v.append(('dti_unallocated', '%s %s @%.1f вне распределений DTI (10.39.4)' % (e[4], e[2], float(e[0]))))
    return v, per


@pytest.fixture(scope='module')
def strict_air(fw_elf, build_dir, uc_fw):
    return run_strict_air(fw_elf, build_dir, uc_fw)


def test_air_strict_schedule_and_access(strict_air):
    """Живой эфир, строгий TDMA при одной станции: каждый BI с Extended Schedule — ref/schedule.check и ref/sp.check_dti
    без нарушений (SP: начинает источник, только источник/получатель, конец SP, без усечения CF-End в
    неусекаемом SP; CBAP расписания — кто начинает, конец CBAP), и ни одного обмена вне распределений DTI. Последний
    BI захвата обрезан — проверяются полные."""
    bis = [b for b in air_bis(strict_air['snap']) if not b['last']]
    assert len(bis) >= AIR_NBI - 1, [b['k'] for b in bis]
    bad = {}
    for b in bis:
        v = judge_bi(b)[0]
        if v:
            bad[b['k']] = v[:10]
    assert not bad, bad


def test_air_strict_sta_table_keeps_init_windows(strict_air):
    """Таблица окон станции (ese_slot_tbl, ESE_SLOTS_N записей) при 4 полях ESE строгого TDMA одной станции (общее CBAP,
    SP точка → станция, SP станция → точка, CBAP остатка BI): сначала окна, где станция может начинать обмен (10.39.5,
    10.39.6.2) — общее CBAP, свой SP, CBAP остатка; SP, где она только получатель, не нужен. Прежде (по порядку полей)
    терялся CBAP остатка: станция в нём не начинала обмен вовсе (стенд 2026-11-10, PMC: ни одного RTS станции в CBAP
    остатка). В эфире станция начинает обмены в CBAP остатка."""
    from fwsh_addr import ESE_SLOT_TBL
    fw = strict_air['sta'].fw
    n = fw.r8(ESE_SLOT_TBL + 1)
    slots = [(fw.r8(ESE_SLOT_TBL + 4 + 12 * i), fw.r8(ESE_SLOT_TBL + 4 + 12 * i + 2),
              fw.r8(ESE_SLOT_TBL + 4 + 12 * i + 3)) for i in range(n)]
    assert n == 3 and all(c & 0x80 for c, _, _ in slots), slots          # б7 — станция может начинать
    assert {(src, dst) for _, src, dst in slots} == {(255, 255), (1, 0)}, slots
    assert sum(1 for c, src, _ in slots if src == 255) == 2               # общее CBAP и CBAP остатка
    sta = RB_mac(Fl.STA_MAC)
    init = 0
    for b in [b for b in air_bis(strict_air['snap']) if not b['last']]:
        _, per = judge_bi(b)
        rem = [p for p in per if p.kind == S.CBAP][-1]
        init += sum(1 for e in b['log'] if e[2] == sta and rem.start <= e[0] < rem.end and e[4] not in RESP_KINDS
                    and e[4] != 'CF-End')
    assert init > 0, 'станция не начинает обмены в CBAP остатка BI'


def _sp_frames(r):
    """Кадры BI в SP с индивидуальным источником: [(kind, src, роль: 'src'|'dst', SP, e)]."""
    out = []
    for b in [b for b in air_bis(r['snap']) if not b['last']]:
        mac_of = {v: k for k, v in b['aids'].items()}
        _, per = judge_bi(b)
        for e in b['log']:
            p = BI.period_at(per, e[0])
            if p is None or p.kind != S.SP or p.src_aid == 255:
                continue
            out.append((e[4], e[2], 'src' if e[2] == mac_of.get(p.src_aid) else 'dst', p, e))
    return out


def test_air_strict_no_cf_end_truncation(strict_air):
    """Цикл источника в своём SP (10.39.6.2, uc/ese_dti.c): в SP ни CF-End (10.39.8.1 — усечение SP; наши SP
    Truncatable = 0, правило судьи sp_after_trunc — в test_air_strict_schedule_and_access), ни RTS/DMG CTS (защита TXOP
    CBAP), ни QoS Null запроса итога; источник шлёт данные, назначение — только ответы (Ack/BlockAck); обмены в SP идут
    у обоих узлов. Без CF-End обмены не встают: данных в SP — не меньше, чем BI × мс трафика / 4."""
    fr = _sp_frames(strict_air)
    kinds = {(k, role) for k, _, role, _, _ in fr}
    assert not {k for k, _ in kinds} & {'CF-End', 'RTS', 'DMG CTS'}, sorted(kinds)
    assert {k for k, role in kinds if role == 'dst'} <= RESP_KINDS | {'SSW', 'BRP'}, sorted(kinds)
    srcs = {src for k, src, role, _, _ in fr if role == 'src' and k in DATA}
    assert srcs == {RB_mac(Fl.AP_MAC), RB_mac(Fl.STA_MAC)}, srcs
    n = sum(1 for k, _, role, _, _ in fr if role == 'src' and k in DATA)
    assert n >= (AIR_NBI - 1) * AIR_BI_TU // 4, n


PIFS_US = 8                                                     # SIFS + aSlotTime (Table 20-30)


def _drop_every(n):
    """Потеря в эфире каждого n-го PPDU с кадрами очереди (данные, A-MPDU) — у обоих узлов."""
    cnt = [0]

    def drop(air, src, frame, rec):
        if rec.get('qframe') is None:
            return False
        cnt[0] += 1
        return cnt[0] % n == 0
    return drop


@pytest.fixture(scope='module')
def strict_air_lossy(fw_elf, build_dir, uc_fw):
    return run_strict_air(fw_elf, build_dir, uc_fw, drop=_drop_every(5), burst=4)


@pytest.mark.xdist_group('strict_air_lossy')
def test_air_strict_sp_retransmit(strict_air_lossy):
    """Потери в SP (каждый 5-й PPDU данных в эфире не принят), нагрузка по 4 кадра в мс в каждую сторону: судья эталона
    без нарушений (в т. ч. sp_retx — повтор источника не раньше PIFS, sp_end); повторы в SP есть — кадр данных
    источника после его же кадра без ответа, не раньше PIFS и без отсрочки EDCA (цикл источника: не позже срока ответа
    + путь доступа, ≤ 200 мкс); данные доходят в обе стороны."""
    r = strict_air_lossy
    bis = [b for b in air_bis(r['snap']) if not b['last']]
    bad = {b['k']: v[:10] for b in bis for v in [judge_bi(b)[0]] if v}
    assert not bad, bad
    fr = _sp_frames(r)
    retx = []
    for (k0, s0, r0, p0, e0), (k1, s1, r1, p1, e1) in zip(fr, fr[1:]):
        # A-MPDU источника без ответа (BlockAck) и следом его же кадр данных; одиночный «Data» источника — QoS Null (No Ack)
        # запроса итога из mtp_get_tx_permission (docs/TDMA.md §2.3) — ответа и не ждёт
        if r0 == r1 == 'src' and s0 == s1 and k0 == 'A-MPDU' and k1 in DATA and p0 is p1:
            retx.append(float(e1[0] - e0[1]))
    assert retx, 'повторов в SP нет'
    assert min(retx) >= PIFS_US and max(retx) <= 200, retx
    assert len(r['ap'].host_rx) >= 200 and len(r['sta'].host_rx) >= 200, (len(r['ap'].host_rx), len(r['sta'].host_rx))


def _by_period(b):
    _, per = judge_bi(b)
    c = {}
    for e in b['log']:
        p = BI.period_at(per, e[0])
        key = (p.kind, p.src_aid, p.dst_aid) if p is not None and p.kind in (S.SP, S.CBAP) else None
        c.setdefault(key, []).append(e)
    return c


def test_air_strict_traffic_in_own_windows(strict_air):
    """Данные идут: хост получил кадры в обе стороны; данные точки — в общем CBAP, CBAP остатка и SP точка → станция,
    данные станции — в CBAP и SP станция → точка; в SP точки станция данных не шлёт, в SP станции — точка (10.39.6.2)."""
    r = strict_air
    assert len(r['ap'].host_rx) >= 10 and len(r['sta'].host_rx) >= 10, (len(r['ap'].host_rx), len(r['sta'].host_rx))
    ap, st = RB_mac(Fl.AP_MAC), RB_mac(Fl.STA_MAC)
    aid = None
    data = {}
    for b in [b for b in air_bis(r['snap']) if not b['last']]:
        aid = b['aids'].get(st)
        for key, evs in _by_period(b).items():
            for e in evs:
                if e[4] in ('Data', 'A-MPDU'):
                    data.setdefault((key, e[2]), 0)
                    data[(key, e[2])] += 1
    assert aid is not None
    assert data.get(((S.SP, 0, aid), ap)) and data.get(((S.SP, aid, 0), st)), data
    assert not data.get(((S.SP, 0, aid), st)) and not data.get(((S.SP, aid, 0), ap)), data


def RB_mac(m):
    import ref_bridge2 as RB
    return RB.mac(m)


# ---- негативы: нарушения, внесённые в журнал этого эфира, судья ловит ----
def _first(b, kind, src, period):
    _, per = judge_bi(b)
    for i, e in enumerate(b['log']):
        p = BI.period_at(per, e[0])
        if e[4] in (kind if isinstance(kind, tuple) else (kind,)) and e[2] == src and p is not None and \
                (p.kind, p.src_aid, p.dst_aid) == period:
            return i, p
    return None, None


def _mut(b, i, **kw):
    log = list(b['log'])
    e = list(log[i])
    if 'dt' in kw:
        e[0], e[1] = e[0] + kw['dt'], e[1] + kw['dt']
    if 'src' in kw:
        e[2] = kw['src']
    log[i] = tuple(e)
    log.sort(key=lambda x: (x[0], x[1]))
    return log


DATA = ('Data', 'A-MPDU')


def _bi_with(strict_air, kind, who, period_of):
    for b in [b for b in air_bis(strict_air['snap']) if not b['last']]:
        aid = b['aids'][RB_mac(Fl.STA_MAC)]
        i, p = _first(b, kind, RB_mac(who), period_of(aid))
        if i is not None:
            return b, i, p
    pytest.fail('в эфире нет %s от %s в %s' % (kind, RB_mac(who), period_of(1)))


def test_air_negative_sta_in_ap_sp(strict_air):
    """Данные станции из её SP перенесены в начало SP точка → станция (до кадров точки): sp_first_src (10.39.6.2 — SP
    начинает источник)."""
    b, i, p = _bi_with(strict_air, DATA, Fl.STA_MAC, lambda aid: (S.SP, aid, 0))
    _, per = judge_bi(b)
    sp = [q for q in per if q.kind == S.SP and q.src_aid == 0][0]
    log = _mut(b, i, dt=sp.start + 1 - b['log'][i][0])
    rules = {r for r, _ in judge_bi(b, log)[0]}
    assert 'sp_first_src' in rules, rules


def test_air_negative_foreign_in_sp(strict_air):
    """Кадр третьей станции (AID 2) в SP точка → станция: sp_foreign (10.39.6.2)."""
    b, i, p = _bi_with(strict_air, DATA, Fl.AP_MAC, lambda aid: (S.SP, 0, aid))
    other = '02:00:00:00:00:99'
    b = dict(b, aids=dict(b['aids'], **{other: 2}))
    log = _mut(b, i, src=other)
    rules = {r for r, _ in judge_bi(b, log)[0]}
    assert 'sp_foreign' in rules, rules


def test_air_negative_sp_end(strict_air):
    """Кадр точки сдвинут так, что кончается после конца своего SP: sp_end (10.39.6.2 «In no case … beyond the end of
    that SP»)."""
    b, i, p = _bi_with(strict_air, DATA, Fl.AP_MAC, lambda aid: (S.SP, 0, aid))
    e = b['log'][i]
    log = _mut(b, i, dt=p.end - (e[1] - e[0]) / 2 - e[0])
    rules = {r for r, _ in judge_bi(b, log)[0]}
    assert 'sp_end' in rules, rules


def test_air_negative_unallocated(strict_air):
    """Данные станции из её SP перенесены в Tguard между общим CBAP и первым SP: dti_unallocated (10.39.4)."""
    b, i, p = _bi_with(strict_air, DATA, Fl.STA_MAC, lambda aid: (S.SP, aid, 0))
    _, per = judge_bi(b)
    cb = [q for q in per if q.kind == S.CBAP][0]
    log = _mut(b, i, dt=cb.end + 2 - b['log'][i][0])
    rules = {r for r, _ in judge_bi(b, log)[0]}
    assert 'dti_unallocated' in rules, rules


def test_air_negative_cf_end_truncates(strict_air):
    """CF-End источника пиру в середине своего SP: судья считает SP усечённым (10.39.8.1), дальнейшие кадры пары —
    sp_after_trunc (правило судьи живое — отклонение TXOP_CF_END_RULES оно и ловит)."""
    b, i, p = _bi_with(strict_air, DATA, Fl.AP_MAC, lambda aid: (S.SP, 0, aid))
    e = b['log'][i]
    log = sorted(b['log'] + [(e[1] + 3, e[1] + 3 + 14, e[2], RB_mac(Fl.STA_MAC), 'CF-End', 0, dict(mcs=0, frame=None))],
                 key=lambda x: (x[0], x[1]))
    rules = {r for r, _ in judge_bi(b, log)[0]}
    assert 'sp_after_trunc' in rules, rules
