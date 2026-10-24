// SPDX-License-Identifier: AGPL-3.0-or-later
/* Приём команд хоста: ящики operational (0x8041f0) и debug (0x843040), их таблицы методов,
 * задачи разбора по прерываниям user-ICR (биты 18/19) и диспетчер WMI-команд
 * (vendor wmi__host_cmd_dispatch 0x8de43c).
 *
 * Таблицы методов ящиков — в fw_data по vendor-адресам (0x800790, 0x8006fc), из адресов
 * наших функций (FWDATA, include/mbox.h). */
#include "../include/types.h"
#include "../include/rf_kill.h"
#include "../include/rf_sets.h"
#include "../include/power.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/fwdata.h"
#include "../include/mbox.h"
#include "../include/mid.h"
#include "../include/wmi.h"
#include "../include/wmi_handlers.h"
#include "../include/rf_obj.h"
#include "../include/radio_mgr.h"
#include "../include/vring_schd.h"
#include "../include/conn.h"
#include "../include/link_sm.h"
#include "../include/lmac_cmd.h"
#include "../include/sys_cfg.h"
#include "../include/macq_desc.h"
#include "../include/ieee80211.h"


/* ---------------- методы ящиков ---------------- */

/* operational_mbox::unmask_irq (0x8ea80c; vt 0x800790 [2]): снять маску бита 18 (команды хоста). */
void mbox_op_unmask_irq(struct wmi_mbox *mb)
{
    (void)mb;
    u32 sv = arc_irq_disable();
    MMIO32(HW_RGF_USER_USER_ICR_IMC) = 0x40000;
    arc_irq_restore(sv);
}

/* debug_mbox::unmask_irq (0x8ea838; vt 0x8006fc [2]): снять маску бита 19. */
void mbox_dbg_unmask_irq(struct wmi_mbox *mb)
{
    (void)mb;
    u32 sv = arc_irq_disable();
    MMIO32(HW_RGF_USER_USER_ICR_IMC) = 0x80000;
    arc_irq_restore(sv);
}

/* operational_mbox::evt_posted (0x8e9818; vt 0x800790 [3]): событие хосту отправлено —
 * FW_INT 29 (MBOX_EVT), бит события PCIe 0x1a. */
void mbox_op_evt_posted(struct wmi_mbox *mb)
{
    (void)mb;
    hwd_dma_raise_host_fw_int(0x1d);
    pcie_set_event_bit(0x1a);
}

/* debug_mbox::evt_posted (0x8e9828; vt 0x8006fc [3]): бит события PCIe 0x1b, FW_INT 30. */
void mbox_dbg_evt_posted(struct wmi_mbox *mb)
{
    (void)mb;
    pcie_set_event_bit(0x1b);
    hwd_dma_raise_host_fw_int(0x1e);
}


/* Таблицы методов (include/mbox.h): [1] разбор записи, [2] после разбора всех записей,
 * [3] после отправки события. [0] у vendor 0. */
/* vendor 0x800790 */
FWDATA(800790) const struct wmi_mbox_vt operational_mbox_vtbl = {
    .rsv0 = 0,
    .dispatch = wmi_host_cmd_dispatch,
    .unmask_irq = mbox_op_unmask_irq,
    .evt_posted = mbox_op_evt_posted,
};
/* vendor 0x8006fc */
FWDATA(8006fc) const struct wmi_mbox_vt debug_mbox_vtbl = {
    .rsv0 = 0,
    .dispatch = wmi_host_cmd_dispatch,
    .unmask_irq = mbox_dbg_unmask_irq,
    .evt_posted = mbox_dbg_evt_posted,
};

/* mbox__consume_one (0x8e3764): запись по текущему курсору → vt[1](ящик, буфер); затем
 * опубликовать курсор чтения: hw->tail = rx.cur. */
static void mbox_consume_one_vt(struct wmi_mbox *mb)
{
    struct mbox_ring *ring = &mb->mb.rx;
    u8 *buf = (u8 *)ring->cur->addr;          /* mbox__load_obj_word4 */
    mb->vt->dispatch(mb, buf);
    ring->hw->tail = (u32)ring->cur;
}

/* mbox__drain_operational (0x8e378c): задача бита 18. [gp,0x280] — «идёт разбор». */
void mbox_drain_operational(u32 a0, u32 a1)
{
    (void)a0;
    (void)a1;
    struct wmi_mbox *mb = &operational_if_get_mbox()->wm;
    wmi_mbox_drain_active = 1;
    while (fw_mailbox_is_empty(&mb->mb.rx) == 0) {   /* fw_mailbox__has_pending */
        mbox_consume_one_vt(mb);
        mb->vt->evt_posted(mb);
    }
    mb->vt->unmask_irq(mb);
    wmi_mbox_drain_active = 0;
}

/* mbox__drain_debug (0x8e37c8): задача бита 19 (без vt[3] на запись). [gp,0x1ac]. */
void mbox_drain_debug(u32 a0, u32 a1)
{
    (void)a0;
    (void)a1;
    struct wmi_mbox *mb = debug_mbox_get_or_init();
    dbg_mbox_draining = 1;
    while (fw_mailbox_is_empty(&mb->mb.rx) == 0)
        mbox_consume_one_vt(mb);
    mb->vt->unmask_irq(mb);
    dbg_mbox_draining = 0;
}

/* ---------------- события-ответы ---------------- */

/* wmi_evt__send_command_not_supported (0x8e5728): WMI_COMMAND_NOT_SUPPORTED (0xffff, 8 Б)
 * {mid, cmd_id, reason}. */
void wmi_evt_send_command_not_supported(struct wmi_mbox *mb, u32 cmd_id, u32 reason, u32 mid)
{
    fw_log_emit2(0, 0x10060cc, cmd_id, reason);
    struct wmi_command_not_supported_event *p = mem_pool_alloc_locked(&mb->mb);
    p->mid = (u8)mid;
    p->command_id = (u16)cmd_id;
    p->command_subtype = (u16)reason;
    wmi_evt_post(mb, p, 0, 0xffff, sizeof(*p), mid, 0, 0);
}

/* Ответ на WMI_ECHO (vendor 0x8e5418): WMI_ECHO_RSP (0x1803, 4 Б). Значение заодно
 * сохраняется: младшие 16 бит — [gp,0x150] = 0x8002d4, старший байт — 0x8577b5. */
static void wmi_echo_rsp(struct wmi_mbox *mb, u32 value, u32 mid)
{
    struct wmi_word_event *p = mem_pool_alloc_locked(&mb->mb);   /* {echoed_value} */
    p->value = value;
    pcp_bcon_interval = value & 0xffff;
    VOL(fwsh_sets.bi_hi) = (u8)(value >> 16);
    fw_log_emit2(0, 0x1006118, value & 0xffff, VOL(fwsh_sets.bi_hi));
    wmi_evt_post(mb, p, 0, 0x1803, sizeof(*p), mid, 0, 0);
}

/* oob__mode_flags (0x8ccac8) для 0x804c34: 0 при пустом флаге, иначе бит 0 — [0x800190],
 * бит 1 — [0x800194]. */
u32 oob_mode_flags(const struct basic_sm *sm)
{
    if (sm->state == RF_MGMT_ENABLED)
        return 0;
    u32 f = (rf_kill_hw != 0) ? 1 : 0;
    if (rf_kill_sw != 0)
        f |= 2;
    return f;
}

/* host_if__hw_ready_for_wmi (0x8da5a4): не ASIC, либо RF есть и OOB/rf-kill не взведён. */
static u32 host_if_hw_ready_for_wmi(void)
{
    if (platform_is_asic() == 0)
        return 1;
    if (rf_is_present() == 0)
        return 0;
    return oob_mode_flags(&rf_mgmt_sm) == 0;
}

/* ---------------- WMI_CFG_RX_CHAIN (0x820) ---------------- */


/* rx_chain__get_cfg_mode (0x8ccec4): байт [gp+0xc4] = 0x800248. */
u32 rx_chain_get_cfg_mode(void)
{
    return rx_chain_cfg_mode;
}

/* 0x805160: адрес назначения CONNECT (dst_mac, 6 Б) и параметры RADIO_MGR::set_primary_channel
 * (+8, +0xc; читаются volatile, кто пишет — не найдено, в образе нули). */
struct connect_req {
    union {
        union mac_addr dst_mac;                /* 0x00 */
        struct { u32 dst_mac_lo; u16 dst_mac_hi; u16 rsv_06; };   /* vendor пишет словом и полусловом */
    };
    u32 chan_p1;                               /* 0x08 */
    u32 chan_p2;                               /* 0x0c */
};
_Static_assert(sizeof(struct connect_req) == 0x10, "connect_req");
FWDATA(805160) struct connect_req connect_req = { 0 };

/* Режим sniffer WMI_CFG_RX_CHAIN (vendor 0x8fb836..0x8fb956): INA-конфиг 0x800bdc с полем
 * flags[1:0] и cfg[4] по phy_support (0 CP — флаги 0; 1 DP — флаги 0, cfg[4] = 2; 2 AD —
 * б1 = 1, б0 = 0; иное — ассерт 0x11e3) → LMAC 0x20; decap_trans_type команды = 2 (его
 * читает l2_offload_cfg_rx_decap ниже); PRS 0x886258 [4:0] = 2, 0x886200 б8, PRP 0x886838
 * б0, SXD 0x886dc8 = 0x31000400; если mid 0 — PCP/AP, остановить его (BCON_CTRL с
 * bcon_interval 0) и выждать lp 0xc3500 × 2 nop_s (как vendor); затем основной канал
 * sniffer_cfg.channel (параметры CONNECT 0x805168/0x80516c, интервал бикона [gp,0x150],
 * роль 1, mid команды). */
static void wmi_cfg_rx_chain_open_sniffer(struct wmi_cfg_rx_chain_cmd *p, u32 mid)
{
    struct lmac_cmd_ina_det ina;
    u32 phy = p->sniffer_cfg.phy_support;

    memcpy_fw(&ina, &phy_ina_det_cfg, sizeof(ina));

    fw_log_emit0(0x2b, 0x100d74c);                      /* «Opening sniffer mode» */
    p->decap_trans_type = 2;
    if (phy == 0) {
        fw_log_emit0(0x2b, 0x100d764);                  /* CP */
        ina.flags &= ~3u;
    } else if (phy == 1) {
        fw_log_emit0(0x2b, 0x100d790);                  /* DP */
        ina.flags &= ~3u;
        ina.cfg[4] = 2;
    } else if (phy == 2) {
        fw_log_emit0(0x2b, 0x100d7b8);                  /* AD */
        ina.flags = (ina.flags | 2u) & ~1u;
    } else {
        fw_sysassert_fatal(__builtin_return_address(0), 0x11e3);
    }
    lmac_if_send_phy_ina_det_cfg(&ina);
    fw_log_emit0(0x2b, 0x100d7e8);                      /* PRS TBL, PRS/PRP RGF */
    MMIO32(HW_PRS_CFG_886258) = (MMIO32(HW_PRS_CFG_886258) & ~0x1fu) | 2u;
    MMIO32(HW_MAC_PRS_CTRL_0) |= 1u << 8;
    MMIO32(HW_PRP_CTRL) |= 1u;
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x31000400u;
    if (mid_state_is_2_or_3(0) != 0) {
        struct wmi_bcon_ctrl_cmd stop;                  /* vendor: u16 0 на стеке */
        memset0_words(&stop, sizeof(stop));
        fw_log_emit0(0x2b, 0x100d814);                  /* «stopping PCP» */
        wmi_bcon_ctrl(&stop, 0);
        arc_zol_nops2(0xc3500);
    }
    fw_log_emit1(0x2b, 0x100d828, p->sniffer_cfg.channel);
    radio_mgr_set_primary_channel(p->sniffer_cfg.channel,
                                  ((volatile struct connect_req *)&connect_req)->chan_p1,
                                  ((volatile struct connect_req *)&connect_req)->chan_p2,
                                  pcp_bcon_interval, 1, mid & 0xffu);
}

/* wmi_cfg_rx_chain (0x8fb7fc): struct wmi_cfg_rx_chain_cmd (include/wmi.h). Ответ
 * WMI_CFG_RX_CHAIN_DONE (0x1820): {rx_ring_tail_ptr, status}. */
static void wmi_cfg_rx_chain(struct wmi_cfg_rx_chain_cmd *p, u32 mid)
{
    struct wmi_cfg_rx_chain_done_event *rsp = host_if_send_pair();
    if (rsp == 0)
        fw_sysassert_fatal((void *)0, 0x1342);
    /* volatile: vendor читает mode двумя ldh (без него gcc при выравнивании 4 берёт слово) */
    const volatile struct wmi_sniffer_cfg *sn = &p->sniffer_cfg;
    u32 sniffer = sn->mode16[0] | ((u32)sn->mode16[1] << 16);
    if (sniffer == 1)
        wmi_cfg_rx_chain_open_sniffer(p, mid);

    u32 cfg_mode = rx_chain_get_cfg_mode();
    u32 mpdu = p->rx_sw_ring.max_mpdu_size;
    if (mpdu > 0x1f28)
        mpdu = 0x1f28;
    u32 reorder = p->reorder_type;
    u32 psize;
    if (reorder == 1) {
        rx_reorder_sw = 1;                /* [gp,0x124] */
        psize = 0x40;
    } else {
        psize = cfg_mode << 1;
        if (psize > 0x40)
            fw_sysassert_fatal((void *)0, 0x11e4);
        rx_reorder_sw = 0;
    }
    fw_log_emit3(0x2b, 0x100d86c, mpdu, cfg_mode, reorder);

    s32 max_pl = p->max_rx_pl_per_desc;
    if (max_pl < 3) {
        max_pl = 0;
    } else if ((max_pl & -max_pl) != max_pl) {    /* не степень двойки */
        fw_log_emit1(0x2b, 0x100d8b0, (u32)max_pl);
        fw_sysassert_fatal((void *)0, 0x1343);
        max_pl = 0;
    }

    psize &= 0xffff;
    rx_chain_set_payload_size(psize);
    disc_sm_sw_data_stopped();
    u32 macq = rx_macq_entry_addr(2);
    rx_macq_setup(macq, 2, 3, mpdu, 0x1000, 0x1000, 8, psize, sniffer == 1);
    if (sniffer != 1 && reorder == 1)
        ((struct rx_macq_cfg *)macq)->reorder = 1;
    rx_macq_bind_all_queues(macq, 2, 0);
    rx_chain_configure(macq, 0, 0, cfg_mode & 0xff, psize);
    fw_log_emit1(0x2b, 0x100d8f0, p->max_rx_pl_per_desc_u);

    const u8 *rb = p->rx_sw_ring.ring_mem_base;     /* vendor собирает u64 побайтно */
    u32 base_lo = rb[0] | (rb[1] << 8) | (rb[2] << 16) | ((u32)rb[3] << 24);
    u32 base_hi = rb[4] | (rb[5] << 8) | (rb[6] << 16) | ((u32)rb[7] << 24);
    dma_mgr_configure_ring(2, base_lo, base_hi, p->rx_sw_ring.ring_size, p->host_thrsh,
                           p->wb_thrsh, 0, (u32)max_pl);
    l2_offload_cfg_rx_decap((const u8 *)p);

    rsp->rx_ring_tail_ptr = rx_chain_reg_8813c8_addr();
    rsp->status = 1;                                /* WMI_CFG_RX_CHAIN_SUCCESS */
    fw_log_emit1(0x2b, 0x100d914, mid);
    low_sme_send_evt2sw(rsp, 0x1820, sizeof(*rsp), mid, 0, 0, 0);
}

/* ---------------- l2mgr: ожидающие операции, события отказа ---------------- */

/* Маска ожидающих операций l2mgr — [gp,-0xd4] = 0x8000b0 (биты: 0 — скан, 1 — connect,
 * 2 — disconnect, 5 — …). */
#define L2MGR_PENDING_OPS   (l2mgr_pending_ops)

/* l2mgr__pending_op_set (0x8e6358, 14 Б). */
void l2mgr_pending_op_set(u32 op)
{
    L2MGR_PENDING_OPS |= 1u << op;
}

/* l2mgr__pending_op_clear (0x8c6a30, 14 Б). */
void l2mgr_pending_op_clear(u32 op)
{
    L2MGR_PENDING_OPS &= ~(1u << op);
}

/* Внутренний код причины → disconnect_reason события (wil6210 wmi.h enum
 * wmi_disconnect_reason). vendor — таблица переходов fw_data 0x8023fc; ≥ 9 → 7. */
static const u8 l2mgr_disc_reason_map[9] = {
    4,      /* 0 → BSS_DISCONNECTED */
    2,      /* 1 → LOST_LINK */
    3,      /* 2 → DISCONNECT_CMD */
    0xd,    /* 3 → CONNECTION_EVICTED */
    7,      /* 4 → NO_RESOURCES_AVAIL */
    0xd,    /* 5 → CONNECTION_EVICTED */
    6, 6, 6 /* 6..8 → ASSOC_FAILED */
};

/* 0x8023fc: таблица переходов switch vendor l2mgr__send_disconnect_evt (0x8e538c;
 * ldb, цель = 0x8e53c2 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8023fc) const u8 l2mgr_send_disconnect_evt_jt[9] = {
    0x04, 0x02, 0x00, 0x06, 0x09, 0x06, 0x08, 0x08, 0x08,
};

/* l2mgr__send_disconnect_evt (0x8e538c, 140 Б): WMI_DISCONNECT_EVENTID (0x1003, 10 Б)
 * {protocol_reason_status u16, bssid[6], disconnect_reason, assoc_resp_len = 0};
 * затем снять ожидающие операции 2, 1, 5. */
void l2mgr_send_disconnect_evt(const u8 *bssid, u32 proto_reason, u32 reason, u32 mid)
{
    struct wmi_disconnect_event *p = host_if_send_pair();
    p->protocol_reason_status = (u16)proto_reason;
    memcpy_fw(p->bssid, bssid, 6);
    u32 r = (reason < 9) ? l2mgr_disc_reason_map[reason] : 7;
    p->disconnect_reason = (u8)r;
    p->assoc_resp_len = 0;
    fw_log_emit2(0x2b, 0x100d2b4, r, proto_reason);
    low_sme_send_evt2sw(p, 0x1003, sizeof(*p), mid, 0, 0, 0);
    l2mgr_pending_op_clear(2);
    l2mgr_pending_op_clear(1);
    l2mgr_pending_op_clear(5);
}

/* ---------------- host_if: ответы при неготовом железе ---------------- */


/* host_if__connect_rf_kill (0x8ec484, 56 Б): CONNECT при неготовом железе (RF нет / rf-kill)
 * — сразу WMI_DISCONNECT_EVENT (protocol_reason 4, причина 6 → ASSOC_FAILED) с BSSID
 * из записи mid. Тело команды vendor не читает. */
void host_if_connect_rf_kill(const struct wmi_connect_cmd *cmd, u32 mid)
{
    u8 bssid[8];
    (void)cmd;
    struct mid *e = mid_list_by_mid_fw(mid);
    mid_copy_bssid(&e->bss, bssid);
    fw_log_emit0(0x10, 0x100b534);
    l2mgr_send_disconnect_evt(bssid, 4, 6, mid);
}

/* host_if__send_scan_complete (0x8ecb94, 82 Б): START_SCAN при неготовом железе — после
 * задержки WMI_SCAN_COMPLETE_EVENTID (0x100a) со статусом 2 (WMI_SCAN_ABORTED).
 * Задержка vendor — аппаратный цикл 0x7a1200 × 2 nop_s; зачем она (дать драйверу время?),
 * не выяснено — повторена как есть, тем же циклом (lp выровнен на 4, конец тела цикла —
 * тоже, как у vendor 0x8ecba8..0x8ecbb0). */
void host_if_send_scan_complete(u32 mid)
{
    __asm__ volatile(
        "mov    lp_count, %0\n\t"
        "nop_s\n\t"
        ".balign 4\n\t"
        "lp     1f\n\t"
        "nop_s\n\t"
        "nop_s\n"
        "1:\n\t"
        : : "r"(0x7a1200u) : "lp_count", "memory");
    struct wmi_word_event *p = host_if_send_pair();  /* WMI_SCAN_COMPLETE {status} */
    p->value = 2;                                   /* WMI_SCAN_ABORTED */
    fw_log_emit1(0, 0x1007b40, mid);
    low_sme_send_evt2sw(p, 0x100a, sizeof(*p), mid, 0, 0, 0);
}

/* ---------------- START_SCAN (0x07) / ABORT_SCAN (0xf007) ---------------- */

struct mem_pool;

/* l2_mgr__is_busy_flag_set (0x8c64f4, 20 Б): бит op маски ожидающих операций. */
u32 l2mgr_is_busy_flag_set(u32 op)
{
    return (L2MGR_PENDING_OPS & (1u << op)) != 0;
}

/* l2mgr: WMI_SCAN_COMPLETE_EVENTID (0x100a) {status} (enum wmi_scan_status) и снять
 * ожидающий скан (бит 0). vendor 0x8e5d48, 70 Б (в NAMES-EXTRA ошибочно
 * pcp_psc_sm__send_usol_psc_resp_sm). */
void l2mgr_send_scan_complete_evt(u32 status, u32 mid)
{
    struct wmi_word_event *p = host_if_send_pair();  /* WMI_SCAN_COMPLETE {status} */
    p->value = status;
    fw_log_emit2(0x2b, 0x100eb24, status, mid);
    low_sme_send_evt2sw(p, 0x100a, sizeof(*p), mid, 0, 0, 0);
    l2mgr_pending_op_clear(0);
}

/* mid_list__any_in_state2_fw (0x8c37ac, 62 Б): есть ли в mid_list запись с активным BSS
 * (bss.state == 2). */
u32 mid_list_any_in_state2(void)
{
    u32 it;
    iter_init(&it, &mid_list);
    while (list_has_items(&it)) {
        struct mid *e = iter_next(&it);
        if (e->bss.state == 2)
            return 1;
    }
    return 0;
}

/* l2_mgr::validate_scan (0x8ebbc8, 268 Б): можно ли начать скан для mid. */
u32 l2mgr_validate_scan(u32 mid)
{
    u32 it;
    if (mid_list_by_mid_fw(mid) == 0) {
        fw_log_emit0(0x19, 0x100f044);
        return 0;
    }
    /* Проверка «нет записи в состоянии 2» пропускается только при [0x80048c] != 0,
     * байте [0x85773c] < 2 и байте [0x800231] < 2. */
    if (scan_validate_skip_state2 == 0 || VOL(fwsh_sets.n_sec[1][0]) >= 2
        || conn_multi_omni_count >= 2) {
        if (mid_list_any_in_state2() != 0) {
            fw_log_emit0(0x19, 0x100f078);
            return 0;
        }
    }
    if (mid_list_by_mid_fw(mid)->mac[0] & 1) {          /* групповой бит MAC записи */
        fw_log_emit0(0x19, 0x100f0ac);
        return 0;
    }
    if (mid_state_is_2_or_3(mid) != 0) {
        fw_log_emit1(0x19, 0x100f0e8, mid);
        return 0;
    }
    if (mid_list_count_active(0) != 0) {                /* vendor: r0 = 0 от предыдущего */
        fw_log_emit0(0x19, 0x100f124);
        return 0;
    }
    if (l2mgr_is_busy_flag_set(1) != 0) {               /* идёт connect */
        fw_log_emit0(0x19, 0x100f15c);
        return 0;
    }
    if (l2mgr_is_busy_flag_set(2) != 0) {               /* идёт disconnect */
        fw_log_emit0(0x19, 0x100f190);
        return 0;
    }
    field_set_0x00_8e5dfc(&it, mids_get_count());
    while (bit_iter_has_more(&it)) {
        struct mid *m = mid_list_by_mid_fw(bitmap_alloc_bit(&it));
        if (m == 0)
            fw_sysassert_fatal((void *)0, 0x16b6);
        if (mid_list_find_by_kind(m, 0) != 0) {
            fw_log_emit1(0x19, 0x100f1e8, m->id);
            return 0;
        }
    }
    fw_log_emit0(0x29, 0x100f1c8);
    return 1;
}

/* lm_if__inject_evt9 (0x8e011c, 42 Б): событие 9 автомату lm_sm линка obj. */
void lm_if_inject_evt9(struct lm_if *obj)
{
    if (obj->lm_sm == 0)
        fw_sysassert_fatal((void *)0, 0x1262);
    lm_sm_event(obj->lm_sm, 9, 0, 0, 0);
}


/* l2_mgr__scan_start_log (0x8f8338, 48 Б): журнал времени и запуск скана scan_mngr записи. */
void l2mgr_scan_start(struct mid_disc *obj, struct wmi_start_scan_cmd *cmd, u32 a2, u32 a3)
{
    fw_log_emit1(0x2c, 0x1016dd8, u_schd_now());
    find_sm_start_search(obj->scan, (u8 *)cmd, a2, a3);
}

/* l2_mgr::wmi_scan_cmd (0x8eca58, 196 Б): скан разрешён — у всех mid с подключением
 * (find_by_kind 1) метод [7] активной таблицы колец (cid) и событие 9 lm_sm соединения;
 * затем смена системного состояния (2) и запуск поиска для mid.
 * Исправлено: событие 9 уходило в lm_if_inject_evt9(conn + 0x38) — vendor 0x8ecb14
 * add3 r0,r14,0xe = conn + 0x70 (add3 масштабирует ×8, не ×4): прежде [conn+0x38] (байты
 * парного ключа tk) читался как указатель автомата, и событие 9 шло по мусорному адресу
 * (или ассерт 0x1262 при нулевом ключе) — событие 9 перед сканом до lm_sm соединения
 * не доходило. */
void l2mgr_wmi_scan_cmd(struct wmi_start_scan_cmd *cmd, u32 mid)
{
    u32 it;
    u32 res = 0;
    l2mgr_pending_op_set(0);
    field_set_0x00_8e5dfc(&it, mids_get_count());
    while (bit_iter_has_more(&it)) {
        struct mid *m = mid_list_by_mid_fw(bitmap_alloc_bit(&it));
        if (m == 0)
            fw_sysassert_fatal((void *)0, 0x16b7);
        struct conn *conn = mid_list_find_by_kind(m, 1);
        if (conn != 0) {
            u32 cid = m->cid_mask;
            fw_log_emit2(0x29, 0x100df5c, cid, m->id);
            struct vring_schd_if *tbl = vring_active_ring_table();
            res = tbl->vt->prohibit(tbl, cid);
            lm_if_inject_evt9(&conn->lm);
        }
    }
    struct mid *e = mid_list_by_mid_fw(mid);
    fw_log_emit2(0x29, 0x100df14, cmd->scan_type, cmd->num_channels);
    sys_state_broadcast(2, 0);
    l2mgr_scan_start(&e->disc, cmd, res, mid_list_any_in_state2());
}

/* low_sme::wmi_scan_cmd_handler (0x8ecb1c, 120 Б): WMI_START_SCAN_CMDID (struct
 * wmi_start_scan_cmd, include/wmi.h). Отказ (нельзя сканировать или нет каналов) —
 * SCAN_COMPLETE со статусом 3 (WMI_SCAN_REJECTED). Счётчик команд — [gp,-0xb4] = 0x8000d0. */
void low_sme_wmi_scan_cmd_handler(struct wmi_start_scan_cmd *cmd, u32 mid)
{
    /* журнал: MAC, dwell_time, force_scan_interval — vendor читает полусловами */
    const u16 *h = (const u16 *)cmd;
    wmi_scan_count += 1;
    fw_log_emit2(0x29, 0x100b970, h[2], h[0] | (u32)h[1] << 16);
    fw_log_emit2(0x29, 0x100b9b8, h[4] | (u32)h[5] << 16, h[6] | (u32)h[7] << 16);
    fw_log_emit2(0x29, 0x100b9f0, cmd->scan_type, cmd->num_channels);
    if (l2mgr_validate_scan(mid) == 0 || cmd->num_channels == 0)
        l2mgr_send_scan_complete_evt(3, mid);       /* WMI_SCAN_REJECTED */
    else
        l2mgr_wmi_scan_cmd(cmd, mid);
}

/* scan_mngr::free_channel_list (0x8f3160, 64 Б): вернуть элементы списка каналов
 * в пул 0x842c74 (scan_mngr__free_with_842c74 0x8f3154 = mem_pool__free). */
void scan_mngr_free_channel_list(struct scan_mngr *obj)
{
    while (obj->channels.count != 0) {
        struct scan_ch *e = llist_pop_front(&obj->channels);
        fw_log_emit1(0x2c, 0x1015410, e->channel);
        mem_pool_free(&scan_ch_pool, e);
    }
}

/* scan_mngr::abort_scan (0x8f04bc, 68 Б): освободить каналы, dwell_stopped = 1, событие
 * остановки: STOP_SCAN (7) автомату каналов либо (при is_connected) SCAN_ABORT (3, статус 2)
 * автомату swc_psc_sm — как выбор автомата в scan_mngr_kick_scan_state_machine. */
void scan_mngr_abort_scan(struct scan_mngr *obj)
{
    fw_log_emit0(0x29, 0x1015724);
    scan_mngr_free_channel_list(obj);
    obj->dwell_stopped = 1;
    if (obj->is_connected == 0)
        basic_sm_handle_event(obj->cs, 7, 0, 0, 0);
    else
        basic_sm_handle_event(&obj->swc, 3, 2, 0, 0);
}

/* scan_stop (0x8f8368, 28 Б): прервать скан scan_mngr объекта discovery записи. */
void scan_stop(struct mid_disc *obj)
{
    fw_log_emit0(0x2c, 0x1016dec);
    scan_mngr_abort_scan(obj->scan);
}

/* scan_abort (0x8f81fc, 36 Б): scan_mngr.aborted = 1 и scan_stop. */
void scan_abort(struct mid_disc *obj)
{
    fw_log_emit0(0x2c, 0x1016df8);
    obj->scan->aborted = 1;
    scan_stop(obj);
}

/* l2_mgr::aborting_scan (0x8c1da4, 98 Б): прервать идущий скан mid; 0 — скана нет. */
u32 l2mgr_aborting_scan(u32 mid)
{
    struct mid *e = mid_list_by_mid_fw(mid);
    fw_log_emit0(0x29, 0x100f230);
    if (e == 0) {
        fw_log_emit1(0x29, 0x100f248, mid);
        return 0;
    }
    struct mid_disc *obj = &e->disc;
    if (obj->scan->active == 0 && obj->find.active == 0) {
        fw_log_emit0(0x29, 0x100f280);
        return 0;
    }
    scan_abort(obj);
    return 1;
}

/* wmi_abort_scan (0x8eca3c, 28 Б): WMI_ABORT_SCAN_CMDID; нечего прерывать —
 * SCAN_COMPLETE со статусом 4 (WMI_SCAN_ABORT_REJECTED). */
void wmi_abort_scan(u32 mid)
{
    if (l2mgr_aborting_scan(mid) == 0)
        l2mgr_send_scan_complete_evt(4, mid);
}

/* ------- SET_MAC_ADDRESS (0xf003) / SET_APPIE (0x3f) / SET_SSID (0x827) ------- */


/* MAC (6 Б, выровнен на 2) → младшее слово регистра: байты 0..3 (двумя полусловами). */
static u32 mac_lo32_h(const u8 *m)
{
    const union mac_addr *a = (const union mac_addr *)m;
    return a->h[0] | (u32)a->h[1] << 16;
}

/* Старшие 2 Б MAC (полуслово 2). */
static u32 mac_hi16(const u8 *m)
{
    return ((const union mac_addr *)m)->h[2];
}

/* mac_parser__set_886000_8dfb84 (0x8dfb84, 28 Б): MAC в 0x886018/0x88601c; бит 31
 * старшего слова (действителен) — последней записью. */
void mac_parser_set_addr_886018(const u8 *m)
{
    MMIO32(HW_PRS_MCAST_ADDR_HI) = 0;
    MMIO32(HW_PRS_MCAST_ADDR_LO) = mac_lo32_h(m);
    MMIO32(HW_PRS_MCAST_ADDR_HI) = mac_hi16(m) | 0x80000000u;
}

/* mac_parser__set_886000_8dfb68 (0x8dfb68, 28 Б): то же в 0x886020/0x886024. */
void mac_parser_set_addr_886020(const u8 *m)
{
    MMIO32(HW_PRS_OWN_ADDR_HI) = 0;
    MMIO32(HW_PRS_OWN_ADDR_LO) = mac_lo32_h(m);
    MMIO32(HW_PRS_OWN_ADDR_HI) = mac_hi16(m) | 0x80000000u;
}

/* mac__set_mcast_addr (0x8e8560, 22 Б): 0x886df8/0x886dfc. */
void mac_set_mcast_addr(const u8 *m)
{
    MMIO32(HW_MAC_MCAST_ADDR_LO) = mac_lo32_h(m);
    MMIO32(HW_MAC_MCAST_ADDR_HI) = mac_hi16(m);
}

/* mac__set_own_addr (0x8e8548, 22 Б): 0x886df0/0x886df4. */
void mac_set_own_addr(const u8 *m)
{
    MMIO32(HW_MAC_OWN_ADDR_LO) = mac_lo32_h(m);
    MMIO32(HW_MAC_OWN_ADDR_HI) = mac_hi16(m);
}

/* l2_offload__set_own_mac_addr (0x8df518, 22 Б): 0x881b28/0x881b2c. */
void l2_offload_set_own_mac_addr(const u8 *m)
{
    MMIO32(HW_L2_OWN_MAC_LO) = mac_lo32_h(m);
    MMIO32(HW_L2_OWN_MAC_HI) = mac_hi16(m);
}

/* Поле битов [shift, shift+width) little-endian значения из n байт по адресу p
 * (bf__set_field_byte_fw / _u16_le / _u32_bytewise, 0x8edccc/0x8edc34/0x8edc60). */
static void le_bits_set(u8 *b, u32 n, u32 shift, u32 width, u32 v)
{
    u32 w = 0, m = (width >= 32) ? 0xffffffffu : ((1u << width) - 1u), i;
    for (i = 0; i < n; i++)
        w |= (u32)b[i] << (8 * i);
    w = (w & ~(m << shift)) | ((v & m) << shift);
    for (i = 0; i < n; i++)
        b[i] = (u8)(w >> (8 * i));
}


/* dmg_cap__build_sta_capability (0x8e6598, 276 Б): свой DMG Capabilities BSS записи mid
 * (obj+0x5e): адрес STA, AID 0, DMG STA Capability Information (sta_cap, obj+0x65..):
 * бит 0 — нет OOB-режима [0x803c0c], число TX-секторов − 1 (биты 7..13), RXSS 0x1f,
 * бит 20, 0x35 (биты 21..26), OUI-часть из caps5 (obj+0x17b; биты 36..59), биты 62..,
 * PCP Capability (pcp_cap, max assoc записи); копии для uc — fwsh_n_rx_ant / fwsh_total_sectors. */
void dmg_cap_build_sta_capability(struct mid_bss *obj, const u8 *sta_addr)
{
    u8 oui[4];
    struct dmg_cap *c = &obj->dmg_cap;
    u32 b;
    c->aid = 0;
    memcpy_fw(c->sta_addr, sta_addr, 6);
    b = c->sta_cap[0];
    b |= 1u;                             /* без OOB R1 (OOB — только SparRAW-pro) */
    b &= ~0xeu;
    c->sta_cap[0] = (u8)b;
    le_bits_set(&c->sta_cap[0], 1, 4, 2, 0);                /* bits__set8_s4_w2 0x8ed298 */
    c->sta_cap[0] &= (u8)~(1u << 6);
    le_bits_set(&c->sta_cap[0], 2, 7, 7, (rf_if_num_tx_sectors(&rf_obj) - 1) & 0x7fu); /* 0x8ed214 */
    le_bits_set(&c->sta_cap[1], 2, 6, 6, 0x1f);             /* bits__set16_s6_w6 0x8ed1d8 */
    c->sta_cap[2] |= 0x10;
    le_bits_set(&c->sta_cap[2], 2, 5, 6, 0x35);             /* 0x8ed1c0 */
    c->sta_cap[3] &= (u8)~8u;
    *(u32 *)oui = 0;
    memcpy_fw(oui, obj->caps5, 3);                               /* mid__copy_bssid_8e211c 0x8ccea4 */
    le_bits_set(&c->sta_cap[3], 4, 4, 24, *(u32 *)oui & 0xffffffu);  /* 0x8ed220 */
    b = c->sta_cap[6];
    b &= ~0x30u;
    b &= ~0xc0u;
    c->sta_cap[6] = (u8)(b | 0x40u);
    c->sta_cap[7] &= (u8)~1u;
    le_bits_set(&c->sta_cap[7], 1, 1, 3, 0);                /* 0x8ed25c */
    b = c->sta_cap[7] | 0x10u;
    c->sta_cap[7] = (u8)(b & ~0x20u);
    le_bits_set(&c->sta_cap[7], 1, 6, 2, 0);                /* bits__set8_s6_w2 0x8ed2bc */
    c->pcp_cap[0] &= (u8)~7u;
    le_bits_set(&c->pcp_cap[0], 2, 3, 8, obj->owner->max_assoc); /* 0x8ed19c */
    c->pcp_cap[1] &= (u8)~0x38u;
    le_bits_set(&c->pcp_cap[1], 1, 6, 2, 0);
    /* vendor читает sta_cap[0] дважды (до и после первой записи) — через volatile: иначе gcc,
     * зная, что fwsh_* не перекрывают c, читает один раз */
    fwsh_n_rx_ant = (u8)(((*(volatile const u8 *)&c->sta_cap[0] >> 4) & 3u) + 1);
    fwsh_total_sectors =
        (u8)((((*(volatile const u8 *)&c->sta_cap[0] | (u32)c->sta_cap[1] << 8) >> 7) & 0x7fu) + 1);
}

/* mac__apply_multicast_addr (0x8e68b4, 60 Б): свой MAC записи mid и фильтры 0x886018 и
 * 0x886df8; для группового адреса — только журнал. */
void mac_apply_multicast_addr(struct mid *e, const u8 *mac)
{
    u8 *a = e->mac;
    memcpy_fw(a, mac, 6);
    if (e->mac_h[0] & 1)
        fw_log_emit0(0xb, 0x100cf04);
    mac_parser_set_addr_886018(a);
    mac_set_mcast_addr(a);
}

/* l2mgr__apply_mac_address (0x8e6368, 52 Б): BSSID объекта BSS записи, DMG capability и
 * регистры своего адреса (парсер, MAC, L2 offload). */
void l2mgr_apply_mac_address(struct mid_bss *obj, const u8 *mac)
{
    u8 *a = obj->bssid;
    memcpy_fw(a, mac, 6);
    dmg_cap_build_sta_capability(obj, obj->owner->mac);
    mac_parser_set_addr_886020(a);
    mac_set_own_addr(a);
    l2_offload_set_own_mac_addr(a);
}

/* l2mgr__set_mac_address (0x8fbc64, 96 Б; переход из диспетчера 0x8ece1c):
 * WMI_SET_MAC_ADDRESS_CMDID {mac[6], reserved[2]}. Журнал — как у vendor: байт 2 и
 * слово байтов 0..3 копии адреса. */
void l2mgr_set_mac_address(const struct wmi_set_mac_address_cmd *cmd, u32 mid)
{
    u32 m[2];
    struct mid *e = mid_list_by_mid_fw(mid);
    if (e == 0)
        fw_sysassert_fatal((void *)0, 0x16bf);
    mac_apply_multicast_addr(e, cmd->mac);
    l2mgr_apply_mac_address(&e->bss, cmd->mac);
    memcpy_fw(m, cmd->mac, 6);
    fw_log_emit3(0x2b, 0x100d690, mid, ((u8 *)m)[2], m[0]);
}

/* app_ies__clear (0x8c6784, 12 Б): обнулить блок IE {buf, len}, вернуть прежний буфер.
 * Длина — 16-битной записью, как у vendor (stw_s). */
__attribute__((noinline)) u32 app_ies_clear(struct app_ies *b)   /* отдельная функция у vendor */
{
    u32 old = b->buf;
    b->buf = 0;
    b->len = 0;
    return old;
}

/* app_ie__find_by_eid (0x8cc2b8, 48 Б): первый IE с данным eid в блоке или 0. */
u8 *app_ie_find_by_eid(struct app_ies *block, u32 eid)
{
    struct ie_iter it;
    u8 *ie;
    ie_iter_init(&it, block);
    while ((ie = app_ie_walk_list(&it)) != 0)
        if (ie[0] == eid)
            return ie;
    return 0;
}

/* app_ie__print_ies (0x8e1008, 84 Б): журнал всех IE блока (номер, eid, длина + дамп). */
void app_ie_print_ies(struct app_ies *block)
{
    struct ie_iter it;
    u32 n = 0;
    u8 *ie;
    ie_iter_init(&it, block);
    fw_log_emit0(0x2d, 0x1010e60);
    while ((ie = app_ie_walk_list(&it)) != 0) {
        fw_log_emit3(0x2d, 0x1010e74, n, ie[0], ie[1]);
        hexdump_words(ie + 2, ie[1]);
        n = (n + 1) & 0xff;
    }
}

/* Смещения блоков IE от объекта BSS по enum wmi_mgmt_frame_type (wil6210 wmi.h):
 * BEACON, PROBE_REQ, PROBE_RESP, ASSOC_REQ, ASSOC_RESP. vendor — таблица 0x8023b8. */
static const u16 app_ie_block_off[5] = {
    __builtin_offsetof(struct mid_bss, ie_beacon),
    __builtin_offsetof(struct mid_bss, ie_probe_req),
    __builtin_offsetof(struct mid_bss, ie_probe_resp),
    __builtin_offsetof(struct mid_bss, ie_assoc_req),
    __builtin_offsetof(struct mid_bss, ie_assoc_resp),
};

/* 0x8023b8: таблица переходов switch vendor set_app_ie (0x8e6224;
 * ldb, цель = 0x8e6256 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8023b8) const u8 mid_set_app_ie_block_jt[5] = {
    0x00, 0x09, 0x0c, 0x03, 0x06,
};

/* set_app_ie (0x8e6224, 128 Б): заменить блок IE кадра type: прежний буфер — в пул TX,
 * новый (если len != 0) — в блок, журнал IE. */
/* Блок IE кадра type (0 — маяк) записи BSS (fw/tdma.c). */
struct app_ies *mid_app_ie_block(struct mid_bss *obj, u32 type)
{
    return (struct app_ies *)((u8 *)obj + app_ie_block_off[type]);
}

void mid_set_app_ie_block(struct mid_bss *obj, u32 type, u32 len, u32 buf)
{
    fw_log_emit2(0x2b, 0x100c8ac, type, len);
    if (type >= 5) {
        fw_sysassert_fatal((void *)0, 0x11f4);
        return;
    }
    struct app_ies *blk = (struct app_ies *)((u8 *)obj + app_ie_block_off[type]);
    u32 old = app_ies_clear(blk);
    if (old != 0)
        TX_API_free_memory(old);
    if (len != 0) {
        app_ies_set_buffer(blk, (const void *)buf, len, 0);
        app_ie_print_ies(blk);
    }
}

/* mid__replace_rsn_ie (0x8e6f34, 84 Б): RSN IE целиком (до 0x28 Б) в rsn_ie (obj+0x180). */
void mid_replace_rsn_ie(struct mid_bss *obj, const u8 *ie)
{
    u32 n = ie[1] + 2;
    hexdump_words(ie, n);
    fw_log_emit2(0x2b, 0x100c634, ie[0], n);
    if (n >= 0x29)
        fw_sysassert_fatal((void *)0, 0x1482);
    memcpy_fw(obj->rsn_ie, ie, n);
    hexdump_words(obj->rsn_ie, n);
}

/* mid__apply_app_ies (0x8e61c0, 100 Б): из IE хоста взять RSN (eid 0x30) и Country
 * (eid 7, код страны — байты 2..3), затем поставить блок кадра type. */
void mid_apply_app_ies(struct mid *e, u32 type, u32 len, u32 buf)
{
    struct app_ies blk;
    u8 *ie;
    app_ies_set_buffer(&blk, (const void *)buf, len, 0);
    hexdump_words((const void *)buf, len);
    ie = app_ie_find_by_eid(&blk, 0x30);
    if (ie != 0)
        mid_replace_rsn_ie(&e->bss, ie);
    ie = app_ie_find_by_eid(&blk, 7);
    if (ie != 0)
        regulatory_domain_set_country_code((u32)ie[2] << 8 | ie[3]);
    mid_set_app_ie_block(&e->bss, type, len, buf);
}

/* l2mgr__set_app_ie (0x8fbb90, 86 Б; переход из диспетчера 0x8ecdc8): WMI_SET_APPIE_CMDID
 * {mgmt_frm_type, reserved, ie_len u16, ie_info[]}. IE копируются в TX-буфер. */
void l2mgr_set_app_ie(const struct wmi_set_appie_cmd *cmd, u32 mid)
{
    struct mid *e = mid_list_by_mid_fw(mid);
    u32 buf = 0;
    if (cmd->ie_len != 0) {
        if (cmd->ie_len > 1024)
            fw_sysassert_fatal((void *)0, 0x11e6);
        buf = TX_API_alloc_tx_payload();
        memcpy_fw((void *)buf, cmd->ie_info, cmd->ie_len);
    }
    fw_log_emit1(0x2b, 0x100def4, cmd->mgmt_frm_type);
    mid_apply_app_ies(e, cmd->mgmt_frm_type, cmd->ie_len, buf);
}

/* mid__set_ssid (0x8e70a8, 24 Б): SSID объекта BSS записи; длина 0 при недопустимой. */
void mid_set_ssid(struct mid_bss *obj, const u8 *ssid, u32 len)
{
    obj->ssid_len = 0;
    if (len == 0 || len >= 0x21)
        return;
    obj->ssid_len = len;
    memcpy_fw(obj->ssid, ssid, len);
}

/* l2_mgr::wmi_cmd_handler_set_ssid (0x8fbcec, 46 Б): WMI_SET_SSID_CMDID {ssid_len u32,
 * ssid[32]}; у PCP/AP-записи (bss.is_go != 0, [e+0x9c]) игнорируется (журнал). */
void l2mgr_set_ssid(const struct wmi_set_ssid_cmd *cmd, u32 mid)
{
    struct mid_bss *obj = &mid_list_by_mid_fw(mid)->bss;
    if (obj->is_go != 0) {
        fw_log_emit0(0x2b, 0x100dbb4);
        return;
    }
    mid_set_ssid(obj, cmd->ssid, cmd->ssid_len);
}

/* ---------------- CONNECT (0x01) / DISCONNECT (0x03) ---------------- */



/* validate_connect (0x8fb348, 128 Б): можно ли подключаться для mid. Канал (второй
 * аргумент) vendor передаёт, но не читает. */
u32 l2mgr_validate_connect(u32 mid, u32 channel)
{
    (void)channel;
    struct mid *e = mid_list_by_mid_fw(mid);
    if (mid_list_by_mid_fw(mid)->mac[0] & 1) {          /* групповой бит MAC записи */
        fw_log_emit0(0xb, 0x100ef24);
        return 0;
    }
    if (e->bss.mode == 2) {
        fw_log_emit0(0x1b, 0x100ef4c);
        return 0;
    }
    if (mid_list_any_in_state2() != 0) {
        fw_log_emit1(0x2b, 0x100ef88, mid);
        return 0;
    }
    if (mid_list_count_active(0) != 0) {                /* vendor: r0 = 0 от предыдущего */
        fw_log_emit1(0x2b, 0x100efd0, mid);
        return 0;
    }
    if (mid_list_by_mid_fw(mid)->connect_busy != 0) {
        fw_log_emit0(0x2b, 0x100f010);
        return 0;
    }
    return 1;
}

/* l2mgr__config_security (0x8f1c84, 52 Б): параметры безопасности записи mid. */
void l2mgr_config_security(struct mid_sec *obj, u32 dot11_auth, u32 auth, u32 group_crypto,
                           u32 a4, u32 wpa_offload)
{
    obj->dot11_auth = dot11_auth;
    obj->auth = auth;
    obj->group_crypto = group_crypto;
    obj->pairwise = a4;
    obj->enabled = 1;
    obj->wpa_offload = wpa_offload;
    fw_log_emit3(0x2e, 0x1010f68, obj->owner->id, wpa_offload, auth);
}

/* mid__set_default_dmg_params (0x8cb728, 120 Б): RSN IE по умолчанию в bss.rsn_ie
 * (e+0x1c8) — eid 0x30, len 0x14, версия 1, групповой и парный шифр 00-0f-ac:8 (GCMP), AKM
 * 00-0f-ac:2 (PSK); у RSN Capabilities (e+0x1dc) vendor по одному гасит биты 0..13 —
 * итог тот же, что ниже. */
void mid_set_default_rsn_ie(struct mid *e)
{
    struct rsn_ie_1x1 *r = (struct rsn_ie_1x1 *)e->bss.rsn_ie;
    r->eid = 0x30;
    r->len = 0x14;
    r->version = 1;
    r->group_cipher[0] = 0;    r->group_cipher[1] = 0xf;    r->group_cipher[2] = 0xac;    r->group_cipher[3] = 8;
    r->pairwise_count = 1;
    r->pairwise_cipher[0] = 0; r->pairwise_cipher[1] = 0xf; r->pairwise_cipher[2] = 0xac; r->pairwise_cipher[3] = 8;
    r->akm_count = 1;
    r->akm[0] = 0;             r->akm[1] = 0xf;             r->akm[2] = 0xac;             r->akm[3] = 2;
    r->rsn_cap[0] = 0;
    r->rsn_cap[1] &= 0xc0;
}

/* mid__clear_flag_1c9 (0x8c6948, 10 Б): длина RSN IE (e+0x1c9) = 0. */
void mid_clear_rsn_ie_len(struct mid *e)
{
    e->bss.rsn_ie[1] = 0;
}

/* l2_mgr__connect_setup (0x8f85d4, 80 Б): безопасность из CONNECT; для
 * dot11_auth_mode OPEN и auth_mode WPA2_PSK — RSN IE по умолчанию, иначе RSN IE снят. */
void l2mgr_connect_setup(const struct wmi_connect_cmd *cmd, u32 mid)
{
    struct mid *e = mid_list_by_mid_fw(mid);
    u32 offload = (cmd->ctrl_flags & WMI_CONNECT_DO_WPA_OFFLOAD) ? 1 : 0;
    l2mgr_config_security(&e->sec, cmd->dot11_auth_mode, cmd->auth_mode, cmd->group_crypto_type, 0,
                          offload);
    /* volatile: два ldb, как у vendor (без него gcc сливает их в одно слово) */
    if (((const volatile struct wmi_connect_cmd *)cmd)->auth_mode == 0x10
        && ((const volatile struct wmi_connect_cmd *)cmd)->dot11_auth_mode == 1)
        mid_set_default_rsn_ie(e);
    else
        mid_clear_rsn_ie_len(e);
}

/* vendor_ie__write_at_282 (0x8ebcd4, 56 Б): TLV {тип u16, длина u16, данные} в vendor
 * IE записи (vs_ie + off, obj+0x11a+off); возврат длина + 4. */
static u32 vendor_ie_write_tlv(struct mid_bss *obj, u32 off, u32 type, const void *src, u32 len)
{
    u8 *p = obj->vs_ie + off;
    p[0] = (u8)type;
    p[1] = (u8)(type >> 8);
    p[2] = (u8)len;
    p[3] = (u8)(len >> 8);
    memcpy_fw(p + 4, src, len);
    return (len + 4) & 0xffffu;
}

/* vendor_ie__build_wilocity (0x8e73a0, 210 Б): Wilocity vendor IE (eid 0xdd, OUI
 * 04:ce:14) в vs_ie (obj+0x11a): TLV 5 = 1, 1 = (f == 1), 2 = тип сети, 3 = (f == 3),
 * 6 = [0x880a8c], 7 = 1; длина IE — vs_ie[1], полная — vs_ie_len (obj+0x17a). */
void vendor_ie_build_wilocity(struct mid_bss *obj, u32 type, u32 f)
{
    u16 t1 = (f == 1) ? 1 : 0, t3 = (f == 3) ? 1 : 0, one = 1, hw, ty = (u16)type;
    volatile u8 *h = obj->vs_ie;    /* побайтно, как у vendor (без volatile gcc сливает в sth) */
    u32 n;
    h[0] = 0xdd;
    h[2] = 0x04;
    h[3] = 0xce;
    h[4] = 0x14;
    n = vendor_ie_write_tlv(obj, 5, 5, &one, 2) + 5;
    n += vendor_ie_write_tlv(obj, n & 0xffffu, 1, &t1, 2);
    n += vendor_ie_write_tlv(obj, n & 0xffffu, 2, &ty, 2);
    n += vendor_ie_write_tlv(obj, n & 0xffffu, 3, &t3, 2);
    hw = *(volatile u16 *)(HW_RGF_USER_FW_REV_ID);
    n += vendor_ie_write_tlv(obj, n & 0xffffu, 6, &hw, 2);
    n += vendor_ie_write_tlv(obj, n & 0xffffu, 7, &one, 2);
    obj->vs_ie[1] = (u8)(n - 2);
    obj->vs_ie_len = (u8)n;
}

/* mid__log_network_type (0x8e696c, 116 Б): тип сети (enum wmi_network_type) записи,
 * vendor IE и журнал; неизвестный тип — ассерт 0x11ec. */
void mid_log_network_type(struct mid *e, u32 type)
{
    u32 tok;
    e->network_type = type;
    vendor_ie_build_wilocity(&e->bss, type, 0);
    switch (e->network_type) {
    case 0x01: tok = 0x100ccc0; break;              /* INFRA */
    case 0x02: tok = 0x100cc78; break;              /* ADHOC */
    case 0x04: tok = 0x100ccdc; break;              /* ADHOC_CREATOR */
    case 0x10: tok = 0x100cd08; break;              /* AP */
    case 0x20: tok = 0x100cc9c; break;              /* P2P */
    default:
        fw_log_emit1(0xb, 0x100cd24, e->network_type);
        fw_sysassert_fatal((void *)0, 0x11ec);
        return;
    }
    fw_log_emit1(0x2b, tok, e->network_type);
}

/* bss_set_active (0x8c4ec8, 28 Б): состояние BSS = 2 (активен). */
void bss_set_active(struct mid_bss *obj)
{
    fw_log_emit1(0x2b, 0x100c420, obj->mode);
    obj->state = MID_BSS_ACTIVE;
}

/* RADIO_MGR::set_primary_channel (0x8e6cec, 72 Б): radio_mgr->set_primary(1, ch, …). */
void radio_mgr_set_primary_channel(u32 ch, u32 rx_on_w0, u32 rx_on_w4, u32 bcn_int,
                                   u32 sta_role, u32 mid)
{
    fw_log_emit1(0x28, 0x1019014, ch);
    struct radio_mgr *rm = radio_mgr_obj;
    rm->vt->set_primary(rm, 1, ch, rx_on_w0, rx_on_w4, bcn_int, sta_role, mid);
}

/* l2_mgr__connect_args (0x8dca38, 28 Б): radio_mgr->request_primary(cb, arg, mid) —
 * запросить радио на основном канале; по готовности вызывается cb. */
struct rm_req *l2mgr_connect_args(rm_req_cb cb, u32 arg, u32 mid)
{
    struct radio_mgr *rm = radio_mgr_obj;
    return rm->vt->request_primary(rm, cb, arg, mid);
}

/* radio_mgr__call_method_10 (0x8ea800, 10 Б): radio_mgr->lock_free(req) — отпустить радио. */
void radio_mgr_call_method_10(struct rm_req *req)
{
    struct radio_mgr *rm = radio_mgr_obj;
    rm->vt->lock_free(rm, req);
}

/* mid__link_acquisition_action (0x8da928): соединение с пиром — scan_mngr.c (порт под
 * именем find_main_sm_bcon_lookup); conn_mgr__ranking_remove (0x8ca6fc) — conn.c. */

/* mid__connect (0x8c71a8, 84 Б): захват линка с dst_mac (инициатор, без бикона, RX-сектор
 * не задан) — соединение снимается из списка ранжирования (переход 0x8e7978), wvs_mode
 * = a2. */
void mid_connect(struct mid *e, const union mac_addr *dst_mac, u32 a2)
{
    struct conn *conn = 0;
    fw_log_emit3(0x2b, 0x100cbfc, dst_mac->h[2], dst_mac->h[1], dst_mac->h[0]);
    if (find_main_sm_bcon_lookup(e, dst_mac, 0, 1, &conn, 0, 1, 0xffff) != 1)
        return;
    conn->wvs_mode = a2;
    conn_mgr_ranking_remove(conn);
}

/* Колбэк радио-менеджера для CONNECT (vendor 0x8f188c, 96 Б; l2_mgr::connect передаёт
 * его числом 0x3188c — у нас полный адрес): радио выделено — mid__connect для mid из
 * [0x8000b8], отпустить радио (lock_free), vendor IE. arg (0) не читается. */
void l2mgr_connect_radio_cb(struct rm_req *req, u32 arg)
{
    (void)arg;
    struct mid *e = mid_list_by_mid_fw(l2mgr_connect_mid);
    if (e == 0)
        fw_sysassert_fatal((void *)0, 0x16c7);
    mid_connect(e, &connect_req.dst_mac, l2mgr_connect_vs_mode);
    fw_log_emit1(0x2b, 0x100f9b4, (u32)req);
    radio_mgr_call_method_10(req);
    vendor_ie_build_wilocity(&e->bss, e->network_type, l2mgr_connect_vs_mode == 1);
}

/* l2_mgr::connect (0x8f1e18, 276 Б): подключение одиночным радио (struct wmi_connect_cmd,
 * include/wmi.h); reserved1[0] vendor берёт как режим vendor IE при [0x803c20] бит 0 == 0. */
void l2mgr_connect(const struct wmi_connect_cmd *cmd, u32 mid)
{
    l2mgr_pending_op_set(1);
    connect_req.dst_mac_lo = cmd->dst_mac_lo;
    connect_req.dst_mac_hi = cmd->dst_mac_hi;
    if (dashboard.cfg.special_flags & 1)
        l2mgr_connect_vs_mode = 1;
    else
        l2mgr_connect_vs_mode = cmd->reserved1[0];
    l2mgr_connect_mid = mid;                /* mid текущего CONNECT */
    struct mid *e = mid_list_by_mid_fw(mid);
    if (e == 0)
        fw_sysassert_fatal((void *)0, 0x16c6);
    fw_log_emit3(0x2b, 0x100e994, mid, cmd->network_type, l2mgr_connect_vs_mode);
    mid_log_network_type(e, cmd->network_type);
    struct mid_bss *obj = &e->bss;
    l2mgr_apply_mac_address(obj, cmd->bssid);
    u32 bss = (u32)obj->bssid;                      /* vendor проверяет адрес на 0 */
    if (bss == 0)
        fw_sysassert_fatal((void *)0, 0x11e2);
    fw_status_set_state(5);
    fw_log_emit3(0x2b, 0x100e9d4, mid, ((const union mac_addr *)bss)->h[2],
                 mac_lo32((const union mac_addr *)bss));
    bss_set_active(obj);
    mid_set_ssid(obj, cmd->ssid, cmd->ssid_len);
    if (cmd->dot11_auth_mode == 8)                  /* WMI_AUTH11_WSC */
        fw_log_emit0(0x2b, 0x100ea08);
    sys_state_broadcast(4, 0);
    radio_mgr_set_primary_channel(cmd->channel, ((volatile struct connect_req *)&connect_req)->chan_p1,
                                  ((volatile struct connect_req *)&connect_req)->chan_p2,
                                  pcp_bcon_interval, 1, mid & 0xff);
    l2mgr_connect_args(l2mgr_connect_radio_cb, 0, mid & 0xff);
}

/* l2_mgr::connect_multi_omni_cb (0x8c7300, 60 Б; задача u_schd, у vendor числом 0x7300):
 * журнал времени, снять отметку «connect flow in progress» записи mid, затем как обычный
 * CONNECT — l2_mgr__connect_setup и l2_mgr::connect. a0 — команда (см. ниже). */
static void l2mgr_connect_multi_omni_cb(u32 a0, u32 mid)
{
    const struct wmi_connect_cmd *cmd = (const struct wmi_connect_cmd *)a0;

    fw_log_emit1(0x2b, 0x100ea2c, u_schd_now());
    mid_list_by_mid_fw(mid)->connect_busy = 0;
    l2mgr_connect_setup(cmd, mid);
    l2mgr_connect(cmd, mid);
}

/* Отложенный вариант колбэка: команда — копия в кадре TX-пула, после подключения кадр
 * возвращается (l2_mgr::connect и connect_setup указатель на команду не сохраняют). */
static void l2mgr_connect_multi_omni_deferred(u32 a0, u32 mid)
{
    l2mgr_connect_multi_omni_cb(a0, mid);
    TX_API_free_memory(a0);
}

/* l2_mgr::connect_multi_omni (0x8c71fc, 260 Б): CONNECT при нескольких directed omni
 * (n = [0x800231] > 1). Цель — запись скана с BSSID = dst_mac на канале команды
 * (l2_mgr__connect_next 0x8e4c24) → [0x800338]. Не найдена — «we don't know this ap» и
 * подключение сразу. Иначе подключение откладывается до начала следующего окна бикона цели:
 * slot = BI × 1000 + 2400 (поле +0xa), период = n × slot; t0 — время бикона цели (+0x10);
 * прошло el = (now − t0) × 16; цель = t0 + ((el / период) + 1) × период / 16; до неё
 * d = (цель − now) × 16; задержка = (d > slot ? d : d + период) − slot (по модулю 2^32, как
 * vendor; делитель не 0 — доказательство в dmg_bcon_rx_handler, scan_mngr.c). Задача — в
 * connect_busy записи mid ([e+0x2ac]).
 * Сознательное отличие: vendor передаёт задаче указатель на команду в кольце ящика хоста,
 * а mbox__consume_one (0x8e3764) сразу после разбора отдаёт запись хосту (hw->tail) —
 * к срабатыванию задачи там может лежать следующая команда. Здесь команда (0x3c Б)
 * копируется в кадр TX-пула (TX_API__alloc_tx_payload) и освобождается после подключения;
 * нет кадра — как vendor, указатель на запись кольца. */
void l2mgr_connect_multi_omni(const struct wmi_connect_cmd *cmd, u32 mid)
{
    struct mid *e = mid_list_by_mid_fw(mid);
    struct scan_peer *t = l2_mgr_connect_next(e->disc.scan, cmd->dst_mac, cmd->channel);

    conn_multi_omni_target = t;
    if (t == 0) {
        fw_log_emit0(0x1b, 0x100ea60);                  /* «we don't know this ap» */
        l2mgr_connect_multi_omni_cb((u32)cmd, mid);
        return;
    }
    u32 t0 = t->bcon_time;
    u32 now = u_schd_now();
    u32 slot = (u32)t->rssi * 1000u + 0x960u;          /* поле +0xa — BI бикона цели */
    u32 period = (u32)conn_multi_omni_count * slot;
    u32 el = (now - t0) << 4;
    u32 target = t0 + ((((el / period) + 1u) * period) >> 4);
    u32 d = (target - now) << 4;
    u32 delay = ((slot < d) ? d : d + period) - slot;

    fw_log_emit3(0x2b, 0x100ea94, now, delay, t->rx_omni);
    fw_log_emit1(0x29, 0x100eaf4, t0);
    u32 copy = TX_API_alloc_tx_payload();
    if (copy != 0) {
        memcpy_fw((void *)copy, cmd, sizeof(*cmd));
        e->connect_busy = u_schd_schedule(l2mgr_connect_multi_omni_deferred, copy, mid, 1,
                                          delay, 0, 0);
    } else {
        e->connect_busy = u_schd_schedule(l2mgr_connect_multi_omni_cb, (u32)cmd, mid, 1,
                                          delay, 0, 0);
    }
}

/* wmi_connect (0x8ec434, 80 Б): WMI_CONNECT_CMDID. Счётчик — [gp,-0xb8] = 0x8000cc.
 * Отказ проверки (и тип сети ADHOC*) — WMI_DISCONNECT_EVENT (protocol_reason 1, причина 6 →
 * ASSOC_FAILED). */
void wmi_connect(const struct wmi_connect_cmd *cmd, u32 mid)
{
    wmi_connect_count += 1;
    /* Типы сети ADHOC (2) / ADHOC_CREATOR (4) — IBSS, только SparRAW-pro; открытая версия —
     * AP/STA/PCP/PBSS по 802.11: отказ тем же путём, что и неверный канал. */
    if (cmd->network_type == 0x02 || cmd->network_type == 0x04 ||
        l2mgr_validate_connect(mid, cmd->channel) == 0) {
        l2mgr_send_disconnect_evt(cmd->bssid, 1, 6, mid);
    } else if (conn_multi_omni_count == 1) {
        l2mgr_connect_setup(cmd, mid);
        l2mgr_connect(cmd, mid);
    } else {
        l2mgr_connect_multi_omni(cmd, mid);
    }
}

/* lmac_if_discovery_mode_cfg_handler (0x8db724, 68 Б): LMAC-команда 0x24 {mode != 0, a1}. */
void lmac_if_discovery_mode_cfg(u32 mode, u32 a1)
{
    struct lmac_cmd_discovery *b = mem_pool_alloc_locked(&lmac_mbox.mb);
    if (b == 0)
        return;
    b->mode = (mode != 0) ? 1 : 0;
    b->type = a1;
    fw_log_emit2(0x29, 0x10049b8, b->mode, a1);
    lmac_if_post_cmd(b, 0x24, 8, 0);
}

/* conn_main_sm__action_step (0x8c9300, 96 Б): разорвать все соединения записи mid. */
void l2mgr_disconnect_mid(u32 mid, u32 reason, u32 protocol)
{
    struct mid *e = mid_list_by_mid_fw(mid);
    if (e == 0)
        fw_sysassert_fatal((void *)0, 0x1533);
    l2mgr_pending_op_set(2);
    fw_log_emit3(0x2b, 0x100d600, mid, reason, protocol);
    mid_list_disconnect_all(e, reason, protocol);
    lmac_if_discovery_mode_cfg(0, 3);
}

/* 0x8c909c (84 Б): disconnect mid. */
void l2mgr_disconnect(u32 mid, u32 reason, u32 protocol)
{
    lmac_if_discovery_mode_cfg(1, 3);
    /* vendor откладывал разрыв, пока чип в shallow sleep (PS) — энергосбережение вырезано. */
    l2mgr_disconnect_mid(mid, reason, protocol);
}

/* wmi_disconnect (0x8ec4ec, 8 Б): WMI_DISCONNECT_CMDID (без тела) → 0x8c909c(mid, 2, 3). */
void wmi_disconnect(u32 mid)
{
    l2mgr_disconnect(mid, 2, 3);
}

/* ---------------- PS-профиль и предел повторов mgmt ---------------- */


/* POWER_MNGR::wmi_ps_dev_profile_cfg_cmd (0x8ec970): WMI_PS_DEV_PROFILE_CFG_EVENTID (0x191c)
 * {status u32}. Энергосбережение вырезано сознательно (см. fw/action.c psc_req_reject):
 * DEFAULT (0) и PS_DISABLED (1) — успех (0), это и есть «без PS»; MAX_PS (2) и
 * LOW_LATENCY_PS (3) — 1, «профиль не поддержан» (у vendor 2/3 тоже не поддержаны, а 0
 * включал PS). */
static void wmi_ps_dev_profile_cfg(const struct wmi_ps_dev_profile_cfg_cmd *cmd, u32 mid,
                                   struct wmi_mbox *mb)
{
    struct wmi_word_event *p = mem_pool_alloc_locked(&mb->mb);   /* {status} */
    fw_log_emit1(0x2e, 0x1002030, cmd->ps_profile);
    p->value = (cmd->ps_profile <= 1) ? 0u : 1u;
    fw_log_emit1(0x2e, 0x100206c, p->value);
    wmi_evt_post(mb, p, 0, 0x191c, sizeof(*p), mid, 0, 0);
}

/* l2_mgr::wmi_cmd_handler_set_mgmt_retry_limit (0x8ec35c): предел 1..254, хранится − 1 в
 * [gp+0xd3] = 0x800257 (tx_api__set_mgmt_retry_limit 0x8e6900). Ответ 0x1930 {status}. */
static void wmi_set_mgmt_retry_limit(const struct wmi_set_mgmt_retry_limit_cmd *cmd, u32 mid,
                                     struct wmi_mbox *mb)
{
    fw_log_emit1(0x2b, 0x100e320, cmd->mgmt_retry_limit);
    struct wmi_status_event *p = mem_pool_alloc_locked(&mb->mb);
    memset0_words(p, sizeof(*p));
    p->status = 1;
    u32 v = cmd->mgmt_retry_limit;
    if (v > 254 || v == 0) {
        fw_log_emit1(0xb, 0x100e364, v);
    } else {
        tx_mgmt_retry_limit = (u8)(v - 1);
        p->status = 0;
    }
    fw_log_emit0(0x2b, 0x100e390);
    wmi_evt_post(mb, p, 0, 0x1930, sizeof(*p), mid, 0, 0);
}

/* l2_mgr::wmi_cmd_handler_get_mgmt_retry_limit (0x8ec200): ответ 0x1931 {предел}
 * (хранимое + 1; 255 — как есть). */
static void wmi_get_mgmt_retry_limit(u32 mid, struct wmi_mbox *mb)
{
    fw_log_emit0(0x2b, 0x100e3c4);
    struct wmi_get_mgmt_retry_limit_event *p = mem_pool_alloc_locked(&mb->mb);
    memset0_words(p, sizeof(*p));
    u32 v = tx_mgmt_retry_limit;               /* tx_api__get_mgmt_retry_limit (0x8cc3d0) */
    p->mgmt_retry_limit = (u8)v;
    if ((s32)v <= 254)
        p->mgmt_retry_limit = (u8)(v + 1);
    fw_log_emit0(0x2b, 0x100e3f4);
    wmi_evt_post(mb, p, 0, 0x1931, sizeof(*p), mid, 0, 0);
}

/* ---------------- мелкие обработчики-переходники ---------------- */

/* wmi__power_mgmt_cfg_thunk (0x8ec358 → 0x8ec350, 2 инстр.): WMI_POWER_MGMT_CFG_CMDID —
 * body[0] (ldb_s) в [gp,-26] (st.as: 0x800184 − 26·4 = 0x80011c). mid не используется. */
static void wmi_power_mgmt_cfg(const struct wmi_power_mgmt_cfg_cmd *cmd, u32 mid)
{
    (void)mid;
    power_source = cmd->power_source;
}

/* wmi_disconnect_sta (0x8ec4f4, 12 Б): WMI_DISCONNECT_STA_CMDID {dst_mac[6], reason u16} →
 * l2mgr__disconnect_sta(mid, mac, reason) (переход b.d 0x8c93a0, ldw_s [body+6] в слоте). */
static void wmi_disconnect_sta(const struct wmi_disconnect_sta_cmd *cmd, u32 mid)
{
    l2mgr_disconnect_sta(mid, cmd->dst_mac, cmd->disconnect_reason);
}

/* boot__clear_object_48 (0x8c1848, 12 Б): ящик и запрос радио = 0, затем memset0_words(req, 4)
 * (b.d с r1 = 4 в слоте) — обнулить 12 Б. Второй аргумент (у вызывающего r1 = 0) не читается. */
static void clear_object_48(struct wmi_rf_sector_get_req *o)
{
    o->mbox = 0;
    o->radio = 0;
    memset0_words((void *)&o->req, sizeof(o->req));
}

/* boot__clear_object_tail (0x8c1854, 16 Б): ящик и запрос радио = 0, memset0_words(req, 0xc4). */
static void clear_object_tail(struct wmi_rf_sector_set_req *o)
{
    o->mbox = 0;
    o->radio = 0;
    memset0_words((void *)&o->req, sizeof(o->req));
}

/* ---------------- диспетчер ---------------- */

/* Журнал «---->> [HOST CMD] WMI_xxx» (модуль 0x20) — у vendor перед вызовом обработчика. */
#define HOST_CMD_LOG(tok) fw_log_emit0(0x20, (tok))

/* 0x802064: таблица переходов switch vendor wmi__host_cmd_dispatch (0x8de43c;
 * ldw, цель = 0x8de502 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802064) const u16 wmi_host_cmd_dispatch_jt_802064[23] = {
    0x01e5, 0x05b2, 0x01ce, 0x01d9, 0x05b2, 0x05b2, 0x0196, 0x05b2,
    0x05b2, 0x05b7, 0x05b2, 0x05b2, 0x05b2, 0x05b2, 0x02db, 0x05b2,
    0x05b2, 0x05b2, 0x05b2, 0x05b2, 0x05b2, 0x0317, 0x0323,
};
/* 0x802094: таблица переходов switch vendor wmi__host_cmd_dispatch (0x8de43c;
 * ldw, цель = 0x8de520 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802094) const u16 wmi_host_cmd_dispatch_jt_802094[34] = {
    0x01a7, 0x05a3, 0x05a3, 0x05a3, 0x05a3, 0x05a3, 0x0195, 0x05a3,
    0x05a3, 0x05a3, 0x05a3, 0x05a3, 0x05a3, 0x05a3, 0x05a3, 0x05a3,
    0x05a3, 0x05a3, 0x05a3, 0x05a3, 0x05a3, 0x05a3, 0x05a3, 0x05a3,
    0x01b3, 0x01e4, 0x01f0, 0x0256, 0x0262, 0x026e, 0x027a, 0x0292,
    0x029e, 0x02aa,
};
/* 0x8020d8: таблица переходов switch vendor wmi__host_cmd_dispatch (0x8de43c;
 * ldw, цель = 0x8de556 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8020d8) const u16 wmi_host_cmd_dispatch_jt_8020d8[41] = {
    0x058d, 0x02e0, 0x0588, 0x0588, 0x0588, 0x02d4, 0x0588, 0x0588,
    0x0588, 0x0588, 0x0588, 0x0588, 0x0588, 0x03fb, 0x0406, 0x0588,
    0x0588, 0x0588, 0x0588, 0x0588, 0x0305, 0x0588, 0x0588, 0x0588,
    0x0588, 0x0588, 0x0588, 0x0588, 0x0588, 0x0588, 0x03b7, 0x0588,
    0x0588, 0x0154, 0x0160, 0x0588, 0x0588, 0x0588, 0x0588, 0x0562,
    0x013a,
};
/* 0x80212c: таблица переходов switch vendor wmi__host_cmd_dispatch (0x8de43c;
 * ldw, цель = 0x8de580 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(80212c) const u16 wmi_host_cmd_dispatch_jt_80212c[8] = {
    0x04a8, 0x0573, 0x0573, 0x02f6, 0x02fd, 0x0383, 0x0573, 0x036b,
};
/* 0x80213c: таблица переходов switch vendor wmi__host_cmd_dispatch (0x8de43c;
 * ldw, цель = 0x8de5a8 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(80213c) const u16 wmi_host_cmd_dispatch_jt_80213c[18] = {
    0x0339, 0x055f, 0x055f, 0x055f, 0x03e8, 0x03f4, 0x055f, 0x055f,
    0x055f, 0x055f, 0x055f, 0x055f, 0x055f, 0x055f, 0x055f, 0x055f,
    0x01f0, 0x01fc,
};
/* 0x802160: таблица переходов switch vendor wmi__host_cmd_dispatch (0x8de43c;
 * ldw, цель = 0x8de5e2 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802160) const u16 wmi_host_cmd_dispatch_jt_802160[17] = {
    0x01a7, 0x01b2, 0x01bd, 0x01c8, 0x0277, 0x0283, 0x0542, 0x01ea,
    0x03e1, 0x0542, 0x0542, 0x0542, 0x0542, 0x037c, 0x0414, 0x02d2,
    0x0389,
};
/* 0x802184: таблица переходов switch vendor wmi__host_cmd_dispatch (0x8de43c;
 * ldw, цель = 0x8de670 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802184) const u16 wmi_host_cmd_dispatch_jt_802184[6] = {
    0x02ac, 0x02b4, 0x02b8, 0x02a1, 0x02bc, 0x02c9,
};
/* 0x802190: таблица переходов switch vendor wmi__host_cmd_dispatch (0x8de43c;
 * ldw, цель = 0x8de6a8 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802190) const u16 wmi_host_cmd_dispatch_jt_802190[5] = {
    0x0456, 0x0475, 0x048b, 0x04a3, 0x03c9,
};
/* 0x80219c: таблица переходов switch vendor wmi__host_cmd_dispatch (0x8de43c;
 * ldw, цель = 0x8de744 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(80219c) const u16 wmi_host_cmd_dispatch_jt_80219c[10] = {
    0x03de, 0x02f1, 0x02f7, 0x0491, 0x0491, 0x0491, 0x0491, 0x0491,
    0x0477, 0x0482,
};

/* wmi__host_cmd_dispatch (0x8de43c, ~1.4 КБ): cmd — mbox-заголовок {seq, len, type, flags(+6)},
 * wmi-заголовок {mid(+8), id(+0xa)}, тело с +0x10. vendor: r15 = obj, r14 = mid, r13 = тело.
 * Разбор id — дерево сравнений + 9 таблиц переходов (ldh.as.x [tbl, id − base] —
 * знаковые полуслова, цель = (адрес после j_s) + 2·запись): 0x802064 (1..0x17),
 * 0x802094 (0x808..0x829), 0x8020d8 (0x835..0x85d), 0x80212c (0x85f..0x866),
 * 0x80213c (0x900..0x911), 0x802160 (0x914..0x924), 0x802184 (0x993..0x998),
 * 0x802190 (0x9a1..0x9a5), 0x80219c (0xa06..0xa0f). Полная таблица — docs/WMI-DISPATCH.md.
 * Неизвестный id — wmi_evt__send_command_not_supported(obj, id, 0, mid) (0x8df066).
 * После обработки слот кольца освобождается (sync = 0) и курсор продвигается
 * (lmac_if__evt_fields). Не портированные обработчики — слабые заглушки
 * (fw/wmi_handlers_todo.c). */
void wmi_host_cmd_dispatch(struct wmi_mbox *mb, u8 *cmd)
{
    const struct mbox_hdr *hdr = (const struct mbox_hdr *)cmd;
    u32 mid = hdr->mid;
    void *body = (void *)(hdr + 1);                 /* тело — struct wmi_*_cmd (include/wmi.h) */
    if (hdr->flags & 2)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1036);
    if (hdr->flags & 4)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1037);

    /* Железо не готово (RF нет / rf-kill): CONNECT и START_SCAN получают немедленный
     * отказ, остальные команды идут в общий разбор. */
    u32 handled = 0;
    if (host_if_hw_ready_for_wmi() == 0) {
        u32 id0 = hdr->id;
        if (id0 == 0x1) {
            host_if_connect_rf_kill(body, mid);
            handled = 1;
        } else if (id0 == 0x7) {
            host_if_send_scan_complete(mid);
            handled = 1;
        }
    }

    /* исправлено (vendor): mid заголовка без записи mid_list — обработчики разыменовывали 0
     * (mid_list_by_mid_fw → 0: WMI_SET_SSID, SET_PASSPHRASE, ESE_CFG, …). Такая команда — «не поддерживается»;
     * WMI_PORT_ALLOCATE (0x911) берёт mid из тела и создаёт запись — её пропускаем. */
    if (handled == 0 && hdr->id != 0x911 && mid_list_by_mid_fw(mid) == 0) {
        wmi_evt_send_command_not_supported(mb, hdr->id, 0, mid);
        handled = 1;
    }

    if (handled == 0) {
        u32 id = hdr->id;                           /* ldh — без знака */
        switch (id) {
        case 0x1:                                   /* WMI_CONNECT */
            fw_log_emit1(0x20, 0x1006c48, wmi_connect_count);
            wmi_connect(body, mid);
            break;
        case 0x3:                                   /* WMI_DISCONNECT */
            HOST_CMD_LOG(0x1006bf4);
            wmi_disconnect(mid);
            break;
        case 0x4:                                   /* WMI_DISCONNECT_STA */
            HOST_CMD_LOG(0x1006c1c);
            wmi_disconnect_sta(body, mid);
            break;
        case 0x7:                                   /* WMI_START_SCAN */
            fw_log_emit1(0x20, 0x1006b44, wmi_scan_count);
            low_sme_wmi_scan_cmd_handler(body, mid);
            break;
        case 0xa:                                   /* WMI_SET_PROBED_SSID */
        case 0x835:                                 /* WMI_MLME_PUSH */
            /* vendor: запись таблицы указывает прямо на выход (0x8df070) — команда
             * молча поглощается, без журнала и без ответа. */
            break;
        case 0xf:                                   /* WMI_BCON_CTRL */
            HOST_CMD_LOG(0x1006fbc);
            wmi_bcon_ctrl(body, mid);
            break;
        case 0x16:                                  /* WMI_ADD_CIPHER_KEY */
            HOST_CMD_LOG(0x1007088);
            wmi_add_cipher_key(body, mid);
            break;
        case 0x17:                                  /* WMI_DELETE_CIPHER_KEY */
            HOST_CMD_LOG(0x10070b4);
            wmi_delete_cipher_key(body, mid);
            break;
        case 0x3f:                                  /* WMI_SET_APPIE (переход 0x8ecdc8) */
            HOST_CMD_LOG(0x1007304);
            l2mgr_set_app_ie(body, mid);
            break;
        case 0x42:                                  /* WMI_PXMT_RANGE_CFG */
            HOST_CMD_LOG(0x100732c);
            wmi_pxmt_range_cfg(body, mid);
            break;
        case 0x803:                                 /* WMI_ECHO */
            HOST_CMD_LOG(0x1006a68);
            wmi_echo_rsp(mb, ((const struct wmi_echo_cmd *)body)->value, mid);
            break;
        case 0x804:                                 /* WMI_DEEP_ECHO */
            HOST_CMD_LOG(0x1006b70);
            wmi_deep_echo(mb, ((const struct wmi_echo_cmd *)body)->value);
            break;
        case 0x808:                                 /* WMI_ADD_DEBUG_TX_PCKT */
            HOST_CMD_LOG(0x1006b98);
            wmi_add_debug_tx_pckt(body, mid);
            break;
        case 0x80e:                                 /* WMI_TEMP_SENSE (журнала нет) */
            wmi_temp_sense(mb, body);
            break;
        case 0x820:                                 /* WMI_CFG_RX_CHAIN */
            HOST_CMD_LOG(0x1006bc8);
            wmi_cfg_rx_chain(body, mid);
            break;
        case 0x821:                                 /* WMI_VRING_CFG */
            HOST_CMD_LOG(0x1006c6c);
            wmi_vring_cfg(body, mid);
            break;
        case 0x822:                                 /* WMI_BCAST_VRING_CFG */
            HOST_CMD_LOG(0x1006c94);
            wmi_bcast_vring_cfg(body, mid);
            break;
        case 0x823:                                 /* WMI_VRING_BA_EN */
            HOST_CMD_LOG(0x1006e18);
            wmi_vring_ba_en(body, mid);
            break;
        case 0x824:                                 /* WMI_VRING_BA_DIS */
            HOST_CMD_LOG(0x1006e40);
            wmi_vring_ba_dis(body, mid);
            break;
        case 0x825:                                 /* WMI_RCP_ADDBA_RESP */
            HOST_CMD_LOG(0x1006e6c);
            wmi_rcp_addba_resp(body, mid);
            break;
        case 0x826:                                 /* WMI_RCP_DELBA */
            HOST_CMD_LOG(0x1006e98);
            wmi_rcp_delba(body, mid);
            break;
        case 0x827:                                 /* WMI_SET_SSID */
            HOST_CMD_LOG(0x1006eec);
            l2mgr_set_ssid(body, mid);
            break;
        case 0x828:                                 /* WMI_GET_SSID */
            HOST_CMD_LOG(0x1006f14);
            wmi_get_ssid(mid, mb);
            break;
        case 0x829:                                 /* WMI_SET_PCP_CHANNEL */
            HOST_CMD_LOG(0x1006f3c);
            wmi_set_pcp_channel(body);
            break;
        case 0x82a:                                 /* WMI_GET_PCP_CHANNEL */
            HOST_CMD_LOG(0x1006f68);
            wmi_get_pcp_channel(mid, mb);
            break;
        case 0x82b:                                 /* WMI_SW_TX_REQ */
            HOST_CMD_LOG(0x10073d0);
            wmi_sw_tx_req(body, mid);
            break;
        case 0x836:                                 /* WMI_BEAMFORMING_MGMT */
            HOST_CMD_LOG(0x1007058);
            wmi_beamforming_mgmt(mb, body, mid);
            break;
        case 0x83a:                                 /* WMI_BF_TRIG */
            HOST_CMD_LOG(0x1007034);
            wmi_trigger_beamforming(body, mid);
            break;
        case 0x842:                                 /* WMI_LINK_MAINTAIN_CFG_WRITE */
            HOST_CMD_LOG(0x1007434);
            wmi_link_maintain_cfg_write(body);
            break;
        case 0x843:                                 /* WMI_LINK_MAINTAIN_CFG_READ */
            HOST_CMD_LOG(0x1007468);
            wmi_link_maintain_cfg_read(body);
            break;
        case 0x849:                                 /* WMI_SET_SECTORS (журнала нет) */
            host_if_set_sectors_hal(mb, body);
            break;
        case 0x853:                                 /* WMI_RF_MGMT */
            HOST_CMD_LOG(0x1007358);
            low_sme_wmi_rf_mgmt_cmd_handler(body);
            break;
        case 0x856:                                 /* WMI_RF_XPM_READ */
            HOST_CMD_LOG(0x1006af0);
            host_if_read_rf_xpm(mb, body);
            break;
        case 0x857:                                 /* WMI_RF_XPM_WRITE */
            HOST_CMD_LOG(0x1006b18);
            host_if_write_rf_xpm(mb, body);
            break;
        case 0x85c:                                 /* WMI_SET_ACTIVE_SILENT_RSSI_TABLE */
            HOST_CMD_LOG(0x1007944);
            wmi_set_active_silent_rssi_table(mb, ((const struct wmi_echo_cmd *)body)->value, mid);   /* {table} */
            break;
        case 0x85d:                                 /* WMI_RF_PWR_ON_DELAY */
            HOST_CMD_LOG(0x1006a8c);
            wmi_rf_pwr_on_delay(mb, body, mid);
            break;
        case 0x85e:                                 /* WMI_SET_HIGH_POWER_TABLE_PARAMS */
            HOST_CMD_LOG(0x1006ab8);
            wmi_set_high_power_table_params(body, mid, mb);
            break;
        case 0x85f:                                 /* WMI_FIXED_SCHEDULING_UL_CONFIG */
            HOST_CMD_LOG(0x1007738);
            wmi_fixed_scheduling_ul_config(mb, body, mid);
            break;
        case 0x862:                                 /* WMI_BF_CTRL (журнала нет) */
            host_if_bf_ctrl_hal(mb, body, mid);
            break;
        case 0x863:                                 /* WMI_NOTIFY_REQ (журнала нет) */
            wmi_notify_req(mb, body);
            break;
        case 0x864:                                 /* WMI_GET_STATUS (журнала нет) */
            host_if_get_status_hal(mb, body, mid);
            break;
        case 0x866:                                 /* WMI_GET_RF_STATUS */
            HOST_CMD_LOG(0x10072a8);
            wmi_get_rf_status(mb, mid);
            break;
        case 0x867:                                 /* WMI_GET_BASEBAND_TYPE */
            HOST_CMD_LOG(0x10072d4);
            wmi_get_baseband_type(mb, mid);
            break;
        case 0x868:                                 /* WMI_VRING_SWITCH_CONFIG */
            HOST_CMD_LOG(0x10076d8);
            wmi_vring_switch_config(mb, body, mid);
            break;
        case 0x900:                                 /* WMI_UNIT_TEST (журнала нет) */
            wmi_ut_handler(mb, body);
            break;
        case 0x910:                                 /* WMI_P2P_CFG (переход 0x8ec34c) */
            HOST_CMD_LOG(0x1006d9c);
            l2mgr_p2p_cfg(body, mid);
            break;
        case 0x911:                                 /* WMI_PORT_ALLOCATE */
            HOST_CMD_LOG(0x1006dc0);
            wmi_port_allocate(body);
            break;
        case 0x913:                                 /* WMI_POWER_MGMT_CFG */
            HOST_CMD_LOG(0x1006cc0);
            wmi_power_mgmt_cfg(body, mid);
            break;
        case 0x914:                                 /* WMI_START_LISTEN (переход 0x8ec3e4) */
            HOST_CMD_LOG(0x1006cec);
            l2mgr_start_listen(mid);
            break;
        case 0x915:                                 /* WMI_START_SEARCH (переход 0x8ec3e8) */
            HOST_CMD_LOG(0x1006d18);
            l2mgr_start_search(mid);
            break;
        case 0x916:                                 /* WMI_DISCOVERY_START (переход 0x8ec3e0) */
            HOST_CMD_LOG(0x1006d44);
            l2mgr_start_discovery(mid);
            break;
        case 0x917:                                 /* WMI_DISCOVERY_STOP (переход 0x8ec3ec) */
            HOST_CMD_LOG(0x1006d70);
            l2mgr_stop_discovery(mid);
            break;
        case 0x918:                                 /* WMI_PCP_START */
            HOST_CMD_LOG(0x1006fe4);
            wmi_pcp_start(body, mid);
            break;
        case 0x919:                                 /* WMI_PCP_STOP */
            HOST_CMD_LOG(0x100700c);
            l2mgr_pcp_stop(mid);
            break;
        case 0x91b:                                 /* WMI_GET_PCP_FACTOR */
            HOST_CMD_LOG(0x1006dec);
            wmi_get_pcp_factor(mid);
            break;
        case 0x91c:                                 /* WMI_PS_DEV_PROFILE_CFG */
            HOST_CMD_LOG(0x10074f8);
            wmi_ps_dev_profile_cfg(body, mid, mb);
            break;
        case 0x921:                                 /* WMI_RS_CFG */
            HOST_CMD_LOG(0x100737c);
            wmi_rs_cfg(mb, body, mid);
            break;
        case 0x922:                                 /* WMI_GET_DETAILED_RS_RES */
            HOST_CMD_LOG(0x10075b4);
            wmi_get_detailed_rs_res(mb, body, mid);
            break;
        case 0x924:                                 /* WMI_BRP_SET_ANT_LIMIT */
            HOST_CMD_LOG(0x10073a0);
            wmi_brp_set_ant_limit(mb, body, mid);
            break;
        case 0x930:                                 /* WMI_SET_MGMT_RETRY_LIMIT */
            HOST_CMD_LOG(0x1007528);
            wmi_set_mgmt_retry_limit(body, mid, mb);
            break;
        case 0x931:                                 /* WMI_GET_MGMT_RETRY_LIMIT */
            HOST_CMD_LOG(0x100755c);
            wmi_get_mgmt_retry_limit(mid, mb);
            break;
        case 0x935:                                 /* WMI_NEW_STA */
            HOST_CMD_LOG(0x1006998);
            l2mgr_new_sta(body, mid, mb);
            break;
        case 0x936:                                 /* WMI_DEL_STA */
            HOST_CMD_LOG(0x1007590);
            l2mgr_del_sta(body, mid, mb);
            break;
        /* WMI_TRAFFIC_DEFERRAL (0x904, в драйвере WMI_TRAFFIC_SUSPEND) и WMI_TRAFFIC_RESUME (0x905) —
         * энергосбережение PCIe вырезано (см. fw/vectors.c pcie_pm_event_unsupported); WMI_UPM_CFG
         * (0x960) — PS 802.11 вырезан (см. fw/action.c psc_req_reject); WMI_AOA_MEAS (0x923), WMI_TOF_* (0x991..0x999) —
         * только SparRAW-pro; здесь
         * default: «команда не поддерживается». */
        case 0x9a0:                                 /* WMI_GET_RF_SECTOR_PARAMS */
            HOST_CMD_LOG(0x10077d0);
            /* Первый запрос — сброс объекта 0x80483c (флаг [0x8004c4] = 1 в fw_data). */
            if (wmi_rf_sector_get_first != 0) {
                wmi_rf_sector_get_first = 0;
                clear_object_48(&wmi_rf_sector_get);
            }
            if (get_rf_sector_params_set(&wmi_rf_sector_get, body, mb) != 0)
                get_rf_sector_params_handle(&wmi_rf_sector_get);
            break;
        case 0x9a1:                                 /* WMI_SET_RF_SECTOR_PARAMS */
            HOST_CMD_LOG(0x1007804);
            if (wmi_rf_sector_set_first != 0) {
                wmi_rf_sector_set_first = 0;
                clear_object_tail(&wmi_rf_sector_set);
            }
            if (set_rf_sector_params_set(&wmi_rf_sector_set, body, mb) != 0)
                set_rf_sector_params_handle(&wmi_rf_sector_set);
            break;
        case 0x9a2: {                               /* WMI_GET_SELECTED_RF_SECTOR_INDEX */
            const struct wmi_get_selected_rf_sector_index_cmd *c = body;
            fw_log_emit2(0x20, 0x1007838, c->cid, c->sector_type);
            if (get_selected_rf_sector_index_set(&rf_sector_sel[RF_SECTOR_SEL_GET], c, mb) != 0)
                lmac_if_send_get_selected_rf_sector_index(&rf_sector_sel[RF_SECTOR_SEL_GET]);
            break;
        }
        case 0x9a3: {                               /* WMI_SET_SELECTED_RF_SECTOR_INDEX */
            const struct wmi_set_selected_rf_sector_index_cmd *c = body;
            fw_log_emit3(0x20, 0x100788c, c->cid, c->sector_type, c->sector_idx);
            if (set_selected_rf_sector_index_set(&rf_sector_sel[RF_SECTOR_SEL_SET], c, mb) != 0)
                lmac_if_send_set_selected_rf_sector_index(&rf_sector_sel[RF_SECTOR_SEL_SET]);
            break;
        }
        case 0x9a4:                                 /* WMI_SET_RF_SECTOR_ON */
            HOST_CMD_LOG(0x10078ec);
            wmi_set_rf_sector_on(body, mb);
            break;
        case 0x9a5:                                 /* WMI_PRIO_TX_SECTORS_ORDER */
            HOST_CMD_LOG(0x1007608);
            wmi_prio_tx_sectors_order(mb, body, mid);
            break;
        case 0x9a6:                                 /* WMI_PRIO_TX_SECTORS_NUMBER */
            HOST_CMD_LOG(0x100763c);
            wmi_prio_tx_sectors_number(mb, body, mid);
            break;
        case 0x9a7:                                 /* WMI_PRIO_TX_SECTORS_SET_DEFAULT_CFG */
            HOST_CMD_LOG(0x1007670);
            wmi_prio_tx_sectors_set_default_cfg(mb, body, mid);
            break;
        case 0x9aa:                                 /* WMI_BF_CONTROL */
            HOST_CMD_LOG(0x100791c);
            wmi_bf_control(body, mb);
            break;
        case WMI_SPARRAW_TDMA_CFG_CMDID:            /* SparRAW: простой TDMA точки (fw/tdma.c) */
            wmi_sparraw_tdma_cfg((const struct wmi_sparraw_tdma_cfg_cmd *)body, mid);
            break;
        case 0xa01:                                 /* WMI_ESE_CFG */
            HOST_CMD_LOG(0x10069bc);
            wmi_ese_cfg(body, mid, mb);
            break;
        case 0xa02:                                 /* WMI_FIXED_SCHEDULING_CONFIG */
            HOST_CMD_LOG(0x1007704);
            wmi_fixed_scheduling_config(mb, body, mid);
            break;
        case 0xa03:                                 /* WMI_ENABLE_FIXED_SCHEDULING */
            HOST_CMD_LOG(0x1007770);
            wmi_enable_fixed_scheduling(mb, body, mid);
            break;
        case 0xa04:                                 /* WMI_SET_MULTI_DIRECTED_OMNIS_CONFIG */
            HOST_CMD_LOG(0x10069e0);
            wmi_set_multi_directed_omnis_config(mb, body, mid);
            break;
        case 0xa05:                                 /* WMI_SET_LONG_RANGE */
            HOST_CMD_LOG(0x10076ac);
            wmi_set_long_range(mb, body, mid);
            break;
        case 0xa06:                                 /* WMI_GET_ASSOC_LIST */
            HOST_CMD_LOG(0x10077a4);
            wmi_get_assoc_list(mb, mid);
            break;
        case 0xa07:                                 /* WMI_GET_CCA_INDICATIONS (журнала нет) */
            wmi_get_cca_indications(mb, mid);
            break;
        case 0xa08:                                 /* WMI_SET_CCA_INDICATIONS_BI_AVG_NUM */
            HOST_CMD_LOG(0x10073f8);
            wmi_set_cca_indications_bi_avg_num(body, mb, mid);
            break;
        case 0xa0e:                                 /* WMI_SET_GRANT_MCS */
            HOST_CMD_LOG(0x1007978);
            wmi_set_grant_mcs(mb, ((const struct wmi_set_grant_mcs_cmd *)body)->mcs);
            break;
        case 0xa0f:                                 /* WMI_SET_AP_SLOT_SIZE */
            HOST_CMD_LOG(0x10079a4);
            wmi_set_ap_slot_size(mb, ((const struct wmi_echo_cmd *)body)->value);   /* {slot_size} */
            break;
        case 0xfff:                                 /* отладочная (журнала нет) */
            wmi_dbg_cmd_fff(body);
            break;
        case 0xf003:                                /* WMI_SET_MAC_ADDRESS (переход 0x8ece1c) */
            HOST_CMD_LOG(0x1006ec0);
            l2mgr_set_mac_address(body, mid);
            break;
        case 0xf007:                                /* WMI_ABORT_SCAN */
            HOST_CMD_LOG(0x1006f94);
            wmi_abort_scan(mid);
            break;
        case 0xf049:                                /* WMI_SET_PASSPHRASE */
            HOST_CMD_LOG(0x1006a1c);
            wmi_set_passphrase_handler(body, mid);
            break;
        case 0xf04d:                                /* WMI_MAC_ADDR_REQ */
            HOST_CMD_LOG(0x1007258);
            wmi_mac_addr_req(mid, mb);
            break;
        case 0xf04e:                                /* WMI_FW_VER */
            HOST_CMD_LOG(0x1007284);
            wmi_fw_ver(mb, mid);
            break;
        case 0xf04f:                                /* WMI_PMC */
            HOST_CMD_LOG(0x1006a48);
            wmi_pmc(body);
            break;
        default:                                    /* 0x8df066 */
            wmi_evt_send_command_not_supported(mb, id, 0, mid);
            break;
        }
    }

    mb->mb.rx.cur->sync = 0;
    lmac_if_evt_fields(&mb->mb.rx);
}
