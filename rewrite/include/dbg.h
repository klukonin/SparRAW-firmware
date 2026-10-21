/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef DBG_H
#define DBG_H
/* Адрес для C (unsigned) и для .S — gas не знает суффикса u. Только у имён, нужных в .S. */
#ifndef ADDR_U
#ifdef __ASSEMBLER__
#define ADDR_U(x) x
#else
#define ADDR_U(x) x##u
#endif
#endif
#ifndef __ASSEMBLER__
#include "types.h"
#endif
/* Отладочная область fw: 0x806a00.. — выше конца vendor fw_data (0x806920), ниже стека
 * (вершина 0x807ffc). vendor сюда не обращается (единственная ссылка выше 0x806920 —
 * mov sp,0x807ffc). Прежние «свободные» слова 0x800100/104/11c/a18..a28 оказались
 * vendor-переменными или буферами. Читается из blob_fw_data по смещению 0x6a00. */
#define DBG_TRACE       0x806a00u   /* шаг трассы (trace_step и др.) */
#define DBG_SPIN        0x806a04u   /* маркер стоп-точки stopN/stopK (0x5709) */
#define DBG_ASSERT      0x806a08u   /* первый ассерт: код | ((blink-0x8c0000)>>1)<<16 */
#define DBG_TRAP_CALLER 0x806a0cu   /* (бывш. fw_vendor_ptr_trap, удалена 2026-10-20) первое место вызова */
#define DBG_TRAP_COUNT  0x806a10u   /* (бывш. fw_vendor_ptr_trap, удалена 2026-10-20) число вызовов */
#define DBG_WD_PC       ADDR_U(0x806a14)   /* сторож TIMER1 (вектор 7): первый прерванный PC (ilink2) */
#define DBG_WD_COUNT    ADDR_U(0x806a18)   /* сторож TIMER1: число срабатываний */
#define DBG_EXC_PC      0x806a1cu   /* исключение «ошибка инструкции» (вектор 2): первый ilink2 */
#define DBG_EXC_BLINK   0x806a3cu   /* … и blink прерванного кода */
#define DBG_TRAP_ARGS   0x806a60u   /* (бывш. fw_vendor_ptr_trap, удалена 2026-10-20) r0..r3 первого вызова */
#define DBG_SM_BAD      0x806a70u   /* basic_sm: действие вне кода — {ид автомата, desc, состояние|событие<<8|след<<16, действие} */
#define DBG_REENTRY     ADDR_U(0x806a80)   /* повторный вход в _reset: blink, ilink1, ilink2, sp (не обнуляется) */
#define DBG_ASSERT_PC   0x806a38u   /* первый ассерт: полный адрес возврата; 0x806a34 — аргумент caller */
#define DBG_TIMER0_PC   ADDR_U(0x806a28)   /* TIMER0: последний прерванный PC (ilink1) */
#define DBG_SELFTX_TO   0x806a40u   /* self-TX: число выходов по таймауту; 0x806a44 — последнее [0x8840f0] | [0x8840ec]<<16 */
#define DBG_SCRATCH     0x806a20u   /* 0x806a20..0x806a24, 0x806a2c..0x806a30 — временные эксперименты */

#ifndef __ASSEMBLER__
/* Кольцо журнала fw (0x843900, 0x1014 Б; fw_log__init_ring 0x8dcb1c, адрес — драйверу в
 * HW_RGF_USER_USAGE_1). Запись: слово заголовка (токен[19:0] | min(TSF_hi, 0xff) << 18 | n << 26
 * | бит 29 | бит 31), TSF_lo, n аргументов; индексы — по модулю FW_LOG_RING_N. */
#define FW_LOG_RING_N 0x400
struct fw_log {
    u32 wr_idx;                                /* 0x00: счётчик слов (не маскируется) */
    u8  lvl_mask[16];                          /* 0x04: по модулю (hdr & 0xf) — биты разрешённых уровней */
    u32 ring[FW_LOG_RING_N];                   /* 0x14 */
};
_Static_assert(__builtin_offsetof(struct fw_log, ring) == 0x14, "fw_log.ring");
_Static_assert(sizeof(struct fw_log) == 0x1014, "fw_log");

/* Кольцо событий evt_ring_push_1c (0x84008c, 0xa4 Б; сразу за flash_ids, до lmac_mbox_shm). */
#define EVT_RING_N 32
struct evt_ring {
    u32 data[EVT_RING_N];                      /* 0x00 */
    u8  type[EVT_RING_N];                      /* 0x80 */
    u8  idx;                                   /* 0xa0: следующая запись (по модулю EVT_RING_N) */
    u8  rsv_a1[3];
};
_Static_assert(__builtin_offsetof(struct evt_ring, idx) == 0xa0, "evt_ring.idx");
_Static_assert(sizeof(struct evt_ring) == 0xa4, "evt_ring");

/* Экземпляры — символы fw/fw.ld (рабочая SRAM). */
extern struct fw_log fw_log;                   /* 0x843900 */
extern struct evt_ring evt_ring;               /* 0x84008c */
#endif /* __ASSEMBLER__ */
#endif
