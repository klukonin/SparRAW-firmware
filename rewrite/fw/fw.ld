/* SPDX-License-Identifier: AGPL-3.0-or-later
 * Компоновка прошивки fw (главное ядро ARC600).
 *
 * Адресное пространство ARC (рантайм):
 *   код   0x8c0000 .. 0x900000   (256 КБ)
 *   данные 0x800000 .. 0x807fff  (32 КБ)  — через gp=0x800184
 *
 * В финальном .fw образе данные лягут в область fw_data (хост-смещение
 * 0x900000) — это упаковка mkimage.py, сюда не относится.
 */
MEMORY
{
    CODE (rx)  : ORIGIN = 0x8c0000, LENGTH = 0x40000
    DATA (rw)  : ORIGIN = 0x800000, LENGTH = 0x8000
}

ENTRY(_reset)

/* Объекты по фиксированным адресам вне DCCM (рабочая память 0x84xxxx и общая с uc 0x85xxxx;
 * раскладка vendor). Общие с uc (include/fwsh.h) — помечены «uc»: у uc те же имена — макросы
 * на литеральный адрес FWSH_A_<имя>, совпадение проверяет tools/check_fwsh.py. */

/* 0x840000.. */
tx_ring_mem_data = 0x840000; /* struct tx_desc[2] — кольцо DMA 5 */
flash_ids    = 0x840040;  /* struct flash_ids — секция идентификаторов/калибровок flash (include/sys_cfg.h) */
evt_ring     = 0x84008c;  /* struct evt_ring — кольцо событий evt_ring_push_1c (include/dbg.h) */
lmac_mbox_shm = 0x840130; /* struct lmac_mbox_shm (SRAM, видна ucode) — include/mbox.h */
lmac_cmd_ring = 0x840178; /* struct mbox_entry[20] — кольцо команд fw → ucode (include/mbox.h) */
lmac_evt_ring = 0x840218; /* struct mbox_entry[12] — кольцо событий ucode → fw */
lmac_cmd_bufs = 0x840278; /* u8 [0x15][0x100] — буферы команд (lmac_mbox_shm.tx_pool) */
lmac_evt_bufs = 0x841778; /* u8 [0xc][0x64] — буферы событий (lmac_mbox_shm.rx_pool) */
lm_sm_recs  = 0x841c28;   /* struct lm_sm[8] — линк-менеджер по cid, include/link_sm.h */
tx_pending   = 0x842148;  /* struct llist — «ждущие» кадры управления (include/fwq_tx.h) */
tx_api_mgmt = 0x842154;   /* struct fwq_tx — include/fwq_tx.h */
tx_api_2    = 0x8421e4;
tx_api_data = 0x842274;
mac_rx_cnt_regs = 0x8872c4;  /* struct mac_rx_cnt — счётчики RX MAC (MMIO), include/mac_cnt.h */
mac_tx_cnt_regs = 0x887744;  /* struct mac_tx_cnt — счётчики TX MAC (MMIO) */
tx_pkt_pool  = 0x842304;  /* struct mem_pool — кадры TX (include/mem_pool.h) */
tx_api_stats = 0x842318;  /* struct fwq_tx_stats[3] — счётчики mgmt/data/2 */
calib_hw_snap        = 0x842390; /* struct calib_hw_snap — снимок RF/PHY калибровки, include/calib.h */
calib_bb_gain_delta  = 0x8423e4; /* u32 [4][8] — дельты мощности VGA (Calib::Measure_VGA_Gains) */
if_gain_res          = 0x842464; /* struct if_gain_res — результат калибровки IF gain, include/calib.h */
tx_ring_mem_mgmt = 0x842800; /* struct tx_desc[2] — кольцо DMA 6 */
rx_pkt_srvs  = 0x842840;  /* struct rx_pkt_srvs — RX-службы и записи разбора mgmt (include/ieee80211.h) */
scan_ch_pool = 0x842c74;  /* struct mem_pool — элементы списка каналов скана */
scan_ch_mem  = 0x842c88;  /* struct scan_ch[10] — память scan_ch_pool (include/scan_mngr.h) */
scan_cs_sms  = 0x842d00;  /* struct channels_switch_sm[] — автоматы каналов скана по mid */
tx_ring_mem_2    = 0x843000; /* struct tx_desc[2] — кольцо DMA 3 */
debug_mbox    = 0x843040; /* struct wmi_mbox — include/mbox.h */
calib_sar_obj        = 0x8430b8; /* struct calib_obj — include/calib_engine.h */
calib_vga_obj        = 0x8430e0; /* struct calib_obj */
calib_if_gain_obj    = 0x843108; /* struct calib_obj */
calib_lo_leakage_obj = 0x843130; /* struct calib_obj */
mgmt_stats  = 0x843158;   /* struct mgmt_stats — счётчики кадров discovery, include/mid.h */
rx_macq_cfgs = 0x843188;  /* struct rx_macq_cfg[4] — include/macq_desc.h */
rx_ring_mem  = 0x843800;  /* struct rx_desc[8] — кольцо RX (rx_pool_configure_ring, include/rx_ring.h) */
fw_log       = 0x843900;  /* struct fw_log — кольцо журнала fw (адрес — в HW_RGF_USER_USAGE_1; include/dbg.h) */
u_schd_tasks = 0x844914;  /* struct u_schd_task[0x78] — пул задач u_schd, include/sched.h */
op_mbox_rx_bufs  = 0x845634; /* u8 [5][0x518] — буферы команд хоста operational_mbox (include/mbox.h) */
dbg_mbox_rx_bufs = 0x846fac; /* u8 [4][0x64] — буферы команд debug_mbox */
dbg_mbox_tx_bufs = 0x84713c; /* u8 [7][0x100] — буферы событий debug_mbox */
rf_set_ranges        = 0x84783c; /* struct rf_sec_range [8][32] — диапазоны секторов конфигураций наборов */
fixed_sched  = 0x847a3c;  /* struct fixed_sched — фиксированное расписание (include/fwsh.h; uc — по указателю) */
calib_lo_power_obj   = 0x847ae4; /* struct calib_lo_power */
stream_pool  = 0x847b34;  /* struct mem_pool — контексты стримов (fw/stream_mgr.c) */
stream_ctxs  = 0x847b48;  /* struct stream_ctx[9] — элементы stream_pool (include/stream.h) */
stream_by_vr = 0x847f80;  /* struct stream_ctx *[10] — стрим по номеру vring */
temp_rf_mdeg         = 0x847fa8; /* u32 [8] — температура RF по индексу, м°C (-1 — нет) */
rx_macq_bufs = 0x847fc8;  /* struct rx_macq_bufs — буферы дескрипторов RX-MACQ */
tx_pkt_mem   = 0x848020;  /* struct tx_pkt[8] — память tx_pkt_pool */
rx_pkt_mem   = 0x84a940;  /* struct rx_pkt[12] — память пула RX (rx_ring.pool, include/ieee80211.h) */
phy_monitor = 0x84e7e0;   /* struct phy_monitor — монитор PHY, include/phy_monitor.h */
brd_file_buf = 0x84f800;  /* u8 [0x2400] — образ board-файла от хоста (include/brd_if.h) */
op_mbox_tx_bufs  = 0x851c00; /* u8 [0x1b][0x100] — буферы событий operational_mbox */

/* 0x853800: блок статистики fw (0x1c0 Б, адрес — boot_diag.fw_stats_addr). */
fw_stats_hdr         = 0x853800; /* struct fw_stats_hdr — заголовок блока (include/sys_cfg.h) */
temp_snap            = 0x853808; /* struct temp_snap — снимок температур (fw/temp_service.c) */
calib_sar_dc_log     = 0x853830; /* s8 [2][8] — журнал сэмплов SAR (calib_sar_step) */
calib_vga_dc_log     = 0x853840; /* s8 [2][64] — остаток VGA DC по строкам (hwf_vga_dc_calibrate) */
calib_lo_leak_xy     = 0x8538c8; /* u32 [2] — итог LO leakage x/y (calib_lo_leakage_sweep) */
calib_srssi_agc_word = 0x8538d0; /* u32 — слово AGC silent RSSI (silent_rssi_report_agc_tables) */
calib_eng_stats      = 0x8538d4; /* u16 [6][5] — include/calib_engine.h */
fw_stats_dash        = 0x853910; /* uc: struct fw_stats_dash — сводка соединений и счётчики */
mac_mon_pub          = 0x853940; /* uc: struct mac_mon_report_s — опубликованный отчёт MAC_MON */

conn_mgr    = 0x854000;   /* struct conn_mgr — include/conn.h */
ll_detectors = 0x854dd4;  /* struct ll_detectors[8] — детекторы потери линка, include/link_loss.h */

/* 0x857000: общий с uc блок (include/fwsh.h). */
fwsh_diag    = 0x857000;  /* uc: struct fwsh_diag — диагностика и счётчики */
fwq_tx_avail = 0x857040;  /* uc: struct fwq_tx_avail — кадры в очередях по cid */
ll_ctx       = 0x857064;  /* uc: struct ll_ctx — контекст поддержания линка */
ese_slot_tbl = 0x857264;  /* uc: struct ese_slot_tbl — слоты ESE */
fwsh_n_rx_ant      = 0x85728c;  /* uc: u8 */
fwsh_total_sectors = 0x85728d;  /* uc: u8 */
fwsh_long_range    = 0x85728e;  /* uc: u8 */
fwsh_energy  = 0x857290;  /* uc: struct fwsh_energy — отсчёты статистики энергии */
fwsh_phy     = 0x8576a0;  /* uc: struct fwsh_phy_blk — статистика PHY RX */
fwsh_sets    = 0x857730;  /* uc: struct fwsh_sets — наборы RF и параметры развёртки */

/* Диапазоны, которые обнуляет crt0 (fw/start.S, как vendor). */
__sram_clr_start = tx_ring_mem_data;        /* 0x840000 */
__sram_clr_end   = phy_monitor + 0x3c;      /* 0x84e81c: конец struct phy_monitor */
__fwsh_clr_start = fwsh_diag;               /* 0x857000 */
__fwsh_clr_end   = 0x857828;               /* как vendor (до конца области шаблона FTM — SparRAW-pro) */
__conn_clr_start = conn_mgr;                /* 0x854000 */
__conn_clr_end   = ll_detectors + 8 * 0xa4; /* 0x8552f4: конец ll_detectors[8] */

SECTIONS
{
    /* Векторы прерываний и код — единой секцией .text, чтобы
     * build_fw.py (objcopy --only-section=.text) упаковал и векторы
     * (иначе reset-вектор 0x8c0000 теряется). */
    .text : {
        KEEP(*(.vectors))
        *(.text.startup)
        *(.text)
        *(.rodata .rodata.*)
    } > CODE

    /* Все портированные функции (-ffunction-sections → .text.*) + явные
     * .textlate — сразу за .text (прежде фиксированный 0x8c6400 оставлял ~20 КБ ICCM
     * пустыми; рантайм-причины для него нет — адрес двигали ради упаковки образа). */
    .textlate ALIGN(0x10) : {
        *(.text.*)
        *(.textlate)
    } > CODE

    .data : {
        *(.data .data.*)
    } > DATA

    .bss (NOLOAD) : {
        __bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        . = ALIGN(4);
        __bss_end = .;
    } > DATA

    /* .bss/.data ставятся с начала DATA (0x800000) — поверх неподвижных переменных DCCM (.fwdata.<адрес>, dccm.h):
     * ld перекрытие с NOLOAD не проверяет, crt0 обнулил бы и начальные значения (проверено пробной сборкой). */
    ASSERT(SIZEOF(.data) == 0 && SIZEOF(.bss) == 0,
           "fw: .data/.bss запрещены - переменные fw только по фиксированным адресам (.fwdata.<addr>, dccm.h)")
    /* Верхушка стека — конец DATA. */
    __stack_top = ORIGIN(DATA) + LENGTH(DATA);
    __dccm_start = ORIGIN(DATA);              /* 0x800000: начало DCCM (fw/power.c — проверка описателя) */
    __gp = ORIGIN(DATA) + 0x184;              /* 0x800184: база gp-адресации, как vendor cpu_reset_init (fw/start.S) */

    /DISCARD/ : {
        *(.comment)
        *(.note*)
    }
}
