// SPDX-License-Identifier: AGPL-3.0-or-later
/* [ЧЕРНОВИК, сверен с asm] MACQ (hardware MAC queue) — запись RX/TX-дескрипторов.
 * Порт: macq_desc__write (0x8c5010), macq_desc__wait_window_free (0x8c50e4),
 *       macq_desc__release_window (0x8c5238), bf__insert_field (0x8edc10). */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/macq_desc.h"

__attribute__((section(".textlate"))) static u32 macq_flag(void) { return sched_fixed_active; } /* [gp,0xb2] = fixed_sched_active (vendor: 0 в STA, 1 в AP) */

/* bf__insert_field (0x8edc10): вставить бит-поле (shift, width бит). */
__attribute__((section(".textlate"))) u32 bf_insert_field(u32 word, u32 value, u32 shift, u32 width)
{
    u32 mask = (width >= 32) ? 0xffffffffu : ((1u << width) - 1u);
    return (word & ~(mask << shift)) | ((value & mask) << shift);
}

/* bit-set thunk'и (vendor bits__set32_* → bf__set_field_word_fw). */
__attribute__((section(".textlate"))) u32 bits_set32_s8_w3(u32 w, u32 v)  { return bf_insert_field(w, v, 8, 3); }
__attribute__((section(".textlate"))) u32 bits_set32_s16_w4(u32 w, u32 v) { return bf_insert_field(w, v, 16, 4); }
__attribute__((section(".textlate"))) u32 bits_set32_s24_w7(u32 w, u32 v) { return bf_insert_field(w, v, 24, 7); }
__attribute__((section(".textlate"))) u32 bits_set32_s0_w12(u32 w, u32 v) { return bf_insert_field(w, v, 0, 12); }

/* Ждать освобождения окна: poll 0x886608 бит 0x1f.
 * СРОК: окно дескрипторов MACQ 0x886600..0x886618 общее с ucode (uc/txss.c
 * qh_wait_desc_window_ready ждёт тот же бит 31 без предела, в т. ч. на пути TX uc —
 * tx_bcast_flow, tail.c). Пока fw держит окно (от записи CTRL 0xc0000000 до
 * macq_desc_release_window: n × (4 записи + ожидание бита 29), без запрета прерываний —
 * TIMER0 каждые 0xce4 тактов и прочие ISR удлиняют удержание), uc стоит; срок uc
 * (SIFS 3 мкс, 802.11-2020 10.3.2.3.3, если ожидание на пути ответа) — аппаратный.
 * Путь удержания ~30–60 инструкций на дескриптор (vendor ~ так же); запас: зависит от того,
 * где uc ждёт окно (открытый вопрос). Кроме того, «проверить бит 31 → писать CMD/ADDR/DATA →
 * взвести бит 31» не атомарно (~10 инструкций у fw): uc, занявший окно в этом промежутке,
 * получит смешанные CMD/ADDR — у vendor так же. При sched_fixed_active (AP) fw окно не
 * удерживает (0x40000000) — только STA. */
__attribute__((section(".textlate"))) void macq_desc_wait_window_free(void)
{
    if (macq_flag() == 0) {
        while (MMIO32(HW_QDESC_WIN_CTRL) & (1u << 0x1f)) {
        }
    }
}

/* Освободить окно: [0x886608] = 0. */
__attribute__((section(".textlate"))) void macq_desc_release_window(void)
{
    if (macq_flag() == 0) {
        MMIO32(HW_QDESC_WIN_CTRL) = 0;
    }
}

/* macq_desc__write (0x8c5010): записать дескриптор в MACQ (0x886600). */
__attribute__((section(".textlate"))) void macq_desc_write(const void *desc, u32 a1, u32 a2, u32 a3, u32 a4,
                     u32 a5, u32 a6, u32 a7)
{
    u32 base = (u32)desc;   /* адрес числом: с const u8 * gcc не сводит desc + cnt·n·4 в add2 вне цикла */
    u32 word = 0;
    u32 word2 = 0;
    u32 i, off, cnt;

    word  = bf_insert_field(word,  a2, 4, 3);   /* s4_w3 (vendor L_8ed514) */
    word  = bf_insert_field(word,  a4, 0, 2);   /* s0_w2 (vendor L_8ed358) */
    word2 = bf_insert_field(word2, a3, 2, 2);   /* s2_w2 (vendor L_8ed4cc) */
    word2 = bf_insert_field(word2, a1, 4, 5);   /* s4_w5 (vendor L_8ed52c) — FIX: в word2 */

    macq_desc_wait_window_free();               /* перед записью */

    MMIO32(HW_QDESC_WIN_CMD) = (word << 16) | 0x80000000u | a5;

    /* Vendor: brlo a7,1 → release (skip); do { …; a7--; cnt++ } while (a7 >= 1).
     * Дескрипторные слова читаются ПОСЛЕДОВАТЕЛЬНО (ld.ab по r14), т.е. каждая
     * итерация берёт следующие n слов: desc + cnt*n*4. */
    cnt = 0;
    if (a7 >= 1) {
        u32 n = (a3 == 2) ? 2u : 4u;   /* add1_s = scale 2 → 2 или 4 */
        do {
            word2 = bf_insert_field(word2, (a6 + cnt), 0, 2);   /* s0_w2 */
            MMIO32(HW_QDESC_WIN_ADDR) = word2;

            off = 0;
            for (i = 0; i < n; i++) {
                MMIO32(HW_QDESC_WIN_DATA0 + off) = *(const u32 *)(base + cnt * n * 4 + off);
                off += 4;
            }

            MMIO32(HW_QDESC_WIN_CTRL) = (macq_flag() == 0) ? 0xc0000000u : 0x40000000u;
            arc_sync();
            while (MMIO32(HW_QDESC_WIN_CTRL) & (1u << 0x1d)) {
            }

            cnt++;
            a7--;
        } while (a7 >= 1);
    }

    macq_desc_release_window();
}

/* mac_bringup__init_rx_fields (0x8e4510): 3 под-дескриптора через macq_desc_write. */
__attribute__((section(".textlate"))) void mac_bringup_init_rx_fields(const u8 *desc, u32 arg)
{
    macq_desc_write(desc,         arg, 1, 0, 0, 0, 0, 2);
    macq_desc_write(desc + 0x50,  arg, 1, 2, 0, 0, 0, 1);  /* add3 = scale 8: 0xa*8=0x50 */
    macq_desc_write(desc + 0x20,  arg, 1, 3, 0, 0, 0, 3);
}

/* mac_bringup__init_rx_desc (0x8f8144): инициализация RX-дескрипторов. */
__attribute__((section(".textlate"))) void mac_bringup_init_rx_desc(void)
{
    u8 desc[0x58];
    u32 i;
    for (i = 0; i < sizeof(desc) / 4; i++)
        ((u32 *)desc)[i] = 0;

    mac_bringup_init_rx_fields(desc, 0x1f);
    mac_bringup_init_rx_fields(desc, 0x0);
    mac_bringup_init_rx_fields(desc, 0x1);
    mac_bringup_init_rx_fields(desc, 0x2);
    mac_bringup_init_rx_fields(desc, 0x3);
}

/* macq_desc__write_type6 (0x8c51c0, 120 Б): запись дескриптора MACQ типа 6 через окно
 * 0x886600: заголовок [0x88660c] = (u16 поле << 16) | бит 31 (запись), адрес/индекс
 * [0x886610] = arg, 4 слова desc → 0x886614.., старт [0x886608] = 0xc0000000 (окно
 * захвачено; при fixed_sched [gp+0xb2] — 0x40000000 без захвата), sync, ожидание сброса
 * бита 29, освобождение окна (0x8c5238). Перед записью — ожидание свободного окна
 * (0x8c50e4, бит 31).
 * Поле — младшее полуслово (ldh) локального слова: биты 0..1 = 0 (0x8ed358, s0_w2),
 * биты 4..6 = 6 (0x8ed514, s4_w3).
 * ХРУПКО: у vendor локальное слово [sp+4] не инициализировано — помощники бит-полей
 * делают чтение-изменение-запись, биты 2..3 и 7..15 заголовка уходят в MACQ из мусора
 * стека (0x8c51ca..0x8c51de: st в [sp+4] до ldh нет). Здесь — 0. */
__attribute__((section(".textlate"))) void macq_desc_write_type6(const void *desc, u32 arg)
{
    const u32 *w = desc;
    u32 i;
    u32 local = 0;
    local = bf_insert_field(local, 0, 0, 2);   /* 0x8ed358: s0_w2 = 0 */
    local = bf_insert_field(local, 6, 4, 3);   /* 0x8ed514: s4_w3 = 6 */

    macq_desc_wait_window_free();
    MMIO32(HW_QDESC_WIN_CMD) = ((local & 0xffffu) << 16) | 0x80000000u;
    MMIO32(HW_QDESC_WIN_ADDR) = arg;
    for (i = 0; i < 4; i++)                    /* lp 4: ld.ab [desc], st [0x886614 + i·4] */
        MMIO32(HW_QDESC_WIN_DATA0 + i * 4) = w[i];
    MMIO32(HW_QDESC_WIN_CTRL) = (macq_flag() == 0) ? 0xc0000000u : 0x40000000u;
    arc_sync();
    while (MMIO32(HW_QDESC_WIN_CTRL) & (1u << 0x1d)) {
    }
    macq_desc_release_window();
}

/* === RX-MACQ config-цепочка (rx_macq__init 0x8d97f4 → rx_macq__setup 0x8d93a0) === */

/* rx_macq__entry_addr (0x8ccb68): адрес записи idx-й RX-MACQ (rx_macq_cfgs 0x843188). */
__attribute__((section(".textlate"))) u32 rx_macq_entry_addr(u32 idx)
{
    return (u32)&rx_macq_cfgs[idx];
}

/* rx_macq__get_cfg_word (0x8cc3c4): глобальное слово конфигурации [gp,600]=0x8003dc. */
__attribute__((section(".textlate"))) u32 rx_macq_get_cfg_word(void)
{
    return rx_macq_desc_cfg;
}


/* rx_macq__setup (0x8d93a0, 108 Б) — запись cfg RX-MACQ (+0 очередь, +1 тип, +2 размер
 * полезной нагрузки u16, +4 = 0, +8 sniffer, +0xc = 0) и программирование 4 дескрипторов
 * (BA-окно, 0x848018, offload, 0x847fe8). Сверено с vendor построчно. */
__attribute__((section(".textlate"))) void rx_macq_setup(u32 cfg, u32 mode, u32 a2,
                                                         u32 a3, u32 a4, u32 a5,
                                                         u32 a6, u32 a7, u32 a8)
{
    struct rx_macq_cfg *d = (struct rx_macq_cfg *)cfg;
    d->queue = (u8)mode;      /* stb_s r1,[r13] */
    d->type = (u8)a2;         /* stb_s r0,[r13,1] */
    d->payload = (u16)a7;     /* stw_s r14,[r13,2] */
    d->decap = 0;             /* stb_s r1,[r13,4] */
    d->sniffer = a8;          /* 9-й аргумент (стек): 1 — sniffer (wmi_cfg_rx_chain) */
    d->reorder = 0;

    {
        u32 w;
        rx_macq_program_ba_win(cfg, a3, a4, a5, a6, a7);
        w = rx_macq_get_cfg_word();
        if (a2 == 0 || a2 == 5 || a2 == 1) w = 0;
        if (a2 == 3) w = 1;
        rx_macq_program_desc_848018(cfg, a3, 0, 0, w);
        rx_macq_program_offload_desc((void *)cfg);
        rx_chain_configure_b(cfg, a7);
    }
}
