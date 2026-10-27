// SPDX-License-Identifier: AGPL-3.0-or-later
/* Карта MMIO-регистров wil6210 (адреса ARC, ядро fw).
 *
 * Здесь — только периферия. Собственные данные прошивки (0x800000..0x807fff)
 * — это обычные глобальные переменные, линкуются в .data/.bss, не сюда.
 *
 * Группы восстановлены из разбора ассемблера; список пополняется по мере
 * портирования модулей.
 */
#ifndef REWRITE_HW_H
#define REWRITE_HW_H

#include "types.h"

/* Чтение/запись 32-битного MMIO-регистра по абсолютному адресу. */
#define MMIO32(addr) (*(volatile u32 *)(addr))
#define MMIO16(addr) (*(volatile u16 *)(addr))
#define MMIO8(addr)  (*(volatile u8 *)(addr))

/* Boot loader — «выделенные регистры», которые драйвер wil6210 опрашивает
 * при загрузке (см. linux/drivers/net/wireless/ath/wil6210/boot_loader.h). */
#define BL_READY        0x880A3Cu  /* boot_loader_ready: драйвер ждёт =1 */
#define BL_STRUCT_VER   0x880A40u  /* boot_loader_struct_version */
#define BL_RF_TYPE      0x880A44u  /* u16 rf_type + u16 rf_status (0=OK) */
#define BL_BB_TYPE      0x880A48u  /* baseband_type */
#define BL_MAC_ADDR     0x880A4Cu  /* mac_address[6] */
#define BL_VER_MAJOR    0x880A52u
#define BL_VER_MINOR    0x880A53u
#define BL_VER_SUBMINOR 0x880A54u
#define BL_VER_BUILD    0x880A56u
#define BL_ASSERT_CODE  0x880A58u
#define BL_ASSERT_BLINK 0x880A5Cu
#define BL_SHUTDOWN_HS  0x880A60u
#define BL_MAGIC        0x880AB8u  /* bl_magic_number; во время работы fw — hw_personality (REGS-KNOWN): персональность платы для SDP/GPIO (0/1) */

/* Состояние прошивки для хоста (0x880a3c+0x8): 4/5/6 по ходу работы,
 * 0xdeaddead при фатале. */
#define BL_FW_STATE     0x880A44u
/* Те же слова «глобального пакета» во время работы fw (REGS-KNOWN; загрузчик до старта fw кладёт
 * сюда свои поля BL_* выше): */
#define HW_FW_SUB_STATE    0x880A48u   /* маркер ассерта для хоста (0xdeaddead) — поверх BL_BB_TYPE */
#define HW_FW_TX_GOODPUT   0x880A58u   /* TX goodput для хоста — поверх BL_ASSERT_CODE */
#define HW_FW_RX_GOODPUT   0x880A5Cu   /* RX goodput — поверх BL_ASSERT_BLINK */
#define HW_FW_BF_MCS       0x880A60u   /* MCS после BF / маска MCS — поверх BL_SHUTDOWN_HS */

/* Базовые адреса периферии (по блокам, см. 6.2/src/asm). */
#define HW_MAC_BASE      0x886000u   /* MAC: тайминги, очереди, счётчики */
#define HW_SXD_MAC_BASE  0x886d00u   /* блок SXD MAC (mac_ifs_sifs и др.), не DMA — docs/UC-REGISTERS.md */
#define HW_MAC_SXD_BASE  0x886d80u   /* mac_sxd_base; +0x50 = fw2uc_ICR */
#define HW_PHY_RGF_BASE  0x883800u   /* PHY RGF-регистры (снапшоты) */
#define HW_PHY_MISC      0x885000u   /* PHY онлайн-измерения */
#define HW_RFC_BASE      0x889000u   /* RF-ядро (RFC): чтение/запись */
#define HW_RFC_BASE_800  0x889800u   /* база отрицательных смещений vendor в блоке RFC/TOF (uc abif_save_override_restore: 0x889520..0x889548) */
#define HW_ABIF_TOP      0x88b000u   /* конец блока ABIF (0x88a000..0x88afff): база отрицательных смещений vendor (uc abif_save_override_restore: 0x88ae08..0x88ae64) */
#define HW_CHIP_STEPPING_ID 0x880000u /* chip_stepping_id (REGS-KNOWN): JTAG ID Sparrow A0 0x0632072f / A1 0x1632072f (pcie bring-up); начало USER RGF (прежде — HW_SWITCH_BASE «AXI/коммутатор»: не использовался) */
#define HW_PRING_BASE    0x881000u   /* PRING (packet ring) */
#define HW_TXQ_REGS      0x886a00u   /* регистры очередей TX (не таймеры) */
#define HW_ADDR_TBL_LO   0x887600u   /* таблица трансляции адресов, младшие */
#define HW_ADDR_TBL_HI   0x887800u   /* ... старшие */


/* Регистры MMIO, к которым обращается uc (имена — 6.2/ref/REGS-62.md из REGS-KNOWN.txt; смысл
 * и биты — там же и в docs/UC-REGISTERS.md §5). */
#define HW_RGF_USER_USAGE_2                  0x880008u   /* RGF_USER_USAGE_2 */
#define HW_RGF_USER_USAGE_3                  0x88000cu   /* RGF_USER_USAGE_3 */
#define HW_RGF_USER_USAGE_4                  0x880010u   /* RGF_USER_USAGE_4 */
#define HW_CLKS_CTL_SW_CLK_VEC_0             0x880af4u   /* clks_ctl_sw_clk_vec_0 */
#define HW_CLKS_CTL_SW_CLK_VEC_1             0x880af8u   /* clks_ctl_sw_clk_vec_1 */
#define HW_CLKS_CTL_SW_CLK_VEC_2             0x880afcu   /* clks_ctl_sw_clk_vec_2 */
#define HW_CLKS_CTL_SW_CLK_VEC_3             0x880b00u   /* clks_ctl_sw_clk_vec_3 */
#define HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0    0x880b04u   /* RGF_USER_CLKS_CTL_SW_RST_VEC_0 */
#define HW_RGF_USER_CLKS_CTL_SW_RST_VEC_1    0x880b08u   /* RGF_USER_CLKS_CTL_SW_RST_VEC_1 */
#define HW_RGF_USER_USER_ICR_ICS             0x880b58u   /* RGF_USER_USER_ICR.ICS */
#define HW_RNG_VALUE                         0x880bc4u   /* hw_rng_value */
#define HW_PWR_MODE_MAP_BE8                  0x880be8u   /* pwr_mode_map_be8 */
#define HW_PWR_MODE_MAP_BEC                  0x880becu   /* pwr_mode_map_bec */
#define HW_PWR_MODE_MAP_BF0                  0x880bf0u   /* pwr_mode_map_bf0 */
#define HW_PWR_MODE_MAP_C04                  0x880c04u   /* pwr_mode_map_c04 */
#define HW_PWR_MODE_MAP_C08                  0x880c08u   /* pwr_mode_map_c08 */
#define HW_PWR_MODE_MAP_C0C                  0x880c0cu   /* pwr_mode_map_c0c */
#define HW_CLKS_CTL_EXT_CLK_VEC_0            0x880c14u   /* clks_ctl_ext_clk_vec_0 */
#define HW_CLKS_CTL_EXT_CLK_VEC_1            0x880c28u   /* clks_ctl_ext_clk_vec_1 */
#define HW_RGF_USER_CLKS_CTL_EXT_SW_RST_VEC_1 0x880c2cu   /* RGF_USER_CLKS_CTL_EXT_SW_RST_VEC_1 */
#define HW_PHY_PWR_CTL                       0x880c78u   /* phy_pwr_ctl */
#define HW_PHY_PWR_STATUS                    0x880c7cu   /* phy_pwr_status */
#define HW_DMA_DESCQ0_12D8                   0x8812d8u   /* dma_descq0_12d8 */
#define HW_L2_OFFLOAD_TX_CTL                 0x881b24u   /* l2_offload_tx_ctl */
#define HW_DMA_FW_ICR_C24_ICR                0x881c28u   /* dma_fw_icr_c24.ICR */
#define HW_DMA_RINGS_WITH_DATA               0x881c84u   /* dma_rings_with_data */
#define HW_PHY_RX_CTL                        0x883010u   /* phy_rx_ctl */
#define HW_PHY_RX_AGC_ROW                    0x88306cu   /* phy_rx_agc_row */
#define HW_PHY_RX_RSSI_ADC_LOCKED            0x883becu   /* [9:0] RSSI АЦП (знак., Q4 дБ), по SFD (phy_rx__read_rssi_adc_locked) */
#define HW_PHY_RX_INA_AGC_START              0x88312cu   /* phy_rx_ina_agc_start */
#define HW_PHY_RX_INA_DET_MODE               0x883150u   /* phy_rx_ina_det_mode */
#define HW_PHY_RX_INA_AGC_GAIN_ARRAY         0x8831ccu   /* phy_rx_ina_agc_gain_array */
#define HW_PHY_RX_SIGNAL_GAIN_ADC_DB         0x883830u   /* phy_rx_signal_gain_adc_db */
#define HW_PHY_RX_STATISTICS_LOCK            0x88395cu   /* phy_rx_statistics_lock */
#define HW_PHY_RX_STATISTICS_CLEAR           0x883960u   /* phy_rx_statistics_clear */
#define HW_PHY_TX_EN                         0x884008u   /* phy_tx_en */
#define HW_UC_ASSERT_CODE                    0x884804u   /* uc_assert_code */
#define HW_PRS_MCAST_ADDR_LO                 0x886018u   /* prs_mcast_addr_lo */
#define HW_PRS_MCAST_ADDR_HI                 0x88601cu   /* prs_mcast_addr_hi */
#define HW_PRS_OWN_ADDR_HI                   0x886024u   /* prs_own_addr_hi */
#define HW_TX_KEY_0                          0x88605cu   /* tx_key_0 */
#define HW_TX_KEY_1                          0x886060u   /* tx_key_1 */
#define HW_TX_KEY_2                          0x886064u   /* tx_key_2 */
#define HW_TX_KEY_3                          0x886068u   /* tx_key_3 */
#define HW_TX_CRYPTO_CTL                     0x88606cu   /* tx_crypto_ctl */
#define HW_MAC_MAC_RGF_PMC_GENERAL_0         0x88607cu   /* MAC_MAC_RGF_PMC_GENERAL_0 */
#define HW_MAC_MODE_MAP_0                    0x8860fcu   /* mac_mode_map_0 */
#define HW_MAC_MODE_MAP_1                    0x886100u   /* mac_mode_map_1 */
#define HW_MAC_MODE_MAP_2                    0x886104u   /* mac_mode_map_2 */
#define HW_MAC_MODE_MAP_3                    0x886108u   /* mac_mode_map_3 */
#define HW_MAC_MODE_MAP_4                    0x88610cu   /* mac_mode_map_4 */
#define HW_MAC_MODE_MAP_5                    0x886110u   /* mac_mode_map_5 */
#define HW_PRS_ICR                           0x886210u   /* PRS_ICR */
#define HW_MAC_MGMT_SEQ_NUM                  0x886544u   /* mac_mgmt_seq_num */
#define HW_TX_ENGINE_STATE                   0x88656cu   /* tx_engine_state */
#define HW_QDESC_WIN_CTRL                    0x886608u   /* qdesc_win_ctrl */
#define HW_QDESC_WIN_CMD                     0x88660cu   /* qdesc_win_cmd */
#define HW_QDESC_WIN_ADDR                    0x886610u   /* qdesc_win_addr */
#define HW_QDESC_WIN_DATA0                   0x886614u   /* qdesc_win_data0 */
#define HW_QDESC_WIN_DATA1                   0x886618u   /* qdesc_win_data1 */
#define HW_TXQ_RING_ENABLE                   0x886a14u   /* txq_ring_enable */
#define HW_TXQ_REQ_SELECT                    0x886a18u   /* txq_req_select */
#define HW_TXQ_REQ_VALUE                     0x886a1cu   /* txq_req_value */
#define HW_TXQ_REQ_APPLY                     0x886a20u   /* txq_req_apply */
#define HW_TXQ_PTR_RESET                     0x886a28u   /* txq_ptr_reset */
#define HW_TXQ_FIFO_SM_A                     0x886a38u   /* txq_fifo_sm_a */
#define HW_TXQ_FIFO_SM_B                     0x886a3cu   /* txq_fifo_sm_b */
#define HW_TXQ_FIFO_SM_C                     0x886a44u   /* txq_fifo_sm_c */
#define HW_TXQ_PTP_SM                        0x886a48u   /* txq_ptp_sm */
#define HW_MAC_TX_MCS_PARAM16                0x886c70u   /* mac_tx_mcs_param16 */
#define HW_MAC_TX_MCS_PARAM8                 0x886c74u   /* mac_tx_mcs_param8 */
#define HW_MAC_IFS_SIFS                      0x886d00u   /* mac_ifs_sifs */
#define HW_MAC_IFS_SLOT                      0x886d04u   /* mac_ifs_slot */
#define HW_MAC_IFS_PIFS_2SLOT                0x886d08u   /* mac_ifs_pifs_2slot */
#define HW_MAC_IFS_RIFS_SBIFS                0x886d0cu   /* mac_ifs_rifs_sbifs */
#define HW_MAC_RX2TX_RESP_START              0x886d10u   /* mac_rx2tx_resp_start */
#define HW_MAC_IFS_CONST_452                 0x886d14u   /* mac_ifs_const_452 */
#define HW_MAC_BI_RELOAD_US                  0x886d18u   /* mac_bi_reload_us */
#define HW_MAC_BI_RELOAD_CLK                 0x886d1cu   /* mac_bi_reload_clk */
#define HW_MAC_BI_INIT_ARG0                  0x886d20u   /* mac_bi_init_arg0 */
#define HW_MAC_BI_INIT_ARG1                  0x886d24u   /* mac_bi_init_arg1 */
#define HW_MAC_BI_INIT_ZERO_28               0x886d28u   /* mac_bi_init_zero_28 */
#define HW_MAC_TSF_EVENT_LO                  0x886d30u   /* mac_tsf_event_lo */
#define HW_MAC_TSF_EVENT_HI                  0x886d34u   /* mac_tsf_event_hi */
#define HW_MAC_TSF_EVENT_CTRL                0x886d38u   /* mac_tsf_event_ctrl */
#define HW_UC_SLEEP_WAKE_MASK                0x886d3cu   /* uc_sleep_wake_mask */
#define HW_MAC_BI_INIT_ONES_40               0x886d40u   /* mac_bi_init_ones_40 */
#define HW_MAC_BI_INIT_CONST_44              0x886d44u   /* mac_bi_init_const_44 */
#define HW_MAC_TIMED_WAIT_US                 0x886d50u   /* mac_timed_wait_us */
#define HW_MAC_USEC_CLK_DIV                  0x886d58u   /* mac_usec_clk_div */
#define HW_MAC_TIMING_CONST_5C               0x886d5cu   /* mac_timing_const_5c */
#define HW_MAC_TIMING_CONST_60               0x886d60u   /* mac_timing_const_60 */
#define HW_MAC_BEACON_INTERVAL               0x886d64u   /* mac_beacon_interval */
#define HW_MAC_CMD1E_OPERAND                 0x886d88u   /* mac_cmd1e_operand */
#define HW_QSET0_MASK_VECTOR                 0x886d8cu   /* QSET0_MASK_VECTOR */
#define HW_QSET1_MASK_VECTOR                 0x886d90u   /* QSET1_MASK_VECTOR */
#define HW_QSET3_MASK_VECTOR                 0x886d98u   /* QSET3_MASK_VECTOR */
#define HW_MAC_BI_INIT_ZERO_AC               0x886dacu   /* mac_bi_init_zero_ac */
#define HW_MAC_CMD0D_TIME_LO                 0x886dc0u   /* mac_cmd0d_time_lo */
#define HW_MAC_CMD0D_TIME_HI                 0x886dc4u   /* mac_cmd0d_time_hi */
#define HW_SXD_LOCAL_WR_DATA                 0x886dc8u   /* sxd_local_wr_data */
#define HW_FW2UC_ICR                         0x886dd0u   /* fw2uc_ICR */
#define HW_FW2UC_ICM                         0x886dd4u   /* fw2uc_ICM */
#define HW_FW2UC_IMV                         0x886ddcu   /* fw2uc_IMV */
#define HW_FW2UC_IMS                         0x886de0u   /* fw2uc_IMS */
#define HW_FW2UC_IMC                         0x886de4u   /* fw2uc_IMC */
#define HW_MAC_TIMING_CONST_E8               0x886de8u   /* mac_timing_const_e8 */
#define HW_MAC_TIMING_CONST_EC               0x886decu   /* mac_timing_const_ec */
#define HW_MAC_LMAC0_TIMING_0                0x886e08u   /* mac_lmac0_timing_0 */
#define HW_MAC_LMAC0_TIMING_1                0x886e0cu   /* mac_lmac0_timing_1 */
#define HW_MAC_LMAC0_TIMING_2                0x886e10u   /* mac_lmac0_timing_2 */
#define HW_MAC_LMAC0_TIMING_3                0x886e14u   /* mac_lmac0_timing_3 */
#define HW_MAC_LMAC0_TIMING_4                0x886e18u   /* mac_lmac0_timing_4 */
#define HW_MAC_LMAC0_TIMING_CONST            0x886e1cu   /* mac_lmac0_timing_const */
#define HW_MAC_SXD_MAC_HW_ICR                0x886e24u   /* MAC_SXD.MAC_HW_ICR */
#define HW_MAC_HW_ICR_IMV                    0x886e30u   /* mac_hw_icr_imv */
#define HW_MAC_HW_ICR_IMS                    0x886e34u   /* mac_hw_icr_ims */
#define HW_MAC_HW_ICR_IMC                    0x886e38u   /* mac_hw_icr_imc */
#define HW_MAC_SXD_ERRORS_ICR                0x886e40u   /* mac_sxd_errors_icr */
#define HW_MAC_SXD_ERRORS_ICS                0x886e48u   /* mac_sxd_errors_ics */
#define HW_MAC_SXD_ERRORS_IMV                0x886e4cu   /* mac_sxd_errors_imv */
#define HW_MAC_SXD_ERRORS_IMC                0x886e54u   /* mac_sxd_errors_imc */
#define HW_MAC_NAV_HW_VALUE                  0x886e84u   /* mac_nav_hw_value */
#define HW_MAC_TIMING_STATUS                 0x886eb4u   /* mac_timing_status */
#define HW_MAC_TIMING_INDIRECT_REG_5         0x886eb8u   /* MAC_SXD.TIMING_INDIRECT.TIMING_INDIRECT_REG_5 */
#define HW_MAC_TSF_HI                        0x886ebcu   /* mac_tsf_hi */
#define HW_MAC_USEC_TO_TBTT                  0x886ec0u   /* mac_usec_to_tbtt */
#define HW_MRFC_SWITCH2TX_STATUS_BUS         0x886f3cu   /* mrfc_switch2tx_status_bus */
#define HW_MRFC_SWITCH2RX_STATUS_BUS         0x886f40u   /* mrfc_switch2rx_status_bus */
#define HW_UCPU_SP                           0x886f4cu   /* ucpu_sp */
#define HW_MAC_TX_QID_ENABLE_MASK            0x886f5cu   /* mac_tx_qid_enable_mask */
#define HW_MAC_TXOP_LIMIT_0                  0x886f70u   /* mac_txop_limit_0 */
#define HW_MAC_TXOP_LIMIT_1                  0x886f74u   /* mac_txop_limit_1 */
#define HW_MAC_SCHED_SLOT_STATUS             0x886f8cu   /* mac_sched_slot_status */
#define HW_MAC_BI_START_TSF_LO               0x886fc4u   /* mac_bi_start_tsf_lo */
#define HW_MAC_BI_START_TSF_HI               0x886fc8u   /* mac_bi_start_tsf_hi */
#define HW_RFC_CORE_CTRL                     0x8890ccu   /* rfc_core_ctrl */
#define HW_RFC_CORE_OPCODE                   0x8890d0u   /* rfc_core_opcode */
#define HW_RFC_CORE_ADDR                     0x8890d4u   /* rfc_core_addr */
#define HW_RFC_CORE_DATA                     0x8890d8u   /* rfc_core_data */
#define HW_RFC_MAC_GO_WHEN_BUSY_ERR_CNT      0x889108u   /* rfc_mac_go_when_busy_err_cnt */
#define HW_RFC_RESET_CTRL                    0x889118u   /* rfc_reset_ctrl */
#define HW_RFC_RFCA_CFG                      0x889154u   /* rfc_rfca_cfg */
#define HW_RFC_DIVIDER_CTRL                  0x889394u   /* rfc_divider_ctrl */
#define HW_RFC_READ_VALID                    0x8893ecu   /* rfc_read_valid */
#define HW_ABIF_FS_CTRL                      0x88941cu   /* abif_fs_ctrl */
#define HW_ABIF_DVS_RF_CTRL                  0x889488u   /* abif_dvs_rf_ctrl */
#define HW_STATE3                            0x8896acu   /* hw_state3 */
#define HW_ABIF_RX_TABLE_CTRL                0x88a204u   /* abif_rx_table_ctrl */
#define HW_ABIF_CAF_PWDN_MODE                0x88ae08u   /* abif_caf_pwdn_mode */
#define HW_MAC_EXT_WINDOW_REMAIN             0x88c120u   /* mac_ext_window_remain */

/* Регистры PHY / ABIF / RFC / USER RGF, повторяющиеся в драйверах калибровки, RF и UT
 * (fw/calib*.c, rf.c, abif_ext.c, car.c, phy_ext.c, temp_service.c, ut_*.c, ...). Имена —
 * 6.2/ref/REGS-KNOWN.txt (источник там же: драйвер RGF_*, wmiUT.xml, лог-строки vendor). */
#define RGF_USER_USER_CPU_0      0x8801e0u  /* бит 1 ручной сброс user-CPU; биты 6..8 отдают банки памяти под запись … */
#define RF_STATUS                0x880a68u  /* 0 RF_OK, 1 RF_NO_COMM, 2 RF_WRONG_BOARD_FILE (globals пака 11ad, … */
#define RGF_USER_CLKS_CTL_0      0x880abcu  /* бит 1 CAR_AHB_SW_SEL: такт AHB от PLL (165 МГц), иначе опорный; … */
#define CLK_SWITCH_STATUS        0x880c60u  /* липкие флаги (запись 1 стирает): бит 2 переключение SEL_SLEEP_OR_REF … */
#define PHY_SELF_MODE_CTL_RX     0x883000u  /* управление self-режимом PHY: пары битов [1:0] и [3:2] (бит разрешения … */
#define PHY_SELF_MODE_CTL_TX     0x883004u  /* self TX режим PHY: бит 1 разрешение, бит 0 строб; взводит … */
#define PHY_RX_SWAP_IQ           0x883038u  /* бит 0 инверсия I, бит 1 инверсия Q на приёме; 3 = … */
#define PHY_RX_AGC_INDEX_FORCE   0x883048u  /* бит 15 = force, [14:0] = agc_val — принудительный индекс AGC; … */
#define PHY_REC_TRIGGER_MODE     0x883598u  /* [15:0] rec_trigger_mode_e рекордера PHY, 0x1f заменяется на 0x1e (UT … */
#define PHY_DBG_CLK_GATE         0x883d60u  /* бит 0 = 1 выключает отладочный такт PHY (пишется инверсия enable); … */
#define PHY_TX_PREDIST_IQ        0x884024u  /* TX IQ-предыскажение: поля [9:0] и [25:16]; выключение пишет … */
#define PHY_TX_SWAP_IQ           0x884028u  /* бит 0 инверсия I, бит 1 инверсия Q на передаче; 3 = … */
#define PHY_TX_SELF_NFRAMES      0x884054u  /* [15:0] nFrames для self transmit; 0xffff = бесконечно, ожидание … */
#define PHY_TX_SELF_PLCP         0x884074u  /* [4:0] phy_tx_plcp_mcs, [22:5] phy_tx_plcp_length для self transmit … */
#define PHY_TX_ATTEN_VAL         0x884134u  /* [7:0] tx_atten_val_i, [15:8] tx_atten_val_q (UT 0x40e … */
#define PHY_SAR_MEAS_CTL         0x885000u  /* управление онлайн- и SAR-измерениями: бит 0 = вкл., бит 6 = пуск … */
#define PHY_SAR_MEAS_STATUS      0x885004u  /* бит 12 = онлайн-измерение готово (UT 0x41d/0x436), бит 13 = SAR-замер … */
/* SparRAW: предел опросов готовности железа (hw_poll_bit, fw/hw_init.c) — 2^25 чтений, на порядки больше
 * штатного ожидания (единицы–сотни опросов). */
#define HW_POLL_MAX              0x2000000u
/* Ожидание «пока бит mask регистра addr установлен» с пределом HW_POLL_MAX для путей со сроком (окно
 * дескрипторов MACQ, общее с uc): в цикле лишь декремент счётчика, таймаут — hw_poll_fail (журнал и
 * ассерт 0x3002 с адресом места, fw/hw_init.c) вне цикла. ХРУПКО: опросы внутри удержания окна —
 * после правки сверять дизассемблер цикла (лишние такты удлиняют ожидание uc). */
#define HW_POLL_WHILE_SET(addr, mask) do {                                   \
        u32 hw_poll_n_ = HW_POLL_MAX;                                       \
        while (MMIO32(addr) & (mask))                                       \
            if (--hw_poll_n_ == 0) {                                        \
                hw_poll_fail((addr), (mask));                               \
                break;                                                      \
            }                                                               \
    } while (0)
#define RFC_TX_POWER_TBL         0x8891b4u  /* массив из 13 регистров (0x8891b4..0x8891e4). При set_low_gain=0 … */
#define RFC_READ_HYST            0x8892b4u  /* регистр гистерезиса чтения RFC: калибровка пишет в биты [2:1] … */
#define ABIF_SENSOR_BGAP_CTRL    0x889364u  /* датчик температуры и bandgap: бит 0 bgap_ctrl, биты 1..2 … */
#define ABIF_PLL_CTRL            0x8893f4u  /* управление PLL (UT 0x101 hwd_abif_pll_ctrl = abif__power_up_analog): … */
#define ABIF_TX_TABLE_CTRL       0x88a000u  /* бит 0 = tx_table_index_force_en (импульс 0/1 = … */
#define ABIF_TX_TABLE            0x88a004u  /* таблица TX, строка = слово: [6:0] dac_fssel, остальные поля … */
#define ABIF_RX_TABLE            0x88a208u  /* таблица RX (AGC), 64 строки: … */
#define ABIF_RX_PREPARE_PWDN     0x88ae60u  /* [13:11] rx_prepare_ifrx_pwdn, [9:2] rx_prepare_rvga_pwdn (UT … */
#define ABIF_LPBK_SWITCH_0       0x88aeb0u  /* [12:9] = первый аргумент hwd_abif_lpbk_mode_switches_config (UT 0x10d … */
#define ABIF_OUT_TO_BUMP_CTL     0x88af44u  /* вывод аналоговых сигналов на контакт: 0 = выкл, режимы 0..3 ставят … */
#define ABIF_LPBK_SWITCH_1       0x88af58u  /* [7:4] и [11:8] = 2-й и 3-й аргументы … */
#define ABIF_LO_SPLITTER_0       0x88af5cu  /* [3:0] dvs_lo_splitter_config_buf_val (группа 1), бит 4 = сплиттер … */
#define ABIF_LO_SPLITTER_1       0x88afa0u  /* [3:0] dvs_lo_splitter_config_buf_val (группа 0), бит 4 = сплиттер … */
#define ABIF_CAF_MODE            0x88afe8u  /* бит 0 = caf_phy_control_mode (UT 0x108), бит 2 = caf_lpbk_mode (UT … */
#define RGF_CAF_PLL_LOCK_STATUS  0x88afecu  /* бит 0 = XTAL стабилен, бит 1 = ROSC готов, бит 2 = PLL захвачен, бит … */

#include "hw_regs.h"

#endif
