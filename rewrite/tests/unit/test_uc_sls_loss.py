# SPDX-License-Identifier: AGPL-3.0-or-later
"""SLS и BRP при потере SSW-Feedback или SSW-Ack в живом эфире двух узлов (test_air._live_data: ассоциация, BF в DTI
обоих узлов, данные станция → AP и AP → станция; затем 10 мс данных в обе стороны).

Проверки по 802.11-2020:
- каждая развёртка (ISS/RSS) целиком: CDOWN подряд до 0, между SSW — SBIFS (10.42.2.2.2, 10.3.2.3.8; допуск записи
  +0,5 мкс), новая развёртка не начинается поверх недоделанной;
- роли BRP — по SLS (10.42.3.1: в том же распределении инициатор уточнения — инициатор SLS), test_uc_brp_roles.roles;
- данные проходят в обе стороны; ошибок MAC (поздних команд) и uc_assert нет.

Стенд 2026-11-07 (c3a, fix/ajc-3): судья sls — ISS/RSS точки с паузами и RSS точки, начатая до конца ISS станции. В
эмуляторе после правок «ответчик SLS — не инициатор BRP» и «предел ISS без ответа пира» (2026-11-07):
- потеря SSW-Feedback: ответчик SLS входит в поток ответчика BRP с пути приёма, когда TRN-R первого BRP инициатора уже
  в эфире, и меряет с середины поля TRN — uc_assert(4) в brp_program_and_measure;
- потеря SSW-Ack: BRP инициатора при первом BF с пиром шёл не сразу после SSW-Ack, а позже через очередь BF (pick, с
  доступом к среде) — ответчик SLS за это время начинал свой ISS через 2 мкс после BRP инициатора (коллизия, пауза в
  его развёртке)."""
import pytest

from test_air import _live_data
from test_uc_brp_roles import roles

FC_SSW, FC_FB, FC_ACK = b'\x64\x08', b'\x64\x09', b'\x64\x0a'
SBIFS_US, REC_TOL_US = 1.0, 0.5


def _run(fw_elf, build_dir, uc_fw, kind):
    lost = {}

    def drop(src, frame, rec):
        if frame[:2] == kind and not lost.get(id(src)):          # первый такой кадр каждого узла
            lost[id(src)] = rec['start']
            return True
        return False
    r = _live_data(fw_elf, build_dir, uc_fw, drop)
    air, ap, sta = r['air'], r['ap'], r['sta']
    n_ap, n_sta = len(ap.host_done), len(sta.host_done)
    for k in range(10):
        for i in range(2):
            sta.host_tx(0, ap.mac, bytes([k]) * 1200)
            ap.host_tx(0, sta.mac, bytes([k]) * 1200)
        sta.pump()
        ap.pump()
        air.run_us(1000)
    for _ in range(10):
        if len(ap.host_done) - n_ap == 20 and len(sta.host_done) - n_sta == 20:
            break
        air.run_us(1000)
    return dict(r, lost=lost, ap_done=ap.host_done[n_ap:], sta_done=sta.host_done[n_sta:])


def sweeps(air):
    """Развёртки в эфире: [(узел, Direction, CDOWN первого, нарушения)]."""
    out, cur = [], None
    for f in sorted((f for f in air.frames if f['frame'][:2] == FC_SSW), key=lambda f: f['start']):
        v = int.from_bytes(f['frame'][16:19], 'little')
        d, cd = v & 1, (v >> 1) & 0x1ff
        if cur and cur['src'] is f['src'] and cur['d'] == d and cd < cur['cd']:
            g = (f['start'] - cur['end']) / 165
            if cd != cur['cd'] - 1:
                cur['bad'].append('CDOWN %d→%d' % (cur['cd'], cd))
            if not SBIFS_US - 0.03 <= g <= SBIFS_US + REC_TOL_US:
                cur['bad'].append('промежуток %.2f мкс перед CDOWN %d' % (g, cd))
            cur.update(cd=cd, end=f['end'])
            continue
        if cur and cur['cd'] != 0:
            cur['bad'].append('оборвана на CDOWN %d' % cur['cd'])
        cur = dict(src=f['src'], d=d, cd0=cd, cd=cd, end=f['end'], t=f['start'], bad=[])
        out.append(cur)
    if cur and cur['cd'] != 0:
        cur['bad'].append('оборвана на CDOWN %d' % cur['cd'])
    return out


@pytest.fixture(scope='module')
def fb_lost(fw_elf, build_dir, uc_fw):
    return _run(fw_elf, build_dir, uc_fw, FC_FB)


@pytest.fixture(scope='module')
def ack_lost(fw_elf, build_dir, uc_fw):
    return _run(fw_elf, build_dir, uc_fw, FC_ACK)


def _check(r):
    assert r['lost'], 'потери не было'
    sw = sweeps(r['air'])
    bad = [(s['t'] // 165, 'AP' if s['src'] is r['ap'] else 'STA', s['d'], s['bad']) for s in sw if s['bad']]
    assert not bad, bad
    _, _, wrong = roles(r['air'])
    assert not wrong, wrong[:4]
    assert len(r['sta_done']) == 20 and all(s == 0 for _, _, s in r['sta_done']), len(r['sta_done'])
    assert len(r['ap_done']) == 20 and all(s == 0 for _, _, s in r['ap_done']), len(r['ap_done'])
    assert not r['ap'].hw.late and not r['sta'].hw.late


@pytest.mark.xdist_group('sls_loss_fb')
def test_sls_lost_feedback(fb_lost):
    """Потерян первый SSW-Feedback каждого узла: инициатор повторяет его (10.42.6.2); развёртки целы, роли BRP верны."""
    _check(fb_lost)


@pytest.mark.xdist_group('sls_loss_ack')
def test_sls_lost_ack(ack_lost):
    """Потерян первый SSW-Ack каждого узла: развёртки целы (ответчик не начинает свою поверх BRP инициатора), роли BRP
    верны, данные — в обе стороны."""
    _check(ack_lost)
