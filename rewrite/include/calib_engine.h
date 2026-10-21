/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Калибровка: объекты классов калибровки (basic_calib и наследники), их таблицы методов,
 * автоматы движков калибровки и CALIB_MNGR (схемы, таймеры периода), очередь отложенных
 * событий автоматов basic_sm.
 * Раскладка — как у vendor 6.2:
 *   объекты классов: SAR 0x8430b8, VGA (bb_gain_dc) 0x8430e0, IF gain 0x843108,
 *     LO leakage 0x843130 (по 0x28 Б, вне DCCM — символы fw/fw.ld), silent RSSI 0x804b5c
 *     (0xd8 Б, DCCM), LO power 0x847ae4 (0x50 Б, вне DCCM); второй объект LO power
 *     0x80676c (DCCM) — только для полной калибровки hwf_calib_all;
 *   таблица объектов движков 0x800da4 (6 указателей), имена движков 0x800dc8;
 *   таблицы методов классов 0x800604 (IF gain), 0x800634 (silent RSSI), 0x800664 (VGA),
 *     0x800694 (LO power), 0x8006c4 (SAR), 0x80072c (LO leakage) — по 0x30 Б;
 *   CALIB_MNGR 0x804924: флаги схем u8[6], таймеры периода [6], автоматы движков 6 × 0x44
 *     (описатель 0x802234);
 *   схемы калибровки 0x800e2c (5 × 0x4c), номер схемы 0x800fa8 [pcp_ap][состояние],
 *     пороги температуры LO power 0x800fd0 (BB) / 0x800fe0 (RF);
 *   счётчики коррекций u32 0x800e08[6]; u16-статистика движков 0x8538d4 (6 × 10 Б, блок
 *     статистики fw 0x853800 — символ fw/fw.ld);
 *   пул отложенных событий basic_sm 0x803cbc (mem_pool + 4 узла по 16 Б).
 * Смещения закреплены _Static_assert. */
#ifndef CALIB_ENGINE_H
#define CALIB_ENGINE_H
#include "types.h"
#include "basic_sm.h"
#include "mem_pool.h"

#define CE_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

struct calib_obj;
struct rm_req;

/* Число движков калибровки: 0 SAR, 1 VGA (bb_gain_dc), 2 IF gain, 3 LO leakage,
 * 4 silent RSSI, 5 LO power. */
enum { CALIB_ENG_SAR = 0, CALIB_ENG_VGA = 1, CALIB_ENG_IF_GAIN = 2, CALIB_ENG_LO_LEAKAGE = 3,
       CALIB_ENG_SILENT_RSSI = 4, CALIB_ENG_LO_POWER = 5, CALIB_ENG_NUM = 6 };

/* Вердикт оценки (calib_est.verdict): 1 — коррекция не нужна, 2 — коррекция без захвата
 * радио, 3 — коррекция с захватом радио. */
enum { CALIB_EST_NONE = 1, CALIB_EST_CORRECT = 2, CALIB_EST_CORRECT_LOCKED = 3 };

/* Результат оценки / запрос коррекции (0xc Б): автомат движка +0x38, кадр hwf_calib_all;
 * заполняет calib__req_fill (0x8c182c), сбрасывает конструктор 0x8c1838 {0, 0, -1}. */
struct calib_est {
    u32 verdict;                               /* 0x00: CALIB_EST_* */
    u8  rf_mask;                               /* 0x04: маска RF (изменилась температура / калибруемые) */
    u8  rsv_05[3];
    u32 nfrag;                                 /* 0x08: число фрагментов (-1 — не задано) */
};
_Static_assert(sizeof(struct calib_est) == 0xc, "calib_est");

/* Таблица методов класса калибровки (0x30 Б; vt = [obj+0x24]). */
struct calib_vt {
    u32 rsv0;
    /* 0x04: сброс (LO power — calib_obj__reset_results, у остальных пусто); зовёт
     * calib_engine_sm_init при установке объекта в движок. */
    void (*reset)(struct calib_obj *o);
    void (*estimation_pre)(struct calib_obj *o, u32 mask);                        /* 0x08 */
    u32 (*estimation_alg)(struct calib_obj *o, u32 mask, struct calib_est *out);  /* 0x0c */
    void (*estimation_post)(struct calib_obj *o, u32 mask);                       /* 0x10 */
    u32 (*is_temperature_changed)(struct calib_obj *o, u32 thr, s32 cur, s32 *last); /* 0x14 */
    void (*pre)(struct calib_obj *o, u32 mask);                                   /* 0x18 */
    /* 0x1c: шаг коррекции: frag — номер фрагмента (с 1), nfrag — число фрагментов,
     * est — результат оценки (0 — нет). Возврат 0/1/2 (счётчики статистики движка). */
    u32 (*main)(struct calib_obj *o, u32 mask, u32 frag, u32 nfrag, struct calib_est *est);
    void (*post)(struct calib_obj *o, u32 mask);                                  /* 0x20 */
    u32 (*is_radio_lock_needed)(struct calib_obj *o);                             /* 0x24 */
    u32 (*check_online_estimation_condition)(struct calib_obj *o);                /* 0x28 */
    void (*set_fragments_num)(struct calib_obj *o, u32 mask, struct calib_est *out); /* 0x2c */
};
_Static_assert(sizeof(struct calib_vt) == 0x30, "calib_vt");

/* basic_calib (0x28 Б): последние температуры (для is_temperature_changed) и vtable.
 * Классы SAR, VGA, IF gain, LO leakage — без своих полей. */
struct calib_obj {
    s32 bb_temp;                               /* 0x00: последняя BB-температура, °C (-1 — нет) */
    s32 rf_temp[8];                            /* 0x04: последние температуры RF[i] */
    const struct calib_vt *vt;                 /* 0x24 */
};
CE_OFF(struct calib_obj, vt, 0x24);
_Static_assert(sizeof(struct calib_obj) == 0x28, "calib_obj");

/* Температурное состояние LO power (calib_lo_power.bb_state / rf_state[i]). */
enum { CALIB_LO_POWER_ROOM = 0, CALIB_LO_POWER_HIGH = 1, CALIB_LO_POWER_LOW = 2 };

/* class_calib_lo_power (0x50 Б): 0x847ae4 (движок 5) и 0x80676c (hwf_calib_all). */
struct calib_lo_power {
    struct calib_obj base;                     /* 0x00 */
    u32 mode;                                  /* 0x28: 1 — хоть одно состояние не ROOM */
    u32 rf_state[8];                           /* 0x2c: CALIB_LO_POWER_* RF[i] */
    u32 bb_state;                              /* 0x4c: CALIB_LO_POWER_* BB */
};
CE_OFF(struct calib_lo_power, mode, 0x28);
CE_OFF(struct calib_lo_power, bb_state, 0x4c);
_Static_assert(sizeof(struct calib_lo_power) == 0x50, "calib_lo_power");

/* Пороги температурных состояний LO power (знаковые, °C): 0x800fd0 — BB, 0x800fe0 — RF. */
struct calib_temp_thr {
    s32 room_to_low;                           /* 0x00 */
    s32 low_to_room;                           /* 0x04 */
    s32 room_to_high;                          /* 0x08 */
    s32 high_to_room;                          /* 0x0c */
};
_Static_assert(sizeof(struct calib_temp_thr) == 0x10, "calib_temp_thr");

/* Параметры поиска silent RSSI (6 Б): рабочие (+0xbe) и наборы A (+0xc4) / B (+0xca).
 * Флаги: b0 — медленный опрос гистограммы (по одному замеру с паузой), b1 — свои стартовые
 * усиления. vendor пишет флаги словом u16 (вместе с max_iter), max_iter читает байтом. */
struct silent_rssi_params {
    union {
        u16 flags_w;                           /* 0x00: флаги | max_iter << 8 */
        struct {
            u8 flags;                          /* 0x00 */
            u8 max_iter;                       /* 0x01: максимум итераций поиска */
        };
    };
    u16 n_meas;                                /* 0x02: число замеров гистограммы */
    u16 thr;                                   /* 0x04: порог гистограммы */
};
_Static_assert(sizeof(struct silent_rssi_params) == 6, "silent_rssi_params");

/* calib_silent_rssi_sparrow (0xd8 Б, 0x804b5c — движок 4). */
struct calib_silent_rssi {
    struct calib_obj base;                     /* 0x00 */
    u8  rf_gain2[8];                           /* 0x28: второе усиление (atten) модуля i */
    u8  rf_gain[8];                            /* 0x30: RF-усиление модуля i */
    union {
        u32 agc_start;                         /* 0x38: старт AGC (абсолютный) */
        u8  agc_start_b;                       /* 0x38: он же байтом (vendor ldb) */
    };
    union {
        u32 agc_start_mode;                    /* 0x3c: старт AGC по режиму RF */
        u8  agc_start_mode_b;
    };
    u32 agc_gain_arr;                          /* 0x40: упакованный массив усилений (старт +0x38) */
    u32 agc_gain_arr_mode;                     /* 0x44: то же для +0x3c */
    u32 last_hist;                             /* 0x48: последнее окно гистограммы */
    s8  base_ofs;                              /* 0x4c: смещение базы RX-индекса (от [0x800508]) */
    s8  temp_ofs;                              /* 0x4d: поправка второго усиления по температуре */
    u8  rsv_4e;                                /* 0x4e: конструктор пишет 0, никто не читает */
    u8  rsv_4f;
    u32 calib_count;                           /* 0x50: число калибровок baseband gain */
    u32 module_count[8];                       /* 0x54: счётчики калибровок модуля (набор B) */
    u16 hist[32];                              /* 0x74: гистограмма RSSI */
    u8  target;                                /* 0xb4: целевое окно гистограммы */
    u8  rsv_b5;                                /* 0xb5: конструктор пишет 0 */
    u8  win;                                   /* 0xb6: ширина скользящего окна, бинов */
    u8  win_base;                              /* 0xb7: база результата окна */
    u8  delta[4];                              /* 0xb8: дельты упаковки массива усилений */
    u8  start_idx;                             /* 0xbc: стартовый RX-индекс поиска */
    u8  min_idx;                               /* 0xbd: минимальный RX-индекс */
    struct silent_rssi_params cur;             /* 0xbe: рабочие параметры */
    union {
        struct silent_rssi_params set[2];      /* 0xc4: наборы A (0) и B (1) */
        u32 set_w[3];                          /* vendor читает/пишет набор A и словом u32 */
    };
    u8  tbl_rewrite;                           /* 0xd0: число полных переписей таблицы усилений */
    u8  rsv_d1[3];
    u32 rf_idx;                                /* 0xd4: RF-индекс (сектор) для txrx_sel */
};
CE_OFF(struct calib_silent_rssi, rf_gain2, 0x28);
CE_OFF(struct calib_silent_rssi, agc_start, 0x38);
CE_OFF(struct calib_silent_rssi, last_hist, 0x48);
CE_OFF(struct calib_silent_rssi, calib_count, 0x50);
CE_OFF(struct calib_silent_rssi, hist, 0x74);
CE_OFF(struct calib_silent_rssi, target, 0xb4);
CE_OFF(struct calib_silent_rssi, start_idx, 0xbc);
CE_OFF(struct calib_silent_rssi, cur, 0xbe);
CE_OFF(struct calib_silent_rssi, set, 0xc4);
CE_OFF(struct calib_silent_rssi, tbl_rewrite, 0xd0);
CE_OFF(struct calib_silent_rssi, rf_idx, 0xd4);
_Static_assert(sizeof(struct calib_silent_rssi) == 0xd8, "calib_silent_rssi");

/* Состояния и события автомата движка (описатель 0x802234, таблица 0x802248). */
enum { CE_ST_IDLE = 0, CE_ST_CHECK_CORRECTION_NEEDED = 1, CE_ST_WAIT_FOR_RADIO_LOCK = 2,
       CE_ST_CORRECTION = 3 };
enum { CE_EV_START = 0, CE_EV_READY_FOR_CORRECTION = 1, CE_EV_LOCK_RADIO = 2,
       CE_EV_FRAG_DONE = 3, CE_EV_CALIB_DONE = 4, CE_EV_ABORT = 5 };
/* Описатель (ид [0x10] пишет ctor_sm_802234_id) и таблица переходов — fw/calib_engine.c. */
extern struct sm_desc calib_engine_sm_desc;                   /* 0x802234 */
extern const struct sm_trans calib_engine_sm_table[6][4];     /* 0x802248 */

/* Колбэк завершения движка cb(a0, a1) (calib_engine.done_cb). */
typedef void (*calib_done_fn)(u32 a0, u32 a1);

/* Автомат движка калибровки (0x44 Б, CALIB_MNGR + 0x20 + i * 0x44). */
struct calib_engine {
    struct basic_sm hdr;                       /* 0x00 */
    struct calib_obj *obj;                     /* 0x08: объект класса калибровки */
    u32 idx;                                   /* 0x0c: индекс движка */
    u32 mask;                                  /* 0x10: маска условий оценки / режима */
    u32 periodic;                              /* 0x14: 1 — периодический запуск, 0 — разовый */
    u32 frag;                                  /* 0x18: номер выполненного фрагмента */
    u32 nfrag;                                 /* 0x1c: число фрагментов */
    u16 pause_s;                               /* 0x20: пауза между фрагментами, с */
    u8  rsv_22[2];
    struct rm_req *radio_req;                  /* 0x24: запрос радио */
    u32 pause_timer;                           /* 0x28: таймер паузы (u_schd) */
    calib_done_fn done_cb;                     /* 0x2c */
    u32 cb_a0;                                 /* 0x30 */
    u32 cb_a1;                                 /* 0x34 */
    struct calib_est est;                      /* 0x38: результат оценки */
};
CE_OFF(struct calib_engine, obj, 0x08);
CE_OFF(struct calib_engine, pause_s, 0x20);
CE_OFF(struct calib_engine, done_cb, 0x2c);
CE_OFF(struct calib_engine, est, 0x38);
_Static_assert(sizeof(struct calib_engine) == 0x44, "calib_engine");

/* CALIB_MNGR (0x804924, 0x1b8 Б). */
struct calib_mngr {
    u8  scheme_active[CALIB_ENG_NUM];          /* 0x00: схема движка активна */
    u8  rsv_06[2];
    u32 timer[CALIB_ENG_NUM];                  /* 0x08: таймер периода схемы (u_schd) */
    struct calib_engine eng[CALIB_ENG_NUM];    /* 0x20: автоматы движков */
};
CE_OFF(struct calib_mngr, timer, 0x08);
CE_OFF(struct calib_mngr, eng, 0x20);
_Static_assert(sizeof(struct calib_mngr) == 0x1b8, "calib_mngr");

/* Запись движка в схеме калибровки (12 Б). */
struct calib_scheme_entry {
    u32 flags;                                 /* 0x00: бит 0 — включён, биты 1..8 — число фрагментов */
    u32 mask;                                  /* 0x04: маска условий оценки */
    u16 period_s;                              /* 0x08: период, с (0 — без таймера) */
    u16 pause_s;                               /* 0x0a: пауза между фрагментами, с */
};
_Static_assert(sizeof(struct calib_scheme_entry) == 0xc, "calib_scheme_entry");

/* Схема калибровки (0x4c Б, таблица 0x800e2c). */
struct calib_scheme {
    u32 all_at_once;                           /* 0x00: != 0 — сразу разовый запуск всех включённых;
                                                * 0 — каждый движок по своему таймеру периода */
    struct calib_scheme_entry eng[CALIB_ENG_NUM]; /* 0x04 */
};
_Static_assert(sizeof(struct calib_scheme) == 0x4c, "calib_scheme");

/* u16-статистика движка: calib_eng_stats[i * CE_STAT_NUM + CE_STAT_*] (5 счётчиков, 10 Б на
 * движок, 0x8538d4 + i * 10). Плоский массив, а не структура / двумерный: индекс i * 5 + k
 * gcc считает сдвигами (как vendor: add_s/add2_s), а с 10-байтным шагом зовёт __mulsi3
 * дважды — для чтения и для записи. */
enum {
    CE_STAT_STARTS = 0,                        /* запусков (START) */
    CE_STAT_DONE = 1,                          /* завершений (все фрагменты) */
    CE_STAT_MAIN_RET0 = 2,                     /* результатов main 0, 1, 2 — CE_STAT_MAIN_RET0 + r */
    CE_STAT_NUM = 5
};


/* Пул отложенных событий автоматов (0x803cbc) — struct mem_pool sm_defer_pool и
 * sm_defer_nodes[] (include/mem_pool.h, basic_sm.h). */

/* Таблицы методов классов (fw/calib_engine.c). */
extern const struct calib_vt calib_if_gain_vtbl;         /* 0x800604 */
extern const struct calib_vt calib_silent_rssi_vtbl;     /* 0x800634 */
extern const struct calib_vt calib_vga_vtbl;             /* 0x800664 */
extern const struct calib_vt calib_lo_power_vtbl;        /* 0x800694 */
extern const struct calib_vt calib_sar_vtbl;             /* 0x8006c4 */
extern const struct calib_vt calib_lo_leakage_vtbl;      /* 0x80072c */

/* Объекты классов. */
extern struct calib_obj calib_sar_obj;                   /* 0x8430b8 (fw.ld) */
extern struct calib_obj calib_vga_obj;                   /* 0x8430e0 (fw.ld) */
extern struct calib_obj calib_if_gain_obj;               /* 0x843108 (fw.ld) */
extern struct calib_obj calib_lo_leakage_obj;            /* 0x843130 (fw.ld) */
extern struct calib_silent_rssi calib_silent_rssi_obj;   /* 0x804b5c */
extern struct calib_lo_power calib_lo_power_obj;         /* 0x847ae4 (fw.ld) */
extern struct calib_lo_power calib_all_lo_power_obj;     /* 0x80676c */

extern struct calib_obj *calib_engine_objs[CALIB_ENG_NUM];       /* 0x800da4 */
extern struct calib_mngr calib_mngr;                             /* 0x804924 */
extern struct calib_scheme calib_schemes[5];                     /* 0x800e2c */
extern u32 calib_scheme_idx[2][5];                               /* 0x800fa8 */
extern struct calib_temp_thr calib_lo_power_bb_thr;              /* 0x800fd0 */
extern struct calib_temp_thr calib_lo_power_rf_thr;              /* 0x800fe0 */
extern u16 calib_eng_stats[CALIB_ENG_NUM * CE_STAT_NUM];          /* 0x8538d4 (fw.ld) */

#endif
