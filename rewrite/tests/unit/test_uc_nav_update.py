# SPDX-License-Identifier: AGPL-3.0-or-later
"""NAV по принятому Duration против 802.11-2020: 10.3.2.4 (NAV обновляется, если Duration больше текущего NAV; отсчёт
— от PHY-RXEND), 10.28.3 (Duration/ID ≥ 32768 не длительность — игнорируется; < 32768 — длительность), Table 9-9
(0..32767 мкс), 10.23.2.10 (DMG: CF-End — сброс NAV в конце интервала Duration от RXEND), 10.3.2.9 (на RTS отвечать
DMG CTS, только если NAV свободен или его поставил сам отправитель RTS).

Цепочки: приём кадра соседа (rx_update_nav_from_frame / rx_cf_end_nav_reset) → NAV в DCCM (rx_nav) → решение об ответе
на RTS (rx_get_required_response: 3 — DMG CTS, 0 — без ответа). TSF и SIFS_CNT — чтения r55 после команд 0x4d000005 /
0x4d000000; SIFS_CNT здесь — время от RXEND принятого кадра до разбора ([15:8] мкс, [7:0] такты)."""
import pytest

from test_uc_ifs_mac import lmac_mac_cfg

NAV = 0x80146c                      # struct rx_nav_state
NAV_FLAGS, NAV_END, NAV_TA, NAV_ENABLE, NAV_MAX, NAV_ADJ = NAV, NAV + 4, NAV + 0x10, NAV + 0x16, NAV + 0x18, NAV + 0x1c
RX_STATUS1 = 0x804004
RX_FC, RX_DUR, RX_RA, RX_TA = 0x804010, 0x804012, 0x804014, 0x80401a
RX_NAV_UPDATE_EN = 0x800445
RX_RESP_SKIP_CNT, DTI_QSET_MODE, RXF_STA = 0x800480, 0x8004f4, 0x802288
LINK_STAT = 0x857e38
BI_STATE = 0x800600
TX_CTX, OUT = 0x806900, 0x806a00

ME = bytes.fromhex('26181d2600aa')
X = bytes.fromhex('24181d243b0b')        # держатель NAV (TXOP holder)
Y = bytes.fromhex('26181d26d47b')        # третья станция

FC_QOS_DATA = 0x0088                     # тип 2, подтип 8
FC_RTS = 0x00b4                          # тип 1, подтип 11
FC_CF_END = 0x00e4                       # тип 1, подтип 14
FC_DMG_BEACON = 0x000c                   # тип 3 (Extension), подтип 0

T0 = 10_000_000                          # TSF, мкс
ELAPSED = (2 << 8) | 30                  # SIFS_CNT: 2 мкс + 30 тактов от RXEND


class World:
    """TSF/SIFS_CNT по последней команде MAC (r32) перед чтением r55."""

    def __init__(self, uc):
        self.uc, self.tsf, self.elapsed = uc, T0, ELAPSED
        uc.ext[55] = self._r55

    def _r55(self, n, k):
        for e in reversed(self.uc.cpu.trace):
            if e[0] == 'extreg' and e[1] == 'w' and e[2] == 32:
                if e[4] == 0x4d000005:
                    return self.tsf
                if e[4] == 0x4d000000:
                    return self.elapsed
                break
        return 0

    @property
    def rxend(self):
        return self.tsf - ((self.elapsed >> 8) + (self.elapsed & 0xff) / 165)


def world(uc):
    """После загрузки и конфигурации MAC: NAV включён (boot: rx_nav_set_flag_b1_if_enabled(1)) и свободен."""
    lmac_mac_cfg(uc)
    uc.w16(NAV_ENABLE, 1)
    uc.w32(NAV_FLAGS, 2)
    uc.w32(NAV_END, T0 - 1000)               # последний NAV давно истёк
    uc.w8(NAV_ADJ, 0)
    uc.w8(RX_NAV_UPDATE_EN, 1)
    uc.w32(BI_STATE, 0)
    uc.w32(RX_RESP_SKIP_CNT, 0)
    uc.w32(DTI_QSET_MODE, 0)
    uc.w32(RXF_STA, 0)
    uc.w8(LINK_STAT + 0x11, 0)
    return World(uc)


def rx_frame(uc, fc, dur, ta, ra=ME):
    uc.w32(RX_STATUS1, 1 << 23)              # кадр с действительным заголовком (FC/Duration — rx_update_nav_from_frame)
    uc.w16(RX_FC, fc)
    uc.w16(RX_DUR, dur)
    uc.wbytes(RX_RA, ra)
    uc.wbytes(RX_TA, ta)


def neighbour(w, fc, dur, ta, ra=Y):
    """Кадр соседа (r38.neighbour_indication, rx.c rx_flow_handle_frame/rx_flow_step → rx_update_nav_from_frame(1))."""
    rx_frame(w.uc, fc, dur, ta, ra)
    w.uc.call('rx_update_nav_from_frame', 1)


def rts_answered(w, ta):
    """RTS к нам от ta: ответим ли DMG CTS (10.3.2.9)."""
    uc = w.uc
    rx_frame(uc, FC_RTS, 100, ta)
    uc.ext.update({36: 0, 37: 1, 38: 0})
    r = uc.call('rx_get_required_response', TX_CTX, OUT)
    assert r in (0, 3)
    return r == 3


def nav_end(uc):
    return uc.r32(NAV_END)


# ---------------------------------------------------------------------------------------------------------------

def test_duration_sets_nav_from_rx_end(uc):
    """10.3.2.4: NAV = Duration от PHY-RXEND принятого кадра; запоминается его TA (держатель для 10.3.2.9)."""
    w = world(uc)
    neighbour(w, FC_QOS_DATA, 200, X)
    end = nav_end(uc)
    assert w.rxend + 200 <= end < w.rxend + 201
    assert uc.r32(NAV_FLAGS) & 1
    assert uc.rbytes(NAV_TA, 6) == X


def test_rts_answer_respects_nav_holder(uc):
    """10.3.2.9: NAV занят кадром X — RTS от Y без ответа, RTS от X (держатель) — DMG CTS; после конца NAV — CTS и Y."""
    w = world(uc)
    neighbour(w, FC_QOS_DATA, 200, X)
    w.tsf += 10
    assert not rts_answered(w, Y)
    assert rts_answered(w, X)
    w.tsf = T0 + 200 + 5
    assert rts_answered(w, Y)


def test_idle_nav_answers_rts(uc):
    w = world(uc)
    assert rts_answered(w, Y)


def test_smaller_duration_does_not_shorten_nav(uc):
    """10.3.2.4: NAV обновляется, только если принятый Duration больше текущего NAV."""
    w = world(uc)
    neighbour(w, FC_QOS_DATA, 1000, X)
    end = nav_end(uc)
    w.tsf += 100
    neighbour(w, FC_QOS_DATA, 50, Y)
    assert nav_end(uc) == end
    assert uc.rbytes(NAV_TA, 6) == X


def test_larger_duration_extends_nav(uc):
    w = world(uc)
    neighbour(w, FC_QOS_DATA, 100, X)
    w.tsf += 50
    neighbour(w, FC_QOS_DATA, 400, Y)
    assert w.rxend + 400 <= nav_end(uc) < w.rxend + 401
    w.tsf += 300
    assert not rts_answered(w, X)            # держатель теперь Y


def test_duration_zero_leaves_nav_idle(uc):
    """Duration 0 не больше никакого NAV: NAV остаётся свободным, RTS получает ответ."""
    w = world(uc)
    neighbour(w, FC_QOS_DATA, 0, X)
    assert nav_end(uc) <= w.tsf
    w.tsf += 1
    assert rts_answered(w, Y)


def test_duration_5ms(uc):
    w = world(uc)
    neighbour(w, FC_QOS_DATA, 5000, X)
    assert w.rxend + 5000 <= nav_end(uc) < w.rxend + 5001


@pytest.mark.xfail(strict=True, reason='802.11-2020 10.3.2.4 / Table 9-9: Duration 0..32767 мкс устанавливает NAV '
                   'полностью; uc усекает до rx_nav.max_us = 5000 (rx.c rx_nav_set_from_duration, data.c '
                   'rx_nav_max_us = 0x1388)')
@pytest.mark.parametrize('dur', [5001, 20000, 32767])
def test_long_duration_sets_full_nav(uc, dur):
    w = world(uc)
    neighbour(w, FC_QOS_DATA, dur, X)
    assert w.rxend + dur <= nav_end(uc) < w.rxend + dur + 1


@pytest.mark.xfail(strict=True, reason='802.11-2020 10.28.3: Duration/ID ≥ 32768 — не длительность (Table 9-9: '
                   'резерв/AID), у DMG-кадров толкования нет — игнорировать; uc ставит по нему NAV (усекая до 5000 мкс, '
                   'rx.c rx_nav_set_from_duration, проверки б15 нет)')
@pytest.mark.parametrize('dur', [0x8000, 0xc001, 0xffff])
def test_non_duration_values_ignored(uc, dur):
    w = world(uc)
    neighbour(w, FC_QOS_DATA, dur, X)
    w.tsf += 10
    assert rts_answered(w, Y)


@pytest.mark.xfail(strict=True, reason='802.11-2020 10.3.2.4: истёкший NAV равен 0 — любой Duration > 0 его ставит; uc '
                   'сравнивает новый конец с rx_nav.end_tsf по знаку разности (rx.c rx_nav_set_from_duration), не '
                   'глядя, активен ли NAV: через 2^31 мкс (~36 мин) после последнего NAV новый NAV не ставится '
                   '(до следующих ~36 мин)')
def test_nav_set_after_long_quiet_period(uc):
    w = world(uc)
    uc.w32(NAV_END, (T0 - 0x90000000) & 0xffffffff)          # последний NAV — ~40 мин назад, флаг активности снят
    neighbour(w, FC_QOS_DATA, 300, X)
    w.tsf += 10
    assert not rts_answered(w, Y)


# ---- CF-End ---------------------------------------------------------------------------------------------------

@pytest.mark.parametrize('to_us', [False, True], ids=['neighbour_cf_end', 'cf_end_to_us'])
def test_cf_end_resets_nav_at_end_of_its_duration(uc, to_us):
    """10.23.2.10 (DMG): CF-End — сброс NAV в 0 в конце интервала Duration от RXEND, независимо от RA; Duration 0 —
    сразу. NAV 3 мс от X, затем CF-End от X с Duration 40: через 20 мкс NAV ещё занят, через 50 — свободен."""
    w = world(uc)
    neighbour(w, FC_QOS_DATA, 3000, X)
    w.tsf += 100
    if to_us:
        # rx_cf_end_nav_reset (rx.c, встроена в rx_flow_handle_frame) = rx_nav_set_from_duration(1, 0xe4, dur, TA)
        rx_frame(uc, FC_CF_END, 40, X, ME)
        uc.call('rx_nav_set_from_duration', 1, FC_CF_END, 40, RX_TA)
    else:
        neighbour(w, FC_CF_END, 40, X)
    assert w.rxend + 40 <= nav_end(uc) < w.rxend + 41
    t = w.tsf
    w.tsf = t + 20
    assert not rts_answered(w, Y)
    w.tsf = t + 50
    assert rts_answered(w, Y)


def test_cf_end_with_zero_duration_resets_nav_now(uc):
    w = world(uc)
    neighbour(w, FC_QOS_DATA, 3000, X)
    w.tsf += 100
    neighbour(w, FC_CF_END, 0, X)
    assert nav_end(uc) <= w.tsf
    w.tsf += 1
    assert rts_answered(w, Y)


# ---- DMG Beacon -------------------------------------------------------------------------------------------------

@pytest.mark.xfail(strict=True, reason='802.11-2020 10.3.2.4 + 9.3.4.2: NAV по DMG Beacon соседа — его Duration (до '
                   'конца BTI); uc прибавляет 1600 мкс (rx.c rx_update_nav_from_frame: «r2 + 0x640» для кадров '
                   'Extension при a ≠ 0)')
def test_dmg_beacon_nav_is_its_duration(uc):
    w = world(uc)
    neighbour(w, FC_DMG_BEACON, 300, X, ra=X)
    assert w.rxend + 300 <= nav_end(uc) < w.rxend + 301
