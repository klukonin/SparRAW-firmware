# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сценарий сравнения по эфиру (этап 2, rewrite/docs/ARCHITECTURE.md): одно описание, которое исполняют обе стороны —
ядро в идеальной среде (run_core → scenario.Bss) и прошивка в эмуляторе (tests/unit/fw_scenario.run; ядро его не
импортирует).

Что задаёт сценарий и кто его исполняет:

| Параметр | Ядро | Прошивка (эмулятор) |
|---|---|---|
| n_sta, bf (A-BFT / SLS в DTI), probe | StaSme | WMI_CONNECT; A-BFT — доступ станции в DTI закрыт до SSW-Feedback |
| bi_tu | MLME-START BeaconPeriod | WMI_PCP_START bcon_interval |
| ul_bytes / dl_bytes, msdu_len | MA-UNITDATA.request после ADDBA | кольца TX хоста после WMI_RING_BA_EN |
| ap/sta_sectors, abft_slots, fss | MLME-START, MAC | выбирает сама (32/32, A-BFT 2 × 16) — «параметры BSS» |
| edca (TXOP Limit AC_BE 2048) | EDCA Parameter Set точки | объявляет свой набор — «параметры BSS» |
| seed | seed MAC ядра | seed отсрочки модели MAC узлов |

Значения по умолчанию секторов и A-BFT — те, что объявляет прошивка (маяк: 32 сектора, A-BFT Length 1, FSS 15), чтобы
сравнивалось поведение, а не конфигурация. Что ядро не умеет (A-BFT раз в N BI: N BIs A-BFT у прошивки — 4, у ядра —
каждый BI), — в Scenario.limits(): отчёт показывает это как ограничение сценария, не как расхождение."""
from dataclasses import dataclass, field, replace

from .ap import EDCA_ADVERTISED
from .sme import MSDU_LEN


@dataclass(frozen=True)
class Scenario:
    name: str
    title: str
    n_sta: int = 1
    bf: str = 'dti'                     # 'abft' — BF в A-BFT; 'dti' — SLS в DTI (без A-BFT)
    probe: bool = False                 # Probe Request перед ассоциацией (драйвер прошивки BSS знает — без Probe)
    bi_tu: int = 100
    ap_sectors: int = 32
    sta_sectors: int = 32
    abft_slots: int = 2
    fss: int = 16
    edca: dict = field(default_factory=lambda: dict(EDCA_ADVERTISED))   # {ACI: (AIFSN, CWmin, CWmax, TXOP мкс)}
    ul_bytes: int = 0
    dl_bytes: int = 0
    msdu_len: int = 1500
    batch: int = 0                      # MSDU в пачке (0 — все сразу); пачки — через batch_gap_us
    batch_gap_us: int = 1500
    seed: int = 1
    # пределы прогона
    max_us: int = 60_000                # прошивка: до подключения всех станций
    data_max_us: int = 30_000           # прошивка: после постановки данных
    tail_us: int = 2_000
    core_max_bis: int = 40

    @property
    def txop_be_us(self):
        return self.edca[0][3]

    def with_(self, **kw):
        return replace(self, **kw)

    def limits(self):
        """Что сценарий не задаёт одной из сторон (в отчёт — «ограничения сценария»)."""
        out = ['прошивка: число секторов, A-BFT Length/FSS и EDCA Parameter Set выбирает сама (параметры сценария — '
               'только для ядра; совпадение проверяется как «параметры BSS»)',
               'ядро: A-BFT в каждом BI (Next A-BFT 0, N BIs A-BFT 1); у прошивки A-BFT — раз в несколько BI',
               'эмулятор: H-SYNC — TSF узлов совпадает, задержки распространения нет; канал идеальный, коллизии '
               'моделью MAC не разбираются']
        if self.bf == 'abft':
            out.append('прошивка: A-BFT вынужден окружением (доступ станции в DTI закрыт до SSW-Feedback точки); на '
                       'стенде станция A-BFT пропускает (test_air)')
        if self.n_sta > 1:
            out.append('прошивка: станции подключаются по очереди (одновременный WMI_CONNECT — пробел модели эфира, '
                       'uc_assert 0x27)')
        return out


def _scn(name, title, **kw):
    return Scenario(name=name, title=title, **kw)


KB = 1500 * 8
SCENARIOS = {s.name: s for s in (
    _scn('abft-1sta', '1 станция, BF в A-BFT, данные вверх', bf='abft', ul_bytes=KB, max_us=600_000),
    _scn('sls-1sta', '1 станция, SLS в DTI, данные вверх', bf='dti', ul_bytes=KB),
    _scn('sls-1sta-dl', '1 станция, SLS в DTI, данные вниз', bf='dti', dl_bytes=KB),
    _scn('sls-1sta-both', '1 станция, SLS в DTI, данные в обе стороны', bf='dti', ul_bytes=KB, dl_bytes=KB, seed=2),
    _scn('sls-2sta', '2 станции, SLS в DTI, данные в обе стороны', n_sta=2, bf='dti', ul_bytes=KB // 2,
         dl_bytes=KB // 2, max_us=120_000, seed=3),
    _scn('sls-1sta-burst', '1 станция, SLS в DTI, 48 MSDU вверх одной пачкой (окно BA против длины A-MPDU)', bf='dti',
         ul_bytes=KB * 6, seed=5),
    _scn('sls-1sta-bi10', 'BI 10 TU (обмены у границы CBAP), SLS в DTI, данные в обе стороны пачками', bf='dti',
         bi_tu=10, ul_bytes=KB * 6, dl_bytes=KB * 6, batch=8, batch_gap_us=1500, data_max_us=20_000,
         core_max_bis=400, seed=4),
)}


def run_core(scn):
    """Ядро в идеальной среде по сценарию → scenario.Bss после прогона (b.journal — журнал эфира, b.done — итог)."""
    from .scenario import Bss
    b = Bss(seed=scn.seed, n_sta=scn.n_sta, bi_tu=scn.bi_tu, ap_sectors=scn.ap_sectors, sta_sectors=scn.sta_sectors,
            abft_slots=scn.abft_slots, fss=scn.fss, ul_bytes=scn.ul_bytes, dl_bytes=scn.dl_bytes, bf=scn.bf,
            probe=scn.probe)
    assert scn.msdu_len == MSDU_LEN, 'ядро режет данные на MSDU по sme.MSDU_LEN'
    b.ap_sme.edca = dict(scn.edca)
    # соглашение BA открывает сторона с данными (как драйвер прошивки: WMI_RING_BA_EN на кольце с трафиком)
    b.ap_sme.addba_on_assoc = True
    for sme in b.sta_smes:
        sme.addba = 'ul'
    if scn.batch:
        for sme in [b.ap_sme] + b.sta_smes:
            _trickle(sme, b.sim, scn.batch, scn.batch_gap_us)
    b.done_ok = b.run(max_bis=scn.core_max_bis)
    return b


def _trickle(sme, sim, batch, gap_us):
    """MA-UNITDATA.request пачками по batch MSDU через gap_us (SME решает, когда отдавать данные; MAC не меняется)."""
    send = sme._send

    def trickled(da, payloads):
        for k in range(0, len(payloads), batch):
            sim.at(sim.now + (k // batch) * gap_us, send, da, payloads[k:k + batch])
    sme._send = trickled

