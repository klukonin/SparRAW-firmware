# SPDX-License-Identifier: AGPL-3.0-or-later
"""Затравка ГПСЧ отсрочки EDCA (txrx_api_program_edca_ac, HW_MAC_EDCA_SEED по AC).

802.11-2020 10.23.2.2: число слотов отсрочки — случайное, равномерное на [0, CW]. Vendor писал 0xc0adc0ad << AC —
одинаково у всех узлов: узлы с общим моментом начала (конец ассоциации) выбирали одни и те же слоты (MAC-STAND
«Столкновение ISS двух инициаторов»). Теперь затравка — аппаратный ГСЧ XOR свой адрес; узлы с разными адресами при
одинаковом ГСЧ получают разные затравки; нулевой затравки нет."""
import struct

import pytest

M32 = 0xffffffff
HW_RNG_VALUE = 0x880bc4
HW_PRS_OWN_ADDR_LO, HW_PRS_OWN_ADDR_HI = 0x886018, 0x88601c
HW_MAC_EDCA_SEED = 0x886d78
SCRATCH = 0x806800                   # свободная часть разделяемой области DCCM (тело LMAC-команды)


def _seed(uc, ac, rng, lo, hi):
    uc.w32(HW_RNG_VALUE, rng)
    uc.w32(HW_PRS_OWN_ADDR_LO, lo)
    uc.w32(HW_PRS_OWN_ADDR_HI, hi)
    uc.cpu.write(SCRATCH, struct.pack('<IHHH2x', ac, 4, 10, 3))   # struct lmac_edca_ac
    uc.call('txrx_api_program_edca_ac', ac, SCRATCH)
    return uc.r32(HW_MAC_EDCA_SEED + 4 * ac)


@pytest.mark.parametrize('ac', range(4))
def test_seed_from_rng_and_own_addr(uc, ac):
    rng, lo, hi = 0x13579bdf, 0x1d2418, 0x80007b26
    want = (rng ^ lo ^ (hi << 16) ^ (0xc0adc0ad << ac)) & M32
    assert _seed(uc, ac, rng, lo, hi) == want


def test_nodes_with_same_rng_differ(uc):
    a = _seed(uc, 0, 0x5a5a5a5a, 0x1d2418, 0x80000b3b)   # точка 24:18:1d:24:3b:0b
    b = _seed(uc, 0, 0x5a5a5a5a, 0x1d2418, 0x80007bd4)   # станция 24:18:1d:26:d4:7b
    assert a != b


def test_zero_seed_replaced(uc):
    assert _seed(uc, 0, 0xc0adc0ad, 0, 0) == 0xc0adc0ad
