// SPDX-License-Identifier: AGPL-3.0-or-later
/* Точка входа fw — порт vendor fw_main (0x8f00dc) в порядке и с журналом vendor.
 * До него crt0 (start.S) обнуляет PERIPH-регионы и запускает статические конструкторы
 * (ctors.c). Каждый шаг — вызов той же функции, что и у vendor (адрес — в комментарии),
 * сообщения журнала — те же токены и уровни (fw_log_emit*), так что кольцо 0x843900
 * сравнивается с vendor построчно. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/dbg.h"
#include "../include/rf_obj.h"
#include "../include/sys_cfg.h"
#include "../include/fwsh.h"



/* WM_MNGR::init (0x8d9390): у vendor пустая функция (j_s [blink]). */
static void wm_mngr_init(void)
{
}


void fw_main(void)
{
    /* НЕ vendor: наша отладочная область 0x806a00..0x806a7f (include/dbg.h) образом не
     * инициализируется — обнулить до первого обращения. vendor туда не пишет. */
    memset0_words((void *)DBG_TRACE, 0x80);

    boot_init_subsystems(&dashboard);
    rfc_tx_power_tbl_load();                          /* lp 13: 0x803908[i] → 0x8891b4 + 4i */
    VOL(fwsh_sets.rx_gain_ofs_lo_mcs) = 0xfffffffdu;                   /* -3 */

    /* Boot-блок 0x880a3c: RF-type, shutdown bit0, SPI-lock, assert bit0 (порядок vendor). */
    u32 v = MMIO32(HW_SPECIAL_FLAGS);
    MMIO32(HW_GUI_FLASH_UNLOCK_CNT) = 0;
    MMIO32(HW_SPECIAL_FLAGS) = v & ~1u;
    v = MMIO32(HW_PLATFORM_FLAGS);
    MMIO32(HW_GUI_FLASH_LOCK_CNT) = 0;
    MMIO32(HW_PLATFORM_FLAGS) = v & ~1u;
    boot_install_diag_magic();
    fw_stats_blk_init();
    fw_log_init_ring();

    fw_log_emit0(0x20, 0x1000760);                    /* MAIN() BOOT STARTS */
    irq_set_level(6, 0);
    fw_log_emit0(0x20, 0x1000774);                    /* set MAC_SXD_ERRORS_ISR interrupt to level 1 */
    fw_log_emit0(0x20, 0x10007a8);                    /* Running Full FW */

    /* [0x8002d8] ([gp,85] .as): 0x11111111 из образа fw_data → 0x22222222; иначе fw
     * перезапущен без перезагрузки образа. */
    if (fw_data_fresh_magic == 0x11111111u) {
        fw_data_fresh_magic = 0x22222222u;
    } else {
        fw_log_emit0(0x20, 0x10007c0);                /* FW Boot occur before HW Boot ended */
        fw_sysassert_fatal(__builtin_return_address(0), 0x11b1);
    }

    baseband_identify();
    l2mgr_init_frame_pool();
    sm_init_defer_pool();
    operational_if_init_mbox_ptr();
    debug_mbox_get_or_init();
    fw_init_link_defaults();

    /* HW statemachine WA (0x8f01b6): 16 nop_s, пока [0x880200] бит 6 (HW boot done) не
     * взведён; затем [0x8801d8] = 0x80000000 и, если младшие 5 бит = 0x15, 0x40000000. */
    fw_log_emit0(0x20, 0x10007ec);                    /* MAIN() HW statemachine WA */
    do {
        arc_nops_mb(16);
    } while (!(MMIO32(HW_BOOT_WAIT_880200) & (1u << 6)));
    MMIO32(HW_HW_SM_WA_CTL) = 0x80000000u;
    if ((MMIO32(HW_HW_SM_WA_CTL) & 0x1f) == 0x15)
        MMIO32(HW_HW_SM_WA_CTL) = 0x40000000u;

    if (platform_is_fpga() != 0)
        fw_log_emit0(0x20, 0x1000808);                /* RUNNING IN FPGA MODE */

    boot_load_from_flash();
    sdp_gpio_boot_init();

    /* PCIe: маска, PERST/D3-прерывания. */
    pcie_mask_interrupts();
    if (boot_read_strap_bit() != 0) {
        fw_log_emit0(0x20, 0x1000634);                /* BUG_5382_WA - hwd_pcie_perst_deassert_int_clear() */
        pcie_perst_deassert_int_clear();
    }
    fw_log_emit0(0x20, 0x1000668);                    /* hwd_pcie_perst_deassert_int_en() */
    pcie_perst_deassert_int_en();
    if (pcie_perst_assert_irq_en != 0) {             /* [gp,500] */
        fw_log_emit0(0x20, 0x100068c);                /* hwd_pcie_perst_assert_int_en() */
        pcie_perst_assert_int_en();
    }
    fw_log_emit0(0x20, 0x10006ac);                    /* hwd_pcie_enter_d3_int_en() */
    pcie_enter_d3_int_en();
    fw_log_emit0(0x20, 0x10006c8);                    /* hwd_pcie_d3_d0_int_en() */
    pcie_d3_d0_int_en();
    fw_log_emit0(0x20, 0x10006e0);                    /* Enable PCIE interrupts */
    arc_core_wr(32, 0);                               /* vendor mov_s r32,r13 (r13 = 0) */
    fw_log_emit0(0x20, 0x10006f8);                    /* WBE_DRIVER::pcie_boot_init() */
    pcie_serdes_init();

    fw_log_emit0(0x20, 0x100082c);                    /* MAIN() Enable ARC interrupts */
    irq_enable_all();
    fw_log_emit0(0x20, 0x100084c);                    /* MAIN() Configurre MAC counters */
    boot_fill_addr_tables();
    cnt_handler_clear_all();
    fw_log_emit0(0x20, 0x100086c);                    /* MAIN() RADIO_MGR::init() */
    radio_mgr_init_global();
    if (platform_is_asic() != 0) {
        fw_log_emit0(0x20, 0x1000888);                /* MAIN() Switch from XTAL to 165MHZ */
        hwm_reset_analog_block();
    }
    fw_log_emit0(0x20, 0x10008ac);                    /* MAIN() Configuring LEDs */
    led_scheme_init(3);
    led_scheme_apply(0);
    if (platform_is_asic() != 0) {
        fw_log_emit0(0x20, 0x10008c4);                /* MAIN() Configuring the PHY */
        hwd_phy_init();
    }
    if (platform_is_asic() != 0 || platform_is_fpga() != 0) {
        fw_log_emit0(0x20, 0x10008e0);                /* MAIN() Configuring RF */
        init_rf_hw(&rf_obj);
        rf_identify_type(&rf_obj);
        fw_log_emit0(0x20, 0x10008f8);                /* MAIN() Role power configurations from board file */
        if (rf_configure_role_power(&rf_obj) == 2) {
            rf_power_off();
            fw_sysassert_fatal(__builtin_return_address(0), 0x1186);
        }
        fw_log_emit0(0x10, 0x100092c);                /* MAIN() Restoring swap IQ config */
        hwd_phy_store_txrx_swap_iq();
    }
    if (boot_force_prod_mode_en != 0) {             /* [gp,680] */
        fw_log_emit0(0x20, 0x1000968);                /* MAIN() Forcing production mode en */
        boot_force_production_mode();
    }
    fw_log_emit0(0x20, 0x10009a4);                    /* MAIN() Initializing the LFSR */
    mac_enable_880bc0_b0();
    MMIO32(BL_SHUTDOWN_HS) = 0;                       /* BL_SHUTDOWN_HS */
    MMIO32(BL_ASSERT_CODE) = 0;                       /* BL_ASSERT_CODE */
    MMIO32(BL_ASSERT_BLINK) = 0;                      /* BL_ASSERT_BLINK */
    fw_log_emit0(0x20, 0x10009c4);                    /* MAIN() Enabling DMA error interrupts */
    hwd_dma_init();
    fw_log_emit0(0x20, 0x1000a1c);                    /* MAIN() Masking user interrupts */
    arc_core_wr(32, 0);                               /* vendor mov_s r32,r13 (r13 = 0) */
    fw_log_emit0(0x20, 0x1000a3c);                    /* MAIN() Activating ARC action point protection for ICCM */
    arc_action_point_install_default();
    fw_boot_log_versions();
    fw_log_emit0(0x20, 0x1000718);                    /* Initializing WM_MNGR */
    wm_mngr_init();
    fw_log_emit0(0x20, 0x1000730);                    /* Initializing CALIB_MNGR */
    calib_engine_init_all();
    fw_log_emit0(0x20, 0x1000748);                    /* Initializing POWER_MNGR */
    power_mngr_init();
    lmac_if_ucode_init();
    fw_status_set_state(4);
    fw_log_emit0(0x20, 0x1000a74);                    /* MAIN() Configure vendor specific DB & IO queue configurations */
    boot_publish_ids();
    if (platform_is_asic() != 0)
        otp_init();
    fw_log_emit0(0x20, 0x1000ab4);                    /* MAIN() SCHEDULER STARTS */
    u_schd_run();
}
