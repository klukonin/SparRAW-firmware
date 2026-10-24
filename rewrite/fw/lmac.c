// SPDX-License-Identifier: AGPL-3.0-or-later
/* Инициализация LMAC (интерфейс с ucode) — lmac_if__ucode_init (0x8f5fd8).
 * Строит кольца команд и запускает второе ядро (ucode). */
#include "../include/types.h"
#include "../include/sched_scheme.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/sysapi_mgr.h"
#include "../include/rf_obj.h"
#include "../include/fwdata.h"
#include "../include/temp_sense.h"
#include "../include/mbox.h"
#include "../include/conn.h"
#include "../include/calib_engine.h"
#include "../include/lmac_cmd.h"
#include "../include/sys_cfg.h"


/* Построить кольца ящика ucode (lmac_mbox) и их описатели в SRAM (lmac_mbox_shm, видна
 * ucode). Портировано из lmac_if__build_cmd_rings (0x8f94e4). */
void lmac_if_build_cmd_rings(struct lmac_mbox *mb)
{
    struct lmac_mbox_shm *m = &lmac_mbox_shm;

    /* Кольцо событий (ucode → fw): 12 записей 0x840218, буферы 0xc × 0x64 (0x841778). */
    MMIO32(HW_SCRATCH_PAD_9) = (u32)&m->rx_hw;       /* вендорская публикация */
    m->rx_hw.base = (u32)lmac_evt_ring;
    m->rx_hw.tail = (u32)lmac_evt_ring;
    m->rx_hw.head = (u32)lmac_evt_ring;
    m->rx_hw.size = 0x60;
    m->rx_hw.entry_size = 0x64;
    memset0_words(lmac_evt_ring, sizeof(lmac_evt_ring));
    memset0_words(lmac_evt_bufs, sizeof(lmac_evt_bufs));
    mem_pool_init(&m->rx_pool, lmac_evt_bufs, sizeof(lmac_evt_bufs[0]), 0xc);
    ring_init_desc(&mb->mb.rx, lmac_evt_ring, sizeof(lmac_evt_ring), &m->rx_hw, &m->rx_pool, 1, 1);

    /* Кольцо команд (fw → ucode): 20 записей 0x840178, буферы 0x15 × 0x100 (0x840278). */
    m->tx_hw.base = (u32)lmac_cmd_ring;
    m->tx_hw.tail = (u32)lmac_cmd_ring;
    m->tx_hw.head = (u32)lmac_cmd_ring;
    m->tx_hw.size = 0xa0;
    m->tx_hw.entry_size = 0x100;
    memset0_words(lmac_cmd_ring, sizeof(lmac_cmd_ring));
    memset0_words(lmac_cmd_bufs, sizeof(lmac_cmd_bufs));
    mem_pool_init(&m->tx_pool, lmac_cmd_bufs, sizeof(lmac_cmd_bufs[0]), 0x15);
    ring_init_desc(&mb->mb.tx, lmac_cmd_ring, sizeof(lmac_cmd_ring), &m->tx_hw, &m->tx_pool, 1, 1);

    /* mbox_ctl (0x8802bc) заполняет boot ROM — НЕ перезаписываем его.
     * Прошивка лишь публикует адрес кольца событий (0x840158 → 0x8802e0)
     * и обновляет rx.head (0x8802d8) при постилке события. */
}

void lmac_if_ucode_init(void)
{
    fw_log_emit0(0x20, 0x1004868);
    if (lmac_ucode_ready != 0)          /* [gp,0x244] — уже инициализировано */
        fw_sysassert_fatal((void *)0, 0x1045);
    lmac_if_build_cmd_rings(&lmac_mbox);

    fw_log_emit0(0x20, 0x1004888);
    MMIO32(HW_RGF_USER_MAC_CPU_0) = 0x31;            /* запуск ucode */
    arc_sync();

    fw_log_emit0(0x20, 0x100489c);
    MMIO32(HW_RGF_USER_USER_ICR_IMC) = 0x200;           /* снять маску прерывания ucode */
    arc_sync();
}

/* ================= LMAC-команды lmac_if__lmac_ready_evt (0x8f61b0) ================= */


/* CW (показатели ecw_min/ecw_max) всех AC по режиму EDCA 0..2. */
struct lmac_edca_cw {
    u16 ecw_min;                               /* 0x00 */
    u16 ecw_max;                               /* 0x02 */
};
_Static_assert(sizeof(struct lmac_edca_cw) == 4, "lmac_edca_cw");

/* 0x800c00: CW по режиму EDCA (за ней — lmac_edca_cur_mode 0x800c0c). vendor не пишет. */
FWDATA(800c00) const struct lmac_edca_cw lmac_edca_mode_cw[3] = {
    { 4, 4 },
    { 4, 7 },
    { 1, 1 },
};

/* edca__fill_ac_table_by_mode (0x8dc28c): заполнить 4 AC-записи (по 0xc Б)
 * из записи режима lmac_edca_mode_cw: [0..3]=AC-index, [4..5]=ecw_min, [6..7]=ecw_max,
 * [8..9]=3. Для i==0 ecw ограничены сверху 4. */
static void edca_fill_ac_table_by_mode(struct lmac_cmd_edca *buf, u32 mode)
{
    u32 tbl;   /* адрес записи — целым: на ветке ассерта vendor читает с адреса 0 (r13 = 0) */
    if (mode == 0)      tbl = (u32)&lmac_edca_mode_cw[0];
    else if (mode == 1) tbl = (u32)&lmac_edca_mode_cw[1];
    else if (mode == 2) tbl = (u32)&lmac_edca_mode_cw[2];
    else {
        fw_sysassert_fatal((void *)0, 0x10cd);   /* 0xcd | (1<<12) */
        tbl = 0;                                 /* vendor: r13 = 0 */
    }

    const struct lmac_edca_cw *cw = (const struct lmac_edca_cw *)tbl;
    struct lmac_edca_ac *e = buf->ac;
    for (u32 i = 0; i < 4; i++, e++) {
        e->ac = i;
        u32 a = cw->ecw_min;
        if (i == 0) a = (a < 4) ? a : 4;
        e->ecw_min = (u16)a;
        u32 b = cw->ecw_max;
        if (i == 0) b = (b < 4) ? b : 4;
        e->ecw_max = (u16)b;
        e->aifsn = 3;
    }
}

/* lmac_if_send_cmd_0x04 (0x8dc2f8): RX-enable / EDCA-таблица AC (type 0x04, 0x30 Б). */
void lmac_if_send_cmd_0x04(u32 mode)
{
    if (mode == lmac_edca_cur_mode)
        return;
    lmac_edca_cur_mode = mode;
    struct lmac_cmd_edca *buf = lmac_cmd_pool_alloc();   /* после lmac_cmd_pool_alloc (uncached) */
    if (buf == 0)
        return;
    edca_fill_ac_table_by_mode(buf, mode);
    lmac_if_post_cmd(buf, 0x04, 0x30, 0);
}

/* 0x800bdc: конфигурация PHY INA-детектора по умолчанию — тело LMAC 0x20 при lmac_ready
 * (wmi_cfg_rx_chain копирует её для режима sniffer). vendor её не пишет. Смысл cfg —
 * у ucode (cmd20_cfg): 4 пары {u32 0x135a1320/0x135f1373, u32 1/3/2/3}. */
FWDATA(800bdc) const struct lmac_cmd_ina_det phy_ina_det_cfg = {
    .cfg = {
        0x20, 0x13, 0x5a, 0x13, 0x01, 0x00, 0x00, 0x00,
        0x20, 0x13, 0x5a, 0x13, 0x03, 0x00, 0x00, 0x00,
        0x20, 0x13, 0x5a, 0x13, 0x02, 0x00, 0x00, 0x00,
        0x73, 0x13, 0x5f, 0x13, 0x03, 0x00, 0x00, 0x00,
    },
    .flags = 2,
};

/* lmac_if__send_phy_ina_det_cfg (0x8dbb24): PHY INA-detection config
 * (0x24 Б из src → type 0x20). */
void lmac_if_send_phy_ina_det_cfg(const struct lmac_cmd_ina_det *src)
{
    struct lmac_cmd_ina_det *buf = lmac_cmd_pool_alloc();
    memcpy_fw(buf, src, 0x24);
    u32 v = buf->flags;
    fw_log_emit2(0x2b, 0x1003a90, (v >> 1) & 1, v & 1);
    lmac_if_post_cmd(buf, 0x20, 0x24, 0);
}


/* lmac_if__send_cmd_0x16_calib_b4 (0x8dc120): калибровочная команда LO-power
 * (type 0x16, 4 Б). vendor: calib_obj4_reset_d4 → get_byte_b4 → obj[0]=obj[0xb4]
 * → post(obj, 0x16, 4, 0). ucode копирует 4 Б в 0x80054c (uc/cmd.c). */
void lmac_if_send_cmd_0x16_calib_b4(void)
{
    /* Тело — буфер из пула команд (vendor mem_pool_alloc_locked(0x804280)); прежде
     * отправлялся сам калибровочный объект 0x804b5c, и wmi_evt_walk_list потом
     * «освобождал» его в пул команд (ассерт 0xe8). */
    struct lmac_cmd_calib_gain *buf = lmac_cmd_pool_alloc();
    calib_obj4_reset_d4();
    struct calib_silent_rssi *obj =
        (struct calib_silent_rssi *)calib_engine_get_by_index(CALIB_ENG_SILENT_RSSI);
    buf->target = obj->target;
    lmac_if_post_cmd(buf, 0x16, 4, 0);
}

/* ================= LMAC ready (vendor 0x8f61b0) и его команды ================= */


/* pcie__get_driver_is_up (0x8d13c4): бит 1 регистра 0x88265c. */
static u32 pcie_get_driver_is_up(void)
{
    return (MMIO32(HW_RGF_HP_CTRL) >> 1) & 1;
}

/* lmac_if__send_txop_limits (0x8dbaa0): 4 × u16 лимита TXOP (type 0x21, 8 Б).
 * При [0x803c0c] ≠ 0 лимит 0x8003f0 = 0x500. Лимит ≥ 0x800 — assert 0x10d1. */
static void lmac_if_send_txop_limits(void)
{
    struct lmac_cmd_txop_limits *buf = lmac_cmd_pool_alloc();
    if (buf == 0)
        return;
    for (u32 i = 0; i < 4; i++) {
        u32 v = lmac_txop_limit;
        buf->limit_us[i] = (u16)v;
        if ((u16)v >= 0x800)                /* extw (без знака) + cmp 0x800 */
            fw_sysassert_fatal((void *)__builtin_return_address(0), 0xd1 | (1u << 12));
    }
    lmac_if_post_cmd(buf, 0x21, 8, 0);
}

/* hw_sysapi_rx__alloc_and_store (0x8dbb04): {u8 a, u16 b} → type 0x19 (4 Б). */
void hw_sysapi_rx_alloc_and_store(u32 a, u32 b)
{
    struct lmac_cmd_rf_chain *buf = lmac_cmd_pool_alloc();
    buf->rf = (u8)a;
    buf->sector = (u16)b;
    lmac_if_post_cmd(buf, 0x19, 4, 0);
}

/* lmac_if_send_cmd_0x23 (0x8db04c): 3 слова (type 0x23, 0xc Б). */
void lmac_if_send_cmd_0x23(u32 a)
{
    struct lmac_cmd_bi_tbl *buf = lmac_cmd_pool_alloc();
    u32 w1;
    buf->responder_mode = (a != 0 ? 1u : 0u) << 1;   /* OOB R1 (только SparRAW-pro): 2 */
    w1 = (a != 0 ? 0u : 1u) + 1;
    buf->beacon_type = w1;
    buf->relax_period = 1;
    lmac_if_post_cmd(buf, 0x23, 0xc, 0);
}

/* lmac_if__send_fw_ready_evt (0x8f3d80): бит события PCIe 0, прерывание FW_READY,
 * событие хосту WMI_FW_READY_EVENTID (0x1801, 4 Б). */
static void lmac_if_send_fw_ready_evt(void)
{
    pcie_set_event_bit(0);              /* pcie__set_event_bit_0_fw_ready */
    host_irq_raise_fw_ready();
    void *p = host_if_send_pair();
    fw_log_emit0(0x20, 0x1000c90);
    low_sme_send_evt2sw(p, 0x1801, 4, 0, 0, 0, 0);
}


/* sector_list__validate (0x8d9ac8): список секторов (до 64, конец — 0xff, каждый
 * < 0x40) → dst (struct ss_cfg_s): x0 = a, host_set = b, order = список (0x40 Б),
 * n_frames = число. */
u32 sector_list_validate(struct ss_cfg_s *dst, const u8 *list, u32 a, u32 b)
{
    if (list[0] == 0xff) {
        fw_log_emit0(0, 0x1003ad8);
        return 0;
    }
    u32 n;
    for (n = 0; n < 64; n++) {
        u32 v = list[n];
        if (v == 0xff)
            break;
        if (v >= 0x40) {
            fw_log_emit3(0, 0x1003af8, 0x40, v, n);
            return 0;
        }
    }
    memcpy_fw(dst->order, list, 0x40);
    dst->n_frames = (u8)n;
    dst->x0 = a;
    dst->host_set = b;
    return 1;
}

/* rf_if__tx_sectors_vcall_14 (0x8cb7f8): список секторов TXSS по умолчанию —
 * виртуальный метод tx_sectors (vt[5]) интерфейса board-файла rf->brd_if. */
const u8 *rf_if_tx_sectors(struct rf_obj *rf)
{
    struct brd_if *obj = rf->brd_if;
    return obj->vt->tx_sectors(obj);
}

/* lmac_if_config_txss (0x8db60c): команда 0x0c (0x50 Б) — список секторов TXSS для
 * станции cid: из таблицы конфигураций ucode (0x8577b0: пары {первый, последний},
 * индекс — RX-сектор соединения, число конфигураций — [0x85773c]) или по умолчанию от RF-объекта
 * (cid 8 — широковещательный, конфигураций < 2, нет станции, индекс 0xffff).
 * ss.x49 (+0x4d) — индекс конфигурации (0 — по умолчанию). */
void lmac_if_config_txss(u32 cid)
{
    struct lmac_cmd_sta_sweep *buf = lmac_cmd_pool_alloc();
    u8 list[0x44];
    const u8 *lp = 0;
    buf->sta = (u8)cid;
    if (fwsh_sets.n_sec[1][0] >= 2 && cid != SPARRAW_PEER_UNKNOWN) {
        struct conn *conn = conn_mgr_by_cid(cid);
        if (conn != 0) {
            u32 idx = conn->rx_sector;
            if (idx >= fwsh_sets.n_sec[1][0] && idx != 0xffff)
                fw_sysassert_fatal((void *)__builtin_return_address(0), 0x1575);
            if (idx != 0xffff) {
                const u8 *r = (const u8 *)&(*fwsh_sets.set_ranges)[idx];
                u32 n = (u8)(r[1] - r[0] + 1);
                if (n > 64) {
                    fw_sysassert_fatal((void *)__builtin_return_address(0), 0x1576);
                    /* Баг vendor: после (возвращающегося) ассерта он пишет n + 1 Б в
                     * буфер 0x44 Б на стеке. Ограничиваем 64 — столько и берёт
                     * sector_list_validate. */
                    n = 64;
                }
                u32 i;
                for (i = 0; i < n; i++)
                    list[i] = (u8)i;
                list[i] = 0xff;
                buf->ss.x49 = (u8)idx;
                lp = list;
            }
        }
    }
    if (lp == 0) {
        buf->ss.x49 = 0;
        lp = rf_if_tx_sectors(&rf_obj);
    }
    if (sector_list_validate(&buf->ss, lp, 0, 0) == 0)
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x136a);
    fw_log_emit2(0x20, 0x1003b38, buf->ss.n_frames, cid);
    lmac_if_post_cmd(buf, 0x0c, 0x50, 0);
}

/* lmac_if__config_txss_8 (0x8db71c): TXSS по умолчанию (широковещательный cid 8). */
static void lmac_if_config_txss_8(void)
{
    lmac_if_config_txss(8);
}

/* temp_sense__get_cached (0x8dddc0): запрос температуры с колбэком cb(ctx). Если служба
 * уже занята ([0x8000a8] — колбэк ожидающего запроса) — «Temp sense is currently active -
 * using old values»: сразу зовётся ОЖИДАЮЩИЙ колбэк ([0x8000a8]([0x8000a4], t, [0x8000ac]))
 * с последним значением, новый cb не запоминается (как у vendor). Иначе запомнить cb/ctx,
 * снять таймер службы [0x80017c] и запустить измерение. */
FWDATA(8000a8) volatile temp_done_fn temp_pending_cb = 0;

void temp_sense_get_cached(temp_done_fn cb, u32 ctx)
{
    if (temp_pending_cb != 0) {
        fw_log_emit0(0x10, 0x1011e94);
        u32 t = temp_get_active_rf(0);
        temp_pending_cb(temp_bb_mdeg, t, temp_pending_ctx);
        return;
    }
    temp_pending_cb = cb;
    temp_pending_ctx = ctx;
    if (temp_timer_task != 0) {
        u_schd_cancel(temp_timer_task);
        temp_timer_task = 0;
    }
    temperature_service_timer_exp_handler(1, 0);
}


/* lmac_if__lmac_ready_evt (0x8f61b0): ucode готов (событие EVENT_UCODE_READY). */
void lmac_if_lmac_ready_evt(void)
{
    lmac_ucode_ready = 1;               /* st.as [gp,0x91]: lmac_ready */
    lmac_if_send_cmd_0x04(0);
    lmac_if_send_txop_limits();
    hw_sysapi_rx_alloc_and_store(rf_obj.rf_idx, rf_obj.sector_cfg_idx);
    lmac_if_send_phy_ina_det_cfg(&phy_ina_det_cfg);
    fw_log_emit1(0x20, 0x1003b68, pcie_get_driver_is_up());
    if (platform_is_asic() != 0)
        lmac_if_send_cmd_0x16_calib_b4();
    fw_data_fresh_magic = 0x33333333;      /* st.as 0x33333333,[gp,0x55] */
    lmac_if_send_fw_ready_evt();
    hwd_rfc_read_calibrate(1000);
    l2mgr_on_lmac_ready();              /* l2mgr_init → WMI_READY (0x1001) */
    lmac_if_config_txss_8();
    led_scheme_apply(4);
    lmac_if_send_cmd_0x23(0);
    temp_sense_get_cached(0, 0);
}

/* ================= События ucode → fw (vendor 0x8df07c) ================= */

/* обработчики — lmac_evt.c */


/* brd_if_multi_array::get_section_info (0x8ccb7c; по коду — mid__sched_obj): схема
 * расписания 0x805234. */
static struct sched_scheme *brd_if_multi_array_get_section_info(void)
{
    return &sched_scheme;
}

/* Журнал vendor «Ucode->EVENT_…: type 0x0%x, curr tsf 0x%08x %08x». */
static void uc_evt_log(u32 token, u32 type, const u32 *tsf)
{
    fw_log_emit3(0x20, token, type, tsf[1], tsf[0]);
}

/* 0x801f40: таблица переходов switch vendor lmac_if__ucode_event_dispatch (0x8df084;
 * ldw, цель = 0x8df0bc + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(801f40) const u16 lmac_if_ucode_event_dispatch_jt[49] = {
    0x0000, 0x000e, 0x0013, 0x0022, 0x004f, 0x002f, 0x0041, 0x0190,
    0x005e, 0x006d, 0x0190, 0x0190, 0x0190, 0x0190, 0x0190, 0x0190,
    0x0190, 0x007c, 0x0190, 0x008b, 0x0046, 0x009a, 0x00a9, 0x00b0,
    0x00b4, 0x00c2, 0x0190, 0x0190, 0x0190, 0x0190, 0x0190, 0x0190,
    0x00dd, 0x00ef, 0x0101, 0x0105, 0x00d0, 0x0118, 0x0126, 0x0135,
    0x0146, 0x0157, 0x0190, 0x0165, 0x0174, 0x0190, 0x0179, 0x017d,
    0x0182,
};

/* lmac_if__ucode_event_dispatch (0x8df084; метод [1] таблицы 0x800770 ящика lmac_mbox —
 * прежнее 0x8df07c было хвостом предыдущей функции): одно событие из кольца ucode (mb = lmac_mbox,
 * evt — запись кольца: тип u16 по +4, тело с +0x10). Переход по таблице 0x801f40
 * (типы 0..0x30); неизвестный тип — ассерт 0x1047. Затем запись помечается свободной
 * (слово 0 = 0) и кольцо сдвигается (lmac_if__evt_fields). Журнал — до обработчика,
 * как у vendor; для 0x24 и 0x29 — второй журнал перед complete_pending_request. */
void lmac_if_ucode_event_dispatch(struct lmac_mbox *mb, u8 *evt)
{
    u32 tsf[2];
    mac_read_tsf64(0, tsf, 0);
    u8 *body = evt + 0x10;
    u32 type = ((const struct mbox_hdr *)evt)->type;
    switch (type) {
    case 0x00:                                                       /* EVENT_UCODE_READY */
        uc_evt_log(0x1004200, 0, tsf);
        lmac_if_lmac_ready_evt();
        break;
    case 0x01:
        rm_main_sm_inject_lock_evt(0);
        break;
    case 0x02:                                                       /* EVENT_ECHO */
        uc_evt_log(0x100423c, 2, tsf);
        lmac_if_echo_evt_handler((const struct lmac_cmd_echo *)body);
        break;
    case 0x03:
        hwd_abif_dvs_rfca_cmd_enable(rf_active_mask, 0);             /* rf__get_active_mask: [gp,0xbe] */
        rm_main_sm_inject_lock_evt(1);
        break;
    case 0x04:                                                       /* EVENT_FLUSH_Q_DONE */
        uc_evt_log(0x10042b4, 4, tsf);
        event_flush_q_done((const struct lmac_evt_u32 *)body);
        break;
    case 0x05: {                                                     /* NEW_LINK_EVT */
        uc_evt_log(0x1004278, 5, tsf);
        u32 st = new_link_evt();
        lmac_if_bf_done_and_new_link((struct lmac_evt_bf_done *)body, st);
        break;
    }
    case 0x06:
        lmac_if_abft_notify_evt((struct lmac_evt_bf_done *)body);
        break;
    case 0x08:                                                       /* QUEUE_DELETED_EVT */
        uc_evt_log(0x10042f0, 8, tsf);
        queue_deleted_evt((const struct lmac_evt_queue_deleted *)body);
        break;
    case 0x09:                                                       /* LINK_LOST */
        uc_evt_log(0x100432c, 9, tsf);
        lmac_if_link_lost_evt_handler((const struct lmac_evt_link_lost *)body);
        break;
    case 0x11:
        uc_evt_log(0x1004368, 0x11, tsf);
        return_field_type((const struct lmac_evt_field_rsp *)body);
        break;
    case 0x13:                                                       /* RS_STARTED */
        uc_evt_log(0x10043a8, 0x13, tsf);
        lmac_if_rs_started((const struct lmac_evt_u32 *)body);
        break;
    case 0x14: {                                                     /* RS_DONE: TSF в тело */
        struct lmac_evt_rs_done *rs = (struct lmac_evt_rs_done *)body;
        rs->tsf_lo = (u16)tsf[0];
        rs->tsf_hi = (u16)(tsf[0] >> 16);
        lmac_if_rs_done_evt(rs);
        break;
    }
    case 0x16:
        lmac_if_ucode_evt_check_8((struct lmac_evt_ps_peer *)body, new_link_evt());
        break;
    case 0x17:
        lmac_if_update_pct_stats();
        break;
    case 0x24:                                                       /* AoA (только SparRAW-pro): затем как 0x20 */
        uc_evt_log(0x10044ac, 0x24, tsf);
        /* fallthrough */
    case 0x20:
        uc_evt_log(0x10044e4, type, tsf);
        fw_sysapi_mgr_complete_pending_request(&fw_sysapi_mgr, ((const struct lmac_evt_u32 *)body)->val, 0);
        break;
    case 0x21:
        uc_evt_log(0x1004530, 0x21, tsf);
        fw_sysapi_mgr_complete_pending_request(&fw_sysapi_mgr, ((const struct lmac_evt_sysapi *)body)->id,
                                               ((const struct lmac_evt_sysapi *)body)->data);
        break;
    case 0x22:                                                       /* итог пачки FTM — только SparRAW-pro */
        break;
    case 0x23:
        uc_evt_log(0x1004580, 0x23, tsf);
        fw_sysapi_mgr_complete_pending_request(&fw_sysapi_mgr, ((const struct lmac_evt_sysapi *)body)->id23,
                                               body);
        break;
    case 0x26:
        uc_evt_log(0x1004604, 0x26, tsf);
        fw_sysapi_mgr_complete_pending_request(&fw_sysapi_mgr, 1, body);
        break;
    case 0x27:                                                       /* GET_SELECTED_RF_SECTOR_INDEX_DONE */
        uc_evt_log(0x100464c, 0x27, tsf);
        evt_get_selected_rf_sector_index_done(&rf_sector_sel[RF_SECTOR_SEL_GET], body);
        break;
    case 0x28:                                                       /* SET_SELECTED_RF_SECTOR_INDEX_DONE */
        uc_evt_log(0x10046a0, 0x28, tsf);
        evt_set_selected_rf_sector_index_done(&rf_sector_sel[RF_SECTOR_SEL_SET], body);
        break;
    case 0x29:                                                       /* затем как 0x2b */
        uc_evt_log(0x10046f4, 0x29, tsf);
        lmac_if_evt_walk(brd_if_multi_array_get_section_info());
        /* fallthrough */
    case 0x2b:
        uc_evt_log(0x100474c, type, tsf);
        fw_sysapi_mgr_complete_pending_request(&fw_sysapi_mgr, body[0], 0);
        break;
    case 0x2c:
        uc_evt_log(0x1004794, 0x2c, tsf);
        fw_sysapi_mgr_complete_pending_request(&fw_sysapi_mgr, 1, body);
        break;
    case 0x2e:                                                       /* BA: таймаут из ucode */
        ba_on_uc_timeout_evt((const struct lmac_evt_ba_timeout *)body);
        break;
    case 0x2f:
        uc_evt_log(0x10047d4, 0x2f, tsf);
        fw_sysapi_mgr_complete_pending_request(&fw_sysapi_mgr, 1, body);
        break;
    case 0x30:                                                       /* EVT_FIXED_SCHEDULING_ENABLED */
        uc_evt_log(0x1004820, 0x30, tsf);
        evt_fixed_scheduling_enabled((const struct lmac_evt_typed *)body);
        break;
    default:    /* в т. ч. 0x15/0x18/0x19/0x25 (shallow sleep, отсрочка трафика, пробуждение PCIe,
                 * UPM) — ucode их больше не шлёт: энергосбережение вырезано (см. fw/action.c
                 * psc_req_reject и fw/vectors.c pcie_pm_event_unsupported) */
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x47 | (1u << 12));
        break;
    }
    mac_read_tsf64(0, tsf, 0);
    mb->mb.rx.cur->sync = 0;             /* запись свободна */
    lmac_if_evt_fields(&mb->mb.rx);
}

/* Таблица методов ящика ucode (include/mbox.h). */
/* vendor 0x800770 */
FWDATA(800770) const struct lmac_mbox_vt lmac_mbox_vtbl = {
    .rsv0 = 0,
    .dispatch = lmac_if_ucode_event_dispatch,
};

/* mbox__consume_one (0x8e3764): событие текущей записи кольца rx → обработчик
 * (у vendor — через таблицу методов mb->vt (0x800770) → dispatch), затем
 * опубликовать курсор чтения: hw->tail = rx.cur. */
static void mbox_consume_one(struct lmac_mbox *mb)
{
    struct mbox_ring *ring = &mb->mb.rx;
    u8 *evt = (u8 *)ring->cur->addr;      /* mbox__load_obj_word4 */
    lmac_if_ucode_event_dispatch(mb, evt);
    ring->hw->tail = (u32)ring->cur;
}


/* lmac_mbox__drain_task (0x8ca22c): пока в кольце событий ucode есть записи —
 * разобрать по одной; затем снять маску прерывания ucode (0x880b64 = 0x200). */
void lmac_mbox_drain_task(u32 a0, u32 a1)
{
    (void)a0;
    (void)a1;
    while (fw_mailbox_is_empty(&lmac_mbox.mb.rx) == 0)   /* fw_mailbox__has_pending */
        mbox_consume_one(&lmac_mbox);
    MMIO32(HW_RGF_USER_USER_ICR_IMC) = 0x200;
    arc_sync();
}
