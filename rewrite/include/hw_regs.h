/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Регистры MMIO 0x88xxxx по именам (этап 8 plain C11), по адресу. Источники — в комментариях:
 * драйвер wil6210 (RGF_*), 6.2/ref/REGS-KNOWN.txt / REGS-62.md, wmiUT.xml, строки журнала vendor;
 * «по использованию» — смысл выведен из кода vendor. Базовые имена и макросы доступа — hw.h. */
#ifndef HW_REGS_H
#define HW_REGS_H
/* Адрес для C (unsigned) и для .S — gas не знает суффикса u. Только у имён, нужных в .S. */
#ifndef ADDR_U
#ifdef __ASSEMBLER__
#define ADDR_U(x) x
#else
#define ADDR_U(x) x##u
#endif
#endif
#define HW_RGF_USER_USAGE_1               0x880004u  /* драйвер RGF_USER_USAGE_1; fw_log__init_ring */
#define HW_RGF_USER_USAGE_5        0x880014u  /* по шагу RGF_USER_USAGE_n драйвера (_1 0x880004 … _6 0x880018); слово platform-info board-файла: [31:28] RF, [27:12] платформа, [11:0] ревизия (лог-строка «BOARD FILE INFO: RF = %d Platform = 0x%x revision», rf_boardfile__read_platform_info; пишет board-файл — brd_if; NAMES-EXTRA) */
#define HW_RGF_USER_USAGE_6        0x880018u  /* REGS-KNOWN (драйвер RGF_USER_USAGE_6): от хоста, биты 31..29 режим OOB */
#define HW_RGF_USER_USAGE_7               0x88001cu  /* лог-строка «pcie_pm_host_config:: LnkCtl=0x%x usage7=0x%x»; по использованию:… */
#define HW_GPIO_FUNC_SEL_0                0x880068u  /* лог-строки «Resetting GPIOs configurations», «GPIO0 = 0x%8X GPIO1 = … GPIO2 =… */
#define HW_GPIO_FUNC_SEL_1                0x88006cu  /* лог-строка «GPIO0 = … GPIO1 = 0x%8X …»; по использованию: gpio__set_pin_func_… */
#define HW_GPIO_FUNC_SEL_2                0x880070u  /* лог-строка «… GPIO2 = 0x%8X»; по использованию: gpio__set_pin_func_and_dump… */
#define HW_GPIO_CFG_3                     0x880074u  /* по использованию: gpio__reset_config */
#define HW_GPIO_CFG_4                     0x880078u  /* по использованию: gpio__reset_config */
#define HW_GPIO_CFG_5                     0x88007cu  /* по использованию: gpio__reset_config */
#define HW_SPI_FLASH_RDATA                0x8800a8u  /* по использованию: hwd_spi_read */
#define HW_SPI_FLASH_CTRL                 0x8801a8u  /* по использованию: hwd_spi_read, hwd_spi__poll_done, лог-строка «SPI READ: wai… */
#define HW_SPI_FLASH_CMD                  0x8801acu  /* по использованию: hwd_spi_read */
#define HW_SPI_FLASH_ADDR                 0x8801b0u  /* по использованию: hwd_spi_read */
#define HW_HW_SM_WA_CTL                   0x8801d8u  /* лог-строка «MAIN() HW statemachine WA», fw_main */
#define HW_RGF_USER_MAC_CPU_0      0x8801fcu  /* REGS-KNOWN (драйвер RGF_USER_MAC_CPU_0, лог «Reseting the uCode»): 0x31 выпускает ucode из сброса */
#define HW_BOOT_WAIT_880200               0x880200u  /* по использованию: fw_main */
#define HW_USER_RGF_880204                0x880204u  /* по использованию: pcie__serdes_init */
#define HW_SYS_TIMER_A_LOAD               0x880208u  /* по использованию: u_schd__hw_timer_a_start из u_schd__timer_init */
#define HW_SYS_TIMER_A_CTL                0x880224u  /* по использованию: u_schd__hw_timer_a_start */
#define HW_SYS_TIMER_B_LOAD               0x880248u  /* по использованию: u_schd__hw_timer_load_start */
#define HW_SYS_TIMER_B_COMPARE            0x88024cu  /* 6.2/docs/MISC-FW.md, u_schd__hw_timer_set_compare */
#define HW_SYS_TIMER_NOW                  0x880254u  /* по использованию: sys_timer__read_now; 4.1 4.1/docs/STRUCTS.md */
#define HW_SYS_TIMER_B_CTL                0x880258u  /* по использованию: u_schd__hw_timer_load_start */
#define HW_RF_KILL_PIN                    0x880288u  /* по использованию: mac__toggle_880288_b1, rf_kill__irq_task; 4.1/docs/MISC.md */
#define HW_PCIE_LP_PARAMS                 0x880290u  /* по использованию: pcie_lp__set_byte_field из hwd_pcie__set_low_power */
#define HW_RGF_USER_USER_SCRATCH_PAD 0x8802bcu /* REGS-KNOWN (драйвер RGF_USER_USER_SCRATCH_PAD, HOST_MBOX): mbox_ctl рабочего ящика */
#define HW_SCRATCH_PAD_9           0x8802e0u  /* REGS-KNOWN scratch_pad_9 = SCRATCH_PAD+0x24 (по использованию): адрес дескриптора кольца команд ucode */
#define HW_OP_MBOX_TX_RING         0x8802e8u  /* REGS-KNOWN op_mbox_tx_ring (struct wil6210_mbox_ring_desc): кольцо хост→FW */
#define HW_OP_MBOX_RX_RING         0x880318u  /* REGS-KNOWN op_mbox_rx_ring (по использованию: mbox__init_descriptor) */
#define HW_DEBUG_MBOX_CTL          0x8803e8u  /* REGS-KNOWN debug_mbox_ctl (лог «Debug MBOX init») */
#define HW_DEBUG_MBOX_TX_RING      0x880414u  /* REGS-KNOWN debug_mbox_tx_ring (по использованию: debug_mbox__get_or_init) */
#define HW_DEBUG_MBOX_RX_RING      0x88042cu  /* REGS-KNOWN debug_mbox_rx_ring (лог «Debug MBOX init») */
#define HW_BL_VERSION_MAJOR               0x880a00u  /* globals пака 11ad, лог-строка «Boot Loader version = %d.%d.%d» */
#define HW_BL_VERSION_MINOR               0x880a04u  /* globals пака 11ad, bootloader_version__log */
#define HW_BL_VERSION_SUBMINOR            0x880a08u  /* globals пака 11ad, bootloader_version__log */
#define HW_BL_VERSION_BUILD               0x880a0cu  /* globals пака 11ad; debug-tools BOOT_LOADER_VERSION_REG */
#define HW_FW_IMAGE_FLAVOR                0x880a10u  /* globals пака 11ad image_flavor_e; по использованию: fw_image_info__set_flavor… */
#define HW_FW_TIMESTAMP_HOUR              0x880a14u  /* globals пака 11ad, debug-tools FW_TIMESTAMP_HOUR_REGISTER, лог-строка «FW tim… */
#define HW_FW_TIMESTAMP_MINUTE            0x880a18u  /* globals пака 11ad, fw_version__log_date */
#define HW_FW_TIMESTAMP_SECOND            0x880a1cu  /* globals пака 11ad, fw_version__log_date */
#define HW_FW_TIMESTAMP_DAY               0x880a20u  /* globals пака 11ad, лог-строка «FW date = %02d/%02d/%d» */
#define HW_FW_TIMESTAMP_MONTH             0x880a24u  /* globals пака 11ad, fw_version__log_date */
#define HW_FW_TIMESTAMP_YEAR              0x880a28u  /* globals пака 11ad, debug-tools FW_TIMESTAMP_YEAR_REGISTER */
#define HW_FW_VERSION_MAJOR               0x880a2cu  /* globals пака 11ad, debug-tools FW_VERSION_MAJOR_REGISTER, лог-строка «FW vers… */
#define HW_FW_VERSION_MINOR               0x880a30u  /* globals пака 11ad, debug-tools */
#define HW_FW_VERSION_SUBMINOR            0x880a34u  /* globals пака 11ad; debug-tools FW_MODE_REG */
#define HW_FW_VERSION_BUILD               0x880a38u  /* globals пака 11ad, debug-tools FW_VERSION_BUILD_REGISTER */
#define HW_RX_MBOX_INT_COUNT              0x880a50u  /* globals пака 11ad, isr_880b50__dispatch_causes */
#define HW_SPECIAL_FLAGS                  0x880a64u  /* globals пака 11ad, special-flags-sys-config */
#define HW_LINK_PER                0x880a6cu  /* REGS-KNOWN per (globals пака 11ad, лог «LINK_STATS ... PER=%d»): PER линка, % */
#define HW_GUI_FLASH_LOCK_CNT             0x880a78u  /* globals пака 11ad, лог-строка «SPI LOCK FAILED (GUI_LOCK_CNT=%d GUI_UNLOCK_CN… */
#define HW_GUI_FLASH_UNLOCK_CNT           0x880a7cu  /* globals пака 11ad, fw_main */
#define HW_FW_POINTER_TABLE_VALIDATION_PATTERN 0x880a80u /* REGS-KNOWN (globals пака 11ad, debug-tools DYNAMIC_ADDRESSING_PATTERN_ADDRESS) */
#define HW_FW_POINTER_TABLE_BASE_ADDRESS 0x880a84u /* REGS-KNOWN (globals пака 11ad, debug-tools POINTER_TABLE_ADDRESS) */
#define HW_FLASH_LOCK_OWNER               0x880a88u  /* globals пака 11ad, лог-строки «SPI LOCK FAILED (FW last locked/released/owner… */
#define HW_RGF_USER_FW_REV_ID             0x880a8cu  /* драйвер RGF_USER_FW_REV_ID; globals пака 11ad rev_id */
#define HW_REV_ID_RF_TYPE          0x880a8eu  /* REGS-KNOWN rev_id: u16 rf_type (0 нет, 1 Marlon, 2 Sparrow-R) */
#define RGF_USER_FW_CALIB_RESULT    0x880a90u  /* от драйвера: байт 0 RDAC, биты 8..15 сигнатура (драйвер RGF_USER_FW_CALIB_RESULT) */
#define HW_PLATFORM_FLAGS                 0x880a94u  /* globals пака 11ad, rf_kill_sm__init */
#define HW_RGF_USER_CLKS_CTL_SW_RST_VEC_2 0x880b0cu  /* драйвер RGF_USER_CLKS_CTL_SW_RST_VEC_2; pcie_serdes__shlicht_wa */
#define RGF_USER_JTAG_DEV_ID        0x880b34u  /* JTAG ID чипа (драйвер RGF_USER_JTAG_DEV_ID) */
#define HW_RGF_USER_USER_ICR_ICR   ADDR_U(0x880b50)  /* драйвер RGF_USER_USER_ICR = 0x880b4c, +4 (ICR) */
#define HW_RGF_USER_USER_ICR_ICM          0x880b54u  /* драйвер RGF_USER_USER_ICR +8 (ICM) */
#define HW_RGF_USER_USER_ICR_IMS   ADDR_U(0x880b60)  /* драйвер RGF_USER_USER_ICR +0x14 (IMS) */
#define HW_RGF_USER_USER_ICR_IMC          0x880b64u  /* драйвер RGF_USER_USER_ICR +0x18 (IMC) */
#define HW_SDP_GPIO_ENABLE                0x880b6cu  /* по использованию: sdp__set_defined_bit, gpio__reset_config */
#define HW_SDP_GPIO_CFG_B70               0x880b70u  /* по использованию: gpio__reset_config, лог-строка «Resetting GPIOs configurati… */
#define HW_SDP_GPIO_STRAP_IN              0x880b7cu  /* по использованию: hw_personality__read_strap */
#define HW_SDP_GPIO_CTRL                  0x880b84u  /* по использованию: gpio__write_ctrl_b84 */
#define HW_SDP_GPIO_OUT_CLR               0x880b88u  /* по использованию: hwd_sdp_drive_value, лог-строка «hwd_sdp_drive_value() - va… */
#define HW_SDP_GPIO_OUT_SET               0x880b90u  /* по использованию: hwd_sdp_drive_value */
#define HW_SDP_GPIO_IN             0x880b98u  /* REGS-KNOWN sdp_gpio_in (по использованию: sdp__read_880b98_bit) */
#define HW_SDP_GPIO_INT_CTRL              0x880bb4u  /* по использованию: sdp__set_int_ctrl_bit */
#define HW_RNG_CTL                 0x880bc0u  /* REGS-KNOWN rng_ctl (по использованию: mac__set_880bc0_b0) */
#define HW_RGF_USER_CLKS_CTL_EXT_SW_RST_VEC_0 0x880c18u /* REGS-KNOWN (драйвер RGF_USER_CLKS_CTL_EXT_SW_RST_VEC_0) */
#define HW_PCIE_SERDES_CFG_C40            0x880c40u  /* по использованию: hwd_pcie__uses_rgf_880c00 из pcie__serdes_program_all */
#define HW_RGF_USER_SPARROW_M_4           0x880c50u  /* драйвер RGF_USER_SPARROW_M_4 */
#define HW_PCIE_SERDES_CFG_C54            0x880c54u  /* по использованию: hwd_pcie__uses_rgf_880c00 */
#define HW_DMA_RING_SEL_102C       0x88102cu  /* REGS-KNOWN dma_ring_sel_102c (по использованию: mac_bringup__prog_881000) */
#define HW_DMA_CFG_1144            0x881144u  /* REGS-KNOWN dma_cfg_1144 (по использованию: mac_bringup__prog_881000) */
#define HW_DMA_CFG_114C            0x88114cu  /* REGS-KNOWN dma_cfg_114c (то же) */
#define HW_DMA_CFG_1154            0x881154u  /* REGS-KNOWN dma_cfg_1154 (то же) */
#define HW_DMA_CFG_1160            0x881160u  /* REGS-KNOWN dma_cfg_1160 (то же) */
#define HW_DMA_CFG_1168            0x881168u  /* REGS-KNOWN dma_cfg_1168 (то же) */
#define HW_DMA_CFG_1170            0x881170u  /* REGS-KNOWN dma_cfg_1170 (то же) */
#define HW_DMA_CFG_128C            0x88128cu  /* REGS-KNOWN dma_cfg_128c (то же) */
#define HW_DMA_CFG_1294            0x881294u  /* REGS-KNOWN dma_cfg_1294 (то же) */
#define HW_DMA_CFG_129C            0x88129cu  /* REGS-KNOWN dma_cfg_129c (то же) */
#define HW_DMA_CFG_12A8            0x8812a8u  /* REGS-KNOWN dma_cfg_12a8 (то же) */
#define HW_DMA_CFG_12B0            0x8812b0u  /* REGS-KNOWN dma_cfg_12b0 (то же) */
#define HW_DMA_CFG_12B8            0x8812b8u  /* REGS-KNOWN dma_cfg_12b8 (то же) */
#define HW_DMA_DIAG_12D4           0x8812d4u  /* REGS-KNOWN dma_diag_12d4 (по использованию: link_lost_diag__dump_dma) */
#define HW_DMA_DESCQ2_SW_TAIL      0x8813c8u  /* REGS-KNOWN DMA_RGF.DESCQ<2>.SW_TAIL (debug-tools PMC DESCQ, лог uc «PRING: … sw_tail %d») */
#define HW_DMA_DESCQ2_SW_HEAD_CRNT 0x8813f0u  /* REGS-KNOWN DMA_RGF.DESCQ<2>.SW_HEAD.CRNT (debug-tools PmcRegistersAccessor) */
#define HW_L2_OFFLOAD_CFG_B18      0x881b18u  /* REGS-KNOWN l2_offload_cfg_b18 (по использованию: mac_bringup__prog_881b00) */
#define HW_L2_OFFLOAD_CFG_B1C      0x881b1cu  /* REGS-KNOWN l2_offload_cfg_b1c (то же) */
#define HW_L2_OFFLOAD_CFG_B20      0x881b20u  /* REGS-KNOWN l2_offload_cfg_b20 (то же) */
#define HW_L2_OWN_MAC_LO           0x881b28u  /* REGS-KNOWN l2_own_mac_lo (по использованию: l2_offload__set_own_mac_addr) */
#define HW_L2_OWN_MAC_HI           0x881b2cu  /* REGS-KNOWN l2_own_mac_hi (то же) */
#define HW_L2_RX_DECAP_CFG         0x881b30u  /* REGS-KNOWN l2_rx_decap_cfg (по использованию: l2_offload__set_rx_decap_cfg) */
#define HW_L2_OFFLOAD_ETHERTYPES   0x881b34u  /* REGS-KNOWN l2_offload_ethertypes (по использованию: mac_bringup__prog_881b00) */
#define HW_DMA_OFFLOAD_DECAP_CFG   0x881b88u  /* REGS-KNOWN dma_offload_decap_cfg (по использованию: dma_offload__pack_decap_cfg) */
#define HW_DMA_OFFLOAD_CTL_B94     0x881b94u  /* REGS-KNOWN dma_offload_ctl_b94 (по использованию: mac_bringup__prog_881b00) */
#define HW_RGF_DMA_EP_MISC_ICR_ICR        0x881bf0u  /* драйвер RGF_DMA_EP_MISC_ICR +4 (ICR) */
#define HW_RGF_DMA_EP_MISC_ICR_ICS        0x881bf8u  /* драйвер RGF_DMA_EP_MISC_ICR +0xc (ICS) */
#define HW_DMA_FW_ICR_C08_ICR      0x881c0cu  /* REGS-KNOWN dma_fw_icr_c08.ICR (по использованию) */
#define HW_DMA_FW_ICR_C08_ICM      0x881c10u  /* REGS-KNOWN dma_fw_icr_c08.ICM (по использованию) */
#define HW_DMA_FW_ICR_C08_ICS             0x881c14u  /* по использованию: первая функция блока tx_api__mask_from_queue */
#define HW_DMA_FW_ICR_C08_IMS      0x881c1cu  /* REGS-KNOWN dma_fw_icr_c08.IMS (по использованию: txrx_mgr__handle_dma_irq) */
#define HW_DMA_FW_ICR_C08_IMC      0x881c20u  /* REGS-KNOWN dma_fw_icr_c08.IMC (по использованию: dma_mgr__configure_ring) */
#define HW_DMA_FW_ICR_C24_ICM             0x881c2cu  /* по использованию: hwd_dma__uses_rgf_881c00_8d07f8; 4.1/docs/MISC.md */
#define HW_DMA_FW_ICR_C24_IMS             0x881c38u  /* по использованию: hwd_dma__uses_rgf_881c00_8d0b74 */
#define HW_DMA_FW_ICR_C24_IMC      0x881c3cu  /* REGS-KNOWN dma_fw_icr_c24.IMC (по использованию) */
#define HW_DMA_FW_ICR_C40_ICR             0x881c44u  /* по использованию: hwd_dma__ack_881c44, hwd_dma__set_881c00 */
#define HW_DMA_FW_ICR_C40_ICM             0x881c48u  /* лог-строка «DMA BAD Interrupt: cause = %x»; hwd_dma__bad_cause */
#define HW_DMA_FW_ICR_C40_IMS             0x881c54u  /* по использованию: hwd_dma__uses_rgf_881c00_8d0c18 из vring_schdlr__isr_dispat… */
#define HW_DMA_FW_ICR_C40_IMC             0x881c58u  /* по использованию: hwd_dma__set_881c00, vring_hw__unmask_irq */
#define HW_DMA_RING_SELECT         0x881c88u  /* REGS-KNOWN dma_ring_select (по использованию: hwd_dma__program_vring_desc) */
#define HW_DMA_FW_INT_D24                 0x881d24u  /* по использованию: hwd_dma__raise_host_fw_int */
#define HW_PCIE_SW_CFG_0                  0x882000u  /* по использованию: hwd_pcie__clear_88b000_bits */
#define HW_PCIE_SW_PM_CFG                 0x88200cu  /* лог-строка, по использованию: pcie__serdes_init */
#define HW_PCIE_SW_CTL_24                 0x882024u  /* по использованию: hwd_pcie_exit_l1, pcie__serdes_init, hwd_pcie__clear_88b000… */
#define HW_PCIE_SW_CTL_28                 0x882028u  /* по использованию: hwd_pcie_exit_l1, pcie__serdes_init, pcie__force_clear_l0s */
#define HW_PCIE_SW_LANE_CFG_40            0x882040u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_SW_LANE_CFG_48            0x882048u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_SW_LANE_CFG_50            0x882050u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_SW_LTSSM_STATE            0x8820c0u  /* по использованию: hwd_pcie__get_ltssm_state, лог-строка «LTSSM STATE:0x%x» */
#define HW_PCIE_SW_APP_DEBUG_IF    0x8820c4u  /* REGS-KNOWN (лог «DEBUG PCIE: APP DEBUG IF: 0x%x») */
#define HW_PCIE_SERDES1_CTL               0x882224u  /* лог-строка «Sparrow PCIe reset Serdes1!», по использованию: hwd_pcie__port1_s… */
#define HW_PCIE_PORT_B_CTL_24             0x88223cu  /* по использованию: pcie__serdes_init */
#define HW_PCIE_L1SS_CTL                  0x882240u  /* лог-строка «Sparrow PCIe L1SS Support enabled», по использованию: pcie__l1ss_… */
#define HW_PCIE_PORT_B_CTL_34             0x88224cu  /* по использованию: pcie__serdes_init */
#define HW_PCIE_PORT_B_LANE_CFG_40        0x882258u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_PORT_B_LANE_CFG_48        0x882260u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_SW_PORT1_DBG_RX_PCPL_REMOTE_0 0x8822d0u  /* лог-строка «PCIE.SW_PORT1.DEBUG.RX.PCPL.REMOTE…_0», wbe_driver__pcie_debug */
#define HW_PCIE_SW_PORT1_DBG_RX_PCPL_REMOTE_1 0x8822d4u  /* лог-строка «PCIE.SW_PORT1.DEBUG.RX.PCPL.REMOTE…_1», wbe_driver__pcie_debug */
#define HW_PCIE_SW_PORT1_DBG_RX_PCPL_REMOTE_2 0x8822d8u  /* лог-строка «PCIE.SW_PORT1.DEBUG.RX.PCPL.REMOTE…_2», wbe_driver__pcie_debug */
#define HW_PCIE_SW_PORT1_DBG_RX_PCPL_REMOTE_3 0x8822dcu  /* лог-строка «PCIE.SW_PORT1.DEBUG.RX.PCPL.REMOTE…_3», wbe_driver__pcie_debug */
#define HW_PCIE_SW_PORT1_DBG_TX_PCPL_REMOTE_0 0x882334u  /* лог-строка «PCIE.SW_PORT1.DEBUG.TX.PCPL.REMOTE…_0», wbe_driver__pcie_debug */
#define HW_PCIE_SW_PORT1_DBG_TX_PCPL_REMOTE_1 0x882338u  /* лог-строка «PCIE.SW_PORT1.DEBUG.TX.PCPL.REMOTE…_1», wbe_driver__pcie_debug */
#define HW_PCIE_SW_PORT1_DBG_TX_PCPL_REMOTE_2 0x88233cu  /* лог-строка «PCIE.SW_PORT1.DEBUG.TX.PCPL.REMOTE…_2», wbe_driver__pcie_debug */
#define HW_PCIE_SW_PORT1_DBG_TX_PCPL_REMOTE_3 0x882340u  /* лог-строка «PCIE.SW_PORT1.DEBUG.TX.PCPL.REMOTE…_3», wbe_driver__pcie_debug */
#define HW_PCIE_PORT_C_CTL_24             0x8823c4u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_PORT_C_CTL_34             0x8823d4u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_PORT_C_LANE_CFG_40        0x8823e0u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_PORT_C_LANE_CFG_48        0x8823e8u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_SERDES_L1_HOLD            0x882554u  /* по использованию: hwd_pcie_exit_l1, pcie__l1ss_config, pcie_pm_host_config, h… */
#define HW_PCIE_SERDES_CTL_60             0x882560u  /* по использованию: hwd_pcie__clear_88b000_bits */
#define HW_PCIE_SERDES_LTSSM_STATE        0x88258cu  /* по использованию: hwd_pcie__get_ltssm_state */
#define HW_PCIE_SERDES_APP_DEBUG_IF 0x882590u /* REGS-KNOWN (лог «DEBUG PCIE: APP DEBUG IF: 0x%x») */
#define HW_PCIE_TOPOLOGY_CTL              0x8825bcu  /* лог-строки pcie__l1_latency_wa «…EP under switch/serdes», по использованию: h… */
#define HW_PCIE_MODE_FLAGS                0x8825c0u  /* лог-строки, по использованию: pcie__serdes_init, pcie__program_seq_fw_8825c0_… */
#define HW_PCIE_PHY_STATUS                0x88262cu  /* лог-строка «PCIE_ISR could not start DBI writes, phy_pll_lock is not ready»… */
#define HW_PCIE_DBI_STATUS                0x882644u  /* лог-строка «Clearing DBI gateway», по использованию: pcie__wait_882644_ready… */
#define HW_PCIE_DBI_CMD                   0x882648u  /* по использованию: pcie__dbi_start_cmd, hwd_pcie__set_882600 */
#define HW_PCIE_DBI_ADDR                  0x88264cu  /* лог-строка «dbi_write FAILED: address=0x%x…», по использованию: pcie__dbi_set… */
#define HW_PCIE_DBI_DATA                  0x882650u  /* по использованию: pcie__dbi_set_data, hwd_pcie__read_882650 из pcie__dbi_read */
#define HW_RGF_HP_CTRL                    0x88265cu  /* драйвер RGF_HP_CTRL */
#define HW_RGF_PAL_UNIT_ICR_ICR           0x882670u  /* драйвер RGF_PAL_UNIT_ICR = 0x88266c, +4 (ICR) */
#define HW_RGF_PAL_UNIT_ICR_ICM           0x882674u  /* драйвер RGF_PAL_UNIT_ICR +8 (ICM) */
#define HW_RGF_PAL_UNIT_ICR_IMS           0x882680u  /* драйвер RGF_PAL_UNIT_ICR +0x14 (IMS) */
#define HW_RGF_PAL_UNIT_ICR_IMC           0x882684u  /* драйвер RGF_PAL_UNIT_ICR +0x18 (IMC) */
#define HW_PCIE_DEBUG_ICR_ICR             0x88268cu  /* раскладка RGF_ICR с ICC в 0x882688; лог-строки; по использованию: pcie_debug_… */
#define HW_PCIE_DEBUG_ICR_ICM             0x882690u  /* по использованию: pcie_debug__read_and_ack_cause; 6.2/docs/MISC-FW.md §вектор 15 */
#define HW_PCIE_DEBUG_ICR_IMS             0x88269cu  /* по использованию: pcie_debug__mask_tx_fifo_full_irq, dpal__mask_cpl_timeout_irq */
#define HW_PCIE_DEBUG_ICR_IMC             0x8826a0u  /* по использованию: pcie_dbg__rearm_irq_bit0/3/9, pcie__clear_cpl_timeout */
#define HW_PCIE_HOST_EVENT_SET            0x8826b0u  /* по использованию: pcie__set_event_bit */
#define HW_WBE_CLOSE_CTL           0x882a74u  /* REGS-KNOWN wbe_close_ctl (по использованию: WBE_DRIVER__CLOSE) */
#define HW_PCIE_PERST_STATUS              0x882b88u  /* лог-строка, по использованию: hwd_pcie__get_882b80, hwd_pcie_exit_l1, fw_vect… */
#define HW_PCIE_PM_TIMER_0A               0x882b90u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_PM_TIMER_0B               0x882b94u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_PM_TIMER_1A               0x882b9cu  /* по использованию: pcie__serdes_init */
#define HW_PCIE_PM_TIMER_1B               0x882ba0u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_PM_TIMER_2A               0x882ba8u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_PM_TIMER_2B               0x882bacu  /* по использованию: pcie__serdes_init */
#define HW_PCIE_PM_TIMER_3A               0x882bb4u  /* по использованию: pcie__serdes_init */
#define HW_PCIE_PM_TIMER_3B               0x882bb8u  /* по использованию: pcie__serdes_init */
#define HW_DPAL_CPL_TO_CTL                0x882d04u  /* по использованию: pcie__clear_cpl_timeout */
#define HW_DPAL_CPL_VALID_VECTOR          0x882d08u  /* лог-строка «DPAL CPL TO Event: cpl_valid_vector = 0x%08X…», по использованию:… */
#define HW_DPAL_CPL_CNT_0_3               0x882d0cu  /* лог-строки DPAL CPL TO, по использованию: dpal__cpl_timeout_evt */
#define HW_DPAL_CPL_CNT_4_7               0x882d10u  /* лог-строки DPAL CPL TO, по использованию: dpal__cpl_timeout_evt */
#define HW_PXE_CTL                        0x882dd4u  /* лог-строки, по использованию: WBE_DRIVER__pxe_isoc_in_dir_bypass, mgmt_tx__co… */
#define HW_PXE_CH_CFG_0                   0x882e08u  /* лог-строка «WBE_DRIVER::pxe_isoc_in_dir_bypass: %d», по использованию: WBE_DR… */
#define HW_PXE_CH_CFG_1                   0x882e1cu  /* лог-строка «…pxe_isoc_in_dir_bypass», по использованию: WBE_DRIVER__pxe_isoc_… */
#define HW_PXE_CH_CFG_2                   0x882e6cu  /* лог-строка «…pxe_isoc_in_dir_bypass», по использованию: WBE_DRIVER__pxe_isoc_… */
#define HW_PXE_PDN_CACHE_REQ_FIFO         0x882e84u  /* лог-строка «PCIE.PXE.PDN.CACHE_REQ_FIFO_CONTROLLER…», wbe_driver__pcie_debug */
#define HW_PXE_PDN_TX_DP_FIFO             0x882e88u  /* лог-строка «PCIE.PXE.PDN.TX_DP_FIFO_CONTROLLER», wbe_driver__pcie_debug */
#define HW_PXE_PUP_DBG_0                  0x882e8cu  /* лог-строка «PCIE.PXE.PUP.DBG.PCIE_PCIE_PXE_PUP_DBG_0», wbe_driver__pcie_debug */
#define HW_PXE_DBG_SEL                    0x882ed8u  /* по использованию: wbe_driver__pcie_debug — [2:0] и [6:4] кольцо, б8 «кольцо ≠ 0»; окно 16 слов отсюда */
#define HW_PXE_DBG_CSU_LOCK               0x882edcu  /* лог-строка «…port1_tx_fifo_pcpl_full_int (dbg_csu_lock=0x%X)», по использован… */
#define HW_PCIE_PWR_MODE_MAP_0            0x882f64u  /* по использованию: hwd_pcie__set_mode_map из hw_modes__apply_power_mode */
#define HW_PCIE_PWR_MODE_MAP_1            0x882f68u  /* по использованию: hwd_pcie__set_mode_map */
#define HW_PCIE_PWR_MODE_MAP_2            0x882f6cu  /* по использованию: hwd_pcie__set_mode_map */
#define HW_PCIE_PWR_MODE_MAP_3            0x882f70u  /* по использованию: hwd_pcie__set_mode_map */
#define HW_PCIE_PWR_MODE_MAP_4            0x882f74u  /* по использованию: hwd_pcie__set_mode_map */
#define HW_PCIE_PWR_MODE_MAP_5            0x882f78u  /* по использованию: hwd_pcie__set_mode_map */
#define HW_PCIE_PWR_MODE_MAP_6            0x882f7cu  /* по использованию: hwd_pcie__set_mode_map */
#define HW_PCIE_PWR_MODE_MAP_7            0x882f80u  /* по использованию: hwd_pcie__set_mode_map */
#define HW_PCIE_PWR_MODE_MAP_8            0x882f84u  /* по использованию: hwd_pcie__set_mode_map */
#define HW_PCIE_PM_CTL_88                 0x882f88u  /* по использованию: hwd_pcie__toggle_882f80_bits */
#define HW_PCIE_SERDES_SHLICHT_CFG_0      0x882f8cu  /* лог-строка «PCIe serdes configuration shlicht», по использованию: pcie_serdes… */
#define HW_PCIE_SERDES_SHLICHT_CFG_1      0x882f90u  /* лог-строка «PCIe serdes configuration shlicht», по использованию: pcie_serdes… */
#define HW_UNIT_ICR_PORT0_LTSSM_DBG_1_ICR 0x882fd0u  /* лог-строка «PCIE UNIT_ICR_PORT0_LTSSM_DBG_1: UN HANDLED INTERRUPT», раскладка… */
#define HW_UNIT_ICR_PORT0_LTSSM_DBG_1_ICM 0x882fd4u  /* лог-строка «deep_sleep_enter: No L1 exit interrupt…», по использованию: hwd_p… */
#define HW_UNIT_ICR_PORT0_LTSSM_DBG_1_IMV 0x882fdcu  /* лог-строка «Clear and mask PCIe interrupts», по использованию: pcie__mask_int… */
#define HW_UNIT_ICR_PORT0_LTSSM_DBG_1_IMS 0x882fe0u  /* по использованию: pcie__mask_l1_enter_irq, pcie__mask_l1_exit_irq */
#define PHY_RX_CHANNEL_FREQ_RATIO   0x883020u  /* частотное слово канала (REGS-KNOWN phy_rx_channel_freq_ratio; debug-tools HostDefinitions.h) */
#define PHY_RX_CAL_CORR_CFG         0x883054u  /* бит 1 cal_mode_corr, [17:2] частота (REGS-KNOWN; UT 0x423 hwd_phy_rx_cal_corr_config) */
#define PHY_RX_CAL_CORR_LENGTH      0x883058u  /* cal_corr_length (REGS-KNOWN; UT 0x423) */
#define HW_PHY_RX_MEAS_8830EC      0x8830ecu  /* REGS-KNOWN phy_rx_meas_8830ec: замер принятого кадра (PLCP; [4:0] и [22:5] → rx_meas +0x52/+0x3c); по использованию: rx_meas */
#define PHY_RX_AGC_MAX_INDEX        0x883138u  /* [5:0] макс. индекс AGC (REGS-KNOWN; лог find_agc_start «MAX index») */
#define PHY_RX_AGC_STEPS_A          0x8831c0u  /* шаги AGC [5:0],[11:6]; 0x21 = выкл. (REGS-KNOWN; UT 0x412 hwd_phy_rx_agc_steps_disable) */
#define PHY_RX_AGC_STEPS_B          0x8831c4u  /* второй регистр шагов AGC (REGS-KNOWN; UT 0x412) */
#define PHY_RX_POSTDIST_DC          0x883584u  /* бит 9 postdist_dc_enable, бит 8 force_dc_set, [7:0] force_dc_val (REGS-KNOWN; UT 0x416/0x419/0x41a) */
#define PHY_REC_DATA_MODE           0x883594u  /* [15:0] rec_data_mode_e рекордера (REGS-KNOWN; UT 0x42b hwd_phy_recording_mode_set) */
#define PHY_REC_POST_TRIGGER_DURATION 0x88359cu /* [15:0] post_trigger_duration (REGS-KNOWN; UT 0x42b) */
#define PHY_REC_LAST_ADDRESS        0x8835a4u  /* [12:0] текущий адрес записи рекордера (REGS-KNOWN; лог hwd_phy_recording_get) */
#define PHY_RX_CAL_CORR_RESULT_I    0x8836e4u  /* результат RX-коррелятора, I (REGS-KNOWN; UT 0x424 rx_correlator_result_rgf_i) */
#define PHY_RX_CAL_CORR_RESULT_Q    0x8836e8u  /* результат RX-коррелятора, Q (REGS-KNOWN; UT 0x424 rx_correlator_result_rgf_q) */
#define PHY_RX_CAL_CORR_DONE        0x8836ecu  /* бит 0 = измерение коррелятора готово (REGS-KNOWN, по использованию: hwd_phy__rx_cal_corr) */
#define HW_PHY_RX_INA_RSSI_ADC_DB  0x883700u  /* REGS-KNOWN (лог-строки link_lost_diag__dump_phy, phy_stats__dump «INA_RSSI_ADC_DB») */
#define HW_PHY_RX_INA_RSSI_ADC_DB_SFD_LOCKED 0x883708u /* REGS-KNOWN (лог-строки link_lost_diag__dump_phy, phy_stats__dump) */
#define HW_PHY_RX_STATUS_8837B0    0x8837b0u  /* REGS-KNOWN phy_rx_status_8837b0: бит 1 при r40[2:0] == 2 — выбор лучшего сектора по SNR; смысл не установлен */
#define HW_PHY_RX_MEAS_8837D8      0x8837d8u  /* REGS-KNOWN phy_rx_meas_8837d8: [15:0] знаковое → rx_meas +0x44; смысл не установлен */
#define HW_PHY_RX_MEAS_8837DC      0x8837dcu  /* REGS-KNOWN phy_rx_meas_8837dc: [15:0] знаковое → rx_meas +0x40; смысл не установлен */
#define HW_PHY_DBG_REGS            0x883844u  /* REGS-KNOWN phy_dbg_regs_883844: начало окна отладочных регистров PHY, ucode копирует n слов (phy_read_regs_883844) */
#define HW_PHY_8838A4               0x8838a4u  /* бит 0 сбрасывается при источнике записи 4 и 0xb, иначе ставится; смысл не установлен (нет в REGS-KNOWN; ≥3 обращений, hwd_phy_recording_mode_set) */
#define PHY_REC_RAM_MASK            0x8838a8u  /* [2:0] маска банков ОЗУ рекордера (REGS-KNOWN; UT 0x42b) */
#define PHY_INA_SYNC_COUNTER_DP          0x883964u  /* REGS-KNOWN phy_ina_sync_counter_dp */
#define PHY_SFD_SYNC_COUNTER_SC          0x883968u  /* REGS-KNOWN phy_sfd_sync_counter_sc */
#define PHY_CRC_OK_COUNTER_SC            0x88396cu  /* REGS-KNOWN phy_crc_ok_counter_sc */
#define PHY_BER_LAST_ZERO_COUNTER_SC     0x883970u  /* REGS-KNOWN phy_ber_last_zero_counter_sc */
#define PHY_SFD_TIMEOUT_COUNTER_DP       0x883974u  /* REGS-KNOWN phy_sfd_timeout_counter_dp */
#define HW_PHY_CRC_ERROR_COUNTER_SC 0x883978u /* REGS-KNOWN (лог-строки phy_stats__dump HEADER_CRC_ERROR_COUNTER_SC, LINK_STATS PHY_ERROR_DP) */
#define PHY_BER_LAST_NON_ZERO_COUNTER_SC 0x88397cu  /* REGS-KNOWN phy_ber_last_non_zero_counter_sc */
#define PHY_INA_SYNC_COUNTER_CP          0x8839a0u  /* REGS-KNOWN phy_ina_sync_counter_cp */
#define PHY_SFD_SYNC_COUNTER_CP          0x8839a4u  /* REGS-KNOWN phy_sfd_sync_counter_cp */
#define PHY_CRC_OK_COUNTER_CP            0x8839a8u  /* REGS-KNOWN phy_crc_ok_counter_cp */
#define PHY_BER_LAST_ZERO_COUNTER_CP     0x8839acu  /* REGS-KNOWN phy_ber_last_zero_counter_cp */
#define PHY_SFD_TIMEOUT_COUNTER_CP       0x8839b0u  /* REGS-KNOWN phy_sfd_timeout_counter_cp */
#define HW_PHY_CRC_ERROR_COUNTER_CP 0x8839b4u /* REGS-KNOWN (лог-строки phy_stats__dump HEADER_CRC_ERROR_COUNTER_CP, LINK_STATS PHY_ERROR_CP) */
#define PHY_BER_LAST_NON_ZERO_COUNTER_CP 0x8839b8u  /* REGS-KNOWN phy_ber_last_non_zero_counter_cp */
#define PHY_APU_IN_1                0x883a68u  /* [15:0] i1, [31:16] q1 */
#define PHY_APU_IN_2                0x883a6cu  /* [15:0] i2, [31:16] q2 */
#define PHY_APU_IN_PHASE            0x883a70u  /* phy_apu_in_phase, 16 бит */
#define PHY_APU_OPCODE              0x883a74u  /* phy_apu_opcode */
#define PHY_APU_OUT                 0x883a78u  /* [15:0] out_i, [31:16] out_q */
#define PHY_APU_DIV_OUT_MAN         0x883a7cu  /* мантисса делителя */
#define PHY_APU_DIV_OUT_EXP         0x883a80u  /* [3:0] порядок делителя */
#define HW_PHY_RX_LDPC_ITER        0x883a84u  /* REGS-KNOWN (лог-строка link_lost_diag__dump_phy «LDPC iter header / data_total») */
#define HW_PHY_RX_SNR_883AEC       0x883aecu  /* REGS-KNOWN phy_rx_snr_883aec: [17:9] знаковое 9 бит, (x+2)>>2 — SNR лучшего сектора */
#define PHY_RX_CHANNEL_CFG          0x883b3cu  /* слово канала (REGS-KNOWN phy_rx_channel_cfg, по использованию: phy__program_channel_regs, UT 0x414) */
#define HW_PHY_BRP_883B78          0x883b78u  /* REGS-KNOWN phy_brp_883b78: [25:24] задаётся на время BRP-обмена инициатора; смысл не установлен */
#define PHY_RX_RSSI_ADC             0x883be4u  /* [9:0] знаковое rssi_adc свободного хода (REGS-KNOWN; лог hw_sysapi_get_rx_energy_data_free_run) */
#define PHY_RX_RSSI_ADC_LOCKED      0x883becu  /* [9:0] rssi_adc защёлкнутое, [20:10] rssi_raw (REGS-KNOWN; лог-строки там же) */
#define PHY_BRP_RAM_CTL             0x883f40u  /* бит 0 доступ к BRP RAM, бит 2 (REGS-KNOWN, по использованию: hwd_phy_rx_read_and_parse_brp_ram) */
#define PHY_BRP_RAM_DATA            0x883f64u  /* окно данных BRP RAM, 8 слов (REGS-KNOWN, по использованию) */
#define PHY_BRP_RAM_ADDR            0x883f84u  /* [7:0] строка, бит 8 строб чтения (REGS-KNOWN, по использованию) */
#define PHY_TX_SELF_SILENCE         0x88400cu  /* phy_tx_silence_duration (REGS-KNOWN; UT 0x407 hwd_phy_tx_self_transmit) */
#define PHY_TX_SELF_START           0x884058u  /* запись 1 = пуск self transmit (REGS-KNOWN; UT 0x407) */
#define PHY_TX_TEST_88405C          0x88405cu  /* тестовый регистр UT TEST_TRIAL_1; смысл не установлен (REGS-KNOWN phy_tx_test_88405c) */
#define HW_PHY_TX_BRP_884060       0x884060u  /* REGS-KNOWN phy_tx_brp_884060: ucode обнуляет перед отправкой BRP-кадра; смысл не установлен */
#define PHY_TX_SINGEN_TRANSMIT      0x884064u  /* start_stop_val синус-генератора (REGS-KNOWN; UT 0x40a hwd_phy_tx_singen_transmit) */
#define PHY_TX_SINGEN_CONFIG        0x884068u  /* tx_singen_config (REGS-KNOWN; UT 0x409 hwd_phy_tx_singen_config) */
#define PHY_TX_SINGEN_FREQ          0x88406cu  /* [15:0] freq_a, [31:16] freq_b (REGS-KNOWN; UT 0x409) */
#define PHY_TX_CTRL_884070          0x884070u  /* [1:0] управление TX (REGS-KNOWN, по использованию: hwd_phy__tx_ctrl_884070) */
#define PHY_TX_SELF_BUSY            0x8840ecu  /* [21:0] ≠0 пока идёт self transmit (REGS-KNOWN; UT 0x408) */
#define PHY_TX_SELF_REMAINING       0x8840f0u  /* [15:0] ≠0 пока идёт self transmit (REGS-KNOWN; UT 0x408) */
#define PHY_TX_MAN_ATTEN_ENABLE     0x884130u  /* tx_man_atten_enable (REGS-KNOWN; UT 0x40e hwd_phy_tx_predist_atten_man_config) */
#define PHY_TX_PREDIST_DC           0x884138u  /* [9:0] tx_dc_val_i, [25:16] tx_dc_val_q (REGS-KNOWN; UT 0x40f hwd_phy_tx_predist_dc_config) */
#define PHY_TX_PREDIST_DC_BYPASS    0x88413cu  /* 1 при tx_dc_en=0 (REGS-KNOWN; UT 0x40f) */
#define PHY_TX_PLAY_BUFFER_EN       0x884140u  /* бит 0 разрешение проигрывания (REGS-KNOWN; UT 0x40b/0x40c) */
#define PHY_TX_PLAY_BUFFER_GO       0x884144u  /* бит 0 пуск (REGS-KNOWN; UT 0x40b hwd_phy_tx_play_buffer_start) */
#define PHY_TX_PLAY_BUFFER_STOP     0x884148u  /* запись 1 — стоп (REGS-KNOWN; UT 0x40c hwd_phy_tx_play_buffer_stop) */
#define PHY_TX_PLAY_BUFFER_MODE     0x88414cu  /* бит 0 play_buffer_mode (REGS-KNOWN; UT 0x40b) */
#define PHY_TX_PLAY_BUFFER_START_ADDR 0x884150u /* [12:0] начальный адрес (REGS-KNOWN; UT 0x40b, по использованию) */
#define PHY_TX_PLAY_BUFFER_LAST_ADDR 0x884154u /* [12:0] play_buffer_last_address (REGS-KNOWN; UT 0x40b) */
#define PHY_TX_PLAY_BUFFER_LOOPS    0x884158u  /* play_buffer_num_of_loops (REGS-KNOWN; UT 0x40b) */
#define PHY_TX_FIR_COEF            0x88416cu  /* REGS-KNOWN phy_tx_fir_coef: массив 84 регистров (0x88416c..0x8842b8), коэффициенты TX-фильтра (phy_load_88416c_table из таблицы 0x803838) */
#define PHY_SAR_MEAS_LENGTH_LO      0x885008u  /* длина измерения, младшее слово (REGS-KNOWN; UT 0x41b/0x425 sar_cal_length_lo) */
#define PHY_SAR_MEAS_LENGTH_HI      0x88500cu  /* длина измерения, старшее слово (REGS-KNOWN; UT 0x425 sar_cal_length_hi) */
#define PHY_SAR_SAMPLE_A_LO        0x885010u  /* SAR-отсчёт A, младшие 16 бит, по idx шаг 8 (с _A_HI; 0x885010..0x88504c); по использованию hwd_phy__read_sar_sample; между PHY_SAR_MEAS_LENGTH_HI и PHY_ONLINE_DC_MEAS */
#define PHY_SAR_SAMPLE_A_HI        0x885014u  /* SAR-отсчёт A, старшие 16 бит (шаг 8); hwd_phy__read_sar_sample */
#define PHY_SAR_SAMPLE_B_LO        0x885050u  /* SAR-отсчёт B, младшие 16 бит (шаг 8, 0x885050..0x88508c); hwd_phy__read_sar_sample */
#define PHY_SAR_SAMPLE_B_HI        0x885054u  /* SAR-отсчёт B, старшие 16 бит (шаг 8); hwd_phy__read_sar_sample */
#define PHY_RX_CAL_GAIN_ACC_A_LO   0x885090u  /* накопитель A измерения RX-усиления калибровки, младшие 24 бита, по idx шаг 8 (0x885090..0x8850cc); hwd_phy__rx_cal_gain_measurement_read */
#define PHY_RX_CAL_GAIN_ACC_A_HI   0x885094u  /* накопитель A, старшая часть (<< 24), шаг 8; hwd_phy__rx_cal_gain_measurement_read */
#define PHY_RX_CAL_GAIN_ACC_B_LO   0x8850d0u  /* накопитель B, младшие 24 бита, шаг 8 (0x8850d0..0x88510c, до PHY_ONLINE_DC_MEAS); hwd_phy__rx_cal_gain_measurement_read */
#define PHY_RX_CAL_GAIN_ACC_B_HI   0x8850d4u  /* накопитель B, старшая часть (<< 24), шаг 8; hwd_phy__rx_cal_gain_measurement_read */
#define PHY_ONLINE_DC_MEAS          0x885110u  /* таблица по sar_index, шаг 4 (REGS-KNOWN; UT 0x41e hwd_phy_online_dc_measurement_read) */
#define PHY_ONLINE_GAIN_MEAS        0x885130u  /* таблица по sar_index, шаг 4 (REGS-KNOWN; UT 0x41f hwd_phy_online_gain_measurement_read) */
#define PHY_RAM_READ_SEL            0x885178u  /* [2:0] селектор чтения ОЗУ PHY (REGS-KNOWN, по использованию: hwd_phy_rx_read_and_parse_brp_ram) */
#define PHY_RX_POSTDIST_DC_PER_SAR  0x8851a0u  /* бит 0 postdist_dc_per_sar_mode (REGS-KNOWN; UT 0x417) */
#define HW_PRS_OWN_ADDR_LO         0x886020u  /* REGS-KNOWN prs_own_addr_lo (по использованию: l2mgr__apply_mac_address) */
#define HW_MAC_IRQ_CTL_886028             0x886028u  /* по использованию: isr_mac_886028_fw, mac_bringup__ack_and_unmask_irqs */
#define HW_RX_KEY_TBL_CTRL         0x88602cu  /* REGS-KNOWN rx_key_tbl_ctrl (по использованию: add_key) */
#define HW_RX_KEY_TBL_CMD          0x886030u  /* REGS-KNOWN rx_key_tbl_cmd (по использованию: add_key) */
#define HW_RX_KEY_TBL_ADDR         0x886034u  /* REGS-KNOWN rx_key_tbl_addr (лог «In the add_key function. KEY[0]ADDRESS: %x») */
#define HW_RX_KEY_TBL_DATA0        0x886038u  /* REGS-KNOWN rx_key_tbl_data0 (по использованию: add_key) */
#define HW_RX_KEY_TBL_DATA1        0x88603cu  /* REGS-KNOWN rx_key_tbl_data1 (то же) */
#define HW_RX_KEY_TBL_DATA2        0x886040u  /* REGS-KNOWN rx_key_tbl_data2 (то же) */
#define HW_RX_KEY_TBL_DATA3        0x886044u  /* REGS-KNOWN rx_key_tbl_data3 (то же) */
#define MAC_TEST_REG_8860D4         0x8860d4u  /* тестовый регистр UT, поле [7:1] (REGS-KNOWN mac_test_reg_8860d4) */
#define HW_RX_KEY_VALID_BITMAP     0x8860d8u  /* REGS-KNOWN rx_key_valid_bitmap (по использованию: add_key) */
#define HW_MAC_PRS_CTRL_0          0x886200u  /* REGS-KNOWN MAC_PRS_CTRL_0 (пак 11ad PmcRegistersAccessor.cpp) */
#define HW_PRS_IMC                 0x886224u  /* REGS-KNOWN PRS_IMC (драйвер struct RGF_ICR; база ICR — HW_PRS_ICR) */
#define HW_PRS_RX_CTRL_886250      0x886250u  /* REGS-KNOWN prs_rx_ctrl_886250 (лог-строка hwd_mac__enable_multicast) */
#define HW_PRS_CFG_886258          0x886258u  /* REGS-KNOWN prs_cfg_886258 (по использованию: mac_parser__set_886200, wmi_cfg_rx_chain) */
#define HW_PRS_CFG_88625C          0x88625cu  /* REGS-KNOWN prs_cfg_88625c (по использованию: mac_parser__set_886200) */
#define HW_PRS_RULE_CTL            0x886260u  /* REGS-KNOWN prs_rule_ctl_N: массив 0x886260 + 4·i (i = 0..3), при подъёме [1] = 0x4102 (mac_parser__set_886260) */
#define HW_PRS_TBL_A_CTRL          0x886274u  /* REGS-KNOWN prs_tbl_a_ctrl (по использованию: mac_filter__write_*) */
#define HW_PRS_TBL_A_CMD           0x886278u  /* REGS-KNOWN prs_tbl_a_cmd (то же) */
#define HW_PRS_TBL_A_ADDR          0x88627cu  /* REGS-KNOWN prs_tbl_a_addr (то же) */
#define HW_PRS_TBL_A_DATA0         0x886280u  /* REGS-KNOWN prs_tbl_a_data0 (то же) */
#define HW_PRS_TBL_A_DATA1         0x886284u  /* REGS-KNOWN prs_tbl_a_data1 (то же) */
#define HW_PRS_DEFAULT_CTRL        0x886288u  /* REGS-KNOWN prs_default_ctrl (по использованию: mac_parser__set_default_ctrl) */
#define HW_PRS_TBL_B_CTRL          0x88628cu  /* REGS-KNOWN prs_tbl_b_ctrl (по использованию: mac_parser__uses_rgf_886280) */
#define HW_PRS_TBL_B_CMD           0x886290u  /* REGS-KNOWN prs_tbl_b_cmd (то же) */
#define HW_PRS_TBL_B_ADDR          0x886294u  /* REGS-KNOWN prs_tbl_b_addr (то же) */
#define HW_PRS_TBL_B_DATA0         0x886298u  /* REGS-KNOWN prs_tbl_b_data0 (то же) */
#define HW_PRS_TBL_B_DATA1         0x88629cu  /* REGS-KNOWN prs_tbl_b_data1 (то же) */
#define HW_RX_Q_BASE_CFG           0x886400u  /* REGS-KNOWN rx_q_base_cfg (по использованию: rx_macq__build_ba_desc) */
#define HW_MAC_ICR_886434_ICR      0x886438u  /* REGS-KNOWN mac_icr_886434_icr (драйвер struct RGF_ICR) */
#define HW_MAC_ICR_886434_IMC      0x88644cu  /* REGS-KNOWN mac_icr_886434_imc (драйвер struct RGF_ICR) */
#define HW_MAC_ICR_886504_ICR      0x886508u  /* REGS-KNOWN mac_icr_886504_icr (по использованию: mac_bringup__ack_and_unmask_irqs) */
#define HW_MAC_ICR_886504_IMC      0x88651cu  /* REGS-KNOWN mac_icr_886504_imc (драйвер struct RGF_ICR) */
#define HW_BAP_Q_AVAIL_VEC         0x886548u  /* REGS-KNOWN bap_q_avail_vec (DATAPATH 4.1, MSXD R41[12] BAP_Q_AVAIL) */
#define HW_PRP_QID_RING_MAP        0x886800u  /* REGS-KNOWN prp_qid_ring_map (по использованию: rx_macq__bind_queue) */
#define HW_PRP_QID_MAP_SEL0        0x886820u  /* REGS-KNOWN (при prp_qid_map_sel1): карта qid селектора 0 (rx_macq__bind_queue / dma_ring qtype 0) */
#define HW_PRP_QID_MAP_SEL1        0x886824u  /* REGS-KNOWN prp_qid_map_sel1 (по использованию: rx_macq__bind_queue) */
#define HW_PRP_QID_MAP_SEL2        0x886828u  /* REGS-KNOWN (при prp_qid_map_sel1): карта qid селектора 2 (qtype 2) */
#define HW_PRP_AVAIL_VEC           0x88682cu  /* REGS-KNOWN prp_avail_vec (лог «Wait prp_avail_vec_val ...») */
#define HW_PRP_CTRL                0x886838u  /* REGS-KNOWN prp_ctrl (по использованию: mac__set_886838_b0, wmi_cfg_rx_chain) */
#define HW_MAC_ICR_88683C_ICR      0x886840u  /* REGS-KNOWN mac_icr_88683c_icr (по использованию: mac_bringup__ack_and_unmask_irqs) */
#define HW_MAC_ICR_88683C_IMC      0x886854u  /* REGS-KNOWN mac_icr_88683c_imc (драйвер struct RGF_ICR) */
#define HW_TXQ_CTRL_1              0x886a04u  /* REGS-KNOWN txq_ctrl_1 (по использованию: mac_bringup__init_dma_ctrl); txq_ctrl_0 = HW_TXQ_REGS */
#define HW_TXQ_PTP_AVAIL           0x886a24u  /* REGS-KNOWN txq_ptp_avail (лог «PTP Availibilty = %x m_vring_index %d») */
#define HW_MAC_CTL_886AA0          0x886aa0u  /* REGS-KNOWN mac_ctl_886aa0 (по использованию: mac_bringup__set_886a80_ctl_bit0) */
#define HW_RGF_MAC_MTRL_COUNTER_0  0x886aa8u  /* REGS-KNOWN (драйвер RGF_MAC_MTRL_COUNTER_0, лог «Lifetime: MTRL count …») */
#define HW_CID_MCS_TBL             0x886b00u  /* REGS-KNOWN cid_mcs_tbl (docs/LMAC-PROTOCOL.md): массив по очередям, [q*4] */
#define HW_MAC_TBL_886C00_CTRL     0x886bf8u  /* REGS-KNOWN mac_tbl_886c00_ctrl (по использованию: mac__program_886c00_entry) */
#define HW_MAC_TBL_886C00_CMD      0x886bfcu  /* REGS-KNOWN mac_tbl_886c00_cmd (то же) */
#define HW_MAC_IND_WR_DATA0        0x886c00u  /* REGS-KNOWN mac_ind_wr_data0 (то же) */
#define HW_MAC_IND_WR_DATA1        0x886c04u  /* REGS-KNOWN mac_ind_wr_data1 (то же) */
#define HW_MAC_IND_WR_DATA2        0x886c08u  /* REGS-KNOWN mac_ind_wr_data2 (то же) */
#define HW_MAC_EDCA_AIFS           0x886d68u  /* по AC i (4 регистра, шаг 4, 0x886d68..0x886d74): [31:28] AIFSN, младшие — 0x201ff (uc txrx_api_step_c, LMAC EDCA); нет в REGS-KNOWN */
#define HW_MAC_EDCA_SEED           0x886d78u  /* по AC i (4 регистра, шаг 4, 0x886d78..0x886d84): 0xc0adc0ad << i (uc txrx_api_step_c); вероятно затравка ГПСЧ отсрочки; нет в REGS-KNOWN */
#define HW_FW2UC_ICS                      0x886dd8u  /* драйвер struct RGF_ICR; по использованию: lmac_if__post_cmd, fw2uc__signal_wa… */
#define HW_MAC_OWN_ADDR_LO         0x886df0u  /* REGS-KNOWN mac_own_addr_lo (по использованию: mac__set_own_addr) */
#define HW_MAC_OWN_ADDR_HI         0x886df4u  /* REGS-KNOWN mac_own_addr_hi (то же) */
#define HW_MAC_MCAST_ADDR_LO       0x886df8u  /* REGS-KNOWN mac_mcast_addr_lo (лог «!!! Multicast MAC address is now applied !!!») */
#define HW_MAC_MCAST_ADDR_HI       0x886dfcu  /* REGS-KNOWN mac_mcast_addr_hi (по использованию: mac__set_mcast_addr) */
#define HW_MAC_HW_ICR_ICS                 0x886e2cu  /* драйвер struct RGF_ICR +0xc; по использованию: isr_mac_886028_fw */
#define HW_MAC_SXD_ERRORS_ICM             0x886e44u  /* драйвер struct RGF_ICR +8; по использованию: fw_vector_06 */
#define HW_MAC_SXD_ERRORS_IMS             0x886e50u  /* драйвер struct RGF_ICR +0x14; по использованию: mac_icr__mask_awake_tsf, fw_v… */
#define HW_MAC_PPDU_REPORT_1       0x886e58u  /* REGS-KNOWN (лог «DEBUG MAC RX: PPDU Report 1») */
#define HW_MAC_PPDU_REPORT_2       0x886e5cu  /* REGS-KNOWN (лог «DEBUG MAC RX: PPDU Report 2») */
#define HW_MAC_PPDU_REPORT_3       0x886e60u  /* REGS-KNOWN (лог «DEBUG MAC RX: PPDU Report 3») */
#define HW_MAC_PPDU_REPORT_4       0x886e64u  /* REGS-KNOWN (лог «DEBUG MAC RX: PPDU Report 4») */
#define HW_MAC_BUSY_STATUS         0x886eccu  /* REGS-KNOWN mac_busy_status (по использованию: STREAM_MGR__2, l2mgr__data_port_open_and_keys) */
#define HW_UCPU_ILINK1                    0x886f50u  /* лог-строка «UCODE :: SYSTEM FATAL CRASH1: … ilink1=0x%X», fw_vector_06 */
#define HW_UCPU_ILINK2                    0x886f54u  /* лог-строка «UCODE :: SYSTEM FATAL CRASH1: … ilink2=0x%X», fw_vector_06 */
#define HW_MAC_SLOT_TIMING         0x886f60u  /* REGS-KNOWN mac_slot_timing_886f60: при инициализации BI 0x03780378 (два поля по 888; mac_set_slot_timing_886f60) */
#define HW_MAC_BI_INIT_ZERO_F78    0x886f78u  /* REGS-KNOWN mac_886f78: обнуляется при инициализации BI вместе с 0x886f7c (bi_mode_init_sequence); смысл не установлен */
#define HW_MAC_BI_INIT_ZERO_F7C    0x886f7cu  /* REGS-KNOWN mac_886f7c: обнуляется при инициализации BI (bi_mode_init_sequence); смысл не установлен */
#define HW_MAC_SCHED_SLOT_END      0x886f84u  /* REGS-KNOWN mac_sched_slot_end (NAMES-EXTRA sched__program_alloc_slot_regs) */
#define HW_MAC_SCHED_SLOT_CTRL     0x886f88u  /* REGS-KNOWN mac_sched_slot_ctrl (по использованию: sched__program_alloc_slot_regs) */
#define HW_MTP_Q_AVAIL             0x886f9cu  /* REGS-KNOWN MTP_Q_AVAIL (MSXD_LR_RGF, DATAPATH 4.1) */
#define HW_MAC_886FBC              0x886fbcu  /* REGS-KNOWN mac_886fbc: ucode пишет 0 при инициализации BI перед уровнем своего прерывания 14; смысл не установлен */
#define HW_MAC_886FC0              0x886fc0u  /* REGS-KNOWN mac_886fc0: ucode пишет 0xffffffff сразу после HW_MAC_886FBC = 0; смысл не установлен */
#define HW_MAC_CNT_CTRL                   0x887008u  /* лог-строка «MAIN() Configurre MAC counters»; по использованию: cnt_handler__c… */
#define HW_MAC_CNT_ICR                    0x887010u  /* по использованию: isr_vec10__ack_mac_icr; драйвер struct RGF_ICR +4 */
#define HW_MAC_CNT_ICM                    0x887014u  /* по использованию: mac_icr__read_cause_887014; драйвер struct RGF_ICR +8 */
#define HW_MAC_CNT2_ICR                   0x88702cu  /* по использованию: isr_vec11__ack_mac_icr2; драйвер struct RGF_ICR +4 */
#define HW_MAC_CNT2_ICM                   0x887030u  /* по использованию: mac_icr__read_cause_887030; драйвер struct RGF_ICR +8 */
#define HW_MAC_CNT_CFG_A_17        0x887144u  /* REGS-KNOWN mac_cnt_cfg_a_17: настройка счётчиков MAC a[17..] (53 слова, шаг 4; лог-строка «MAIN() Configurre MAC counters», boot_fill_addr_tables) */
#define HW_MAC_CNT_SEL_A_17        0x8873c4u  /* REGS-KNOWN mac_cnt_sel_a_17: номер события счётчиков MAC a[17..] (53 слова, шаг 4; в паре с HW_MAC_CNT_CFG_A_17) */
#define RFC_CTRL_F8                 0x8890f8u  /* старшая половина 0xc8 при активации RFC; смысл не установлен (REGS-KNOWN rfc_ctrl_f8) */
#define ABIF_SENSOR_COMP_VALUE      0x889368u  /* код компаратора датчика (REGS-KNOWN; 6.2/docs/UT-DRIVERS.md hwd_abif_sensor_set_comp_value) */
#define ABIF_SENSOR_COMP_OUT        0x889390u  /* бит 0 выход компаратора датчика (REGS-KNOWN; UT 0x127 hwd_abif_sensor_get_comp_out) */
#define ABIF_RGF_889398             0x889398u  /* поле [4:0] (REGS-KNOWN abif_rgf_889398, по использованию) */
#define ABIF_RGF_88939C             0x88939cu  /* слово целиком (REGS-KNOWN abif_rgf_88939c, по использованию) */
#define ABIF_FS_CH1_INT             0x889420u  /* FS канала 1, [9:0]; каналы идут с шагом 8 (REGS-KNOWN abif_fs_ch1_int, по использованию: channel__check_range) */
#define HW_ABIF_FS_CH1_FRAC        0x889424u  /* REGS-KNOWN abif_fs_ch1_frac (лог «orig_fract:%u off:%u») */
#define HW_ABIF_FS_CH2_FRAC        0x88942cu  /* REGS-KNOWN abif_fs_ch2_frac (по использованию: channel__check_range) */
#define HW_RGF_CAF_ICR                    0x88946cu  /* драйвер RGF_CAF_ICR */
#define HW_RGF_CAF_ICR_ICR                0x889470u  /* драйвер RGF_CAF_ICR = 0x88946c, +4 (ICR) */
#define HW_RGF_CAF_ICR_ICM                0x889474u  /* драйвер RGF_CAF_ICR +8 (ICM) */
#define HW_RGF_CAF_ICR_IMS                0x889480u  /* драйвер RGF_CAF_ICR +0x14 (IMS, установка маски) */
#define HW_RGF_CAF_ICR_IMC                0x889484u  /* драйвер RGF_CAF_ICR +0x18 (IMC, снятие маски) */
#define RF_REGD_CTRL                0x889494u  /* поле [3:0] = 0xf при стране «не задана»/JP (REGS-KNOWN rf_regd_ctrl, по использованию) */
#define HW_ABIF_DVS_CLK_CFG        0x8894a0u  /* REGS-KNOWN abif_dvs_clk_cfg (по использованию: hwd__program_889_group) */
#define HW_ABIF_DVS_CTRL_24               0x8894a4u  /* по использованию: ut_hw_modes_cmd_0x304_fw, hwd_abif__fs_on, hwd_abif__fs_off */
#define ABIF_DVS_STAT_64            0x8894e4u  /* поле [21:16] в результат калибровки IF-усиления (REGS-KNOWN abif_dvs_stat_64, по использованию) */
#define ABIF_DVS_STAT_70            0x8894f0u  /* поля [15:12],[19:16],[23:20] (REGS-KNOWN abif_dvs_stat_70, по использованию) */
#define ABIF_RX_SAR_DC_TABLE       0x88a608u  /* таблица SAR DC RX-строк: 64 строки × 8 слов, 5-битные поля (сразу за ABIF_RX_TABLE 64 × 4 слова, до HW_ABIF_CAF_PWDN_MODE); hwd_abif__rx_table_config_sar_dc */
#define ABIF_LPBK_CTRL_6C           0x88ae6cu  /* биты 11..13 на время loopback калибровки (REGS-KNOWN abif_lpbk_ctrl_6c, по использованию) */
#define ABIF_ADC_CLK_CTRL           0x88af08u  /* 0 = такт АЦП вкл., 1 = выкл. (REGS-KNOWN; UT 0x102 hwd_abif_adc_clk_ctrl) */
#define ABIF_SAR_DC                 0x88af10u  /* банк SAR DC, 5-битные поля по 4 в слове (REGS-KNOWN; UT 0x111/0x112/0x114/0x115) */
#define ABIF_SAR_GAIN              0x88af30u  /* банк усиления SAR: 2 слова (c < 2), 4-битные поля по idx (сразу за банком ABIF_SAR_DC 0x88af10..0x88af2c); hwd_abif__rx_rgf_config_sar_gain */
#define ABIF_CTRL_40                0x88af40u  /* бит 0, бит 4, биты 8..11 для loopback (REGS-KNOWN abif_ctrl_40, по использованию) */
#define HW_ABIF_ADC_SAR_VREG_CTRL         0x88af48u  /* UT 0x10b hwd_abif_adc_sar_vreg_ctrl */
#define ABIF_CTRL_64                0x88af64u  /* поле [7:4], цепь 0 из 3 (REGS-KNOWN abif_ctrl_64, по использованию) */
#define ABIF_CTRL_6C                0x88af6cu  /* поле [2:0], цепь 0 из 3 (REGS-KNOWN abif_ctrl_6c, по использованию) */
#define ABIF_CTRL_70                0x88af70u  /* поле [7:4], цепь 1 (REGS-KNOWN abif_ctrl_70, по использованию) */
#define ABIF_CTRL_78                0x88af78u  /* поле [2:0], цепь 1 (REGS-KNOWN abif_ctrl_78, по использованию) */
#define ABIF_CTRL_7C                0x88af7cu  /* поле [7:4], цепь 2 (REGS-KNOWN abif_ctrl_7c, по использованию) */
#define ABIF_CTRL_84                0x88af84u  /* поле [2:0], цепь 2 (REGS-KNOWN abif_ctrl_84, по использованию) */
#define HW_RGF_CAF_OSC_CONTROL            0x88afa4u  /* драйвер RGF_CAF_OSC_CONTROL */
#define ABIF_PLL_CFG                0x88afb0u  /* биты 12..15, 17 при включении PLL (REGS-KNOWN abif_pll_cfg, по использованию: abif__power_up_analog) */
#define HW_ABIF_CTRL_B4                   0x88afb4u  /* по использованию: hwd_abif__uses_rgf_88af80_8ce660 */
#define ABIF_BATTERY_CONFIG         0x88afbcu  /* [7:4],[3:0] банка battery_index (REGS-KNOWN; лог «hwd_abif_battery_config: battery_index %d») */
#define RGF_USER_REVISION_ID        0x88afe4u  /* [1:0] ревизия Sparrow (драйвер RGF_USER_REVISION_ID) */
#define ABIF_STAT_F0                0x88aff0u  /* поле [4:0] 1..16 (REGS-KNOWN abif_stat_f0, по использованию) */
#define HW_PCIE_RGF_EXT_2C                0x88b02cu  /* по использованию: pcie__l1ss_enable, hwd_pcie__clear_88b000_bits */
#define HW_PCIE_RGF_EXT_60                0x88b060u  /* по использованию: pcie__l1ss_enable */
#define HW_PCIE_RGF_EXT_B0                0x88b0b0u  /* по использованию: pcie__l1ss_enable, hwd_pcie__clear_88b000_bits, hwd_pcie__t… */
#define HW_PCIE_RGF_EXT_B4                0x88b0b4u  /* по использованию: pcie__mirror_link_bit */
#define HW_PCIE_L1SS_CFG                  0x88b0b8u  /* лог-строка «Sparrow PCIe L1SS Support enabled»; по использованию: pcie__l1ss_… */
#define HW_PCIE_LINK_STATE                0x88b0c0u  /* по использованию: hwd_pcie__get_88b0c0_state4 */
#define HW_PCIE_LTSSM_STATUS              0x88b0d0u  /* по использованию: hwd_pcie_ltssm_is_l1_idle */
#define HW_MAC_EXT_SCHED_48        0x88c048u  /* REGS-KNOWN mac_ext_sched_48 (по использованию: mid__reset_sched_alloc_regs; окно mac_rgf_ext драйвера) */
#define HW_MAC_EXT_SCHED_4C        0x88c04cu  /* REGS-KNOWN mac_ext_sched_4c (то же) */
#define HW_MAC_EXT_SCHED_SLOT_START 0x88c050u /* REGS-KNOWN mac_ext_sched_slot_start (NAMES-EXTRA sched__program_alloc_slot_regs) */
#define HW_MAC_EXT_SCHED_68        0x88c068u  /* REGS-KNOWN mac_ext_sched_68 (по использованию: mid__program_88c068) */
#define HW_MAC_EXT_SCHED_6C        0x88c06cu  /* REGS-KNOWN mac_ext_sched_6c (то же) */
#define HW_MAC_EXT_33K_MEAS_STAT          0x88c180u  /* по использованию: hwm__measure_33khz_wait, hwm__probe_33khz_clk */


#endif
