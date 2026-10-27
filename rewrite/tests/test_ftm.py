# SPDX-License-Identifier: AGPL-3.0-or-later
"""FTM (только SparRAW-PRO): измерения с подключённым пиром, статус SESSION_END для неверного запроса."""
import struct, time
import pytest

pytestmark = [pytest.mark.stand, pytest.mark.sta, pytest.mark.pro]

TOF_SESSION_START = 0x991
TOF_SESSION_END_EVT = 0x1991
TOF_PER_DEST_RES_EVT = 0x1995


def start_cmd(sid, mac, channel=0, word0e=0):
    """Тело WMI_TOF_SESSION_START: один адресат {канал, flags ASAP, token 2, 4 FTM, 1 пачка, длит. 2, период 0, MAC,
    слово +0x0e}."""
    return struct.pack('<IBBHI', sid, 0, 0, 1, 0) + struct.pack('<BBBBBBH6sH', channel, 2, 2, 4, 0, 2, 0, mac, word0e)


def session_start(node, sid, mac, channel=0, word0e=0):
    node.wmi_send(TOF_SESSION_START, start_cmd(sid, mac, channel, word0e))


def session_end_logged(node, image, sid):
    """Статусы WMI_TOF_SESSION_END сессии sid из журнала fw (событие в debugfs mbox ненадёжно: буфер записи кольца
    fw переиспользует)."""
    import re
    return [int(m.group(1), 16) for l in node.fw_log(image)
            for m in [re.search(r'WMI_TOF_SESSION_END session 0x%x status (0x[0-9a-f]+)' % sid, l)] if m]


def peer_mac(s):
    import re
    m = re.search(r'Connected to ([0-9a-f:]{17})', s.dut.run('iw dev %s link' % s.dut.iface(), check=False))
    assert m, 'dut не подключён'
    return bytes.fromhex(m.group(1).replace(':', ''))


def collect(node, seconds, evids=(TOF_SESSION_END_EVT, TOF_PER_DEST_RES_EVT)):
    """События FTM за seconds с частым опросом: кольцо rx в debugfs mbox — 26 записей, затирается за секунды.
    {(id, ид сессии): [тела]} без повторов (одна и та же запись кольца видна в нескольких снимках)."""
    seen, out, t0 = set(), {}, time.time()
    while time.time() - t0 < seconds:
        for i, b in node.mbox_events():
            if i in evids and (i, b) not in seen:
                seen.add((i, b))
                out.setdefault((i, struct.unpack_from('<I', b)[0]), []).append(b)
        time.sleep(0.2)
    return out


def measured(ev, sid):
    return any(b[24] >= 1 for b in ev.get((TOF_PER_DEST_RES_EVT, sid), []))


def end_status(ev, sid):
    return [b[4] for b in ev.get((TOF_SESSION_END_EVT, sid), [])]


def test_ftm_measurement(sta, pro):
    session_start(sta.dut, 0x21, peer_mac(sta))
    ev = collect(sta.dut, 4)
    assert measured(ev, 0x21), 'нет измерений сессии 0x21; события: %s' % sorted(ev)
    assert end_status(ev, 0x21) == [0], 'SESSION_END: %s' % end_status(ev, 0x21)


def test_ftm_word0e_ignored(sta, pro):
    """Слово +0x0e адресата (reserved хоста) не останавливает FTM (vendor читал его как тип запроса)."""
    mac = peer_mac(sta)
    session_start(sta.dut, 0x22, mac, word0e=5)
    ev = collect(sta.dut, 4)
    session_start(sta.dut, 0x23, mac)
    ev.update(collect(sta.dut, 4))
    assert measured(ev, 0x22) and measured(ev, 0x23), 'события: %s' % sorted(ev)


def test_ftm_session_end_params_error(sta, pro, fw_path):
    session_start(sta.dut, 0x24, peer_mac(sta), channel=5)
    time.sleep(1)
    st = session_end_logged(sta.dut, fw_path, 0x24)
    assert st == [2], 'SESSION_END канала 5: %s (ожидается PARAMS_ERROR = 2)' % st

# BUSY (повторный адресат, пока идёт его сессия) на стенде не воспроизводится детерминированно: сессия из одной
# пачки (fw принимает только параметры своих возможностей) кончается раньше, чем драйвер передаёт вторую команду.
