# SPDX-License-Identifier: AGPL-3.0-or-later
"""Исполнитель сценария сравнения (ref/core/diff_scenario.Scenario) на прошивке в эмуляторе: fw + uc каждого узла в
air.Air, драйвер — команды WMI (как test_ref_diff.run_live / test_air._live_rd). Возвращает снимок эфира
ref_bridge2.snapshot и сведения о прогоне — вход сравнителя ref/core/diff_report.

Прошивка и uc не меняются; сценарий задаёт только то, что задаёт драйвер (BI, SSID, число станций, данные хоста) и
окружение эмулятора (seed отсрочки). Остальные параметры BSS (секторы, A-BFT, EDCA) прошивка выбирает сама — они
сравниваются как поведение (diff_report: «параметры BSS»).

BF «A-BFT»: доступ станции к среде в DTI закрыт (арбитр очередей machw, как test_air.abft_run), пока точка не ответит
ей SSW-Feedback в A-BFT; затем открыт. Это окружение эмулятора (на стенде станция входит в BTI с пути приёма и A-BFT
пропускает — test_air), не правка модели MAC."""
import os

import fwflows as F
from air import Air
from cosim import CoSim

WMI_CONNECT_EVENT = 0x1002
SSID = b'test'


def sta_mac(i):
    """MAC станции i: первая — fwflows.STA_MAC (как в тестах эфира), дальше — последний октет + i."""
    m = bytearray(F.STA_MAC)
    m[5] = (m[5] + i) & 0xff
    return bytes(m)


def _makers(fw_elf, build_dir, uc_fw):
    import fwemu
    import ucemu
    return (lambda: fwemu.FW(fw_elf).boot()), (lambda: ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw))


def _node(mk_fw, mk_uc, mac):
    n = CoSim(mk_fw(), mk_uc(), first_tbtt_us=10_000)
    n.mac = mac
    return n


def _msdus(n_bytes, msdu_len, seed):
    out, i = [], 0
    while n_bytes > 0:
        n = min(msdu_len, n_bytes)
        out.append(bytes(((seed + i + k) & 0xFF) for k in range(n)))
        n_bytes -= n
        i += 1
    return out


class Run:
    """Прогон: air, узлы, отметки фаз (такт модели) и итог по фазам (что не состоялось — notes)."""
    def __init__(self, scn):
        self.scn = scn
        self.notes = []
        self.marks = {}
        self.air = self.ap = None
        self.stas = []

    def note(self, msg):
        self.notes.append(msg)


def _connected(n):
    return [e for e in n.fw.wmi_evts if e.id == WMI_CONNECT_EVENT]


def _ba_agree(air, orig, resp, ring, step_us, tries=40):
    """Соглашение BA orig → resp, как у драйвера (WMI_RING_BA_EN → ADDBA → WMI_RCP_ADDBA_RESP). → bool."""
    n_o, n_r = len(orig.fw.wmi_evts), len(resp.fw.wmi_evts)
    orig.wmi(F.WMI_RING_BA_EN, F.ring_ba_en_cmd(ring))
    req = []
    for _ in range(tries):
        air.run_us(step_us)
        req = [e for e in resp.fw.wmi_evts[n_r:] if e.id == F.WMI_RCP_ADDBA_REQ_EVENT]
        if req:
            break
    if not req:
        return False
    resp.wmi(F.WMI_RCP_ADDBA_RESP, F.rcp_addba_resp_cmd(req[0].body))
    for _ in range(tries):
        air.run_us(step_us)
        if any(e.id == F.WMI_BA_STATUS_EVENT for e in orig.fw.wmi_evts[n_o:]):
            return True
    return False


def run(scn, fw_elf, build_dir, uc_fw, step_us=500):
    """Сценарий scn на прошивке в эмуляторе → Run (r.air — эфир, r.snapshot — ref_bridge2.snapshot). Срыв эмуляции
    (air.ModelGapAir: uc_assert узла, пробел модели эфира) не роняет прогон: эфир до срыва — в снимке, причина — в
    r.notes с префиксом «эмулятор:» и в r.gap."""
    import ref_bridge2 as RB
    from air import ModelGapAir
    r = Run(scn)
    r.gap, r.late = None, []
    try:
        _run(r, scn, fw_elf, build_dir, uc_fw, step_us)
    except ModelGapAir as e:
        r.gap = str(e)
        r.note('эмулятор: срыв на %.1f мкс модели — %s' % (r.ap.hw.now / 165 if r.ap else 0, e))
    if r.air is not None:
        r.late = [n.hw.late for n in [r.ap] + r.stas if n.hw.late]
        r.snapshot = RB.snapshot(r.air)
    return r


def _run(r, scn, fw_elf, build_dir, uc_fw, step_us):
    import machw
    mk_fw, mk_uc = _makers(fw_elf, build_dir, uc_fw)
    ap = _node(mk_fw, mk_uc, F.AP_MAC)
    stas = [_node(mk_fw, mk_uc, sta_mac(i)) for i in range(scn.n_sta)]
    r.ap, r.stas = ap, stas
    for n in [ap] + stas:
        n.bssid = ap.mac
    with ap:
        F.Fw(ap.fw).set_mac(ap.mac)
        F.Fw(ap.fw).set_ssid(SSID)
        F.Fw(ap.fw).ap_start(bi=scn.bi_tu)
    for s in stas:
        with s:
            F.Fw(s.fw).set_mac(s.mac)
    ap.hw.backoff_seed = scn.seed
    for i, s in enumerate(stas):
        s.hw.backoff_seed = 1000 * (i + 1) + scn.seed
    ap.live()
    for s in stas:
        s.live()
    air = Air([ap] + stas)
    r.air = air
    blocked = set()
    if scn.bf == 'abft':
        for s in stas:
            s.hw._qsel = lambda: None              # A-BFT: без доступа станции в DTI до SSW-Feedback точки
            blocked.add(id(s))
    # Станции подключаются по очереди: следующая — после WMI_CONNECT_EVENT предыдущей. Одновременный WMI_CONNECT двух
    # станций в эмуляции кончается uc_assert(0x27) (l1_task_on_evt1: событие приёма при выключенном RX): эфир
    # доставляет кадр соседней станции узлу в окне «RX off → RX on» подключения — у MAC с выключенным приёмом события
    # нет (пробел модели air.py, не прошивки). По той же причине следующая станция подключается в тишине эфира
    # (QUIET_US без передач): иначе uc_assert(0x7d) — RX on при незавершённом приёме (счётчики PPDU и CCA разошлись).
    stas[0].wmi(F.WMI_CONNECT, F.connect_cmd(bssid=ap.mac, ssid=SSID))
    started = 1
    limit_clk = scn.max_us * 165 + ap.hw.now

    def unblock():
        for s in stas:
            if id(s) in blocked and any(f['src'] is ap and f['frame'][:2] == b'\x64\x09' and
                                        f['frame'][4:10] == bytes(s.mac) for f in air.frames):
                del s.hw._qsel
                blocked.discard(id(s))

    while ap.hw.now < limit_clk:
        air.run_us(step_us)
        unblock()
        if started < len(stas) and _connected(stas[started - 1]) and _quiet(air, ap, QUIET_US):
            stas[started].wmi(F.WMI_CONNECT, F.connect_cmd(bssid=ap.mac, ssid=SSID))
            started += 1
        if all(_connected(s) for s in stas) and all(_connected_ap(ap, s) for s in stas):
            break
    r.marks['connected'] = ap.hw.now
    if not all(_connected(s) for s in stas):
        r.note('прошивка: не все станции подключились за %d мкс' % scn.max_us)
        return
    # кольца TX и соглашения BA (драйвер: wil_vring_init_tx, wmi_addba)
    qmask = lambda n: n.hw._raw(machw.HW_QSET0_MASK_VECTOR + 4 * machw.QSET_DATA_MASK)
    ap_ring = {}
    for i, s in enumerate(stas):
        if scn.ul_bytes:
            s.wmi(F.WMI_VRING_CFG, F.vring_cfg_cmd(0, _connected(s)[0].body[0x13]))
        if scn.dl_bytes:
            cid = F.Fw(ap.fw).cid_of(s.mac)
            ap.wmi(F.WMI_VRING_CFG, F.vring_cfg_cmd(i, cid))
            ap_ring[i] = cid
    for _ in range(40):
        air.run_us(step_us)
        ok = all(qmask(s) & 1 for s in stas) if scn.ul_bytes else True
        if scn.dl_bytes:
            ok = ok and all(qmask(ap) >> i & 1 for i in ap_ring)
        if ok:
            break
    for i, s in enumerate(stas):
        if scn.ul_bytes and not _ba_agree(air, s, ap, 0, step_us):
            r.note('прошивка: нет соглашения BA станция %d → точка' % (i + 1))
        if scn.dl_bytes and not _ba_agree(air, ap, s, i, step_us):
            r.note('прошивка: нет соглашения BA точка → станция %d' % (i + 1))
    r.marks['data'] = ap.hw.now
    ul = {i: _msdus(scn.ul_bytes, scn.msdu_len, 0x10) for i in range(len(stas))} if scn.ul_bytes else {}
    dl = {i: _msdus(scn.dl_bytes, scn.msdu_len, 0x40) for i in range(len(stas))} if scn.dl_bytes else {}
    # данные хоста: все сразу или пачками по scn.batch MSDU через scn.batch_gap_us (как ядро: diff_scenario._trickle)
    batch = scn.batch or max([len(v) for v in list(ul.values()) + list(dl.values())] + [1])
    n_batches = max([-(-len(v) // batch) for v in list(ul.values()) + list(dl.values())] + [0])

    def put(k):
        for i, s in enumerate(stas):
            for p in ul.get(i, ())[k * batch:(k + 1) * batch]:
                s.host_tx(0, ap.mac, p)
            s.pump()
        for i, s in enumerate(stas):
            for p in dl.get(i, ())[k * batch:(k + 1) * batch]:
                ap.host_tx(i, s.mac, p)
        ap.pump()
    want_ul = {i: len(v) for i, v in ul.items()}
    n_dl = sum(len(v) for v in dl.values())
    t0 = ap.hw.now
    put(0)
    sent = 1
    end = ap.hw.now + (scn.data_max_us + n_batches * scn.batch_gap_us) * 165
    while ap.hw.now < end:
        air.run_us(min(step_us, scn.batch_gap_us))
        while sent < n_batches and ap.hw.now >= t0 + sent * scn.batch_gap_us * 165:
            put(sent)
            sent += 1
        if sent >= n_batches and all(len(stas[i].host_done) >= n for i, n in want_ul.items()) and \
                len(ap.host_done) >= n_dl:
            break
    air.run_us(scn.tail_us)
    r.marks['end'] = ap.hw.now
    r.delivered_ul = {i: [f for t, f in ap.host_rx if f[10:16] == bytes(stas[i].mac)] for i in ul}
    r.delivered_dl = {i: [f for t, f in stas[i].host_rx if t >= r.marks['data']] for i in dl}
    for i, v in ul.items():
        got = r.delivered_ul[i]
        if [f[-len(p):] for f, p in zip(got, v)] != v or len(got) != len(v):
            r.note('прошивка: вверх от станции %d доставлено %d из %d MSDU' % (i + 1, len(got), len(v)))
    for i, v in dl.items():
        got = r.delivered_dl[i]
        if [f[-len(p):] for f, p in zip(got, v)] != v or len(got) != len(v):
            r.note('прошивка: вниз к станции %d доставлено %d из %d MSDU' % (i + 1, len(got), len(v)))


QUIET_US = 3000


def _quiet(air, ap, us):
    """В эфире не было передач последние us мкс (по часам точки)."""
    last = max((f['end'] for f in air.frames), default=0)
    return ap.hw.now - last >= us * 165


def _connected_ap(ap, s):
    return F.Fw(ap.fw).cid_of(s.mac) is not None and bool(_connected(ap))


def run_cfg(scn, build_dir):
    """run() по каталогу сборки (fw.elf, uc.elf) — для CLI: образ uc_fw (DCCM из vendor-образа) — как conftest."""
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
        uc_fw = os.path.join(tempfile.mkdtemp(prefix='diffuc'), 'uc.fw')
        p = subprocess.run([sys.executable, os.path.join(rew, 'tools', 'build_fw.py'), '--uc-elf',
                            os.path.join(build_dir, 'uc.elf'), '--vendor', vendor, '--out', uc_fw, '--objcopy',
                            objcopy], capture_output=True, text=True)
        if p.returncode != 0:
            raise RuntimeError(p.stdout[-2000:] + p.stderr[-2000:])
    return run(scn, os.path.join(build_dir, 'fw.elf'), build_dir, uc_fw)

