// SPDX-License-Identifier: AGPL-3.0-or-later
/* Обработчики WMI-команд хоста: BF / секторы / RS и фиксированное расписание
 * (vendor wmi__host_cmd_dispatch 0x8de43c → fw/wmi_cmd.c). Сильные определения на месте
 * слабых заглушек fw/wmi_handlers_todo.c, сигнатуры — include/wmi_handlers.h.
 *
 * BF/секторы/RS: 0x836 (0x8dcfa8), 0x83a (0x8fc11c), 0x849 (0x8dd64c), 0x862 (0x8dd028),
 * 0x921 (0x8dd528), 0x922 (0x8dd310), 0x924 (0x8dd068), 0x9a0..0x9a3 (0x8e5e00/0x8cd104,
 * 0x8e5e84/0x8cd14c, 0x8e5f44/0x8cd198, 0x8e5fb4/0x8cd1c0), 0x9a4 (0x8eceb8),
 * 0x9a5..0x9a7 (0x8ecfec/0x8ecfa0/0x8ecf54), 0x9aa (0x8ec068), 0x85c (0x8e6120),
 * 0x85e (0x8ec3f0), 0xa05 (0x8ecdcc).
 * Расписание: 0xa01 (0x8fbb20), 0xa02 (0x8ec56c), 0xa03 (0x8ec500), 0xa04 (0x8ece20),
 * 0x85f (0x8ec5fc), 0x868 (0x8e7340), 0xa08 (0x8fbbe8), 0xa0e (0x8e66ac), 0xa0f (0x8e6178).
 *
 * Буферы событий/LMAC-команд — из пулов (mem_pool__alloc_locked / lmac_cmd_pool__alloc):
 * там, где vendor пишет не все байты, у vendor остаётся прежнее содержимое слота пула; у нас
 * элемент обнуляет сам mem_pool_alloc_locked (fw/pool.c, единое правило). Такие байты
 * отмечены у каждого сборщика («остаток слота пула»). */
#include "../include/types.h"
#include "../include/ieee80211.h"
#include "../include/hw.h"
#include "../include/mid.h"
#include "../include/arc.h"
#include "../include/wmi_handlers.h"
#include "../include/rf_obj.h"
#include "../include/radio_mgr.h"
#include "../include/vring_schd.h"
#include "../include/fwdata.h"
#include "../include/mbox.h"
#include "../include/conn.h"
#include "../include/calib_engine.h"
#include "../include/lmac_cmd.h"
#include "../include/sys_cfg.h"
#include "../include/sysapi_mgr.h"
#include "../include/link_sm.h"
#include "../include/calib.h"
#include "../include/calib.h"

/* fw_sysassert_fatal у vendor получает blink — у нас адрес возврата (как в vring.c). */
#define caller() __builtin_return_address(0)
/* Шаблон LMAC 0x10 (0x8014b0): vendor пишет его по абсолютным адресам — доступы volatile. */
#define BF_TPL (*(volatile struct lmac_cmd_bf_ctrl *)&lmac_bf_ctrl_tpl)
/* Фиксированное расписание: vendor читает/пишет каждое поле отдельно — через volatile. */
#define FSCHED (*(volatile struct fixed_sched *)&fixed_sched)
#define CCA (*(volatile struct cca_pct_stats *)&cca_pct_stats)


/* u32 из двух полуслов (vendor: ldw_s lo / ldw_s hi; asl 16; or) — тело команды
 * выровнено только на 2. */
static inline u32 ld32h(const u8 *p)
{
    const u16 *h = (const u16 *)p;
    return (u32)h[0] | ((u32)h[1] << 16);
}

/* Поле [lo .. lo+n-1] слова *p = v (bits__set32_* → bf__set_field_word_fw 0x8edcb8:
 * r10 = lo, r11 = n - 1). */
static void bf_set32(u32 *p, u32 lo, u32 n, u32 v)
{
    u32 m = ((1u << n) - 1u) << lo;
    *p = (*p & ~m) | ((v << lo) & m);
}

/* ======================= 0x836 / 0x862 / 0x849: BF и секторы (HAL) ======================= */

/* wmi_beamforming_mgmt (0x8dcfa8, 128 Б): WMI_BEAMFORMING_MGMT — тело команды vendor не
 * читает. LMAC 0x09 {1, 0, 0} (как lmac_if_trigger_bf(0, 0), но flags = mid и без его
 * журнала), затем пустой ответ 0x1836 (длина 0). Четыре журнальные метки hdr 0. */
void wmi_beamforming_mgmt(struct wmi_mbox *mb, const void *cmd, u32 mid)
{
    struct lmac_cmd_trigger_bf *c;
    u8 *p;
    (void)cmd;
    c = lmac_cmd_pool_alloc();
    c->kind = 1;
    c->arg = 0;
    c->cid = 0;
    fw_log_emit0(0, 0x10061f4);
    lmac_if_post_cmd(c, 9, 0xc, mid);        /* r3 = mid (mov_s r3,r15 в слоте) */
    fw_log_emit0(0, 0x10061fc);
    p = (u8 *)mem_pool_alloc_locked(&mb->mb);
    fw_log_emit0(0, 0x1006204);
    wmi_evt_post(mb, p, 0, 0x1836, 0, mid, 0, 0);
    fw_log_emit0(0, 0x100620c);
}

/* host_if__bf_ctrl_hal (0x8dd028, 62 Б): WMI_BF_CTRL — только журнал и пустой ответ
 * 0x1862 (длина 0); тело не читается. */
void host_if_bf_ctrl_hal(struct wmi_mbox *mb, const void *cmd, u32 mid)
{
    u8 *p;
    (void)cmd;
    fw_log_emit0(0x25, 0x1006278);
    p = (u8 *)mem_pool_alloc_locked(&mb->mb);
    wmi_evt_post(mb, p, 0, 0x1862, 0, mid, 0, 0);
}

/* lmac_if__send_sta_cfg_05_b (0x8dc380, 68 Б): LMAC 0x05 (0x28 Б) из пула 0x804280:
 * op = 2, cid = a0, tx_sector = a1, tx_rf = a2, rx_sector = a3, rx_rf = a4, omni_sector = 0xffff.
 * Прочие байты vendor не пишет (у vendor — остаток слота пула, у нас нули (mem_pool_alloc_locked обнуляет)). */
static void bf_lmac_send_sta_cfg_05(u32 a0, u32 a1, u32 a2, u32 a3, u32 a4)
{
    struct lmac_cmd_sta_cfg *b = mem_pool_alloc_locked(&lmac_mbox.mb);
    b->op = 2;
    b->cid = (u8)a0;
    b->tx_sector = (u16)a1;
    b->tx_rf = (u8)a2;
    b->rx_sector = (u16)a3;
    b->rx_rf = (u8)a4;
    b->omni_sector = 0xffff;
    lmac_if_post_cmd(b, 5, 0x28, 0);
}

/* host_if__set_sectors_hal (0x8dd64c, 134 Б): WMI_SET_SECTORS {u32 cid?, u32 a, u32 b}:
 * поля a/b — сектор = биты 4..18 (lsr 4, bmsk 0xe), RF = биты 0..3. Журнал и LMAC 0x05.
 * Ответа хосту vendor не шлёт (r0 = ящик не используется). */
void host_if_set_sectors_hal(struct wmi_mbox *mb, const struct wmi_set_sectors_cmd *cmd)
{
    u32 w4, w8;
    (void)mb;
    fw_log_emit0(0x25, 0x1006214);
    fw_log_emit1(0x25, 0x100622c, cmd->cid);
    fw_log_emit1(0x25, 0x1006238, (cmd->sector_rf[0] >> 4) & 0x7fffu);
    fw_log_emit1(0x25, 0x1006248, cmd->sector_rf[0] & 0xfu);
    fw_log_emit1(0x25, 0x1006258, (cmd->sector_rf[1] >> 4) & 0x7fffu);
    fw_log_emit1(0x25, 0x1006268, cmd->sector_rf[1] & 0xfu);
    w4 = cmd->sector_rf[0];
    w8 = cmd->sector_rf[1];
    bf_lmac_send_sta_cfg_05(cmd->cid, (w4 >> 4) & 0x7fffu, w4 & 0xfu,
                            (w8 >> 4) & 0x7fffu, w8 & 0xfu);
}

/* ======================= 0x83a: WMI_BF_TRIG ======================= */

/* wmi_trigger_beamforming_cmdid (0x8fc11c, 122 Б): тип [0] (u32): 0 — по MAC пира
 * ([0xc], 6 Б) найти запись mid-списка и lmac_if_trigger_bf(её cid, 0); 1 — по cid [4]:
 * lmac_if_trigger_bf(cid, 1); 2 — ассерт 0x11e0 (0x8f << 5). Ответа хосту нет.
 * mid-список берётся до разбора типа (vendor: всегда). */
void wmi_trigger_beamforming(const struct wmi_bf_trig_cmd *cmd, u32 mid)
{
    struct mid *ml = mid_list_by_mid_fw(mid);
    u32 t = cmd->bf_type;

    if (t == 0) {
        struct conn *e;
        fw_log_emit2(0x2b, 0x100de84, cmd->dst_mac_hi, cmd->dst_mac_lo);
        e = mid_list_find_by(ml, cmd->dst_mac);
        if (e == 0) {
            fw_log_emit0(0x1b, 0x100dea8);             /* hdr 0x1b (не 0x2b) — как у vendor */
            return;
        }
        lmac_if_trigger_bf(e->cid, 0);
    } else if (t == 1) {
        fw_log_emit1(0x2b, 0x100de6c, cmd->cid32);
        lmac_if_trigger_bf(cmd->cid, 1);
    } else if (t == 2) {
        /* vendor: mov.eq r0,blink — blink здесь уже от bl mid_list__by_mid_fw */
        fw_sysassert_fatal(caller(), 0x8f << 5);
    }
}

/* ======================= 0x921 / 0x922: RS ======================= */

/* lmac_if_send_cmd_0x13 (0x8dbbb4, 48 Б): LMAC 0x13 (0x28 Б) {cid, a1, 0x26 Б из src}.
 * Копия static из link_sm.c (там static). */
static void bf_lmac_send_cmd_0x13(u32 cid, u32 a1, const u8 *src)
{
    struct lmac_cmd_rs_cfg *b = lmac_cmd_pool_alloc();
    b->cid = (u8)cid;
    b->enable = (u8)a1;
    memcpy_fw(b->cfg, src, 0x26);
    lmac_if_post_cmd(b, 0x13, 0x28, 0);
}

/* rs_cfg__validate (0x8dd5ac, 158 Б): cid [0] < 8; [0x1c], [0x1d] и 13 байт [2..0xe] —
 * не больше 100 (знаковое сравнение ldb-значений, т. е. 0..255 > 100 — ошибка);
 * u32 [0x24] & 0x220 = 0 (bic.f с -545); для u32 [0x20]: 32 - (индекс старшего бита)
 * (norm + rsub 0x1e; бит 31 → 31; 0 → norm 0x1f → -1) ≥ [0x1e] (без знака).
 * Ошибка — журнал (hdr 5) и 0. obj (r0) не читается. */
static u32 rs_cfg_validate(const struct wmi_rs_cfg_cmd *c)
{
    const struct wmi_rs_cfg *r = &c->rs_cfg;
    u32 i, v, msb;
    if (c->cid >= 8) {
        fw_log_emit1(5, 0x1006618, c->cid);
        return 0;
    }
    if ((s32)r->stop_th > 100) {
        fw_log_emit1(5, 0x1006638, r->stop_th);
        return 0;
    }
    if ((s32)r->mcs1_fail_th > 100) {
        fw_log_emit1(5, 0x1006654, r->mcs1_fail_th);
        return 0;
    }
    for (i = 0; (s32)i < WMI_NUM_MCS; i++) {
        if ((s32)r->per_threshold[i] > 100) {
            fw_log_emit1(5, 0x1006674, r->per_threshold[i]);
            return 0;
        }
    }
    v = ld32h((const u8 *)r->mcs_en_vec);
    if ((v & ~0xfffffddfu) != 0) {                 /* bic.f r12,r12,-545 */
        fw_log_emit1(5, 0x1006690, v);
        return 0;
    }
    v = ld32h((const u8 *)r->back_failure_mask);
    msb = (v & 0x80000000u) ? 0x1fu : 0x1eu - arc_norm(v);
    if (0x20u - msb < r->max_back_failure_th) {    /* brhs r13,r3 → годно */
        fw_log_emit2(5, 0x10066ac, v, r->max_back_failure_th);
        return 0;
    }
    return 1;
}

/* wmi_rs_cfg (0x8dd528, 132 Б): WMI_RS_CFG {cid, rs_enable, …}: проверка, при годности и
 * наличии станции cid — LMAC 0x13 {cid, [1], 0x26 Б с [2]}, статус 0; иначе 1.
 * Ответ 0x1921 (4 Б): [0] = cid, [1] = статус. */
void wmi_rs_cfg(struct wmi_mbox *mb, const struct wmi_rs_cfg_cmd *cmd, u32 mid)
{
    u32 st = 1;
    struct wmi_rs_cfg_done_event *p;
    fw_log_emit1(0x25, 0x100622c, cmd->cid);
    fw_log_emit1(0x25, 0x10066f4, cmd->rs_enable);
    if (rs_cfg_validate(cmd) == 1 && conn_mgr_by_cid(cmd->cid) != 0) {
        bf_lmac_send_cmd_0x13(cmd->cid, cmd->rs_enable, (const u8 *)&cmd->rs_cfg);
        st = 0;
    }
    p = mem_pool_alloc_locked(&mb->mb);
    memset0_words(p, sizeof(*p));
    p->status = (u8)st;
    p->cid = cmd->cid;
    wmi_evt_post(mb, p, 0, 0x1921, sizeof(*p), mid, 0, 0);
}

/* wmi_get_detailed_rs_res (0x8dd310, 182 Б): ответ 0x1922 (0x24 Б): [0] = cid, [1] =
 * статус (1 — нет данных), [2..0x20] — 0x1f Б результата RS станции (rs__copy_detailed_
 * result 0x8ccb48: статистика MCS lm_if, conn + 0x70 + 0x50). Копия берётся, только если u32 по смещению 26
 * результата ненулевой. */
void wmi_get_detailed_rs_res(struct wmi_mbox *mb, const struct wmi_get_detailed_rs_res_cmd *cmd, u32 mid)
{
    struct wmi_get_detailed_rs_res_event *p = mem_pool_alloc_locked(&mb->mb);
    union { u32 w[8]; u16 h[16]; u8 b[32]; } res;  /* vendor: sp+4, 0x1f Б (копируются все) */
    struct conn *conn;

    memset0_words(p, sizeof(*p));
    p->cid = cmd->cid;
    p->status = 1;
    if (cmd->cid >= 8) {
        fw_log_emit1(5, 0x1006618, cmd->cid);
    } else {
        fw_log_emit1(0x25, 0x1006798, cmd->cid);
        conn = conn_mgr_by_cid(cmd->cid);
        if (conn != 0) {
            fw_log_emit1(0x25, 0x10067b0, conn->cid);
            memcpy_fw(res.b, conn->lm.mcs_total, sizeof(struct wmi_rs_results));   /* 0x8ccb48 */
            /* tsf результата (+0x1a): ldh [sp,30] | ldh [sp,32] << 16 */
            if (((u32)res.h[13] | ((u32)res.h[14] << 16)) != 0) {
                memcpy_fw(&p->rs_results, res.b, sizeof(p->rs_results));
                p->status = 0;
            }
        }
    }
    fw_log_emit1(0x25, 0x10067c0, p->cid);
    wmi_evt_post(mb, p, 0, 0x1922, sizeof(*p), mid, 0, 0);
}

/* ======================= 0x924: WMI_BRP_SET_ANT_LIMIT ======================= */

/* ant_limit__validate (0x8dd0d0, 94 Б): cid [0] < 8, режим [1] < 3; для режимов 1/2 —
 * лимит [2] ≠ 0 и не больше числа бит маски [0x85776c + 4·mid] (vendor индексирует
 * таблицу аргументом r2 = mid вызывающего). Ошибка — журнал hdr 5 и 0. */
static u32 ant_limit_validate(const struct wmi_brp_set_ant_limit_cmd *b, u32 mid)
{
    if (b->cid >= 8) {
        fw_log_emit1(5, 0x1006704, b->cid);
        return 0;
    }
    if (b->limit_mode >= 3) {
        fw_log_emit1(5, 0x1006720, b->limit_mode);
        return 0;
    }
    if (b->limit_mode == 1 || b->limit_mode == 2) {
        u32 m = VOL(fwsh_sets.brp_cfg_mask[mid]);
        u32 n = 0;
        while (m != 0) {
            m &= m - 1;
            n = (u16)(n + 1);
        }
        if (b->ant_limit == 0 || n < b->ant_limit) {
            fw_log_emit1(5, 0x1006740, b->ant_limit);
            return 0;
        }
    }
    return 1;
}

/* wmi_brp__alloc_and_store (0x8db598, 36 Б): LMAC 0x32 (3 Б) {cid, режим, лимит}. */
static void wmi_brp_alloc_and_store(u32 a, u32 b, u32 c)
{
    struct lmac_cmd_sta_byte2 *p = lmac_cmd_pool_alloc();
    p->cid = (u8)a;
    p->mode = (u8)b;
    p->val = (u8)c;
    lmac_if_post_cmd(p, 0x32, 3, 0);
}

/* wmi_brp_set_ant_limit (0x8dd068, 102 Б): проверка → LMAC 0x32, статус 0, иначе 1;
 * ответ 0x1924 (4 Б) {статус}. */
void wmi_brp_set_ant_limit(struct wmi_mbox *mb, const struct wmi_brp_set_ant_limit_cmd *cmd, u32 mid)
{
    u32 st = 1;
    struct wmi_status_event *p;
    if (ant_limit_validate(cmd, mid) == 1) {
        wmi_brp_alloc_and_store(cmd->cid, cmd->limit_mode, cmd->ant_limit);
        st = 0;
    }
    p = mem_pool_alloc_locked(&mb->mb);
    memset0_words(p, sizeof(*p));
    p->status = (u8)st;
    fw_log_emit1(0x25, 0x100675c, st & 0xffu);
    wmi_evt_post(mb, p, 0, 0x1924, sizeof(*p), mid, 0, 0);
}

/* ======================= 0x9a0 / 0x9a1: параметры RF-сектора ======================= */

/* Проверка запроса get/set (0x8c6040 / 0x8c60d0, по 144 Б, отличаются журналом и кодом
 * ассерта): {u16 сектор, u8 тип, u8 маска RF}. Нет тела или ящика — журнал hdr 0 +
 * ассерт, проверка продолжается. Тип не 0/1 — сразу 0; сектор ≥ 64 (знаково) или маска
 * не пересекается с RF платы — 0 после журнала. */
static u32 rf_sector_params_check(const struct wmi_get_rf_sector_params_cmd *b, const struct wmi_mbox *mb,
                                  const u32 *tok, u32 code)
{
    u32 ok, mask;
    if (b == 0 || mb == 0) {
        fw_log_emit3(0, tok[0], (u32)b, (u32)mb, 0);
        fw_sysassert_fatal(caller(), code);
    }
    if (b->sector_type != 0 && b->sector_type != 1) {
        fw_log_emit3(0x25, tok[1], b->sector_type, 0, 1);
        return 0;
    }
    ok = 1;
    if ((s32)b->sector_idx >= 0x40) {
        fw_log_emit2(0x25, tok[2], b->sector_idx, 0x40);
        ok = 0;
    }
    mask = rf_cfg_get_rf_mask_45e(&rf_obj);
    if ((b->rf_modules_vec & mask) == 0) {
        fw_log_emit2(0x25, tok[3], b->rf_modules_vec, mask);
        ok = 0;
    }
    return ok;
}

static const u32 get_rf_sector_tok[4] = { 0x1007d78, 0x1007d00, 0x1007dec, 0x1007e58 };
static const u32 set_rf_sector_tok[4] = { 0x10081d0, 0x1008160, 0x1008244, 0x10082ac };

/* Запросы, ждущие радио (include/wmi.h; в образе нули). */
/* vendor 0x80483c */
FWDATA(80483c) struct wmi_rf_sector_get_req wmi_rf_sector_get = { 0 };
/* vendor 0x804848 */
FWDATA(804848) struct wmi_rf_sector_set_req wmi_rf_sector_set = { 0 };

/* wmi_handler_get_rf_sector_params::set (0x8e5e00, 130 Б): self = wmi_rf_sector_get
 * (0x80483c). Занят (radio ≠ 0) — статус 2; проверка не прошла — 1; иначе запомнить
 * запрос и ящик, вернуть 1 (диспетчер зовёт ::handle).
 * Ошибка — ответ 0x19a0 (208 Б нулей, [0] = статус), mid 0, возврат 0. */
u32 get_rf_sector_params_set(struct wmi_rf_sector_get_req *self,
                             const struct wmi_get_rf_sector_params_cmd *cmd, struct wmi_mbox *mb)
{
    u32 st = 0;
    struct wmi_get_rf_sector_params_done_event *p;
    if (self->radio != 0) {
        fw_log_emit1(0x25, 0x1007f08, (u32)self->radio);
        st = 2;
    } else if (rf_sector_params_check(cmd, mb, get_rf_sector_tok, 0x1469) != 0) {
        memcpy_fw((void *)&self->req, cmd, sizeof(*cmd));
        self->radio = 0;
        self->mbox = mb;
    } else {
        fw_log_emit0(0x25, 0x1007f8c);
        st = 1;
    }
    if (st == 0)
        return 1;
    p = mem_pool_alloc_locked(&mb->mb);
    memset0_words(p, sizeof(*p));
    p->status = (u8)st;
    wmi_evt_post(mb, p, 0, 0xcd << 5, sizeof(*p), 0, 0, 0);   /* 0x19a0 */
    return 0;
}

/* rfc_read_sector_params (0x8d3678, 304 Б): шесть RF-полей строки idx (шаг 192 бита) в
 * банке sel ? 0x8000 : 0x10000 — смещения 0x00/0x20/0x60/0x40/0xa0/0x80 (адрес поля =
 * (бит >> 3) & ~3), чтение — пара к hwd__program_rf_regs_seq. */
void rfc_read_sector_params(u32 rf, u32 idx, u32 sel, u32 *o0, u32 *o1, u32 *o2,
                                   u32 *o3, u32 *o4, u32 *o5)
{
    u32 b = ((idx << 6) * 3u) + (sel != 0 ? 0x8000u : 0x10000u);   /* asl 6; add1 */
    *o0 = hwd_rfc_read_rgf(rf, ((b + 0x00) >> 3) & ~3u);
    *o1 = hwd_rfc_read_rgf(rf, ((b + 0x20) >> 3) & ~3u);
    *o2 = hwd_rfc_read_rgf(rf, ((b + 0x60) >> 3) & ~3u);
    *o3 = hwd_rfc_read_rgf(rf, ((b + 0x40) >> 3) & ~3u);
    *o4 = hwd_rfc_read_rgf(rf, ((b + 0xa0) >> 3) & ~3u);
    *o5 = hwd_rfc_read_rgf(rf, ((b + 0x80) >> 3) & ~3u);
}

/* 0x8021b0: начальные шесть слов сектора (нули) для get_rf_sector_params_radio_locked
 * (vendor memcpy с 0x8021b0, затем rfc_read_sector_params перезаписывает все). */
FWDATA(8021b0) const u32 rf_sector_params_tpl[6] = { 0, 0, 0, 0, 0, 0 };

/* wmi_handler_get_rf_sector_params::on_radio_locked_cb (0x8cd2dc, 306 Б): радио
 * захвачено — для каждого RF из маски запроса (∩ RF платы): DVS RFCA на этот RF (прежняя
 * маска — при первом), шесть слов сектора → ответ [0x10 + 24·rf]; затем вернуть маску
 * DVS, TSF в [8], ответ 0x19a0 (208 Б, статус 0) в запомненный ящик. */
static void get_rf_sector_params_radio_locked(struct wmi_rf_sector_get_req *self)
{
    struct wmi_get_rf_sector_params_done_event *p = mem_pool_alloc_locked(&self->mbox->mb);
    u32 it, rf;
    u8 *old_out;
    u32 v[6];                                      /* vendor: sp+0xc..0x23 */
    u8 old = 0;

    memset0_words(p, sizeof(*p));
    old_out = &old;
    field_set_0x00_8e5dfc(&it, self->req.rf_modules_vec & rf_cfg_get_rf_mask_45e(&rf_obj));
    while (bit_iter_has_more(&it)) {
        rf = bitmap_alloc_bit(&it);
        if (rf >= 8)
            fw_sysassert_fatal(caller(), 0x146e);  /* vendor продолжает с этим rf */
        hwd_abif_dvs_rfca_cmd_enable((u8)(1u << rf), old_out);
        old_out = 0;                               /* mov r18,0: прежняя маска — один раз */
        memcpy_fw(v, rf_sector_params_tpl, 0x18);     /* шаблон fw_data, весь перезаписывается */
        rfc_read_sector_params((u8)rf, self->req.sector_idx, self->req.sector_type == 1, &v[0], &v[1],
                               &v[2], &v[3], &v[4], &v[5]);
        memcpy_fw(&p->sectors_info[rf], v, sizeof(p->sectors_info[0]));
        fw_log_emit3(0x20, 0x1008080, rf, self->req.sector_idx, self->req.sector_type);
        fw_log_emit3(0x20, 0x10080f8, v[0], v[1], v[2]);
        fw_log_emit3(0x20, 0x1008128, v[3], v[4], v[5]);
    }
    hwd_abif_dvs_rfca_cmd_enable(old, 0);
    mac_read_tsf64(0, p->tsf, 0);
    p->status = 0;
    wmi_evt_post(self->mbox, p, 0, 0xcd << 5, sizeof(*p), 0, 0, 0);   /* 0x19a0 */
}

/* Колбэк радио-менеджера (0x8df5d4, в коде ::handle как 0x1f5d4): cb(req, self) —
 * обработать, отпустить радио (lock_free), radio = 0. */
static void get_rf_sector_params_radio_cb(struct rm_req *req, u32 arg)
{
    struct wmi_rf_sector_get_req *self = (struct wmi_rf_sector_get_req *)arg;
    get_rf_sector_params_radio_locked(self);
    radio_mgr_call_method_10(req);
    self->radio = 0;
}

/* wmi_handler_get_rf_sector_params::handle (0x8cd104, 70 Б): запросить радио (любой
 * канал 0xffff) с колбэком 0x8df5d4. Уже занят — журнал + ассерт 0x1466, затем запрос
 * всё равно. */
void get_rf_sector_params_handle(struct wmi_rf_sector_get_req *self)
{
    if (self->radio != 0) {
        fw_log_emit3(0, 0x1007fe8, (u32)self->radio, self->req.rf_modules_vec, self->req.sector_idx);
        fw_sysassert_fatal(caller(), 0x1466);
    }
    self->radio = radio_mgr_request(get_rf_sector_params_radio_cb, (u32)self, 0, 0xffff, 0);
}

/* wmi_handler_set_rf_sector_params::set (0x8e5e84, 136 Б): self = wmi_rf_sector_set
 * (0x804848); как get: статус 2 — занят, 1 — проверка; ошибка — ответ 0x19a1
 * (1 Б {статус}), mid 0. */
u32 set_rf_sector_params_set(struct wmi_rf_sector_set_req *self,
                             const struct wmi_set_rf_sector_params_cmd *cmd, struct wmi_mbox *mb)
{
    u32 st = 0;
    struct wmi_status_event *p;
    if (self->radio != 0) {
        fw_log_emit1(0x25, 0x1008354, (u32)self->radio);
        st = 2;
    } else if (rf_sector_params_check((const struct wmi_get_rf_sector_params_cmd *)cmd, mb,
                                      set_rf_sector_tok, 0x1467) != 0) {   /* общий заголовок 4 Б */
        memcpy_fw((void *)&self->req, cmd, sizeof(*cmd));
        self->radio = 0;
        self->mbox = mb;
    } else {
        fw_log_emit0(0x25, 0x10083d8);
        st = 1;
    }
    if (st == 0)
        return 1;
    p = mem_pool_alloc_locked(&mb->mb);
    memset0_words(p, 1);
    p->status = (u8)st;
    wmi_evt_post(mb, p, 0, 0x19a1, 1, 0, 0, 0);
    return 0;
}

/* wmi_handler_set_rf_sector_params::set_rf_sector_params (0x8cd410, 292 Б): для каждого
 * RF из маски — DVS RFCA, запись шести слов [4 + 24·rf] в строку сектора
 * (hwd__program_rf_regs_seq, v6 = 0xff — без команды 0x508), журнал; маску DVS вернуть,
 * ответ 0x19a1 (1 Б, статус 0) в запомненный ящик. */
static void set_rf_sector_params_apply(struct wmi_rf_sector_set_req *self)
{
    struct wmi_status_event *p = mem_pool_alloc_locked(&self->mbox->mb);
    u32 it, rf;
    u8 *old_out;
    const volatile struct wmi_rf_sector_info *e;
    u8 old = 0;

    memset0_words(p, 1);
    old_out = &old;
    field_set_0x00_8e5dfc(&it, self->req.rf_modules_vec & rf_cfg_get_rf_mask_45e(&rf_obj));
    while (bit_iter_has_more(&it)) {
        rf = bitmap_alloc_bit(&it);
        if (rf >= 8)
            fw_sysassert_fatal(caller(), 0x1499);
        hwd_abif_dvs_rfca_cmd_enable((u8)(1u << rf), old_out);
        old_out = 0;                               /* mov_s r14,r21 (= 0) в конце итерации */
        e = &self->req.sectors_info[rf];
        hwd_program_rf_regs_seq((u8)rf, self->req.sector_idx, self->req.sector_type == 1, e->psh_hi,
                                e->psh_lo, e->etype0, e->etype1, e->etype2, e->dtype_swch_off, 0xff);
        fw_log_emit3(0x20, 0x10084cc, rf, self->req.sector_idx, self->req.sector_type);
        fw_log_emit3(0x20, 0x10080f8, e->psh_hi, e->psh_lo, e->etype0);
        fw_log_emit3(0x20, 0x1008128, e->etype1, e->etype2, e->dtype_swch_off);
    }
    hwd_abif_dvs_rfca_cmd_enable(old, 0);
    p->status = 0;
    wmi_evt_post(self->mbox, p, 0, 0x19a1, 1, 0, 0, 0);
}

/* Колбэк радио-менеджера (0x8df5f4, в коде ::handle как 0x1f5f4). */
static void set_rf_sector_params_radio_cb(struct rm_req *req, u32 arg)
{
    struct wmi_rf_sector_set_req *self = (struct wmi_rf_sector_set_req *)arg;
    set_rf_sector_params_apply(self);
    radio_mgr_call_method_10(req);
    self->radio = 0;
}

/* wmi_handler_set_rf_sector_params::handle (0x8cd14c, 74 Б): как get, ассерт 0x1468. */
void set_rf_sector_params_handle(struct wmi_rf_sector_set_req *self)
{
    if (self->radio != 0) {
        fw_log_emit3(0, 0x1008434, (u32)self->radio, self->req.rf_modules_vec, self->req.sector_idx);
        fw_sysassert_fatal(caller(), 0x1468);
    }
    self->radio = radio_mgr_request(set_rf_sector_params_radio_cb, (u32)self, 0, 0xffff, 0);
}

/* ======================= 0x9a2 / 0x9a3: выбранный RF-сектор ======================= */

/* Проверка (0x8c6160, 114 Б / 0x8c61d4, 144 Б): self {[0] запрос 4 Б, [4] ящик — занят}.
 * Статус: 2 — занят (журнал прежнего запроса), 1 — cid [0] ≥ 8 или тип [1] ≥ 2 (для set
 * ещё сектор [2] (u16) > 0x7f и ≠ 0xffff); позднейшая ошибка перекрывает раннюю.
 * Нет тела — журнал hdr 5 + ассерт, проверка продолжается. */
static u32 selected_rf_sector_check(const struct rf_sector_sel_req *self,
                                    const struct wmi_set_selected_rf_sector_index_cmd *b,
                                    const u32 *tok, u32 code, u32 is_set)
{
    u32 st = 0;
    if (b == 0) {
        fw_log_emit0(5, tok[0]);
        fw_sysassert_fatal(caller(), code);
    }
    if (self->mbox != 0) {
        fw_log_emit2(5, tok[1], self->req[0], self->req[1]);
        st = 2;
    }
    if (b->cid >= 8) {
        fw_log_emit2(5, tok[2], b->cid, 7);
        st = 1;
    }
    if (b->sector_type >= 2) {
        fw_log_emit3(5, tok[3], b->sector_type, 0, 1);
        st = 1;
    }
    if (is_set) {
        u32 s = b->sector_idx;
        if ((s32)s > 0x7f && s != 0xffff) {
            fw_log_emit2(5, tok[4], s, 0x7f);
            st = 1;
        }
    }
    return st;
}

static const u32 get_sel_sector_tok[4] = { 0x1008544, 0x10085a0, 0x1008648, 0x10086e4 };
static const u32 set_sel_sector_tok[5] = { 0x1008860, 0x10088bc, 0x1008964, 0x1008a00, 0x1008aa8 };

/* Запросы GET/SET_SELECTED_RF_SECTOR_INDEX, ждущие ответа ucode (include/mbox.h; в образе
 * нули, конструктор 0x8c1a0c — fw/ctors.c). */
/* vendor 0x804914 */
FWDATA(804914) struct rf_sector_sel_req rf_sector_sel[2] = { 0 };

/* wmi_get_selected_rf_sector_index (0x8e5f44, 110 Б): self = rf_sector_sel[GET]. Годно —
 * запомнить запрос и ящик, вернуть 1 (диспетчер шлёт LMAC 0x39; ответ хосту — lmac_evt.c
 * 0x8cd534). Иначе ответ 0x19a2 (0x10 Б, [2] = статус), mid 0, возврат 0. */
u32 get_selected_rf_sector_index_set(struct rf_sector_sel_req *self,
                                     const struct wmi_get_selected_rf_sector_index_cmd *cmd,
                                     struct wmi_mbox *mb)
{
    /* общая часть {cid, sector_type} — как у SET; sector_idx при is_set = 0 не читается */
    u32 st = selected_rf_sector_check(self, (const struct wmi_set_selected_rf_sector_index_cmd *)cmd,
                                      get_sel_sector_tok, 0x146b, 0);
    struct wmi_get_selected_rf_sector_index_done_event *p;
    if (st == 0) {
        memcpy_fw(self->req, cmd, sizeof(*cmd));
        self->mbox = (u32)mb;
        return 1;
    }
    p = mem_pool_alloc_locked(&mb->mb);
    memset0_words(p, sizeof(*p));
    p->status = (u8)st;
    fw_log_emit1(0, 0x100878c, st);
    wmi_evt_post(mb, p, 0, 0x19a2, sizeof(*p), 0, 0, 0);
    return 0;
}

/* wmi_set_selected_rf_sector_index (0x8e5fb4, 110 Б): self = rf_sector_sel[SET], то же;
 * ответ при ошибке 0x19a3 (4 Б, [0] = статус). */
u32 set_selected_rf_sector_index_set(struct rf_sector_sel_req *self,
                                     const struct wmi_set_selected_rf_sector_index_cmd *cmd,
                                     struct wmi_mbox *mb)
{
    u32 st = selected_rf_sector_check(self, cmd, set_sel_sector_tok, 0x146a, 1);
    struct wmi_status_event *p;
    if (st == 0) {
        memcpy_fw(self->req, cmd, sizeof(*cmd));
        self->mbox = (u32)mb;
        return 1;
    }
    p = mem_pool_alloc_locked(&mb->mb);
    memset0_words(p, sizeof(*p));
    p->status = (u8)st;
    fw_log_emit1(0, 0x1008b1c, st);
    wmi_evt_post(mb, p, 0, 0x19a3, sizeof(*p), 0, 0, 0);
    return 0;
}

/* lmac_if_send_get_selected_rf_sector_index (0x8cd198, 38 Б): LMAC 0x39 (4 Б) — запрос. */
void lmac_if_send_get_selected_rf_sector_index(const struct rf_sector_sel_req *self)
{
    void *c = lmac_cmd_pool_alloc();
    memcpy_fw(c, self->req, 4);
    lmac_if_post_cmd(c, 0x39, 4, 0);
}

/* lmac_if_send_set_selected_rf_sector_index (0x8cd1c0, 38 Б): LMAC 0x3a (4 Б). */
void lmac_if_send_set_selected_rf_sector_index(const struct rf_sector_sel_req *self)
{
    void *c = lmac_cmd_pool_alloc();
    memcpy_fw(c, self->req, 4);
    lmac_if_post_cmd(c, 0x3a, 4, 0);
}

/* ======================= 0x9a4..0x9a7: секторы ======================= */

/* wmi_set_rf_sector_on_cmd_handler (0x8eceb8, 100 Б): не поддержано — маска RF платы
 * читается и не используется, ответ 0x19a4 (4 Б) со статусом 3, mid 0. Тело (r0) не
 * читается. */
void wmi_set_rf_sector_on(const void *cmd, struct wmi_mbox *mb)
{
    struct wmi_status_event *p;
    (void)cmd;
    (void)rf_cfg_get_rf_mask_45e(&rf_obj);
    fw_log_emit0(5, 0x1007c18);
    fw_log_emit1(0, 0x1007cb0, 3);
    p = mem_pool_alloc_locked(&mb->mb);
    memset0_words(p, sizeof(*p));
    p->status = 3;
    wmi_evt_post(mb, p, 0, 0x19a4, sizeof(*p), 0, 0, 0);
}

/* lmac_if_set_ss_sectors_order_handler (0x8dc080, 138 Б): {список 0x40 Б, [0x40] тип < 3,
 * [0x41] число < 9} → LMAC 0x35 (0x54 Б): заголовок sector_list (a = 1), [0x4c] = тип,
 * [0x50] = число. Статус 0 / 1. Локальный буфер vendor обнуляет целиком. */
static u32 ss_sectors_order(const struct wmi_prio_tx_sectors_order_cmd *b)
{
    struct ss_cfg_s tmp;
    struct lmac_cmd_ss_order *c;
    memset0_words(&tmp, 0x4c);
    if (b->cid >= 9) {
        fw_log_emit1(0x10, 0x1004cac, b->cid);
        return 1;
    }
    if (b->sector_sweep_type >= 3) {
        fw_log_emit1(0x10, 0x1004cfc, b->sector_sweep_type);
        return 1;
    }
    if (sector_list_validate(&tmp, b->tx_sectors_priority_array, 1, 0) == 0) {
        fw_log_emit0(0x10, 0x1004d64);
        return 1;
    }
    c = lmac_cmd_pool_alloc();
    memcpy_fw(&c->ss, &tmp, 0x4c);
    c->set = b->cid;
    c->target = b->sector_sweep_type;
    lmac_if_post_cmd(c, 0x35, 0x54, 0);       /* 0x51..0x53: у vendor остаток пула, у нас 0 */
    return 0;
}

/* lmac_if_set_ss_sectors_number_handler (0x8dc018, 104 Б): {[0], [1] ≤ 0x40, не оба 0,
 * [2] < 9} → LMAC 0x36 (3 Б, копия тела). */
static u32 ss_sectors_number(const struct wmi_prio_tx_sectors_number_cmd *b)
{
    u8 *c;
    if (b->cid >= 9) {
        fw_log_emit1(0x10, 0x1004e78, b->cid);
        return 1;
    }
    if ((s32)b->txss_number_of_sectors > 0x40 || (s32)b->beacon_number_of_sectors > 0x40) {
        fw_log_emit1(0x10, 0x1004ec8, 0x40);
        return 1;
    }
    if (b->txss_number_of_sectors == 0 && b->beacon_number_of_sectors == 0) {
        fw_log_emit1(0x10, 0x1004f20, 0x40);
        return 1;
    }
    c = (u8 *)lmac_cmd_pool_alloc();
    memcpy_fw(c, b, 3);
    lmac_if_post_cmd(c, 0x36, 3, 0);
    return 0;
}

/* lmac_if_set_ss_sectors_default_cfg_handler (0x8dbfa0, 118 Б): {[0] тип < 3, [1] число
 * < 9} → LMAC 0x35 (0x54 Б) со списком TXSS по умолчанию (sector_list a = b = 0);
 * негодный список — ассерт 0x136b, команда уходит всё равно. */
static u32 ss_sectors_default_cfg(const struct wmi_prio_tx_sectors_set_default_cfg_cmd *b)
{
    struct lmac_cmd_ss_order *c;
    if (b->cid >= 9) {
        fw_log_emit1(0x10, 0x1004db4, b->cid);
        return 1;
    }
    if (b->sector_sweep_type >= 3) {
        fw_log_emit1(0x10, 0x1004e08, b->sector_sweep_type);
        return 1;
    }
    c = lmac_cmd_pool_alloc();
    if (sector_list_validate(&c->ss, rf_if_tx_sectors(&rf_obj), 0, 0) == 0)
        fw_sysassert_fatal(caller(), 0x136b);
    c->set = b->cid;
    c->target = b->sector_sweep_type;
    lmac_if_post_cmd(c, 0x35, 0x54, 0);
    return 0;
}

/* Общий хвост 0x9a5..0x9a7 (0x8ecfec / 0x8ecfa0 / 0x8ecf54, по 76 Б): [0] = статус
 * обработчика, журнал hdr 0x2e, ответ 0x19a5 (4 Б) с mid. Vendor пишет только [0]
 * (байты 1..3 у vendor — остаток слота пула, у нас нули). Все три команды отвечают id 0x19a5
 * (WMI_PRIO_TX_SECTORS_ORDER_EVENTID) — у vendor так в каждой из трёх функций
 * (mov_s r3,0x19a5 по 0x8ecf86, 0x8ecfd2, 0x8ed01e), хотя у NUMBER / SET_DEFAULT_CFG
 * в wil6210 свои id 0x19a6 / 0x19a7: ошибка vendor, сохранена. */
static void prio_tx_sectors_reply(struct wmi_mbox *mb, struct wmi_status_event *p, u32 st, u32 tok,
                                  u32 mid)
{
    p->status = (u8)st;
    fw_log_emit1(0x2e, tok, st & 0xffu);
    wmi_evt_post(mb, p, 0, 0x19a5, sizeof(*p), mid, 0, 0);
}

/* wmi_prio_tx_sectors_order (0x8ecfec, 76 Б). */
void wmi_prio_tx_sectors_order(struct wmi_mbox *mb, const struct wmi_prio_tx_sectors_order_cmd *cmd,
                               u32 mid)
{
    struct wmi_status_event *p = mem_pool_alloc_locked(&mb->mb);
    prio_tx_sectors_reply(mb, p, ss_sectors_order(cmd), 0x10067fc, mid);
}

/* wmi_prio_tx_sectors_number (0x8ecfa0, 76 Б). */
void wmi_prio_tx_sectors_number(struct wmi_mbox *mb, const struct wmi_prio_tx_sectors_number_cmd *cmd,
                                u32 mid)
{
    struct wmi_status_event *p = mem_pool_alloc_locked(&mb->mb);
    prio_tx_sectors_reply(mb, p, ss_sectors_number(cmd), 0x100683c, mid);
}

/* wmi_prio_tx_sectors_set_default_cfg (0x8ecf54, 76 Б). */
void wmi_prio_tx_sectors_set_default_cfg(struct wmi_mbox *mb,
                                         const struct wmi_prio_tx_sectors_set_default_cfg_cmd *cmd,
                                         u32 mid)
{
    struct wmi_status_event *p = mem_pool_alloc_locked(&mb->mb);
    prio_tx_sectors_reply(mb, p, ss_sectors_default_cfg(cmd), 0x100687c, mid);
}

/* ======================= 0x9aa: WMI_BF_CONTROL ======================= */

/* wmi_bf_control (0x8ec068, 284 Б): параметры BF в шаблон LMAC-команды 0x10 (0x8014b0,
 * его же шлёт lm_main_sm::config_lmac_bf_sm): [0xd] = [5], [0xe] = [6]; [0x8003cc]
 * ([gp,0x248]) = [7]; при [8] ≠ 0 — 13 таймаутов (u32 LE с [0x1e], ×1000) в 0x801448;
 * ненулевые [9], [0xa], [0xb], [0x10] → [8], [0xa], [9], [0xb] шаблона; ненулевой u32 [0xc]
 * → [0]. Затем LMAC 0x10 (копия шаблона 0x10 Б) и LMAC 0x14 (u32 [0]); ответ 0x19aa
 * (4 Б, статус 0), mid 0. */
void wmi_bf_control(const u8 *body, struct wmi_mbox *mb)
{
    struct wmi_status_event *p = mem_pool_alloc_locked(&mb->mb);
    u32 i, v;
    struct lmac_cmd_bf_ctrl *c;
    struct lmac_cmd_bf_triggers *t;

    memset0_words(p, 4);
    fw_log_emit3(0x20, 0x1007ba8, body[6], body[5], body[8]);
    BF_TPL.txss_mode = body[5];
    BF_TPL.brp_mode = body[6];
    bf_long_term_enable = body[7];                         /* st.as [gp,146] */
    if (body[8] != 0) {
        for (i = 0; i < 0xd; i++) {
            const u8 *s = body + 0x1e + i * 4;
            v = (u32)s[0] | ((u32)s[1] << 8) | ((u32)s[2] << 16) | ((u32)s[3] << 24);
            maintain_lt_period[i] = v * 1000u;       /* mulu64 → mlo */
        }
    }
    if (body[9] != 0)
        BF_TPL.ctrl_code_tx = body[9];
    if (body[0xa] != 0)
        BF_TPL.ctrl_code_tx_alt = body[0xa];
    if (body[0xb] != 0)
        BF_TPL.ctrl_code_rx = body[0xb];
    if (body[0x10] != 0)
        BF_TPL.ctrl_code_rx_alt = body[0x10];
    v = ld32h(body + 0xc);
    if (v != 0)
        BF_TPL.w0 = v;
    c = lmac_cmd_pool_alloc();
    memcpy_fw(c, &lmac_bf_ctrl_tpl, 0x10);
    lmac_if_post_cmd(c, 0x10, 0x10, 0);
    fw_log_emit1(0x20, 0x1007bf0, ld32h(body));
    t = lmac_cmd_pool_alloc();
    t->triggers = ld32h(body);
    lmac_if_post_cmd(t, 0x14, 4, 0);
    p->status = 0;
    wmi_evt_post(mb, p, 0, 0x19aa, sizeof(*p), 0, 0, 0);
}

/* ======================= 0x85c / 0x85e / 0xa05: таблицы мощности, long range ======================= */

/* calib__start_scheme4 (0x8e6fd4, 112 Б): таблица 1 — calib_silent_rssi_tbl (0x800408) = 0x800d04
 * (calib_srssi_temp_tbl[1])
 * (таблица высокой мощности, rf_cfg__load_800d04); таблица 0 — ассерт 0x1588 (и
 * продолжение без записи). Затем движок 4: [obj+0xd0] = число RF платы, [obj+0x50] = 0,
 * периодический запуск, фрагментов = число RF, пауза 1. Маска движка — слово с полем
 * 20..31 = r1 = 0 (calib__bits_set32_s20_w12 с r1 = 0 после st_s r1,[sp,0]), т. е. 0 —
 * так у vendor (0x8e7012..0x8e701a). */
static void calib_start_scheme4(struct calib_silent_rssi *o, u32 table)
{
    /* volatile: порядок записей calib_count / tbl_rewrite — как у vendor (0x8e7010..0x8e701a). */
    volatile struct calib_silent_rssi *obj = o;
    u32 m, n, w;
    if (table == 0)
        fw_sysassert_fatal(caller(), 0x1588);
    else if (table == 1)
        calib_silent_rssi_tbl = (u8 *)&calib_srssi_temp_tbl[1];   /* таблица высокой мощности */
    m = rf_cfg_get_rf_mask_45e(&rf_obj);
    n = 0;
    while (m != 0) {
        m &= m - 1;
        n = (u16)(n + 1);
    }
    obj->calib_count = 0;
    w = 0;
    obj->tbl_rewrite = (u8)n;
    calib_bits_set32_s20_w12(&w, 0);
    calib_mngr_engine_start(CALIB_ENG_SILENT_RSSI, w, 1, obj->tbl_rewrite, 1, 0, 0, 0);
}

/* wmi_set_active_silent_rssi_table (0x8e6120, 88 Б): объект движка 4 (calib_obj4__reset_
 * d4: [+0xd4] = 0 или 0x3f); таблица 0/1 — calib__start_scheme4, статус 0; иначе 1.
 * Ответ 0x185c (8 Б): [0] = статус (u32), [4] = таблица — пишутся оба слова целиком. */
void wmi_set_active_silent_rssi_table(struct wmi_mbox *mb, u32 value, u32 mid)
{
    struct calib_silent_rssi *o = calib_obj4_reset_d4();
    struct wmi_set_silent_rssi_table_done_event *p = mem_pool_alloc_locked(&mb->mb);
    u32 st = 1;
    p->table = value;
    if (value == 0 || value == 1) {
        calib_start_scheme4(o, value);
        st = 0;
    }
    p->status = st;
    wmi_evt_post(mb, p, 0, 0x185c, sizeof(*p), mid, 0, 0);
}

/* rf_cfg__load_800d04 (0x8e6e8c, 150 Б): таблица высокой мощности из тела команды в
 * 0x800d04 кусками (3, 0x10, 3, 0x20, 3, 0x10, 3, 0x20, 3, 4). Последний кусок: приёмник
 * +0x73, источник +0x74 (add_s r0,0x73 / add2 r1,r14,0x1d) — у приёмника поле после
 * 3-байтового упаковано; так у vendor. */
static void rf_cfg_load_800d04(const struct wmi_set_high_power_table_params_cmd *b)
{
    u8 *d = (u8 *)&calib_srssi_temp_tbl[1];
    memcpy_fw(d, b->tx_dtype_temp, 3);
    memcpy_fw(d + 0x4, b->tx_dtype_conf, 0x10);
    memcpy_fw(d + 0x14, b->tx_etype_temp, 3);
    memcpy_fw(d + 0x18, b->tx_etype_conf, 0x20);
    memcpy_fw(d + 0x38, b->rx_dtype_temp, 3);
    memcpy_fw(d + 0x3c, b->rx_dtype_conf, 0x10);
    memcpy_fw(d + 0x4c, b->rx_etype_temp, 3);
    memcpy_fw(d + 0x50, b->rx_etype_conf, 0x20);
    memcpy_fw(d + 0x70, b->rx_2_tx_temp, 3);
    memcpy_fw(d + 0x73, b->rx_2_tx_offs, 4);
}

/* wmi_set_high_power_table_params (0x8ec3f0, 68 Б): загрузить таблицу, ответ 0x185e
 * (4 Б, статус 0). mid (r1) vendor не использует: ответ с mid 0 (r5 = r2 = 0). */
void wmi_set_high_power_table_params(const struct wmi_set_high_power_table_params_cmd *cmd, u32 mid,
                                     struct wmi_mbox *mb)
{
    struct wmi_status_event *p;
    (void)mid;
    p = mem_pool_alloc_locked(&mb->mb);
    memset0_words(p, sizeof(*p));
    rf_cfg_load_800d04(cmd);
    p->status = 0;
    wmi_evt_post(mb, p, 0, 0x185e, sizeof(*p), 0, 0, 0);
}

/* wmi_set_long_range (0x8ecdcc, 80 Б): тело не читается — всегда «включить»: байт
 * fwsh_long_range (0x85728e) = 1 (stb в слоте задержки bl.d lmac_cmd_pool__alloc при r0 = 0x857280,
 * т. е. ДО вызова; аргумент вызов не читает), LMAC 0x41 (4 Б) — содержимое буфера vendor
 * не пишет (у vendor — остаток слота пула, у нас нули); ответ 0x1a05 (4 Б): пишется только [0] = 0. */
void wmi_set_long_range(struct wmi_mbox *mb, const void *cmd, u32 mid)
{
    void *c;
    struct wmi_status_event *p;
    (void)cmd;
    fwsh_long_range = 1;
    c = lmac_cmd_pool_alloc();
    lmac_if_post_cmd(c, 0x41, 4, 0);
    p = mem_pool_alloc_locked(&mb->mb);
    p->status = 0;
    wmi_evt_post(mb, p, 0, 0x1a05, sizeof(*p), mid, 0, 0);
}

/* ======================= Расписание: 0xa01 (ESE) ======================= */

/* seq__next_nibble (0x8cb818, 44 Б): номер распределения: 0 — для «широковещательного»
 * (не ESE-режим [0x803c10] = 0, [5] = 1, aid-пара 0xff/0xff); иначе текущий полубайт
 * [ssb+4] и его инкремент по модулю 16. */
/* Слот команды читается через volatile: структура выровнена на 4, и без volatile gcc
 * сливает соседние байтовые чтения (src_aid/dest_aid) в одно полуслово — vendor читает
 * байтами (ldb [e,0xe] / ldb [e,0xf]). */
static u32 seq_next_nibble(volatile struct sched_scheme *ssb, const volatile struct wmi_sched_scheme_slot *e)
{
    u32 r;
    if (e->type == 1 && e->dest_aid == 0xff && e->src_aid == 0xff)
        return 0;
    r = ssb->seq;
    ssb->seq = (u8)((r + 1) & 0xfu);
    return r;
}

/* sched__slot_start_offset (0x8ccc48, 50 Б): ESE-режим — начало = накопитель [ssb+0x14],
 * затем накопитель += длительность [6] (u16) + 4000 (add3 500), журнал; иначе — u32 [0]
 * записи команды. */
static u32 sched_slot_start_offset(volatile struct sched_scheme *ssb, const volatile struct wmi_sched_scheme_slot *e)
{
    (void)ssb;                           /* OOB R2 (накопитель начала) — только SparRAW-pro */
    return e->tbtt_offset;
}

/* sched__build_alloc_entry (0x8c2ca4, 84 Б): 15-байтовое поле Allocation IE: шаблон
 * sched_scheme.alloc_tpl (0x805250), [0] биты 0..3 = номер, [4]/[5] = aid-пара [0xe]/[0xf], [6] = start
 * (u32 полусловами), [10] = длительность [6] (u16); → dst. */
static void sched_build_alloc_entry(u32 start, u32 nib, const volatile struct wmi_sched_scheme_slot *e,
                                    u8 *dst)
{
    union { u32 w[4]; u16 h[8]; u8 b[16]; } t;     /* vendor: sp, 16 Б; 15 из шаблона */
    memcpy_fw(t.b, &sched_scheme.alloc_tpl, 0xf);
    bf_set32(&t.w[0], 0, 4, nib & 0xfu);           /* bits__set32_s0_w4 (0x8ed370) */
    /* Allocation Type (B4..B6, 9.4.2.131): SP (0) из команды; прочее — CBAP (1). Vendor тип не
     * переносил — в маяке оставался тип шаблона (CBAP, mid__init_sched_scheme), и любая
     * аллокация, в том числе SP, объявлялась как CBAP (стенд 2026-10-23: таблица станции
     * ctrl 0x91 на SP 0→1 точки). Свою таблицу точка строит с типом из команды. */
    bf_set32(&t.w[0], 4, 3, e->type == 0 ? 0u : 1u);
    t.b[4] = e->src_aid;
    t.h[3] = (u16)start;                           /* [6] */
    t.b[5] = e->dest_aid;
    t.h[4] = (u16)(start >> 16);                   /* [8] */
    t.h[5] = e->duration;                          /* [10] */
    memcpy_fw(dst, t.b, 0xf);
}

/* schedule__build_allocation_entry (0x8c2cf8, 126 Б): слот ESE для своего cid: слово 0
 * {биты 0..3 номер, 4..5 = [5] & 3, бит 6 = 0, бит 7 = (aid [0xe] — свой cid
 * [[ssb+0x10]+8] или 0xff)}, [1] = cid пира, [2]/[3] = aid-пара, [4] = start, [8] =
 * длительность; → ese__slot_table_add([ssb]). */
static void sched_build_allocation_entry(volatile struct sched_scheme *ssb, u32 start, u32 nib,
                                         const volatile struct wmi_sched_scheme_slot *e)
{
    union { u32 w[3]; u16 h[6]; u8 b[12]; } t;
    u32 own, src;
    memset0_words(t.b, 0xc);
    bf_set32(&t.w[0], 0, 4, nib & 0xfu);           /* 0x8ed370 */
    bf_set32(&t.w[0], 4, 2, e->type & 3u);         /* bits__set32_s4_w2 (0x8ed4fc) */
    t.w[0] &= ~(1u << 6);
    own = ssb->mid->aid;
    src = e->src_aid;                              /* vendor: одно ldb на сравнения и аргумент */
    t.w[0] = (t.w[0] & ~(1u << 7)) | ((src == own || src == 0xff) ? (1u << 7) : 0u);
    t.b[1] = (u8)ese_peer_cid_by_aid((struct sched_scheme *)ssb, src, e->dest_aid);
    t.b[2] = e->src_aid;
    t.b[3] = e->dest_aid;
    t.w[1] = start;
    t.h[4] = e->duration;                          /* [8] */
    ese_slot_table_add(ssb->ese, t.b);
}

/* schedule_scheme_builder::build_allocations (0x8c52cc, 298 Б) — из WMI_SCHEDULING_SCHEME
 * {[1] — строить Allocation IE, [2] флаги (u16), [4] число, записи по 20 Б с [0x10]}.
 * Флаг 0 не задан или число 0 — сброс (0x8c68a0) и выход; флаг 2 — сброс перед сборкой.
 * [ssb+0xc] = 1; ESE-режим — накопитель [ssb+0x14] = 3000, номер [ssb+4] = 0. Без IE —
 * [[[ssb]+4]] = 1; с IE — 2 и TX-буфер {0x90, 15·число, …}. Для каждой записи: номер,
 * начало (+ TSF начала BI + BI), поле IE и (если aid-пара наша) слот ESE. С IE и флагом 3
 * — блок IE в кадр (mid__apply_app_ies, тип 0) и add_bcon. Затем schedule_scheme__sum_two.
 * Возврат 0 (не используется). TX-буфер без флага 3 vendor не освобождает (утечка vendor,
 * сохранена). Имя — по адресу: 0x8c68a0 в stubs.c уже занял имя build_allocations. */
static u32 ssb_build_allocations_cmd(struct sched_scheme *ssb_, const struct wmi_scheduling_scheme_cmd *b)
{
    volatile struct sched_scheme *ssb = ssb_;      /* vendor: каждое поле читается заново */
    u32 fl = b->flags;
    u32 n = b->num_allocs;
    u32 tx = 0, base, i, rem, nib, start;
    const struct wmi_sched_scheme_slot *e;

    if (!(fl & 1) || n == 0) {
        schedule_scheme_builder_build_allocations(ssb_);
        return 0;
    }
    if (fl & 4)
        schedule_scheme_builder_build_allocations(ssb_);
    ssb->built = 1;
    ssb->tdma_owned = 0;                           /* расписание хоста — TDMA точки его не трогает (fw/tdma.c) */
    fw_log_emit1(0x2b, 0x1014450, n);
    if (b->ese_advertisment == 0) {
        ((volatile struct ese_sched *)ssb->ese)->tbl->mode = 1;
    } else {
        ((volatile struct ese_sched *)ssb->ese)->tbl->mode = 2;
        tx = TX_API_alloc_tx_payload();
        ((u8 *)tx)[0] = EID_EXT_SCHED;             /* заголовок IE: eid, длина */
        ((u8 *)tx)[1] = (u8)(n * 15u);             /* add2 + add1: 15·n */
    }
    base = mac_get_bi_start_tsf();
    base = mac_get_beacon_interval_us() + base;
    if ((s32)n >= 1) {
        i = 0;
        rem = n;
        do {
            /* &b->allocs[i] байтовой арифметикой: так gcc держит адрес записи в регистре
             * (с индексом массива он пересчитывает 20·i через __mulsi3 на каждом поле) */
            e = (const struct wmi_sched_scheme_slot *)((const u8 *)b->allocs + i * 20u);   /* asl 2; add2 → 20·i */
            nib = seq_next_nibble(ssb, e);
            start = sched_slot_start_offset(ssb, e);
            if (tx != 0)
                sched_build_alloc_entry(start + base, nib, e, (u8 *)(tx + 2 + i * 15u));
            if (cid_pair_matches(ssb_, e->src_aid, e->dest_aid) != 0)
                sched_build_allocation_entry(ssb, start, nib, e);
            rem--;
            i++;
        } while (rem >= 1);
    }
    if (tx != 0 && (b->flags & 8)) {
        mid_apply_app_ies(ssb->mid, 0, (u16)(n * 15u + 2), tx);
        add_bcon(ssb->mid);
    }
    schedule_scheme_sum_two(ssb_);
    return 0;
}

/* wmi_ese_cfg (0x8fbb20, 110 Б): WMI_SCHEDULING_SCHEME — сборщик расписания mid
 * ([mid + 0x290], ld.as [r0,164]). Ответ 0x1a01 (4 Б): [0] = [2] = результат сборки
 * (всегда 0), [1] = [0] тела. */
void wmi_ese_cfg(const struct wmi_scheduling_scheme_cmd *cmd, u32 mid, struct wmi_mbox *mb)
{
    u32 r = ssb_build_allocations_cmd(((volatile struct mid *)mid_list_by_mid_fw(mid))->sched,
                                      cmd);
    struct wmi_scheduling_scheme_event *p = mem_pool_alloc_locked(&mb->mb);
    memset0_words(p, sizeof(*p));
    p->status = (u8)r;
    p->failure_type = (u8)r;
    p->serial_num = cmd->serial_num;
    fw_log_emit2(0x2b, 0x100e2d4, mid, r & 0xffu);
    wmi_evt_post(mb, p, 0, 0x1a01, sizeof(*p), mid, 0, 0);
}

/* ======================= Расписание: фиксированное (0xa02, 0xa03, 0x85f) ======================= */

/* Таблица фиксированного расписания 0x847a3c — struct fixed_sched (include/sched_scheme.h):
 * 13 записей по MCS, длительности 0x847ad8..0x847adf (u16 ×4; virtual_slot_us ≠ 0 —
 * признак настройки), [0xa4] слоты AP, [0xa5] «включено». */

/* wmi_fixed_scheduling_config (0x8ec56c, 144 Б): параметры [0x9c..0xa3] → 0x847ad8..;
 * [0xa4] → [0x847ae0]; 13 записей по 12 Б тела {u8 индекс, a, b, -, u16 c, u16 d, u32 e} →
 * запись по индексу. Индекс не проверяется (до 255 → запись за таблицу на 12·255 Б) —
 * так у vendor. Ответ 0x1a02 (4 Б): пишется только [0] = 0. */
void wmi_fixed_scheduling_config(struct wmi_mbox *mb, const struct wmi_fixed_scheduling_config_cmd *cmd,
                                 u32 mid)
{
    u32 i;
    struct wmi_status_event *p;

    /* vendor адресует хвост от body + 0x80 (add3 r13,r1,0x10) */
    FSCHED.max_sta_rd_ppdu_us = cmd->max_sta_rd_ppdu_duration_in_usec;
    FSCHED.max_sta_grant_ppdu_us = cmd->max_sta_grant_ppdu_duration_in_usec;
    FSCHED.assoc_slot_us = cmd->assoc_slot_duration_in_usec;
    FSCHED.ap_slots_initiate_grant = cmd->number_of_ap_slots_for_initiate_grant;
    FSCHED.virtual_slot_us = cmd->virtual_slot_duration_in_usec;
    for (i = 0; i < WMI_NUM_MCS; i++) {            /* lp_count = 0xd */
        const struct wmi_map_mcs_to_schd_params *s = &cmd->mcs_to_schd_params_map[i];
        volatile struct fixed_sched_mcs *d = &FSCHED.mcs[s->mcs];   /* индекс не проверяется */
        d->time_before_tx_us = s->time_in_usec_before_initiate_tx;
        d->rd_count = s->rd_enabled;
        d->stop_vring_us = s->time_in_usec_to_stop_vring;
        d->flush_to_us = s->flush_to_in_usec;
        d->mac_buff_size = s->mac_buff_size_in_bytes;
    }
    p = mem_pool_alloc_locked(&mb->mb);
    p->status = 0;
    wmi_evt_post(mb, p, 0, 0x1a02, sizeof(*p), mid, 0, 0);
}

/* wmi_fixed_scheduling_ul_config (0x8ec5fc, 142 Б): {s8 индекс, u8 b}: индекс -1 — b во
 * все 13 записей (+1), 0..12 — в одну; иначе статус 1. Ответ 0x185f (4 Б): пишется
 * только [0]. */
void wmi_fixed_scheduling_ul_config(struct wmi_mbox *mb, const struct wmi_fixed_scheduling_ul_config_cmd *cmd,
                                    u32 mid)
{
    struct wmi_status_event *p = mem_pool_alloc_locked(&mb->mb);
    s32 idx;
    u32 i;

    p->status = 0;
    fw_log_emit1(0x20, 0x10068c4, (u32)(s32)cmd->mcs);
    idx = cmd->mcs;
    if (idx == -1) {
        for (i = 0; i < WMI_NUM_MCS; i++)
            FSCHED.mcs[i].rd_count = cmd->rd_count_per_slot;
    } else if (idx >= 0 && idx < WMI_NUM_MCS) {
        FSCHED.mcs[idx].rd_count = cmd->rd_count_per_slot;
    } else {
        p->status = 1;
    }
    wmi_evt_post(mb, p, 0, 0x185f, sizeof(*p), mid, 0, 0);
}

/* sched__init_default_alloc_table (0x8ca388, 334 Б): таблица по умолчанию. memset0_words
 * обнуляет только 12 Б (r1 = 0xc — запись 0); записи 5 и 9 не пишутся (остаются как
 * были) — так у vendor. Значения {a, b, c, d, e}: 1 — {15,1,139,3000,45000},
 * 2 — {15,1,515,3000,69000}, 3 — {15,1,649,3000,76500}, 4 — {15,1,706,3000,76500},
 * 6 — {15,2,776,2000,76500}, 7 — {15,2,819,2000,…}, 8, 10..12 — {15,2,847,2000,76500};
 * параметры 150/300/1000/2000, [0xa4] = 20, [0xa5] = 0. Возврат 0 (не используется). */
static void sched_init_default_alloc_table(void)
{
    static const u16 c_tbl[FIXED_SCHED_MCS_N] = { 0, 0x8b, 515, 649, 706, 0, 776, 819, 847, 0, 847, 847, 847 };
    u32 k;
    volatile struct fixed_sched_mcs *d;

    memset0_words(&fixed_sched.mcs[0], sizeof(struct fixed_sched_mcs));
    for (k = 1; k < FIXED_SCHED_MCS_N; k++) {
        if (k == 5 || k == 9)
            continue;
        d = &FSCHED.mcs[k];
        d->mac_buff_size = (k == 1) ? 0xafc8u : (k == 2) ? 0x10d88u : 0x12ad4u;
        d->stop_vring_us = c_tbl[k];
        d->rd_count = (k < 5) ? 1 : 2;
        d->flush_to_us = (k < 5) ? 0xbb8 : 2000;
        d->time_before_tx_us = 0xf;
    }
    FSCHED.max_sta_rd_ppdu_us = 0x96;
    FSCHED.max_sta_grant_ppdu_us = 300;
    FSCHED.assoc_slot_us = 1000;
    FSCHED.virtual_slot_us = 2000;
    FSCHED.ap_slots_initiate_grant = 0x14;
    FSCHED.enabled = 0;
}

/* ie__scan_buf_10 (0x8e27bc, 76 Б): MACQ-дескриптор типа 2 очереди [e+0xa]: прочитать
 * (16 Б), поле 4..7 слова 0 = 0 (bits__set32_s4_w4 0x8ed520), записать обратно. */
static void ie_scan_buf_10(const struct vring_tbl_entry *e)
{
    u32 d[4];                                      /* заполняется чтением целиком (4 слова) */
    macq_desc_read_typed(d, e->macq, 2, 0, 1, 1, 4);
    bf_set32(&d[0], 4, 4, 0);
    macq_desc_write(d, e->macq, 2, 0, 0, 0, 1, 1);
}

/* fixed_sched__start (0x8c9884, 192 Б): [0x800235] ([gp,177]) = 0; у всех TX-очередей
 * поле 4..7 дескриптора 2 = 0; таблица по умолчанию, если не настроена ([0xa2] = 0);
 * [0x847ae1] = 1 («включено»), [0x857744] = 0x847a3c, [0x800236] = 1; при связи —
 * add_bcon(mid 0); таймауты 8..11 в 0x801448 = 10 000 000; LMAC 0x3e (4 Б — буфер vendor
 * не пишет: у vendor — остаток слота пула, у нас нули); ответ 0x1a03 (4 Б, пишется только [0] = 0), mid 0. */
static void fixed_sched_start(struct wmi_mbox *mb)
{
    u32 i;
    void *c;
    struct wmi_status_event *p;

    rf_chain_sector_desc_f4 = 0;                               /* stb [gp,177] */
    for (i = 0; i < fixed_sched_get_entry_count(); i++)
        ie_scan_buf_10(vring_tbl_entry_addr(i));
    if (FSCHED.virtual_slot_us == 0)
        sched_init_default_alloc_table();
    FSCHED.enabled = 1;
    fwsh_sets.fsched_tbl = &fixed_sched;
    sched_fixed_active = 1;
    if (mid_state_is_2_or_3(0) != 0)
        add_bcon(mid_list_by_mid_fw(0));
    for (i = 8; i < 12; i++)                       /* lp_count 4, r1 от 8 */
        maintain_lt_period[i] = 0x989680;
    c = lmac_cmd_pool_alloc();
    lmac_if_post_cmd(c, 0x3e, 4, 0);
    p = mem_pool_alloc_locked(&mb->mb);
    p->status = 0;
    wmi_evt_post(mb, p, 0, 0x1a03, sizeof(*p), 0, 0, 0);
}

/* hwd_dma__get_8812d8 (0x8d08a4, 28 Б): бит 4 регистра 0x8812d8; если он установлен —
 * *out = биты 16..20. */
static u32 hwd_dma_get_8812d8(u32 *out)
{
    u32 v = MMIO32(HW_DMA_DESCQ0_12D8);
    if (v & (1u << 4))
        *out = (v >> 16) & 0x1fu;
    return (v >> 4) & 1u;
}

/* vring__set_pair_mode (0x8e72fc, 54 Б): режим vring_schd [0x80006c] ([gp,-0x118]);
 * при смене: 1 — сброс 0x804dbc (vt[2]) и карты варианта 0x804e64, иначе — сброс
 * прерываний 0x804dbc (vt[1]). */
static void vring_set_pair_mode(u32 mode)
{
    if (vring_pair_mode == mode)
        return;
    vring_pair_mode = mode;
    if (mode == 1) {
        vring_schd_vt_reset(&vring_schd.base);
        vring_schd_alt_vt_reset(&vring_schd_alt.base);
    } else {
        vring_schd_vt_reset_irq(&vring_schd.base);
    }
}

/* wmi_fixed_sched__apply (0x8c9854, 48 Б): обработчик завершения остановки pring
 * (pring__set_done_handler, у vendor — 0x9854 младшего отображения; у нас — полный
 * адрес): DMA должен быть свободен (бит 4 0x8812d8, иначе ассерт 0x158b), режим пар 1,
 * старт расписания. Первый аргумент (id pring) не читается. */
static void wmi_fixed_sched_apply(u32 id, u32 obj)
{
    u32 out;                                       /* vendor: sp, не читается */
    (void)id;
    if (hwd_dma_get_8812d8(&out) != 0)
        fw_sysassert_fatal(caller(), 0x158b);
    vring_set_pair_mode(1);
    fixed_sched_start((struct wmi_mbox *)obj);
}

/* wmi_enable_fixed_scheduling (0x8ec500, 108 Б): уже включено ([0x847ae1] = 1) — журнал,
 * без ответа. Нет связи — сразу старт. Иначе: обработчик завершения pring =
 * wmi_fixed_sched__apply(obj), vt[7] активного vring_schd (cid пира [mid+36]) — если
 * вернул 0 (ждать нечего), применить сразу. Тело (r1) не читается. */
void wmi_enable_fixed_scheduling(struct wmi_mbox *mb, const void *cmd, u32 mid)
{
    u32 cid;
    struct vring_schd_if *tbl;
    (void)cmd;
    if (FSCHED.enabled == 1) {
        fw_log_emit0(0x10, 0x10068f0);
        return;
    }
    if (mid_state_is_2_or_3(0) == 0) {
        fixed_sched_start(mb);
        return;
    }
    cid = mid_list_by_mid_fw(mid)->cid_mask;
    (void)vring_active_ring_table();               /* vendor: результат не используется */
    pring_set_done_handler(wmi_fixed_sched_apply, (u32)mb);
    tbl = vring_active_ring_table();
    if (tbl->vt->prohibit(tbl, cid) == 0)
        wmi_fixed_sched_apply(0, (u32)mb);
}

/* ======================= Расписание: прочее ======================= */

/* wmi_set_multi_directed_omnis_config_cmd (0x8ece20, 66 Б): [0x800231] ([gp,173]) =
 * [0] тела (0 → 1). Ответ 0x1a04 (4 Б): пишется только [0] = 0. */
void wmi_set_multi_directed_omnis_config(struct wmi_mbox *mb,
                                         const struct wmi_set_multi_directed_omnis_config_cmd *cmd,
                                         u32 mid)
{
    u32 v = cmd->dest_ap_num_directed_omnis;
    struct wmi_status_event *p;
    if ((s32)v <= 0)
        v = 1;
    conn_multi_omni_count = (u8)v;
    p = mem_pool_alloc_locked(&mb->mb);
    p->status = 0;
    wmi_evt_post(mb, p, 0, 0x1a04, sizeof(*p), mid, 0, 0);
}

/* wmi_vring_switch_config (0x8e7340, 74 Б): ненулевые u32 [0] / [4] тела → [0x800074]
 * ([gp,-0x110]) / [0x800070] ([gp,-0x114]); ноль — оставить (vendor перечитывает и пишет
 * то же значение). Ответ 0x1868 (4 Б): пишется только [0] = 0. */
void wmi_vring_switch_config(struct wmi_mbox *mb, const struct wmi_vring_switch_timing_config_cmd *cmd,
                             u32 mid)
{
    struct wmi_status_event *p;
    if (cmd->interval_usec != 0)
        vring_switch_interval_us = cmd->interval_usec;
    if (cmd->idle_th_usec != 0)
        vring_switch_idle_th_us = cmd->idle_th_usec;
    p = mem_pool_alloc_locked(&mb->mb);
    p->status = 0;
    wmi_evt_post(mb, p, 0, 0x1868, sizeof(*p), mid, 0, 0);
}

/* wmi_set_cca_indications_bi_avg_num (0x8fbbe8, 124 Б): новое окно усреднения CCA
 * ([0] ≠ [0x803c1c]) — сброс накопителя cca_pct_stats (0x80426c: суммы, средние = 0,
 * n = 1) и [0x803c1c] = [0]. mid-список берётся и не используется. Ответ 0x1a08
 * (4 Б): пишется только [0] = 0. */
void wmi_set_cca_indications_bi_avg_num(const struct wmi_set_cca_indications_bi_avg_num_cmd *cmd,
                                        struct wmi_mbox *mb, u32 mid)
{
    struct wmi_status_event *p;
    if (dashboard.cfg.cca_bi_avg_num != cmd->bi_number) {
        CCA.sum2 = 0;
        CCA.sum1 = 0;
        CCA.avg2 = 0;
        CCA.avg1 = 0;
        CCA.n = 1;
        dashboard.cfg.cca_bi_avg_num = cmd->bi_number;
    }
    p = mem_pool_alloc_locked(&mb->mb);
    (void)mid_list_by_mid_fw(mid);
    fw_log_emit0(0x2b, 0x100e254);
    p->status = 0;
    fw_log_emit0(0x2b, 0x100e294);
    wmi_evt_post(mb, p, 0, 0x1a08, sizeof(*p), mid, 0, 0);
}

/* wmi_set_grant_mcs (0x8e66ac, 86 Б): MCS 0/1 — LMAC 0x49 (1 Б {mcs}), статус 0; иначе 1.
 * Ответ 0x1a0e (4 Б): пишется только [0]; mid 0. */
void wmi_set_grant_mcs(struct wmi_mbox *mb, u32 value)
{
    struct wmi_status_event *p = mem_pool_alloc_locked(&mb->mb);
    if (value == 0 || value == 1) {
        struct lmac_cmd_u8 *c;
        p->status = 0;
        c = lmac_cmd_pool_alloc();
        c->val = (u8)value;
        lmac_if_post_cmd(c, 0x49, 1, 0);
    } else {
        p->status = 1;
    }
    wmi_evt_post(mb, p, 0, 0x1a0e, sizeof(*p), 0, 0, 0);
}

/* wmi_set_ap_slot_size (0x8e6178, 70 Б): LMAC 0x4a (4 Б {размер}); ответ 0x1a0f (4 Б),
 * mid 0. Тело ответа vendor не пишет вовсе (r15 — буфер пула, в него ни одной записи до
 * wmi_evt__post по 0x8e61b2) — статус у vendor = остаток слота пула (ошибка vendor); у нас
 * статус 0 (mem_pool_alloc_locked обнуляет). */
void wmi_set_ap_slot_size(struct wmi_mbox *mb, u32 value)
{
    struct wmi_status_event *p = mem_pool_alloc_locked(&mb->mb);
    struct lmac_cmd_u32 *c = lmac_cmd_pool_alloc();
    c->val = value;
    lmac_if_post_cmd(c, 0x4a, 4, 0);
    wmi_evt_post(mb, p, 0, 0x1a0f, sizeof(*p), 0, 0, 0);
}
