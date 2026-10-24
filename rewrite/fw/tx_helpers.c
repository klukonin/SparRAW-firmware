// SPDX-License-Identifier: AGPL-3.0-or-later
/* Вспомогательные функции TX/стримов: соединения, MAC-адреса, TX-дескрипторы очередей
 * (LMAC 0x45 / MACQ), автомат ba_sm, правила MAC-фильтра; чтение MACQ-дескрипторов и
 * отправка LMAC-команд/WMI-событий через mbox. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/fwdata.h"
#include "../include/vring_schd.h"
#include "../include/macq_desc.h"
#include "../include/mbox.h"
#include "../include/conn.h"
#include "../include/mid.h"
#include "../include/stream.h"
#include "../include/lmac_cmd.h"

/* Таблица vring_tbl (0x806014, 32 × 16 Б; в образе нули). */
FWDATA(806014) struct vring_tbl_entry vring_tbl[VRING_TBL_N] = { 0 };


/* Поле w бит [lo .. lo+n-1] = v (bits__set32_* → bf__set_field_word_fw 0x8edcb8). */
static void bf32(u32 *w, u32 lo, u32 n, u32 v)
{
    u32 m = ((n >= 32) ? 0xffffffffu : ((1u << n) - 1u)) << lo;
    *w = (*w & ~m) | ((v << lo) & m);
}

/* bits__set32_s16_w5 (0x8ed400). */
void bits_set32_s16_w5(u32 *p, u32 v) { bf32(p, 16, 5, v); }
/* bits__set_s8_w5 (0x8ed580). */
void bits_set_s8_w5(u32 *p, u32 v) { bf32(p, 8, 5, v); }
/* bits__set32_s4_w12 (0x8ed4f0) / s16_w12 (0x8ed3e8). */
void bits_set32_s4_w12(void *p, u32 v) { bf32((u32 *)p, 4, 12, v); }
void bits_set32_s16_w12(void *p, u32 v) { bf32((u32 *)p, 16, 12, v); }
/* bits__set16h_s0_w2 (0x8ed2d4) / mac_filter__bits_set16h_s4_w2 (0x8ed304): 16-битные. */
void bits_set16h_s0_w2(void *p, u32 v) { u16 *w = (u16 *)p; *w = (u16)((*w & ~3u) | (v & 3u)); }
void mac_filter_bits_set16h_s4_w2(void *p, u32 v) { u16 *w = (u16 *)p; *w = (u16)((*w & ~(3u << 4)) | ((v & 3u) << 4)); }

/* 0x802448: таблица переходов switch vendor ba_sm_evt_type (0x8d9c4c;
 * ldb, цель = 0x8d9c70 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802448) const u8 ba_sm_evt_type_jt[7] = {
    0x00, 0x02, 0x04, 0x06, 0x08, 0x0a, 0x0c,
};

/* ba_sm_evt_type (0x8d9c4c, 116 Б): тип события стрима → событие ba_sm (jump-table
 * 0x802448: 0,1,5,3,4,6,0xa). */
void ba_sm_evt_type(struct stream_ctx *obj, u32 evt, u32 a0, u32 a1, u32 a2)
{
    static const u8 ev_tab[7] = { 0, 1, 5, 3, 4, 6, 0xa };
    u32 ev;
    if (evt >= 7) {
        fw_sysassert_fatal((void *)0, 0x129b);
        ev = 8;
    } else {
        ev = ev_tab[evt];
    }
    fw_log_emit1(0x2b, 0x1010e48, ev);
    basic_sm_handle_event(&obj->sm, ev, a0, a1, a2);
}

/* vring_tbl__entry_addr (0x8ccfd8, 12 Б). */
struct vring_tbl_entry *vring_tbl_entry_addr(u32 idx)
{
    return &vring_tbl[idx];
}

/* conn_mgr__by_cid (0x8cbffc, 38 Б): соединение cid из cid_db (0 — нет). */
struct conn *conn_mgr_by_cid(u32 cid)
{
    if (cid >= SPARRAW_MAX_STA)
        fw_sysassert_fatal((void *)0, 0x11c9u);
    return conn_mgr.cid_db[cid].conn;
}

/* mac_hdr__copy_addr (0x8cc3ac, 14 Б): свой MAC записи mid. */
void mac_hdr_copy_addr(const struct mid *p, void *d)
{
    memcpy_fw(d, p->mac, 6u);
}

/* mid__copy_bssid (0x8cbb58, 38 Б): BSSID активного BSS, иначе свой MAC записи. */
void mid_copy_bssid(const struct mid_bss *obj, u8 *dst)
{
    if (obj->state == 2u)
        memcpy_fw(dst, obj->bssid, 6u);
    else
        memcpy_fw(dst, obj->owner->mac, 6u);
}

/* host_if__send_pair (0x8c32d8): буфер события хосту = mem_pool__alloc_locked(operational_mbox). */
void *host_if_send_pair(void)
{
    return mem_pool_alloc_locked(&operational_mbox.wm.mb);
}

/* mid__state_is_2_or_3 (0x8da488, 30 Б): запись mid — PCP/AP (режим BSS 2 или 3). */
u32 mid_state_is_2_or_3(u32 mid)
{
    u32 st = mid_list_by_mid_fw(mid)->bss.mode;
    return (st == 2u || st == 3u) ? 1u : 0u;
}

/* dma__set_881b24_bit1 (0x8df5c4, 14 Б). */
void dma_set_881b24_bit1(void)
{
    MMIO32(HW_L2_OFFLOAD_TX_CTL) |= (1u << 1);
}

/* tx_dma__build_desc (0x8ea2f0, 110 Б): RA/TA (по три полуслова) и поля очереди. */
void tx_dma_build_desc(void *dst, const u16 *s0, const u16 *s1, u8 a3, u8 a4, u8 a5, u8 a6)
{
    u16 *d = (u16 *)dst;
    u32 *w = (u32 *)(d + 6);
    memset0_words(dst, 0x10);
    d[0] = s0[0]; d[1] = s0[1]; d[2] = s0[2];
    d[3] = s1[0]; d[4] = s1[1]; d[5] = s1[2];
    bf32(w, 0, 4, a3 & 0xfu);
    bf32(w, 4, 2, a4 & 3u);
    bf32(w, 16, 7, a5 & 0x7fu);
    bf32(w, 14, 2, ((a6 & 1u) << 1) | ((a6 & 2u) >> 1));
    dma_set_881b24_bit1();
}

/* conn__alloc_and_fill (0x8dc43c, 54 Б): LMAC-команда 0x45 {q, flags, n, desc[0x70]}. */
void conn_alloc_and_fill(u32 a0, u32 a1, const struct macq_qdesc *a2, u32 a3)
{
    struct lmac_cmd_write_qh *r = lmac_cmd_pool_alloc();
    r->q = (u8)a0;
    r->flags = (u8)a1;
    r->n = (u16)a3;
    memcpy_fw(r->desc, a2, sizeof(*a2));
    lmac_if_post_cmd(r, 0x45, 0x74, 0);
}

/* qh__write_by_flags_fw (0x8dd90c, 348 Б): по флагам записать/прочитать MACQ-дескрипторы
 * очереди a: 0x10 — окно (+0x40), 0x1..0x8 — четыре под-дескриптора, 0x20 — типизированный.
 * Поля 12-битные (bits__set32_*_w12; прежде маска 0x7ff). */
void qh_write_by_flags_fw(u32 a, u32 b, struct macq_qdesc *c, u32 d)
{
    u32 buf[4];
    if ((b & 0x21) == 0x21)
        fw_sysassert_fatal((void *)0, 0x1585);
    if (b & 0x10) {
        u32 v;
        macq_desc_read(buf, a, 2, 0, 1);
        v = buf[1] & 0xfffu;
        c->ba.w1_b[2] = 0;
        bf32(&c->ba.w1, 0, 12, v);
        c->ba.w2_b[2] = (u8)(d - 1);
        bf32(&c->ba.w2, 0, 12, (v + d - 1) & 0xfffu);
        macq_desc_write(&c->ba, a, 2, 3, 0, 0, 0, 3);
    }
    if (b & 0x1)
        macq_desc_write(&c->win, a, 2, 0, 0, 0, 0, 1);
    if (b & 0x2)
        macq_desc_write(&c->sector, a, 2, 0, 0, 0, 1, 1);
    if (b & 0x4)
        macq_desc_write(&c->mode, a, 2, 0, 0, 0, 2, 1);
    if (b & 0x8)
        macq_desc_write(c->addr, a, 2, 0, 0, 0, 3, 1);
    if (b & 0x20) {
        macq_desc_read_typed(buf, a, 2, 0, 0, 1, 4);
        {   /* два ldw (vendor), не одно ld слова: поля по отдельности, volatile */
            u32 lo = *(volatile u16 *)&c->win.lines;
            u32 hi = *(volatile u16 *)&c->win.base;
            buf[1] = (hi << 16) | lo;
        }
        bf32(&buf[2], 0, 12, c->win.w2 & 0xfffu);
        bf32(&buf[3], 4, 12, (c->win.w3 >> 4) & 0xfffu);
        bf32(&buf[3], 16, 12, (c->win.w3 >> 16) & 0xfffu);
        macq_desc_write(buf, a, 2, 0, 0, 0, 0, 1);
    }
}

/* qh__write_or_conn_alloc (0x8ea5b0, 62 Б): при активном режиме fixed_sched.enabled и MID 0 в
 * состоянии 2/3 — через LMAC (0x45), иначе прямо в MACQ. */
u32 qh_write_or_conn_alloc(u32 a, u32 b, struct macq_qdesc *c, u32 d)
{
    if (*(volatile u8 *)&fixed_sched.enabled != 0 && mid_state_is_2_or_3(0) != 0) {
        conn_alloc_and_fill(a, b, c, d);
        return 0;
    }
    qh_write_by_flags_fw(a, b, c, d);
    return 0;
}

/* ba_sm__addba_at_10 (0x8c7edc, 20 Б): секторный дескриптор очереди e в буфер +0x10. */
void ba_sm_addba_at_10(const struct vring_tbl_entry *e, struct macq_qdesc *buf, u32 a2, u32 a3,
                       u32 a4, u32 a5)
{
    rf_chain_program_sector_desc(&buf->sector, e->mode, a2, a3, a4, a5);
}

/* obj_vt802b50__ctor (0x8f5280, 36 Б): ba_setup_sm. retry_timer (+0x10) vendor не
 * обнуляет — его снимает ba_setup_close_* перед возвратом в WAIT_FOR_START. */
void obj_vt802b50_ctor(struct ba_setup_sm *s, struct stream_sm *p)
{
    s->resp_timer = 0;
    s->global_timer = 0;
    s->token = 0;
    s->sm = p;
    basic_sm_bind_descriptor(s, &ba_setup_sm_desc);
    s->hdr.trace = 1;
}

/* wait_sm__init (0x8d8e24, 16 Б). */
void wait_sm_init(struct ba_wait_sm *s, struct stream_sm *p)
{
    s->sm = p;
    s->rsv_08 = 0;
    basic_sm_bind_descriptor(s, &wait_sm_desc);
}

/* obj_vt80296c__ctor (0x8d9230, 50 Б): ba_sm стрима (описатель 0x80296c). */
void obj_vt80296c_ctor(struct stream_sm *s, struct stream_ctx *p)
{
    obj_vt802b50_ctor(&s->setup, s);
    wait_sm_init(&s->wait, s);
    s->ctx = p;
    basic_sm_bind_descriptor(s, &stream_sm_desc);
    s->hdr.trace = 1;
}

/* mac_filter__write_one (0x8df704, 114 Б): правило idx MAC-фильтра для соединения n. */
void mac_filter_write_one(const u32 *mac, u32 n, u32 idx)
{
    u16 cmd = 0;
    if (idx >= 8)
        fw_sysassert_fatal((void *)0, 0x1012);
    bits_set16h_s0_w2(&cmd, 1);
    mac_filter_bits_set16h_s4_w2(&cmd, 2);
    MMIO32(HW_PRS_TBL_A_CMD) = ((u32)cmd << 16) | 0x80000000u;
    MMIO32(HW_PRS_TBL_A_ADDR) = idx + n * 8;
    MMIO32(HW_PRS_TBL_A_DATA0) = *mac;
    MMIO32(HW_PRS_TBL_A_CTRL) = 0x40000000u;
    arc_sync();
    while (MMIO32(HW_PRS_TBL_A_CTRL) & (1u << 29)) {
    }
}

/* install_key__parse_flags (0x8df9a4, 68 Б): правило ключа i соединения k. Слово правила
 * у vendor — неинициализированный стек (биты вне 0..12 — мусор); у нас 0. */
void install_key_parse_flags(u32 k, u32 i, u32 f)
{
    u32 val = 0;
    bits_set_s8_w5(&val, f & 0x1fu);
    bf32(&val, 0, 4, i & 0xfu);
    val |= 0x10u;
    if (i >= 8)
        fw_sysassert_fatal((void *)0, 0x1013);
    mac_filter_write_one(&val, k, i);
}

/* macq_desc__read (0x8c50f8, ~175 Б): прочитать дескриптор(ы) из MACQ 0x886600. */
void macq_desc_read(void *d,u32 b,u32 c,u32 count,u32 e)
{
    u32 sp0 = 0;
    u32 sp1 = (c & 7u) << 4;                       /* bits_set32_s4_w3 */
    sp0 &= ~3u;                                    /* bits_set32_s0_w2 = 0 */
    sp0 = (sp0 & ~(3u << 2)) | ((count & 3u) << 2);       /* bits_set32_s2_w2 */
    sp0 = (sp0 & ~(0x1fu << 4)) | ((b & 0x1fu) << 4);      /* bits_set32_s4_w5 (5 бит) */
    macq_desc_wait_window_free();
    MMIO32(HW_QDESC_WIN_CMD) = sp1 << 16;
    if (e >= 1) {
        u32 r3 = e, r13 = 0;
        u32 *dst = (u32 *)d;
        do {
            sp0 = (sp0 & ~3u) | (r13 & 3u);         /* bits_set32_s0_w2(r13&3) */
            MMIO32(HW_QDESC_WIN_ADDR) = sp0;
            MMIO32(HW_QDESC_WIN_CTRL) = (sched_fixed_active == 0) ? 0xc0000000u : 0x40000000u;
            arc_sync();
            /* Порт-баг (исправлен 2026-10-20): чтение было без volatile — gcc читал регистр
             * один раз и крутился на ветке (бит 29 при первом чтении → вечный цикл); vendor
             * 0x8c5178: ld r0,[r2,8]; bbit1 r0,29 — перечитывает каждую итерацию. */
            while (MMIO32(HW_QDESC_WIN_CTRL) & (1u << 29)) {}
            u32 r1 = (count == 2) ? 2u : 4u;
            for (u32 i = 0; i < r1; i++)
                dst[i] = MMIO32(HW_QDESC_WIN_DATA0 + i * 4);
            dst += r1;
            r3--;
            r13++;
        } while (r3 >= 1);
    }
    macq_desc_release_window();
}
/* 0x8021d8: таблица переходов switch vendor macq_desc__read_typed (0x8c4f1c;
 * ldb, цель = 0x8c4f66 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8021d8) const u8 macq_desc_read_typed_jt[6] = {
    0x00, 0x00, 0x0d, 0x0b, 0x0b, 0x0b,
};

/* macq_desc__read_typed (0x8c4f1c, 175 Б): «типизированное» чтение (jump-table 0x8021d8). */
void macq_desc_read_typed(void *d,u32 b,u32 c,u32 dd,u32 e,u32 f,u32 g)
{
    u32 sp0 = 0;
    u32 sp1 = (c & 7u) << 4;                       /* bits_set32_s4_w3 */
    sp0 &= ~3u;                                    /* bits_set32_s0_w2 = 0 */
    u32 r15 = 0;
    u32 r16 = e;
    s32 t = (s32)c - 1;
    if (t == 0 || t == 1) {                        /* 0x8021d8 {0,0,..} → case «set» */
        sp0 = (sp0 & ~(3u << 2)) | ((dd & 3u) << 2);   /* bits_set32_s2_w2 */
        r15 = 1;
        sp0 = (sp0 & ~(0x1fu << 4)) | ((b & 0x1fu) << 4);  /* bits_set32_s4_w5 (5 бит) */
    } else if (t >= 3 && t <= 5) {                 /* 0x8021d8 {..,13,11,11,11} → case «st e» */
        sp0 = e;
    }
    macq_desc_wait_window_free();
    MMIO32(HW_QDESC_WIN_CMD) = sp1 << 16;
    u32 r2 = f, r13 = 0;
    if (r2 >= 1) {
        u32 *dst = (u32 *)d;
        do {
            u32 r18 = r2;
            u32 r1 = r13 + r16;
            if (r15 != 0)
                sp0 = (sp0 & ~3u) | (r1 & 3u);     /* bits_set32_s0_w2 (2 бита) */
            else
                sp0 = r1;
            MMIO32(HW_QDESC_WIN_ADDR) = sp0;
            MMIO32(HW_QDESC_WIN_CTRL) = (sched_fixed_active == 0) ? 0xc0000000u : 0x40000000u;
            arc_sync();
            while (MMIO32(HW_QDESC_WIN_CTRL) & (1u << 29)) {}
            for (u32 i = 0; i < g; i++)
                dst[i] = MMIO32(HW_QDESC_WIN_DATA0 + i * 4);
            dst += g;
            r2 = r18 - 1;
            r13++;
        } while (r2 >= 1);
    }
    macq_desc_release_window();
}
/* lmac_cmd_pool__alloc (0x8c3284) = mem_pool__alloc_locked(lmac_mbox). */
void *lmac_cmd_pool_alloc(void)
{
    void *r = mem_pool_alloc_locked(&lmac_mbox.mb);   /* mem_pool_alloc_locked вернулся */
    __asm__ volatile("" ::: "memory");   /* запретить tail-call: нужен корректный blink */
    return r;
}
/* lmac_if__post_cmd (0x8e5204, 76 Б): отправить LMAC-команду (wmi_evt + mailbox). */
void lmac_if_post_cmd(volatile void *body, u32 type, u32 len, u32 flags)
{
    if (lmac_ucode_ready != 1)   /* [gp,0x244] = 0x8003c8 (lmac_ready_evt st.as [gp,0x91]) */
        fw_sysassert_fatal((void *)0, 0x1046);
    wmi_evt_build_and_post(&lmac_mbox.mb, (void *)body, type, 0, len, flags, 0, 0);
    MMIO32(HW_FW2UC_ICS) = 1;
    arc_sync();
}
/* wmi_evt__build_and_post (0x8e4ff8, 208 Б): собрать WMI-событие (mbox-заголовок
 * + wmi-заголовок + timestamp) в буфере body-0x10, продвинуть кольцо tx ящика и
 * отправить через wmi_evt_fill_payload. 9-й аргумент (flags bit3) в текущем
 * вызове lmac_if_post_cmd не передаётся → считаем его 0. */
__attribute__((section(".textlate"))) void wmi_evt_build_and_post(struct fw_mailbox *mb, void *b, u32 c, u32 d, u32 e, u32 f, u32 g, u32 h)
{   /* ДИАГНОСТИКА: вход build_and_post */
    struct mbox_hdr *hdr = (struct mbox_hdr *)b - 1;
    struct mbox_ring *ring = &mb->tx;
    struct mbox_ring_hw *hw = mb->tx.hw;
    u32 arg9 = 0;   /* bit0 → flags bit3 */

    if (b == 0)
        fw_sysassert_fatal((void *)0, 0xc3);   /* build_and_post: до ring_advance */
    if (mbox_ring_advance(ring) == 0) {
        mailbox_debug_dump(ring);
        fw_sysassert_fatal((void *)0, 0xc4);
    }   /* build_and_post: после ring_advance */

    hdr->seq = mb->seq;
    hdr->type = (u16)c;
    hdr->flags_lo = 0;

    if (hw->entry_size < e) {
        if (g == 0 && h == 0)
            fw_sysassert_fatal((void *)0, 0xc5);
    }

    hdr->len = (u16)e;
    hdr->len_lo = (u8)e;
    hdr->mid = (u8)f;
    hdr->rsv_09 = 0;
    hdr->id = (u16)d;
    hdr->timestamp = u_schd_now();

    hdr->flags_lo = (u8)(((arg9 & 1u) << 3) | ((h & 1u) << 2) | ((g & 1u) << 1));

    mb->seq += 1;   /* seq 16 бит: vendor ldw_s/stw_s [r15,0] (0x8e5090) */
    wmi_evt_fill_payload(ring, hdr);
    hw->head = (u32)ring->cur;
}

/* wmi_evt__post (0x8e4fc4): обёртка + post-callback (vtable[3]). a — ящик хоста
 * (struct wmi_mbox). */

void wmi_evt_post(struct wmi_mbox *mb, void *b, u32 c, u32 d, u32 e, u32 f, u32 g, u32 h)
{
    if (c == 0)
        e += 8;
    wmi_evt_build_and_post(&mb->mb, b, c, d, e, f, g, h);
    mb->vt->evt_posted(mb);   /* vt[3]: событие отправлено (vendor 0x8e4fe8) */
}

/* mbox_ring__advance (0x8da460): следующая запись (с переходом на начало) не равна курсору
 * читателя hw->tail — в кольце есть место. */
__attribute__((section(".textlate"))) u32 mbox_ring_advance(struct mbox_ring *r)
{
    struct mbox_entry *next = r->cur + 1;
    if (next == r->end)
        next = r->base;
    return ((u32)next != r->hw->tail) ? 1u : 0u;
}
/* mailbox_debug_dump (0x8ddab4, 78 Б): отладочный дамп кольца ящика. */
__attribute__((section(".textlate"))) void mailbox_debug_dump(struct mbox_ring *r)
{
    struct mbox_ring_hw *hw = r->hw;
    fw_log_emit2(0, 0x1001aa8, hw->tail, hw->head);
    fw_log_emit2(0, 0x1001af8, (u32)r->cur, (u32)r->base);
    fw_log_emit0(0, 0x1001b34);
    struct mbox_entry *e = r->base;
    while (e < r->end) {
        fw_log_emit2(0, 0x1001b54, e->sync, e->addr);
        e++;
    }
}
/* wmi_evt__fill_payload (0x8cadf8, 107 Б): занять текущую запись кольца буфером события
 * (у кольца с пулом — сперва вернуть буферы записей, прочитанных второй стороной). */
__attribute__((section(".textlate"))) void wmi_evt_fill_payload(struct mbox_ring *ring, struct mbox_hdr *buffer)
{   /* ДИАГНОСТИКА: вход fill_payload */
    if (buffer == 0)
        fw_sysassert_fatal((void *)0, 0xca);
    if (fw_mailbox_is_empty(ring) == 0)
        fw_sysassert_fatal((void *)0, 0xcb);
    u32 sv = arc_irq_disable();   /* vendor: lr [0xa]; bclr bit1; flag (запрет прерываний) */
    if (ring->pooled == 1) {
        struct mbox_entry *e = ring->base;
        while (e < ring->end) {
            wmi_evt_walk_list(ring, e);
            e++;
        }
        ring->cur->addr = (u32)buffer;
    }
    ring->cur->sync = 1;   /* addr — только в ветке выше (vendor 0x8cae34..3c) */
    lmac_if_evt_fields(ring);
    arc_irq_restore(sv);   /* vendor: lr [0xa]; or r16&2; flag (восстановление) */
}
/* fw_mailbox__is_empty (0x8da150, 24 Б): текущая запись свободна (sync == 0). */
__attribute__((section(".textlate"))) u32 fw_mailbox_is_empty(const struct mbox_ring *r)
{
    return (r->cur->sync == 0) ? 1u : 0u;
}
/* wmi_evt__walk_list (0x8cafb4, 123 Б): запись e прочитана второй стороной (sync == 0) —
 * вернуть её буфер: флаг 1 — free_cb, флаг 2 — free_cb2, иначе в пул кольца. */
__attribute__((section(".textlate"))) void wmi_evt_walk_list(struct mbox_ring *ring, struct mbox_entry *e)
{
    struct mbox_hdr *h = (struct mbox_hdr *)e->addr;
    if (h == 0)
        return;
    if (e->sync != 0)
        return;
    u32 flags = h->flags;
    if (flags & (1u << 1)) {
        if (ring->free_cb == 0)
            fw_sysassert_fatal((void *)0, 0xc8);
        if (h->flags & (1u << 3)) {
            h->flags &= ~(1u << 3);
        } else {
            void (*cb)(u32) = ring->free_cb;
            h++;   /* vendor add_s r14,r14,0x10: колбэку — payload; флаг ниже vendor снимает
                    * уже по payload+6 (а не в заголовке) — повторено как есть */
            cb((u32)h);
        }
        h->flags &= ~(1u << 1);
    } else if (flags & (1u << 2)) {
        void (*cb)(u32) = ring->free_cb2;
        h++;       /* то же: флаг 2 снимается по payload+6 */
        if (cb == 0)
            fw_sysassert_fatal((void *)0, 0xc9);
        cb((u32)h);
        h->flags &= ~(1u << 2);
    } else {
        stream_mgr_check_vring(ring->pool, h);
    }
    e->addr = 0;
}
/* lmac_if__evt_fields (0x8d86c0, 55 Б): сдвинуть курсор кольца ящика (с переходом на начало). */
__attribute__((section(".textlate"))) void lmac_if_evt_fields(struct mbox_ring *r)
{
    struct mbox_entry *next = r->cur + 1;
    if (r->end < next)
        fw_sysassert_fatal((void *)0, 0xcc);
    if (next == r->end)
        r->cur = r->base;
    else
        r->cur = next;
}

/* tx_api__get_mgmt_retry_limit / tx_api__send_mgmt / TX_API__send_packet
 * (0x8cc3d0 / 0x8e5874 / 0x8e58a4) — портированы в tx_api.c. */

