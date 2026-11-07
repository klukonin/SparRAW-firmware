# SPDX-License-Identifier: AGPL-3.0-or-later
"""Предел ISS без ответа пира (802.11-2020 10.42.8, рис. 10-91 [p. 1966]: из Idle инициатор SLS начинает ISS заново, только
пока не превышен dot11BFRetryLimit; тайм-аут в Sector Selector в DTI — снова Idle; T2 = dot11MaxBFTime ограничивает
процедуру BF). Стенд 2026-11-06 (ajc3_11.pcap): станция замолчала на ~6 с, точка по каждому сбою RTS начинала новую
развёртку — ~300 ISS/с (19 200 SSW/с, Direction = 0), без ответа. В uc: bf_sm_txss_init_result повторял ISS без ответа
сразу (до 4 раз на запрос), а новый триггер BF (CTS failure, bf_trigger_for_sta) начинал новый запрос без предела.

Сценарий — живой эфир двух узлов (test_air._live_data: ассоциация, кольца, данные станция → AP и AP → станция), затем
станция DEAF_MS мс не слышит точку (кадры точки в эфире теряются), у точки — данные станции. Проверка: за окно точка
начинает не больше 1 + dot11BFRetryLimit ISS; после окна данные идут в обе стороны."""
import pytest

from test_air import _live_data

DOT11_BF_RETRY_LIMIT = 8                          # MIB DEFVAL (uc/ifs.h)
DEAF_MS = 25                                      # окно глухоты станции: без предела точка успевает > 9 ISS (~1,7 мс на ISS)
FC_SSW = b'\x64\x08'


@pytest.fixture(scope='module')
def deaf_sta(fw_elf, build_dir, uc_fw):
    st = dict(t=None, src=None, lost=0)

    def drop(src, frame, rec):
        if st['t'] is not None and src is st['src'] and st['t'] <= rec['start'] < st['t'] + DEAF_MS * 1000 * 165:
            st['lost'] += 1
            return True
        return False
    r = _live_data(fw_elf, build_dir, uc_fw, drop)
    air, ap, sta = r['air'], r['ap'], r['sta']
    n_ap, n_sta = len(ap.host_done), len(sta.host_done)
    st['src'] = ap
    st['t'] = t0 = ap.hw.now
    for k in range(DEAF_MS):                      # окно: точка шлёт данные глухой станции
        ap.host_tx(0, sta.mac, bytes([k]) * 1200)
        ap.pump()
        air.run_us(1000)
    t1 = ap.hw.now
    for _ in range(20):                           # после окна: очередь точки уходит
        air.run_us(1000)
        if len(ap.host_done) - n_ap == DEAF_MS:
            break
    up = [bytes([0x80 + i]) * (1000 + 100 * i) for i in range(5)]
    for p in up:
        sta.host_tx(0, ap.mac, p)
    sta.pump()
    for _ in range(20):
        air.run_us(1000)
        if len(sta.host_done) - n_sta == len(up):
            break
    return dict(air=air, ap=ap, sta=sta, t0=t0, t1=t1, lost=st['lost'], ap_done=ap.host_done[n_ap:],
                sta_done=sta.host_done[n_sta:], up=up)


def iss_starts(air, src, t0, t1):
    """Начала ISS узла src в [t0, t1): SSW с Direction = 0 (поле SSW, рис. 9-834: B0 Direction, B1..B9 CDOWN), у которого
    CDOWN не меньше, чем у предыдущего SSW того же узла (новая развёртка: CDOWN убывает до 0 внутри одной)."""
    out, cd_prev = [], None
    for f in sorted((f for f in air.frames if t0 <= f['start'] < t1 and f['src'] is src), key=lambda f: f['start']):
        if f['frame'][:2] != FC_SSW or f['frame'][16] & 1:
            cd_prev = None
            continue
        cd = int.from_bytes(f['frame'][16:19], 'little') >> 1 & 0x1ff
        if cd_prev is None or cd >= cd_prev:
            out.append(f['start'])
        cd_prev = cd
    return out


@pytest.mark.xdist_group('bf_iss_limit')
def test_iss_without_response_limited(deaf_sta):
    """10.42.8 (рис. 10-91): ISS подряд без ответа — не больше 1 + dot11BFRetryLimit, дальше — не раньше dot11MaxBFTime
    (4 BI = 410 мс при BI 100 TU, за окно не наступает)."""
    r = deaf_sta
    assert r['lost'] > 0
    starts = iss_starts(r['air'], r['ap'], r['t0'], r['t1'])
    assert starts, 'точка не начинала ISS при глухой станции'
    assert len(starts) <= 1 + DOT11_BF_RETRY_LIMIT, (len(starts), [(s - r['t0']) // 165 for s in starts])


@pytest.mark.xdist_group('bf_iss_limit')
def test_link_recovers_both_ways(deaf_sta):
    """После окна станция снова слышит точку: данные точки (накопленные за окно) и данные станции доходят."""
    r = deaf_sta
    assert len(r['ap_done']) == DEAF_MS and all(s == 0 for _, _, s in r['ap_done']), r['ap_done'][:4]
    assert [s for _, _, s in r['sta_done']] == [0] * len(r['up']), r['sta_done']
    got = [f for _, f in r['ap'].host_rx][-len(r['up']):]
    assert [f[-len(p):] for f, p in zip(got, r['up'])] == r['up']
    assert not r['ap'].hw.late and not r['sta'].hw.late
