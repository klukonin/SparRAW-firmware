# SPDX-License-Identifier: AGPL-3.0-or-later
"""Старт эмулятора со снимка памяти (UC.from_snapshot): состояние стенда (debugfs blob_uc_data + blob_fw_peri) →
эмулятор → тот же путь кода и его время в модели. Так проверяются гипотезы о времени на настоящем состоянии, а не на
собранном вручную (повтор завершения BF со снимка стенда — docs/UC-TIMING.md).

Здесь снимок берётся с самого эмулятора: эмулятор со снимка обязан пройти тот же путь за те же такты и оставить ту же
память, что исходный, — иначе снимок теряет состояние (не та область, инициализация модели MAC поверх снимка)."""
import ucemu
from machw import HW

BF_REQ = 0x8020b0                    # bf_req: pending +0, fifo[8] +4, head +0xc, tail +0x10
BF_STA = 0x801ffc                    # bf_sta[]: state +0, flow_status +4
UC_DATA_SIZE = 0x4000                # blob_uc_data
FW_PERI_SIZE = 0x20000               # blob_fw_peri


def inject_bf_done(u):
    """Запрос завершения BF для станции 0 в очереди bf_req — как его ставит обработчик конца SLS."""
    h = u.r32(BF_REQ + 0xc)
    u.w32(BF_REQ, 1)
    u.w8(BF_REQ + 4 + h % 8, 0)
    u.w32(BF_REQ + 0x10, h + 1)
    u.w32(BF_STA, 0xd)
    u.w32(BF_STA + 4, 0)


def run(u):
    hw = u.hw
    t0 = hw.now
    inject_bf_done(u)
    u.call('bf_sm_process_request_fifo')
    return hw.now - t0, u.rbytes(ucemu.DCCM, UC_DATA_SIZE)


def test_snapshot_replays_same_path_and_time(uc):
    HW(uc)                                                   # исходный: модель MAC с ящиком, как после загрузки
    uc_data = uc.rbytes(ucemu.DCCM, UC_DATA_SIZE)
    fw_peri = uc.rbytes(ucemu.FW_PERI, FW_PERI_SIZE)
    now = uc.hw.now
    t_src, mem_src = run(uc)
    u = ucemu.UC.from_snapshot(uc.elf, uc_data, fw_peri)
    HW(u, mailbox=False).now = now                           # тот же момент: TSF в журнале uc считается от now
    t, mem = run(u)
    assert t == t_src and t > 0
    assert mem == mem_src
