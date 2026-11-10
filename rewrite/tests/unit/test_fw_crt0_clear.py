# SPDX-License-Identifier: AGPL-3.0-or-later
"""crt0 fw (fw/start.S) — одинаковое состояние памяти при любом старте. После тёплой перезагрузки хоста или перезапуска
fw драйвером SRAM хранит данные прошлого запуска, после включения питания — узор включения. Память заполняется узором
(«прошлый запуск»), исполняется _reset до вызова fw_main, затем проверяется: вся SRAM периферии 0x840000..0x860000
(карта драйвера, fw_peri) — нули, кроме board-файла хоста brd_file_buf 0x84f800..0x851bff; ни одной записи за
0x860000 и в DCCM, кроме переменных, которые crt0 пишет явно."""
import pytest

PATTERN = 0xa5
PERI, PERI_END = 0x840000, 0x860000
BRD, BRD_END = 0x84f800, 0x84f800 + 0x2400


class _AtFwMain(Exception):
    pass


def _stop(fw, args):
    raise _AtFwMain()


def _after_dc_ctrl(fw):
    """Адрес команды за «sr r0,[dc_ctrl]» в _reset (эмулятор не знает aux dc_ctrl; кэш ему не нужен)."""
    a = fw.a('_reset')
    for _ in range(64):
        if fw.r32(a) == 0x020120ab:                 # sr r0,[0x48]: 20ab 0201
            return a + 4
        a += 2
    raise AssertionError('нет sr dc_ctrl в _reset')


@pytest.fixture
def crt0(fw_elf):
    import fwemu
    fw = fwemu.FW(fw_elf)
    for a in range(PERI, PERI_END + 0x100):
        fw.w8(a, PATTERN)
    fw.w32(0x800000, 0x12345678)                    # __bss_end (пустая .bss): переменная образа, crt0 её не трогает
    with pytest.raises(RuntimeError) as e:
        fw.call(_after_dc_ctrl(fw), stub={'static_ctors_run': 0, 'fw_main': _stop})
    assert isinstance(e.value.__cause__, _AtFwMain), e.value
    return fw


def test_crt0_clears_all_peri_sram_except_board_file(crt0):
    fw = crt0
    dirty = [hex(a) for a in range(PERI, PERI_END, 4) if not BRD <= a < BRD_END and fw.r32(a) != 0]
    assert dirty == []
    assert all(fw.r32(a) == PATTERN * 0x01010101 for a in range(BRD, BRD_END, 4)), 'board-файл хоста затёрт'


def test_crt0_writes_nothing_outside(crt0):
    """Ровно [start, end): ни слова за 0x860000 (отсутствующий адрес вешает шину) и в пустой .bss."""
    assert crt0.r32(PERI_END) == PATTERN * 0x01010101
    assert crt0.r32(0x800000) == 0x12345678


def test_crt0_uc_sector_ranking_zero(crt0):
    """rank_b1[cid][0..1] uc читает до первой записи (uc/tail.c, uc/cmd.c) — после crt0 там нули."""
    assert all(crt0.r32(a) == 0 for a in range(0x857a00, 0x857e38, 4))
