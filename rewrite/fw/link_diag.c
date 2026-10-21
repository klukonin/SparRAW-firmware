// SPDX-License-Identifier: AGPL-3.0-or-later
/* Диагностический дамп при потере линка / фатальном ассерте — link_lost_diag (0x8c853c)
 * и его ступени. Вызывается из fw_sysassert_fatal (0x8c9b28). Все ступени только
 * читают регистры и пишут в журнал; единственные записи — переключатель выборки
 * отладочного окна MAC RX [0x886dc8] (0x32000000/0x32000001) в dump_mac_rx. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/rf_obj.h"
#include "../include/mac_cnt.h"



/* pcie__read_app_debug_if (0x8d13a4): «APP DEBUG IF» — EP под SerDes: [0x882590],
 * иначе [0x8820c4]. */
u32 pcie_read_app_debug_if(void)
{
    if (hwd_pcie_is_ep_under_serdes() != 0)
        return MMIO32(HW_PCIE_SERDES_APP_DEBUG_IF);
    return MMIO32(HW_PCIE_SW_APP_DEBUG_IF);
}

/* hwd_dma__read_8812d4 (0x8d07c8): [0x881280+0x54]. */
u32 hwd_dma_read_8812d4(void)
{
    return MMIO32(HW_DMA_DIAG_12D4);
}

/* mac_rx_stats__crc_err (0x8dd8a8): слово +4 структуры по указателю [gp,0x24c] = [0x8003d0]. */
__attribute__((noinline)) u32 mac_rx_stats_crc_err(void)   /* отдельная функция у vendor */
{
    return mac_rx_cnt_blk->crc_err;
}

/* mac_rx_stats__crc_ok (0x8dd8b0): слово +8 структуры по указателю [0x8003d0]. */
__attribute__((noinline)) u32 mac_rx_stats_crc_ok(void)
{
    return mac_rx_cnt_blk->crc_ok;
}

/* link_lost_diag__dump_pcie (0x8c8638): «DEBUG PCIE: L1 STATE / L1SS STATE / LTSSM STATE»,
 * затем «APP DEBUG IF». Порядок чтений как у vendor: 0x8d1070, 0x8d13ec, 0x8d13fc. */
void link_lost_diag_dump_pcie(void)
{
    u32 l1   = hwd_pcie_ltssm_is_l1_idle();
    u32 l1ss = hwd_pcie_get_88b0c0_state4();
    u32 lt   = hwd_pcie_get_ltssm_state();
    fw_log_emit3(0x20, 0x10010b8, l1, l1ss, lt);
    fw_log_emit1(0x20, 0x10010f4, pcie_read_app_debug_if());
}

/* link_lost_diag__dump_dma (0x8c84d4): «DEBUG DMA: PEDI DIF DEBUG IF: 0x%x». */
void link_lost_diag_dump_dma(void)
{
    fw_log_emit1(0x20, 0x1001114, hwd_dma_read_8812d4());
}

/* link_lost_diag__dump_mac_rx (0x8c8568): «DEBUG MAC RX: CRC_OK / CRC_ERR», регистры
 * 0x886e58..0x886e64, затем два окна по 24 слова из 0x944000: выборка окна —
 * [0x887000-0x238] = 0x886dc8 (vendor st.as …,[r15,-142]) = 0x32000000 и 0x32000001. */
void link_lost_diag_dump_mac_rx(void)
{
    u32 ok  = mac_rx_stats_crc_ok();
    u32 err = mac_rx_stats_crc_err();
    fw_log_emit2(0x20, 0x1001138, ok, err);
    fw_log_emit1(0x20, 0x100115c, MMIO32(HW_MAC_PPDU_REPORT_1));
    fw_log_emit1(0x20, 0x1001180, MMIO32(HW_MAC_PPDU_REPORT_2));
    fw_log_emit1(0x20, 0x10011a4, MMIO32(HW_MAC_PPDU_REPORT_3));
    fw_log_emit1(0x20, 0x10011c8, MMIO32(HW_MAC_PPDU_REPORT_4));

    volatile u32 *p = (volatile u32 *)0x944000;
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x32000000;
    fw_log_emit1(0x20, 0x10011ec, (u32)p);
    for (u32 n = 0x18; n >= 1; n--)
        fw_log_emit1(0x20, 0x100122c, *p++);

    p = (volatile u32 *)0x944000;
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x32000001;
    fw_log_emit1(0x20, 0x1001238, (u32)p);
    for (u32 n = 0x18; n >= 1; n--)
        fw_log_emit1(0x20, 0x100122c, *p++);
}

/* link_lost_diag__dump_rf (0x8c86b4): «DEBUG RF: …» — только для RF типа 2 (0x8da584).
 * rf — радио-объект (vendor передаёт 0x8042c8), rf_idx — индекс RF; vendor
 * перечитывает его перед каждым чтением RFC-регистра. */
void link_lost_diag_dump_rf(const struct rf_obj *rf)
{
    if (rf_type_is_sparrow_r() == 0)
        return;
    u32 v = hwd_rfc_read_rgf(rf->rf_idx, 0x504);
    fw_log_emit2(0x20, 0x100589c, v & 0xfu, v >> 4);
    fw_log_emit1(0x20, 0x10058d8, hwd_rfc_read_rgf(rf->rf_idx, 0x6c8));
    fw_log_emit1(0x20, 0x1005904, hwd_rfc_read_rgf(rf->rf_idx, 0x6d4));
    fw_log_emit1(0x20, 0x1005930, hwd_rfc_read_rgf(rf->rf_idx, 0x6d8));
    fw_log_emit1(0x20, 0x100595c, hwd_rfc_read_rgf(rf->rf_idx, 0x6dc));
    fw_log_emit1(0x20, 0x1005988, hwd_rfc_read_rgf(rf->rf_idx, 0x6e0));
    fw_log_emit1(0x20, 0x10059b4, hwd_rfc_read_rgf(rf->rf_idx, 0x42c));
}

/* link_lost_diag__noop_dump_hook (0x8c8564): пустая ступень (j_s [blink]). */
void link_lost_diag_noop_dump_hook(void)
{
}

/* link_lost_diag (0x8c853c): все ступени дампа по порядку vendor. */
void link_lost_diag(void)
{
    link_lost_diag_dump_pcie();
    link_lost_diag_dump_dma();
    link_lost_diag_dump_mac_rx();
    link_lost_diag_dump_false_alarms();
    link_lost_diag_dump_rf(&rf_obj);
    calib_obj4_reset_d4();
    link_lost_diag_noop_dump_hook();
}
