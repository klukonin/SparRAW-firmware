// SPDX-License-Identifier: AGPL-3.0-or-later
/* Записи mid (сетевые интерфейсы fw): открытие, начальная настройка, список mid_list.
 * mid 0 создаёт l2mgr__init (0x8f55b8) через l2mgr__mac_started_log (0x8f972c).
 *
 * Запись mid (struct mid, include/mid.h) — элемент пула mid_pool (1 × 0x2b0, память
 * mid_recs); узел списка mid_list — в начале записи. Битовая карта открытых mid — байт
 * [gp,0xd5] = 0x800259. */
#include "../include/types.h"
#include "../include/ieee80211.h"
#include "../include/hw.h"
#include "../include/bitfield.h"
#include "../include/conn.h"
#include "../include/fwdata.h"
#include "../include/mid.h"
#include "../include/sys_cfg.h"


#define MID_BITMAP      (mid_open_bitmap)   /* [gp,0xd5]: бит на открытый mid */
#define SCHED_SCHEME    (&sched_scheme)   /* mid__sched_obj (0x8ccb7c): 0x805234 */

/* Список открытых записей mid (0x804e70), пул записей (0x804e7c) и его память (0x804e90);
 * в образе — нули, строит mid_ctx__init_pools (0x8d91f4, fw/l2mgr.c). */
FWDATA(804e70) struct llist mid_list = { 0 };
FWDATA(804e7c) struct mem_pool mid_pool = { 0 };
FWDATA(804e90) struct mid mid_recs[MID_RECS_N] = { 0 };

/* Пул dband-инфо (0x805524) и его память (0x805538, 0x10 × 0x4c Б): mid__init_scan_and_pools
 * (0x8d9660), alloc_dband_info (0x8f0cf8). В образе — нули. */
FWDATA(805524) struct mem_pool dband_info_pool = { 0 };
FWDATA(805538) u8 dband_info_mem[DBAND_INFO_N][DBAND_INFO_SIZE] = { { 0 } };

/* Таблица методов объекта discovery (0x80070c; ставит ctor 0x8c1ad4 — fw/ctors.c). */
FWDATA(80070c) const struct mid_disc_vt mid_disc_vtbl = {
    .rsv0 = 0,
    .rx_pkt = discovery_rx_pkt_handler,
};

/* Поле [shift, shift+width) LE-полуслова по невыровненному адресу — vendor bf-хелпер
 * 0x8edc34 (побайтно). */
static void bf_set16_unaligned(u32 addr, unsigned shift, unsigned width, u32 v)
{
    u8 *p = (u8 *)addr;
    u32 w = bf_put((u32)p[0] | ((u32)p[1] << 8), shift, width, v);
    p[0] = (u8)w;
    p[1] = (u8)(w >> 8);
}

/* ---------------- объекты, создаваемые с записью ---------------- */

/* obj_vt8030f4__ctor (0x8f532c, 36 Б): автомат find_sm с описателем 0x8030f4, владелец a. */
static void obj_vt8030f4_ctor(struct find_sm *o, struct find_mngr *a)
{
    basic_sm_bind_descriptor(o, &find_sm_desc);
    o->owner = a;
    o->req = 0;
    o->hdr.trace = 1;
}

/* channels_switch_sm::ctor (obj_vt802fb4__ctor 0x8d9058, 44 Б): автомат каналов с описателем
 * 0x802fb4 для scan_mngr a и записи mid b. */
static void obj_vt802fb4_ctor(struct channels_switch_sm *o, struct scan_mngr *a, struct mid *b)
{
    basic_sm_bind_descriptor(o, &channels_switch_sm_desc);
    o->scan = a;
    o->cur = 0;
    o->mid = b;
    o->alloc_tmr = 0;
    o->scan_tmr = 0;
    o->hdr.trace = 1;
}

/* radio_req__addr_of (0x8f3698, 16 Б; vendor-имя неточно): объект scan_mngr записи mid i —
 * 0x8052ec + 0x228·i. */
struct scan_mngr *radio_req_addr_of(u32 i)
{
    return &scan_mngrs[i];
}

/* scan_mngr__entry_addr (0x8cc6a4, 16 Б): автомат каналов записи mid i — 0x842d00 + 0x24·i.
 * noinline — как у vendor (отдельная функция): иначе gcc -Os, зная адрес &scan_cs_sms[i],
 * пересчитывает i·0x24 (__mulsi3) после вызова в scan_mngr_init. */
__attribute__((noinline)) struct channels_switch_sm *scan_mngr_entry_addr(u32 i)
{
    return &scan_cs_sms[i];
}

/* scan_mngr__init (0x8f1cb8, 36 Б): o — объект scan_mngr записи mid e. */
void scan_mngr_init(struct scan_mngr *o, struct mid *e)
{
    struct channels_switch_sm *x = scan_mngr_entry_addr(e->id);
    o->cs = x;
    obj_vt802fb4_ctor(x, o, e);
    o->mid = e;
}

/* mid__init_find_sm (0x8d9588, 44 Б). Запись mid 0 к этому моменту ещё не в списке —
 * x->mid = 0 (как у vendor). */
static void mid_init_find_sm(struct find_mngr *x)
{
    obj_vt8030f4_ctor(&x->sm, x);
    x->mid = mid_list_by_mid_fw(0);
    x->quiet = 1;
    x->active = 0;
    x->channel = scan_find_default_channel;   /* ldb_s [gp,188] */
    x->timer = 0;
    x->bcon_added = 0;
}

/* mid__init_scan_and_pools (0x8d9660, 96 Б): объект discovery записи e. */
static void mid_init_scan_and_pools(struct mid_disc *obj, struct mid *e)
{
    volatile u32 *z = (volatile u32 *)&mgmt_stats;
    u32 i;
    obj->mid = e;
    for (i = 0; i < sizeof(mgmt_stats) / 4; i++)   /* 0x843158..0x843187 */
        z[i] = 0;
    obj->scan = radio_req_addr_of(e->id);
    scan_mngr_init(obj->scan, e);
    obj->scan->active = 0;
    mid_init_find_sm(&obj->find);
    mem_pool_init(&dband_info_pool, dband_info_mem, DBAND_INFO_SIZE, DBAND_INFO_N);
}

/* mid__init (0x8d95b4, 172 Б): объект BSS записи e. Четыре блока IE хоста (assoc req/resp,
 * probe req/resp) должны быть пусты — иначе ассерты 0x11ef..0x11f2. */
static void mid_init(struct mid_bss *o, struct mid *e)
{
    u32 i;
    o->state = 0;
    o->mode = 1;
    o->owner = e;
    o->f1ac = 0;
    o->f1a8 = 0;
    o->ssid_len = 0;
    /* vendor: aw_len = 1000 (Awake Window для маяка) — PS вырезан */
    o->hidden = 0;
    /* volatile: соседние байты — две записи stb, как у vendor (stb_s [r1,0x14]/[r1,0x15]);
     * без volatile gcc сливает их в одну sth */
    ((volatile struct mid_bss *)o)->is_go = 0;
    ((volatile struct mid_bss *)o)->abft_len = 1;
    for (i = 0; i < 8; i++)
        o->pbss[i].aid = 8;
    if (app_ies_clear(&o->ie_assoc_req) != 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x11ef);
    if (app_ies_clear(&o->ie_assoc_resp) != 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x11f0);
    if (app_ies_clear(&o->ie_probe_req) != 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x11f1);
    if (app_ies_clear(&o->ie_probe_resp) != 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x11f2);
}

/* mid__set_default_counters (0x8f5350, 24 Б; vendor-имя неточно): безопасность записи по
 * умолчанию. */
static void mid_set_default_counters(struct mid_sec *o, struct mid *e)
{
    o->dot11_auth = 1;
    o->auth = 1;
    o->group_crypto = 1;
    o->owner = e;
    o->pairwise = 3;
    o->enabled = 1;
    o->wpa_offload = 1;
    o->privacy = 0;
}

/* mid__reset_sched_alloc_regs (0x8d0e48, 20 Б). */
static void mid_reset_sched_alloc_regs(void)
{
    MMIO32(HW_MAC_EXT_SCHED_48) = 0;
    MMIO32(HW_MAC_EXT_SCHED_4C) = 0x80001f00;
}

/* mid__program_88c068 (0x8d0e14, 52 Б): пары 13-битных полей из полуслов
 * [gp+0x100..0x10c] = 0x800284..0x800290 (ldh — без знака), бит 31. */
static void mid_program_88c068(void)
{
    u32 lo = sched_ext_a_lo & 0x1fff;
    u32 hi = ((u32)sched_ext_a_hi << 16) & 0x1fff0000;
    MMIO32(HW_MAC_EXT_SCHED_68) = hi | lo | 0x80000000u;
    lo = sched_ext_b_lo & 0x1fff;
    hi = ((u32)sched_ext_b_hi << 16) & 0x1fff0000;
    MMIO32(HW_MAC_EXT_SCHED_6C) = lo | hi | 0x80000000u;
}

/* mid__init_sched_scheme (0x8d96fc, 64 Б): s — 0x805234, e — запись mid.
 * 0x8ed514 = поле [4..6] слова; r2 = 1 сохраняется хелпером → байт [s+0x28] = 1. */
static void mid_init_sched_scheme(struct sched_scheme *s, struct mid *e)
{
    s->mid = e;
    s->ese = &ese_sched;                  /* mid__sched_scheme_addr (0x8ccb74): 0x8052e4 */
    memset0_words(&s->alloc_tpl, 0xf);
    bf_set32((u32)&s->alloc_tpl.ctrl, 4, 3, 1);
    s->alloc_tpl.ctrl |= 1u << 7;
    s->alloc_tpl.b[0xc] = 1;
    mid_reset_sched_alloc_regs();
    mid_program_88c068();
}

/* ---------------- BSS-объект записи ---------------- */

/* bss_set_mode__capinfo (0x8c4cd8, 76 Б): capability info: тип BSS (биты 0..1), бит 2,
 * privacy (бит 4); сброс битов 3, 5 и битов 0/4 старшего байта. Vendor пишет словом. */
static void bss_set_mode_capinfo(struct mid_bss *o, u32 mode, u32 priv)
{
    u32 w;
    bf_set32((u32)&o->capinfo_w, 0, 2, mode & 3);
    w = o->capinfo_w;
    w |= 1u << 2;
    w &= ~0x18u;
    w |= (priv & 1) << 4;
    w &= ~(1u << 5);
    o->capinfo_w = w;
    o->capinfo_b[1] &= (u8)~0x11u;
    w = o->capinfo_w;
    fw_log_emit3(0x2b, 0x100c368, o->capinfo, w & 3, (w >> 4) & 1);
}

/* bss_set_mode (0x8c4eec, 48 Б): режим BSS; privacy — из безопасности записи. */
void bss_set_mode(struct mid_bss *o, u32 mode)
{
    u32 priv;
    o->mode = mode;
    priv = o->owner->sec.privacy;
    bss_set_mode_capinfo(o, mode, priv);
    o->f1ac = 0;
    fw_log_emit2(0x2b, 0x100c3a4, o->mode, priv);
}

/* mid__reset_10b_at_248 (0x8c4e04, 28 Б). */
static void mid_reset_10b_at_248(struct mid_bss *o)
{
    memset0_words(o->blk_f8, 10);
    o->blk_f8[9] = 0x14;
}

/* mid__reset_ie_area (0x8c4e20, 44 Б): 0x8ed2d4 — поле [0..1] полуслова (ldw/stw). */
static void mid_reset_ie_area(struct mid_bss *o, u32 mode)
{
    memset0_words(&o->dmg_params, 1);
    bf_set16((u32)&o->dmg_params_h, 0, 2, mode & 3);
    o->dmg_params_h |= 1u << 2;
}

/* mid__reset_ssid (0x8c4df8, 12 Б). */
static void mid_reset_ssid(struct mid_bss *o)
{
    memset0_words(o->blk_103, 4);
}

/* edca__fill_default_ac_params (0x8e63f4, 200 Б): записи AC 0..3 EDCA IE (o+0x16 + 4·i):
 * ACM (б4) = 0, ACI [6:5] = i (0x8ed328), б7 = 0; AIFSN [3:0] (0x8ed2ec), ECWmin/ECWmax
 * (0x8ed238/0x8ed2a4), TXOP:
 *   AC 0: 3, 4/10, 0x40 (в OOB-режиме R1 или R2 — 0x28);  AC 1: 7, 4/10, 0;
 *   AC 2: 2, 3/4, 0x40;                                   AC 3: 2, 2/3, 0x10. */
static void edca_fill_default_ac_params(struct mid_bss *o)
{
    static const u8 aifsn[4] = { 3, 7, 2, 2 };
    static const u8 ecw[4] = { 0xa4, 0xa4, 0x43, 0x32 };      /* ECWmax << 4 | ECWmin */
    static const u16 txop[4] = { 0x40, 0, 0x40, 0x10 };

    for (u32 i = 0; i < 4; i++) {
        struct edca_ac_param *ac = mid_edca_ac(o, i);
        ac->aci_aifsn = (u8)((i << 5) | aifsn[i]);              /* ACM и б7 — 0 */
        ac->ecw = ecw[i];
        ac->txop = txop[i];
    }
}

/* l2mgr__set_edca_defaults (0x8d97a4, 48 Б). 0x8ed370 — поле [0..3] слова. */
static void l2mgr_set_edca_defaults(struct mid_bss *o)
{
    /* volatile: две записи stb, как у vendor (без volatile gcc сливает их в sth) */
    ((volatile struct mid_bss *)o)->edca_12 = 0xc;
    ((volatile struct mid_bss *)o)->edca_13 = 0x12;
    bf_set32((u32)&o->edca_w, 0, 4, 0);
    o->edca_w &= ~0xf0u;                  /* bic 0x30, bic 0xc0 */
    o->edca_15 = 0;
    edca_fill_default_ac_params(o);
}

/* sta_rec__unpack_5bit_caps (0x8e70c4, 116 Б): пять 5-битных полей и два бита из c[0..2]
 * в байты caps5[0..2] (o+0x17b..0x17d). */
static void sta_rec_unpack_5bit_caps(struct mid_bss *o, const u8 *c)
{
    u8 b;
    bf_set8((u32)&o->caps5[0], 0, 5, c[0] & 0x1f);                            /* 0x8ed244 */
    bf_set8((u32)&o->caps5[1], 2, 5, (c[1] >> 2) & 0x1f);                     /* 0x8ed274 */
    bf_set16_unaligned((u32)&o->caps5[0], 5, 5,
                       (((u32)c[0] | ((u32)c[1] << 8)) >> 5) & 0x1f);          /* 0x8ed1b4 */
    bf_set16_unaligned((u32)&o->caps5[1], 7, 5,
                       (((u32)c[1] | ((u32)c[2] << 8)) >> 7) & 0x1f);          /* 0x8ed1fc */
    b = (u8)((((c[2] >> 5) & 1) << 5) | (o->caps5[2] & ~0x20u));
    o->caps5[2] = b;
    o->caps5[2] = (u8)((((c[2] >> 4) & 1) << 4) | (b & ~0x10u));
}

/* mid__reset_bss_defaults (0x8c4d24, 212 Б): объект BSS записи. Собственный MAC, режим BSS,
 * DMG capability, SSID, EDCA, 5-битные поля capability.
 * Слово caps у vendor — неинициализированное слово стека; все биты, которые читает
 * sta_rec__unpack_5bit_caps (байт 0, байт 1, биты 0..5 байта 2), пишутся ниже, поэтому
 * начальный 0 поведения не меняет. */
void mid_reset_bss_defaults(struct mid_bss *o, const u8 *mac, const u8 *ssid, u32 ssid_len,
                            u32 mode)
{
    union { u32 w; u16 h[2]; } caps = { 0 };       /* слово caps; хелперы bf_* — по адресу */
    u32 c = (u32)&caps;
    l2mgr_apply_mac_address(o, mac);
    bss_set_mode(o, mode);
    o->bcon_int = 10;
    dmg_cap_build_sta_capability(o, o->owner->mac);
    mid_reset_10b_at_248(o);
    mid_reset_ie_area(o, mode);
    mid_reset_ssid(o);
    bcon_tx_build_step(o, 1);
    mid_set_ssid(o, ssid, ssid_len);
    l2mgr_set_edca_defaults(o);
    obj_set_field4_one(o);
    caps.h[1] &= (u16)~0x30u;                     /* побайтно у vendor: [sp+2], [sp+3] */
    bf_set32(c, 5, 5, 0);                         /* mid__bits_set32_s5_w5 (0x8ed538) */
    bf_set16_unaligned(c + 1, 7, 5, 0);           /* bits__set16_s7_w5 (0x8ed1fc) */
    bf_set32(c, 0, 5, 0xc);                       /* bits__set32_s0_w5 (0x8ed37c) */
    bf_set8(c + 1, 2, 5, 0xc);                    /* bits__set8_s2_w5 (0x8ed274) */
    sta_rec_unpack_5bit_caps(o, (const u8 *)c);
    vendor_ie_build_wilocity(o, o->owner->network_type, 0);
    o->bcon_int2 = (u16)pcp_bcon_interval;        /* ld_s [gp,336] */
    o->bcon_int = (u16)pcp_bcon_interval;
}

/* ---------------- открытие записи и список ---------------- */

/* mid__open (0x8c34d0, 122 Б): новая запись mid из пула mid_pool; 0 — mid уже есть
 * или пул пуст (журнал). */
struct mid *mid_open(u32 mid)
{
    struct mid *e;
    if (mid_list_by_mid_fw(mid) != 0) {
        fw_log_emit1(0x1b, 0x100c92c, mid);     /* Reject MID opening - ID %d is already exist */
        return 0;
    }
    e = mem_pool_allocate(&mid_pool);
    if (e == 0) {
        fw_log_emit0(0x1b, 0x100c95c);
        return 0;
    }
    e->id = (u8)mid;
    e->cid_mask = 0;
    mid_init_scan_and_pools(&e->disc, e);
    mid_init(&e->bss, e);
    mid_set_default_counters(&e->sec, e);
    e->sched = SCHED_SCHEME;                    /* mid__sched_obj (0x8ccb7c) */
    mid_init_sched_scheme(SCHED_SCHEME, e);
    return e;
}

/* mid_list__insert (0x8e5f0c, 56 Б): запись в список mid_list, бит mid в [0x800259]. */
void mid_list_insert(struct mid *e)
{
    if (mid_list_by_mid_fw(e->id) != 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x11c4);
    list_find_entry_d((u32 *)&mid_list, (u32 *)e);
    MID_BITMAP = (u8)(MID_BITMAP | (1u << (e->id & 31)));
}

/* l2mgr__mac_started_log (0x8f972c, 84 Б): открыть mid, MAC, BSS по умолчанию (режим 1),
 * в список; журнал «[L2MGR] MAC %d started : ADDR-%04X%08X». 1 — успех. */
u32 l2mgr_mac_started_log(u32 mid, const u8 *mac, const u8 *ssid, u32 ssid_len)
{
    struct mid *e = mid_open(mid);
    if (e == 0)
        return 0;
    mac_apply_multicast_addr(e, mac);
    mid_reset_bss_defaults(&e->bss, mac, ssid, ssid_len, 1);
    mid_list_insert(e);
    fw_log_emit3(0x2b, 0x100e5f8, mid, ((const union mac_addr *)mac)->h[2],
                 mac_lo32((const union mac_addr *)mac));
    return 1;
}

/* mid__count_active_conns (0x8cc66c, 56 Б): соединения записи с состоянием [connMLME] != 0. */
u32 mid_count_active_conns(struct mid *e)
{
    u32 it, n = 0;
    iter_init(&it, &e->conns);
    while (list_has_items(&it)) {
        struct conn *c = (struct conn *)iter_next(&it);
        if (c->mlme.sm.state != 0)
            n++;
    }
    return n;
}
