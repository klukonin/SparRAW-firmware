// SPDX-License-Identifier: AGPL-3.0-or-later
/* TX-путь: tx_desc_init_32 + TX_API completion + mgmt_tx header. .textlate. */
#include "../include/types.h"
#include "../include/wmi.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/conn.h"
#include "../include/mid.h"
#include "../include/stream.h"
#include "../include/vring_schd.h"
#include "../include/ieee80211.h"
#include "../include/sys_cfg.h"




/* mgmt_tx__build_mac_header (0x8d7db8, 60 Б): FC (subtype), Duration и Sequence Control
 * — полуслова (stw_s r14,[r13,0x2] / [r13,0x16]). Прежний порт писал их словами по
 * невыровненным адресам h+2 / h+0x16 (кадр выровнен на 4) — невыровненный доступ к слову
 * ARC600 не поддерживает, а по смыслу задевались бы байты 4..5 / 0x18..0x19. mid — запись
 * mid (наш адрес mid+0xa, BSSID из mid+0x48), src_addr — адрес получателя (Addr1). */
__attribute__((section(".textlate"))) void mgmt_tx_build_mac_header(const struct mid *mid,
                                                                    struct ieee80211_hdr *h,
                                                                    u32 subtype, const u8 *src_addr)
{
    h->fc_b[0] = (u8)(subtype << 4);
    h->fc_b[1] = 0;
    h->duration = 0;
    memcpy_fw(h->addr1.b, src_addr, 6);
    mac_hdr_copy_addr(mid, h->addr2.b);
    mid_copy_bssid(&mid->bss, h->addr3.b);
    h->seq = 0;
}

/* mgmt_tx__begin_frame (0x8e9c7c, 30 Б): MAC-заголовок кадра управления (subtype) от MID
 * mid соединению conn в pl, *len = 0x18. */
u32 mgmt_tx_begin_frame(u32 pl, u32 *len, const struct mid *mid, struct conn *conn, u32 subtype)
{
    mgmt_tx_build_mac_header(mid, (struct ieee80211_hdr *)pl, subtype, conn->peer);
    *len = sizeof(struct ieee80211_hdr);
    return sizeof(struct ieee80211_hdr);
}



/* l2mgr__send_vring_cfg_done (0x8f8e98, 76 Б): WMI_VRING_CFG_DONE (0x1821)
 * {ringid, status, reserved[2], tx_vring_tail_ptr}. */
__attribute__((section(".textlate"))) void l2mgr_send_vring_cfg_done(u32 vring, u32 mac_qid, u32 status, u32 devid)
{
    struct wmi_vring_cfg_done_event *evt = host_if_send_pair();
    evt->tx_vring_tail_ptr = mac_qid;
    evt->ringid = (u8)vring;
    evt->status = (u8)status;
    fw_log_emit1(0x2b, 0x100d954, devid);
    low_sme_send_evt2sw(evt, 0x1821, 8, devid, 0, 0, 0);
}


/* wmi_vring_cfg (0x8fc198, 460 Б): WMI_VRING_CFG_CMDID. cmd — struct wmi_vring_cfg_cmd
 * (wil6210 wmi.h): action (+0), vring_cfg (+4): tx_sw_ring {ring_mem_base, ring_size,
 * max_mpdu_size (+0xe)}, ringid (+0x10), cidxtid (+0x11), encap_trans_type (+0x12),
 * ds_cfg, nwifi_ds_trans_type, mac_ctrl (+0x15), to_resolution (+0x16),
 * agg_max_wsize (+0x17), schd_params. Отказ — WMI_VRING_CFG_DONE со статусом 1
 * (WMI_FW_STATUS_FAILURE); успех отвечает STREAM_MGR. */
__attribute__((section(".textlate"))) void wmi_vring_cfg(void *cmd_p, u32 mid)
{
    const struct wmi_vring_cfg_cmd *cmd = cmd_p;
    const struct wmi_vring_cfg *vc = &cmd->vring_cfg;
    u32 ringid = vc->ringid;
    u32 cidxtid = vc->cidxtid;
    u32 tid = (cidxtid & 0xf0) >> 4;
    u32 cid = cidxtid & 0xf;
    u32 fail_tok;

    if (ringid >= 0xa) {
        fw_sysassert_fatal(0, 0x11da);
        return;
    }
    if (tid >= 7)
        fw_sysassert_fatal(0, 0x11db);              /* vendor продолжает */
    struct conn *conn = conn_mgr_by_cid(cid);
    if (conn == 0) {
        fail_tok = 0x100d994;                       /* нет соединения cid */
        goto fail;
    }
    if (conn->msm.sm.state == 8) {
        fail_tok = 0x100d9d8;
        goto fail;
    }
    if (conn->mlme.sm.state != 2 && conn->mlme.busy == 0) {
        fail_tok = 0x100db40;
        goto fail;
    }

    switch (cmd->action) {
    case 2:                                         /* WMI_VRING_CMD_DEL */
        fw_log_emit2(0x2b, 0x100da20, tid, cid);
        stream_mgr_delete_vring(vc->ringid);
        return;
    case 0: {                                       /* WMI_VRING_CMD_ADD */
        fw_log_emit2(0x2b, 0x100da40, tid, cid);
        struct stream_ctx *ctx = vring_ctx_alloc();
        u32 mpdu = vc->tx_sw_ring.max_mpdu_size;
        u32 mac_ctrl = vc->mac_ctrl;
        u32 to_res = vc->to_resolution;
        fw_log_emit3(0x2b, 0x100da60, vc->encap_trans_type, mpdu, vc->agg_max_wsize);
        fw_log_emit3(0x2b, 0x100daa4, mac_ctrl & 1, to_res & 0x3f, (mac_ctrl >> 1) & 1);
        if (vc->agg_max_wsize == 0 && mpdu > 0x1f28) {
            fw_log_emit2(0x1b, 0x100dadc, mpdu, 0x1f28);
            l2mgr_send_vring_cfg_done(ringid, 0, 1, mid);
            wmi_vring_cfg_with_847b34(ctx);         /* вернуть ctx */
            return;
        }
        struct vring_tbl_entry *entry = vring_tbl_entry_addr(ringid);
        entry->max_mpdu = (u16)mpdu;
        vring_configure_tx(ctx, ringid, conn, (u8)tid, 0, vc->encap_trans_type, to_res & 0x3f,
                           mac_ctrl & 1, 0, 0, 0, 0);
        if (STREAM_MGR_ADD(ctx, vc, mpdu) != 0) {
            fw_log_emit0(0x1b, 0x100db2c);
            wmi_vring_cfg_with_847b34(ctx);
        }
        return;
    }
    default:                                        /* в т. ч. 1 (MODIFY) */
        fw_sysassert_fatal(0, 0x11dc);
        return;
    }

fail:
    fw_log_emit2(0x1b, fail_tok, tid, cid);
    l2mgr_send_vring_cfg_done(ringid, 0, 1, mid);
}
