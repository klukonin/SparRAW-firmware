# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сценарий сравнения (ref/core/diff_scenario.Scenario) с ядром на адаптере Sparrow (adapter_sparrow, этап 3):

  run_core(scn)                         — точка и станции на ядре, все на адаптере Sparrow (без прошивки): ядро с
                                          разгрузкой Sparrow; против ядра в идеальной среде — где железо/модель MAC
                                          расходятся со стандартом;
  run_mixed(scn, 'ap', fw_elf, ...)     — смешанная пара: точка на ядре + станция на прошивке (CoSim);
  run_mixed(scn, 'sta', fw_elf, ...)    — точка на прошивке + станция на ядре.

SME ядра — как у ядра в идеальной среде (diff_scenario.run_core): соглашение BA открывает сторона с данными; драйвер
прошивки — команды WMI, как в fw_scenario (PCP_START/CONNECT, VRING_CFG, RING_BA_EN, RCP_ADDBA_RESP на запрос пира).
Сетка TBTT узлов прошивки — TSF, кратный BI (first_tbtt_us = 24 000: TBTT 1 024 000 = 10 BI 100 TU и 100 BI 10 TU), как
у точки на ядре (11.1.3.3.1: TBTT — TSF mod BI = 0) — окружение эмулятора, прошивку и модель MAC не меняет. Срыв
эмуляции (air.ModelGapAir) прогон не роняет: эфир до срыва — в снимке, причина — в notes («эмулятор: …»)."""
import os

import fwflows as F
from adapter_sparrow import CLK, CoreNode, MixedAir, snapshot
from air import ModelGapAir
from machw import ModelGap

from ref import fields as RF
from ref.core.ap import DmgApMac
from ref.core.diff_scenario import _trickle, apply_bf
from ref.core.sme import ApSme, StaSme
from ref.core.sta import DmgStaMac
from ref.timing import TU

FIRST_TBTT_US = 24_000
CORE_SSID = b'dmg-core'


def sta_mac(i):
    m = bytearray(F.STA_MAC)
    m[5] = (m[5] + i) & 0xff
    return bytes(m)


class Run:
    def __init__(self, scn, kind):
        self.scn, self.kind = scn, kind
        self.notes, self.marks = [], {}
        self.air = None
        self.gap = None
        self.snapshot = None
        self.core_nodes = []
        self.done = False

    def note(self, msg):
        self.notes.append(msg)


def _core_ap(scn, ssid, t0_clk=0):
    ap = CoreNode(DmgApMac, F.AP_MAC, 'AP', scn.ap_sectors, seed=scn.seed * 7 + 1, backoff_seed=scn.seed,
                  t0_clk=t0_clk)
    sme = ApSme(ap.core, ssid=ssid, bi_tu=scn.bi_tu, abft_slots=scn.abft_slots, fss=scn.fss, dl_bytes=scn.dl_bytes)
    sme.edca = dict(scn.edca)
    sme.addba_on_assoc = True
    apply_bf(scn, [ap.core], ap=ap.core)
    return ap, sme


def _core_sta(scn, i, ssid, t0_clk=0, bssid=None):
    name = 'STA' if scn.n_sta == 1 else f'STA{i + 1}'
    s = CoreNode(DmgStaMac, sta_mac(i), name, scn.sta_sectors, seed=scn.seed * 7 + 2 + i,
                 backoff_seed=1000 * (i + 1) + scn.seed, t0_clk=t0_clk)
    s.core.ap_sectors = scn.ap_sectors
    sme = StaSme(s.core, ssid=ssid, ul_bytes=scn.ul_bytes, bf=scn.bf, probe=scn.probe, bssid=bssid)
    sme.addba = 'ul'
    apply_bf(scn, [s.core], [sme])
    return s, sme


def _sta_done(scn, sme, ap_rx_bytes):
    if sme.state != 'data' or sme.ok_count() < len(sme.ul):
        return False
    if scn.ul_bytes and ap_rx_bytes < scn.ul_bytes:
        return False
    return not scn.dl_bytes or sme.rx_bytes() >= scn.dl_bytes


# =====================================================================================================================
def run_core(scn, step_us=1000):
    """Точка и станции — ядро на адаптере Sparrow."""
    r = Run(scn, 'core-sparrow')
    ap, ap_sme = _core_ap(scn, CORE_SSID)
    stas = [_core_sta(scn, i, CORE_SSID) for i in range(scn.n_sta)]
    r.core_nodes = [ap] + [s for s, _ in stas]
    air = r.air = MixedAir([], r.core_nodes)
    if scn.batch:
        for sme in [ap_sme] + [m for _, m in stas]:
            _trickle(sme, sme.mac.sim, scn.batch, scn.batch_gap_us)
    ap.sim.at(ap.sim.now, ap_sme.start)
    for i, (s, sme) in enumerate(stas):
        s.sim.at(s.sim.now + 1000 + 37 * i, sme.start)

    def done():
        return all(_sta_done(scn, sme, sum(len(x.data) for x in ap_sme.rx if x.source_address == s.core.addr))
                   for s, sme in stas)
    limit = scn.core_max_bis * scn.bi_tu * TU
    try:
        while air.clock_us() < limit and not done():
            air.run_us(step_us)
        air.run_us(2000)
    except ModelGapAir as e:
        r.gap = str(e)
        r.note('эмулятор: срыв на %.1f мкс — %s' % (air.clock_us(), e))
    r.done = done()
    r.ap_sme, r.sta_smes = ap_sme, [m for _, m in stas]
    if not r.done:
        r.note('ядро на Sparrow: сценарий не завершён за %d BI (состояния станций: %s)' % (
            scn.core_max_bis, [m.state for _, m in stas]))
    r.snapshot = snapshot(air)
    return r


# =====================================================================================================================
WMI_CONNECT_EVENT = 0x1002


def _makers(fw_elf, build_dir, uc_fw):
    import fwemu
    import ucemu
    return (lambda: fwemu.FW(fw_elf).boot()), (lambda: ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw))


def _fw_node(mk_fw, mk_uc, mac):
    from cosim import CoSim
    n = CoSim(mk_fw(), mk_uc(), first_tbtt_us=FIRST_TBTT_US)
    n.mac = mac
    return n


def _connected(n):
    return [e for e in n.fw.wmi_evts if e.id == WMI_CONNECT_EVENT]


def _auto_driver(n, seen):
    """Драйвер узла прошивки: на запрос ADDBA пира (WMI_RCP_ADDBA_REQ_EVENT) — WMI_RCP_ADDBA_RESP (как fw_scenario)."""
    evs = n.fw.wmi_evts
    for e in evs[seen.get(id(n), 0):]:
        if e.id == F.WMI_RCP_ADDBA_REQ_EVENT:
            n.wmi(F.WMI_RCP_ADDBA_RESP, F.rcp_addba_resp_cmd(e.body))
    seen[id(n)] = len(evs)


def _msdus(n_bytes, msdu_len, seed):
    out, i = [], 0
    while n_bytes > 0:
        k = min(msdu_len, n_bytes)
        out.append(bytes(((seed + i + j) & 0xFF) for j in range(k)))
        n_bytes -= k
        i += 1
    return out


def run_mixed(scn, core_role, fw_elf, build_dir, uc_fw, step_us=500, sme_pause_us=0, mgmt_mcs=None,
              resp_cmd_delay_clk=0, setup=None):
    """Смешанная пара (одна станция): core_role 'ap' — точка на ядре, станция на прошивке; 'sta' — наоборот.
    sme_pause_us — пауза SME станции-ядра перед MLME-ASSOCIATE и MLME-ADDBA (0 — сразу, как ядро в идеальной
    среде; StaSme.pause_us); mgmt_mcs — MCS кадров управления ядра (None — по умолчанию ядра, MCS 1; DmgMac.mgmt_mcs).
    resp_cmd_delay_clk — задержка ответа MAC узла ядра после точки IFS (CoreNode.resp_cmd_delay_clk; 0 — минимум
    железа H-RESPCMD). Все три — выбор реализации в рамках стандарта; прогон «как ядро» — с умолчаниями.
    setup(core, fw) — вызов после создания узлов, до эфира (сценарии тестов: фаза тика uc и т. п.)."""
    assert scn.n_sta == 1, 'смешанная пара — одна станция'
    import fw_scenario as FS
    r = Run(scn, 'mixed-' + core_role)
    try:
        _run_mixed(r, scn, core_role, fw_elf, build_dir, uc_fw, step_us, FS, sme_pause_us, mgmt_mcs, resp_cmd_delay_clk,
                   setup)
    except (ModelGapAir, ModelGap) as e:
        r.gap = str(e)
        r.note('эмулятор: срыв на %.1f мкс — %s' % (r.air.clock_us() if r.air else 0, e))
    if r.air is not None:
        r.snapshot = snapshot(r.air)
        r.late = [n.hw.late for n in r.air.nodes if n.hw.late]
    return r


def _run_mixed(r, scn, core_role, fw_elf, build_dir, uc_fw, step_us, FS, sme_pause_us=0, mgmt_mcs=None,
               resp_cmd_delay_clk=0, setup=None):
    import machw
    mk_fw, mk_uc = _makers(fw_elf, build_dir, uc_fw)
    ssid = FS.SSID
    seen = {}
    if core_role == 'ap':
        fw = _fw_node(mk_fw, mk_uc, sta_mac(0))
        fw.bssid = F.AP_MAC
        with fw:
            F.Fw(fw.fw).set_mac(fw.mac)
        fw.hw.backoff_seed = 1000 + scn.seed
        fw.live()
        core, sme = _core_ap(scn, ssid, t0_clk=fw.hw.now)
        sta_fw, ap_fw = fw, None
    else:
        fw = _fw_node(mk_fw, mk_uc, F.AP_MAC)
        fw.bssid = fw.mac
        with fw:
            F.Fw(fw.fw).set_mac(fw.mac)
            F.Fw(fw.fw).set_ssid(ssid)
            F.Fw(fw.fw).ap_start(bi=scn.bi_tu)
        fw.hw.backoff_seed = scn.seed
        fw.live()
        # BSSID — как драйвер в WMI_CONNECT (маяк прошивки SSID не несёт, табл. 9-45: элемент необязателен)
        core, sme = _core_sta(scn, 0, ssid, t0_clk=fw.hw.now, bssid=RF.mac_str(F.AP_MAC))
        sme.pause_us = sme_pause_us
        sta_fw, ap_fw = None, fw
    if mgmt_mcs is not None:
        core.core.mgmt_mcs = mgmt_mcs
    core.resp_cmd_delay_clk = resp_cmd_delay_clk
    if scn.batch:
        _trickle(sme, sme.mac.sim, scn.batch, scn.batch_gap_us)    # данные ядра — пачками, как у узла прошивки
    r.core_nodes, r.fw_nodes = [core], [fw]
    r.core_sme = sme
    if setup is not None:
        setup(core, fw)
    air = r.air = MixedAir([fw], [core])
    blocked = False
    if core_role == 'ap':
        if scn.bf == 'abft':
            fw.hw._qsel = lambda: None             # как fw_scenario: доступ станции в DTI закрыт до SSW-Feedback
            blocked = True
        core.sim.at(core.sim.now, sme.start)
        fw.wmi(F.WMI_CONNECT, F.connect_cmd(bssid=F.AP_MAC, ssid=ssid))
    else:
        core.sim.at(core.sim.now + 1000, sme.start)
    # станция-ядро: пассивный поиск MLME-SCAN (MaxChannelTime 120 TU, StaSme.mac_bi_tu) и JOIN по следующему маяку —
    # сверх предела прошивки ещё 120 TU + 3 BI
    t_end = fw.hw.now + (scn.max_us * (2 if scn.bf == 'abft' else 1) +
                         ((120 + 3 * scn.bi_tu) * 1024 if core_role == 'sta' else 0)) * CLK

    def connected():
        if core_role == 'ap':
            return bool(_connected(fw)) and RF.mac_str(fw.mac) in core.core.associated()
        return F.Fw(fw.fw).cid_of(core.mac) is not None and sme.state in ('associated', 'data')

    while fw.hw.now < t_end:
        air.run_us(step_us)
        _auto_driver(fw, seen)
        if blocked and any(f['src'] is core and f['frame'][:2] == b'\x64\x09' and f['frame'][4:10] == bytes(fw.mac)
                           for f in air.frames):
            del fw.hw._qsel
            blocked = False
        if connected():
            break
    r.marks['connected'] = fw.hw.now
    if not connected():
        r.note('смешанная пара: соединение не установлено за %d мкс (станция-ядро: %s)' % (
            scn.max_us, sme.state if core_role == 'sta' else '-'))
        return
    qmask = lambda n: n.hw._raw(machw.HW_QSET0_MASK_VECTOR + 4 * machw.QSET_DATA_MASK)
    # кольца и соглашения BA узла прошивки (драйвер); ядро открывает своё соглашение само (SME)
    if core_role == 'ap' and scn.ul_bytes:
        fw.wmi(F.WMI_VRING_CFG, F.vring_cfg_cmd(0, _connected(fw)[0].body[0x13]))
    if core_role == 'sta' and scn.dl_bytes:
        fw.wmi(F.WMI_VRING_CFG, F.vring_cfg_cmd(0, F.Fw(fw.fw).cid_of(core.mac)))
    fw_tx = (core_role == 'ap' and scn.ul_bytes) or (core_role == 'sta' and scn.dl_bytes)
    if fw_tx:
        for _ in range(40):
            air.run_us(step_us)
            _auto_driver(fw, seen)
            if qmask(fw) & 1:
                break
        n0 = len(fw.fw.wmi_evts)
        fw.wmi(F.WMI_RING_BA_EN, F.ring_ba_en_cmd(0))
        ok = False
        for _ in range(80):
            air.run_us(step_us)
            _auto_driver(fw, seen)
            if any(e.id == F.WMI_BA_STATUS_EVENT for e in fw.fw.wmi_evts[n0:]):
                ok = True
                break
        if not ok:
            r.note('смешанная пара: нет соглашения BA прошивка → ядро')
    r.marks['data'] = fw.hw.now
    want_fw = _msdus(scn.ul_bytes if core_role == 'ap' else scn.dl_bytes, scn.msdu_len, 0x10 if core_role == 'ap'
                     else 0x40) if fw_tx else []
    batch = scn.batch or max(len(want_fw), 1)
    n_batches = -(-len(want_fw) // batch) if want_fw else 0
    peer = F.AP_MAC if core_role == 'ap' else core.mac

    def put(k):
        for p in want_fw[k * batch:(k + 1) * batch]:
            fw.host_tx(0, peer, p)
        fw.pump()
    t0 = fw.hw.now
    sent = 0
    if n_batches:
        put(0)
        sent = 1

    def data_done():
        if want_fw and len(fw.host_done) < len(want_fw):
            return False
        if core_role == 'ap':
            ok_core = not scn.ul_bytes or sum(len(x.data) for x in sme.rx) >= scn.ul_bytes
            ok_fw = not scn.dl_bytes or len([f for t, f in fw.host_rx if t >= r.marks['data']]) >= \
                len(_msdus(scn.dl_bytes, scn.msdu_len, 0x40))
            return ok_core and ok_fw
        ok_core = not scn.dl_bytes or sme.rx_bytes() >= scn.dl_bytes
        ok_fw = not scn.ul_bytes or len([f for t, f in fw.host_rx if f[10:16] == core.mac]) >= \
            len(_msdus(scn.ul_bytes, scn.msdu_len, 0x10))
        return ok_core and ok_fw and sme.ok_count() >= len(sme.ul)

    end = fw.hw.now + (scn.data_max_us + n_batches * scn.batch_gap_us) * CLK
    while fw.hw.now < end:
        air.run_us(min(step_us, scn.batch_gap_us))
        _auto_driver(fw, seen)
        while sent < n_batches and fw.hw.now >= t0 + sent * scn.batch_gap_us * CLK:
            put(sent)
            sent += 1
        if sent >= n_batches and data_done():
            break
    air.run_us(scn.tail_us)
    r.marks['end'] = fw.hw.now
    r.done = data_done()
    # доставка по направлениям
    if core_role == 'ap':
        up = [x.data for x in sme.rx]
        down = [f for t, f in fw.host_rx if t >= r.marks['data']]
        exp_up, exp_down = _msdus(scn.ul_bytes, scn.msdu_len, 0x10), sme.dl_sent.get(RF.mac_str(fw.mac), [])
    else:
        up = [f for t, f in fw.host_rx if f[10:16] == core.mac]
        down = [x.data for x in sme.rx]
        exp_up, exp_down = sme.ul, _msdus(scn.dl_bytes, scn.msdu_len, 0x40)
    r.delivered = dict(ul=(len(up), len(exp_up)), dl=(len(down), len(exp_down)))
    for name, got, exp in (('вверх', up, exp_up), ('вниз', down, exp_down)):
        if [g[-len(p):] for g, p in zip(got, exp)] != list(exp) or len(got) != len(exp):
            r.note('смешанная пара: %s доставлено %d из %d MSDU' % (name, len(got), len(exp)))


# Наборы выбора реализации для смешанной пары (run_mixed(**PRESETS[name])):
#   core   — как ядро в идеальной среде (умолчания ядра, ответ MAC — минимум железа);
#   compat — то, что стандарт тоже допускает, но ближе к узлам прошивки: пауза SME 3 мс перед MLME-ASSOCIATE и
#            MLME-ADDBA, кадры управления на control PHY (MCS 0), ответ через SIFS — через 4,95 мкс после конца PPDU
#            (230 тактов после точки IFS + MACLAT; стенд: DMG CTS через 4,93/4,96 мкс, machw H-RESPCMD).
PRESETS = {'core': dict(), 'compat': dict(sme_pause_us=3000, mgmt_mcs=0, resp_cmd_delay_clk=230)}

_UC_FW = {}


def uc_fw_for(build_dir):
    """Образ vendor fw + наш uc (начальная DCCM) по каталогу сборки — как fw_scenario.run_cfg; один на каталог."""
    if build_dir in _UC_FW:
        return _UC_FW[build_dir]
    import subprocess
    import sys
    import tempfile
    here = os.path.dirname(os.path.abspath(__file__))
    rew = os.path.dirname(os.path.dirname(here))
    vendor = os.path.join(rew, '..', 'images', 'openwrt', 'fw', 'wil6210_6.2.0.1000.fw')
    uc_fw = None
    if os.path.exists(vendor):
        arc = os.environ.get('ARC_DIR', '')
        objcopy = os.path.join(arc, 'bin', 'arc-elf32-objcopy') if arc else 'arc-elf32-objcopy'
        uc_fw = os.path.join(tempfile.mkdtemp(prefix='mixuc'), 'uc.fw')
        p = subprocess.run([sys.executable, os.path.join(rew, 'tools', 'build_fw.py'), '--uc-elf',
                            os.path.join(build_dir, 'uc.elf'), '--vendor', vendor, '--out', uc_fw, '--objcopy',
                            objcopy], capture_output=True, text=True)
        if p.returncode != 0:
            raise RuntimeError(p.stdout[-2000:] + p.stderr[-2000:])
    _UC_FW[build_dir] = uc_fw
    return uc_fw


def run_mixed_cfg(scn, core_role, build_dir, **kw):
    """run_mixed по каталогу сборки (fw.elf, uc.elf) — для CLI ref.core.diff_report."""
    return run_mixed(scn, core_role, os.path.join(build_dir, 'fw.elf'), build_dir, uc_fw_for(build_dir), **kw)
