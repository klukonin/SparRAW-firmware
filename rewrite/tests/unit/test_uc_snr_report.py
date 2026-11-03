# SPDX-License-Identifier: AGPL-3.0-or-later
"""SNR Report (802.11-2020 9.5.3): «SNR from the frame that was received with best quality … 8-bit 2s complement
value of 4×(SNR−19), where SNR is measured in dB … from –13 dB to 50.75 dB in 0.25 dB steps». SNR — оценка PHY
принятого кадра (HW_PHY_RX_SNR_883AEC [17:9], четверти дБ со знаком); лучший кадр выбирает метрика BF (r40 [19:9]).
Станция в A-BFT: SNR лучшего маяка BTI (bcn_rx.snr_rep → SSW Feedback кадров SSW); AP в A-BFT: SNR лучшего SSW
станции (sls_peer_rec.rx_snr_rep → SSW-Feedback, direct_tx_build_desc)."""
import pytest

import test_uc_beacon_rx as B
from test_uc_beacon_rx import sta, path                     # noqa: F401 (фикстуры)

HW_PHY_RX_SNR_883AEC = 0x883aec
SNR_REP_OFF = 0x0e                                          # struct bcn_rx_s: snr_rep
REC_SNR_REP = 0x11                                          # struct sls_peer_rec: rx_snr_rep


def report(snr_q4):
    """9.5.3: 4·(SNR − 19) с насыщением в 8 бит со знаком."""
    return max(-128, min(127, snr_q4 - 76)) & 0xff


def phy_snr(uc, snr_q4):
    uc.w32(HW_PHY_RX_SNR_883AEC, (snr_q4 & 0x1ff) << 9)


SNRS = [76, 76 + 45, 0, -52, -60, 203, 255]                # 19 дБ, 30,25, 0, −13, ниже −13, 50,75, выше 50,75


@pytest.mark.parametrize('snr_q4', SNRS)
def test_sta_beacon_snr_report(sta, path, snr_q4):
    """Маяк, на котором станция решила отвечать в A-BFT: SNR Report = 4·(SNR − 19) по оценке PHY этого маяка."""
    phy_snr(sta, snr_q4)
    sta.ext[40] = 200 << 9                                  # метрика BF маяка
    path(sta, B.dmg_beacon(B.bic_encode()))
    assert sta.r8(B.BCN_RX + 0x1f) == 1                     # abft_go
    assert sta.r8(B.BCN_RX + SNR_REP_OFF) == report(snr_q4)


@pytest.mark.parametrize('snr_q4', SNRS)
def test_sls_feedback_frame_snr_report(uc, snr_q4):
    """SSW-Feedback (рис. 9-850): SNR Report — из записи пира (лучший SSW), не из метрики BF."""
    rec, buf = 0x807e80, 0x807f00
    for i in range(0x18):
        uc.w8(rec + i, 0)
    uc.w32(rec + 4, 0x155)                                  # метрика BF лучшего SSW: младший байт ≠ SNR Report
    uc.w8(rec + REC_SNR_REP, report(snr_q4))
    uc.call('direct_tx_build_desc', rec, buf)
    assert uc.r8(buf + 0x11) == report(snr_q4)


@pytest.mark.parametrize('snr_q4', [76, 121, -60, 255])
def test_ap_abft_ssw_snr_report(uc, snr_q4):
    """AP в A-BFT принял SSW станции (abft_rx_ssw_tx_feedback, обвязка test_uc_deadlines): SNR Report в записи пира —
    по оценке PHY этого SSW."""
    import test_uc_deadlines as D
    uc.cpu.regs[25] = D.MAC_CMD_LOG
    D.clean_shadows(uc)
    rec = 0x807e80
    D.zero(uc, rec, 0x18)
    ssw = bytearray(32)
    ssw[0:2] = (0x0864).to_bytes(2, 'little')
    ssw[10:16] = bytes.fromhex('24181d243b0b')
    ssw[16:19] = (1 | (15 << 1) | (5 << 10)).to_bytes(3, 'little')
    uc.wbytes(B.RX_BUF, bytes(ssw))
    phy_snr(uc, snr_q4)

    def r54(n, k):
        return 0x80 if D.cmds_since(uc, lambda c: c == 0x1d00d000) else 0
    uc.ext.update({42: (1 << 12) | (1 << 16) | (1 << 14) | (1 << 15), 54: r54, 55: 0x300, 38: 0x800 | (D.STA_IDX << 8),
                   37: 1 << 24, 36: 1 << 6, 40: (1 << 24) | (300 << 9) | 5, 43: 1 << 31, 45: 1 << 31, 47: 0xffff})
    uc.call('abft_rx_ssw_tx_feedback', rec, stub={'uc_assert': 0, 'uc_evt_build_and_post_report': 0}, max_steps=200000)
    assert uc.r8(rec + REC_SNR_REP) == report(snr_q4)
