# SPDX-License-Identifier: AGPL-3.0-or-later
"""Негативы: испорченное поведение ядра ловится судьями (air_judge и мост). Каждая порча — одно отступление от
стандарта в подклассе MAC; ожидается находка по соответствующему правилу."""
import pytest

from .. import cbap as C
from .. import duration as D
from . import frames as FR
from . import mac as MAC
from .ap import DmgApMac
from .conftest import judge_all
from .scenario import Bss
from .sta import DmgStaMac


def run(ap_cls=DmgApMac, sta_cls=DmgStaMac, RB=None, **kw):
    mb = kw.pop('max_bis', 8)
    b = Bss(seed=kw.pop('seed', 1), ul_bytes=kw.pop('ul', 100_000), dl_bytes=kw.pop('dl', 100_000),
            mac_cls=(ap_cls, sta_cls), **kw)
    b.run(max_bis=mb)
    c, rules, va, evs, found = judge_all(b, RB)
    return {v.rule for v in va}, {(f.judge, f.rule) for f in found}, b


def test_clean_baseline(RB):
    air, br, b = run(RB=RB)
    assert not air and not br


class StaShortAifs(DmgStaMac):
    """AIFSN 1 у non-AP STA (10.23.2.4: «shall be greater than or equal to 2 for non-AP STAs»)."""
    def _aifs(self, ac):
        return C.aifs(1)


def test_short_aifs_caught(RB):
    air, br, _ = run(sta_cls=StaShortAifs, RB=RB)
    assert ('cbap', 'aifs') in br or 'access' in air


class ApBadCts(DmgApMac):
    """DMG CTS с Duration на 1 мкс больше 9.3.1.13."""
    def _dispatch(self, frames, rxv, t0):
        f = frames[0]
        if f.kind == 'RTS' and f.ra == self.addr and self.nav.idle_for_rts(self.sim.now, f.ta):
            self._respond(FR.dmg_cts(D.duration_cts_response(f.dur) + 1, f.ta, self.addr), 0, self._beam_to(f.ta))
            return
        super()._dispatch(frames, rxv, t0)


def test_cts_duration_caught(RB):
    air, br, _ = run(ap_cls=ApBadCts, RB=RB)
    assert 'dur_cts' in air and ('duration', 'DMG CTS') in br


def test_cf_end_without_reserve_caught(RB, monkeypatch):
    """CF-End с Duration ≠ 0 без запаса 2×TCF-End + 2×SIFS в NAV (10.23.2.10)."""
    monkeypatch.setattr(MAC, 'CF_END_RESERVE', MAC.SIFS + MAC.T_CF_END)
    monkeypatch.setattr(D, 'cf_end_nonzero_allowed', lambda rem, t=None: True)
    air, br, _ = run(RB=RB)
    assert 'nav_txop' in air or ('cbap', 'cf_end_dur') in br or ('duration', 'CF-End') in br


class ApBadBeaconDur(DmgApMac):
    """Duration DMG Beacon на 5 мкс больше остатка BTI (9.3.4.2)."""
    def _beacon(self, ts_tsf, sector, cdown, dur):
        return super()._beacon(ts_tsf, sector, cdown, dur + 5)


def test_beacon_duration_caught(RB):
    air, br, _ = run(ap_cls=ApBadBeaconDur, RB=RB)
    assert 'bi' in air and any(j == 'bi' for j, _ in br)


class ApLateSifs(DmgApMac):
    """Немедленный ответ через 5 мкс вместо SIFS (10.3.2.3.3)."""
    def _respond(self, mpdu, mcs, beam, kind=None):
        if self._resp_ev is not None or self.tx_on:
            return
        self._resp_ev = self.sim.at(self.sim.now + 5, self._resp_tx, mpdu, mcs, beam)
        self._medium_changed()


def test_late_response_caught(RB):
    air, br, _ = run(ap_cls=ApLateSifs, RB=RB)
    assert 'ifs_sifs' in air and ('cbap', 'sifs') in br


class StaNoAssoc(DmgStaMac):
    """Данные до завершения ассоциации: класс 3 в State 2 (11.3.3)."""
    def _associated(self):
        return self.bssid is not None


class ApSlowAssoc(DmgApMac):
    """Точка принимает данные от STA в State 2 и отвечает на ассоциацию с задержкой (чтобы данные STA успели)."""
    def _may_rx_data(self, ta):
        return True

    def _req_MlmeAssociateResponse(self, prim):
        self.sim.after(3000, super()._req_MlmeAssociateResponse, prim)


def test_class3_without_association_caught(RB):
    b = Bss(seed=1, ul_bytes=50_000, mac_cls=(ApSlowAssoc, StaNoAssoc), probe=False)
    b.start()
    sme = b.sta_sme
    orig = sme._associate

    def assoc_then_data():
        orig()
        for d in [bytes(1500)] * 10:
            sme.mac.ma_unitdata_request(__import__('ref.core.sap_mac', fromlist=['x']).MaUnitdataRequest(
                sme.mac.addr, sme.bss.BSSID, d))
    sme._associate = assoc_then_data
    b.sim.run(4 * 102400)
    c, rules, va, evs, found = judge_all(b, RB)
    assert 'assoc_state' in {v.rule for v in va}


class StaBadAbftSsw(DmgStaMac):
    """SSW в A-BFT с Duration CDOWN-формулы DTI вместо остатка слота (9.3.1.15)."""
    def _abft_tx(self, raw, beam):
        p = MAC.F.parse_frame(raw, with_fcs=False)
        d = D.duration_ssw(p.ssw.cdown)
        super()._abft_tx(raw[:2] + int(d).to_bytes(2, 'little') + raw[4:], beam)


def test_abft_ssw_duration_caught(RB):
    air, br, _ = run(sta_cls=StaBadAbftSsw, RB=RB)
    assert 'dur_bf' in air or ('abft', 'ssw_dur') in br or ('duration', 'SSW') in br


class ApPastCbap(DmgApMac):
    """Окно CBAP за TBTT: обмены могут пересечь начало следующего BTI (10.39.5)."""
    def set_cbap(self, s, e, margin=0):
        super().set_cbap(s, e + 3000, margin)


def test_exchange_past_cbap_caught(RB):
    air, br, _ = run(ap_cls=ApPastCbap, RB=RB, dl=3_000_000, ul=0, max_bis=60, bi_tu=5)
    assert 'cbap_end' in air or 'bti_delay' in air or ('bi', 'beacon_outside_bti') in br or \
        any(j == 'cbap' and r == 'cbap_end' for j, r in br)


class StaNoSupportedChannels(DmgStaMac):
    """Association Request без Supported Channels (11.8.2.2)."""
    def _req_MlmeAssociateRequest(self, prim):
        from .. import chswitch as CS
        enc = CS.encode_supported_channels
        CS.encode_supported_channels = lambda sub: b''
        try:
            super()._req_MlmeAssociateRequest(prim)
        finally:
            CS.encode_supported_channels = enc


def test_supported_channels_caught(RB):
    air, br, _ = run(sta_cls=StaNoSupportedChannels, RB=RB)
    assert 'supp_channels' in air


@pytest.mark.parametrize('limit', [8191])
def test_ampdu_over_peer_limit_caught(RB, monkeypatch, limit):
    """A-MPDU длиннее Maximum A-MPDU Length Exponent получателя (10.12.2)."""
    monkeypatch.setattr(MAC, 'MAX_AMPDU_EXP', 0)        # объявляем 8191 …
    import importlib
    from . import ap as APM
    from . import sta as STM
    monkeypatch.setattr(APM, 'MAX_AMPDU_EXP', 0)
    monkeypatch.setattr(STM, 'MAX_AMPDU_EXP', 0)
    monkeypatch.setattr(MAC, 'ampdu_limit', lambda caps: 262143)   # … но предел получателя не соблюдаем
    monkeypatch.setattr(APM, 'ampdu_limit', lambda caps: 262143)
    monkeypatch.setattr(STM, 'ampdu_limit', lambda caps: 262143)
    importlib.invalidate_caches()
    air, br, _ = run(RB=RB)
    assert 'ampdu_limits' in air
