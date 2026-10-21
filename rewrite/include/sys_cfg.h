/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Объекты конфигурации системы при загрузке:
 *  - dashboard (DCCM 0x803b80, 0xd4 Б, до u_schd 0x803c54): настройки PCP/BSS по умолчанию
 *    (канал, SSID, пароль, безопасность) и вложенная конфигурация системы sys_cfg
 *    (0x803c00: уведомление хоста об ассерте, OOB-режимы по strap, флаги особой
 *    конфигурации, ap_sme_offload_mode, LED-схемы). Заполняет boot__init_subsystems
 *    (0x8f519c, fw/subsys.c); в образе fw_data — нули.
 *  - boot_diag (DCCM 0x803b70, 16 Б): блок диагностики для хоста, адрес — в [0x880a84]
 *    (boot__install_diag_magic 0x8d8ec0).
 *  - flash_hdr / flash_ids: заголовок flash (0x5c Б, на стеке) и секция идентификаторов и
 *    калибровок производства (0x4c Б, SRAM 0x840040) — boot__load_from_flash (0x8f2f9c).
 *  - arc_ap_cfg: параметры ARC action point (arc_action_point__arm 0x8c3af0).
 * Раскладка — как у vendor 6.2; смещения закреплены _Static_assert. */
#ifndef SYS_CFG_H
#define SYS_CFG_H
#include "types.h"

#define SYSCFG_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* LED-схема (6 Б): led_scheme__apply (0x8da84c) — hw_ch_enable_once(канал, on, period), при
 * duration_ms != 0 — выключение через duration_ms мс. */
struct led_scheme {
    u16 on;                                    /* 0x00 */
    u16 period;                                /* 0x02 */
    u16 duration_ms;                           /* 0x04 */
};
_Static_assert(sizeof(struct led_scheme) == 6, "led_scheme");

#define SYS_CFG_LED_SCHEMES 7

/* Конфигурация системы (0x803c00 = dashboard + 0x80, 0x54 Б). */
struct sys_cfg {
    volatile u32 host_assert_notify_en;        /* 0x00: 1 — fw_sysassert_fatal сообщает хосту */
    volatile u32 assert_led_en;                /* 0x04: 1 — при фатальном ассерте LED-схема 5 */
    u32 rsv_08;                                /* 0x08: = 0 при загрузке, читателей нет */
    volatile u32 oob_r1_mode;                  /* 0x0c: OOB-режим R1 (strap 4; «R1 OOB mode:
                                                *       disable power management», pf_mode_en) */
    volatile u32 oob_r2_mode;                  /* 0x10: OOB-режим R2 (strap 2; «R2 OOB mode») */
    u8  oob_r1_fixed_mcs;                      /* 0x14: R1 OOB: MCS в команде LMAC 0x05 (4) */
    u8  oob_r1_fixed_sector;                   /* 0x15: R1 OOB: сектор в команде LMAC 0x05 (0x43) */
    u8  rsv_16[2];
    u32 rsv_18;                                /* 0x18: = 0 при загрузке, читателей нет */
    u8  cca_bi_avg_num;                        /* 0x1c: окно усреднения CCA в BI − 1 (0xff;
                                                *       WMI_SET_CCA_INDICATIONS_BI_AVG_NUM) */
    u8  rsv_1d[3];
    volatile u32 special_flags;                /* 0x20: флаги особой конфигурации (fw только читает):
                                                *       б0 connect (vendor IE), б1/б2 link stat/lost,
                                                *       б3 пороги BF, б6 TXSS 10 мс, б7 dwell 500 мс,
                                                *       б9, б10, б12, б13..14 персональность */
    volatile u32 oob_info_flow_period;         /* 0x24: период информационного потока в OOB-режиме
                                                *       R1 (6000000) */
    volatile u8 ap_sme_offload_mode;           /* 0x28: из WMI_PCP_START; != 0 — split MAC
                                                *       (ассоциацию ведёт хост) */
    u8  rsv_29;
    struct led_scheme led[SYS_CFG_LED_SCHEMES];/* 0x2a: схемы LED (led_scheme__apply) */
};
SYSCFG_OFF(struct sys_cfg, oob_r1_mode, 0x0c);
SYSCFG_OFF(struct sys_cfg, oob_r1_fixed_mcs, 0x14);
SYSCFG_OFF(struct sys_cfg, cca_bi_avg_num, 0x1c);
SYSCFG_OFF(struct sys_cfg, special_flags, 0x20);
SYSCFG_OFF(struct sys_cfg, oob_info_flow_period, 0x24);
SYSCFG_OFF(struct sys_cfg, ap_sme_offload_mode, 0x28);
SYSCFG_OFF(struct sys_cfg, led, 0x2a);
_Static_assert(sizeof(struct sys_cfg) == 0x54, "sys_cfg");

#define DASHBOARD_SSID_MAX       32
#define DASHBOARD_PASSPHRASE_MAX 64

/* dashboard (0x803b80): настройки PCP/BSS по умолчанию + sys_cfg. */
struct dashboard {
    volatile u32 pcp_channel;                  /* 0x00: первичный канал PCP (1; WMI_SET_PCP_CHANNEL,
                                                *       WMI_PCP_START) */
    u8  ssid[DASHBOARD_SSID_MAX];              /* 0x04: SSID по умолчанию (WMI_SET_PASSPHRASE) */
    u8  rsv_24[2];
    volatile u16 ssid_len;                     /* 0x26 */
    u8  passphrase[DASHBOARD_PASSPHRASE_MAX];  /* 0x28: пароль («12345678» при загрузке) */
    volatile u16 passphrase_len;               /* 0x68: при загрузке — длина имени + 1 */
    u8  rsv_6a[2];
    volatile u32 pcp_security_en;              /* 0x6c: WMI_PCP_START disable_sec == 0 */
    volatile u32 pcp_sec_offload_en;           /* 0x70: WMI_PCP_START disable_sec_offload == 0 */
    u32 rsv_74[3];                             /* 0x74: = 1 при загрузке, читателей нет */
    struct sys_cfg cfg;                        /* 0x80 (0x803c00) */
};
SYSCFG_OFF(struct dashboard, ssid, 0x04);
SYSCFG_OFF(struct dashboard, ssid_len, 0x26);
SYSCFG_OFF(struct dashboard, passphrase, 0x28);
SYSCFG_OFF(struct dashboard, passphrase_len, 0x68);
SYSCFG_OFF(struct dashboard, pcp_security_en, 0x6c);
SYSCFG_OFF(struct dashboard, pcp_sec_offload_en, 0x70);
SYSCFG_OFF(struct dashboard, cfg, 0x80);
_Static_assert(sizeof(struct dashboard) == 0xd4, "dashboard");

/* Экземпляр в DCCM — fw/subsys.c (FWDATA 803b80). */
extern struct dashboard dashboard;

/* Блок диагностики для хоста (0x803b70): адрес — в [0x880a84] (ключ 0xbacacafe в 0x880a80). */
struct boot_diag {
    u32 status;                                /* 0x00: = 0 при загрузке */
    u32 reg0_addr;                             /* 0x04: адрес регистра 0x8802bc */
    u32 reg1_addr;                             /* 0x08: адрес регистра 0x8803e8 */
    u32 fw_stats_addr;                         /* 0x0c: адрес блока статистики fw 0x853800 */
};
_Static_assert(sizeof(struct boot_diag) == 0x10, "boot_diag");

/* Экземпляр в DCCM — fw/stubs.c (FWDATA 803b70). */
extern struct boot_diag boot_diag;

/* Заголовок flash (первые 0x5c Б, читается на стек). */
struct flash_hdr {
    u8  rsv_00[0x2c];
    u32 ids_section_off;                       /* 0x2c: смещение секции идентификаторов/калибровок */
    u8  rsv_30[0x2c];
};
SYSCFG_OFF(struct flash_hdr, ids_section_off, 0x2c);
_Static_assert(sizeof(struct flash_hdr) == 0x5c, "flash_hdr");

/* Секция идентификаторов и калибровок производства во flash (0x4c Б, SRAM 0x840040). Имена —
 * по журналу vendor («ppm value from flash: %d», «lo_power_xif_gc value from flash» …). */
struct flash_ids {
    u16 rsv_00;
    union {
        u8  mac[6];                            /* 0x02: MAC-адрес → 0x8004a4 */
        u16 mac_h[3];                          /*       в журнале — тремя полусловами */
    };
    u8  rsv_08[0x24];
    u16 ppm;                                   /* 0x2c: подстройка кварца (≤ 0x3f) → [0x88afb4][13:8] */
    u8  rsv_2e[6];
    u16 lo_power_xif_gc;                       /* 0x34: только журнал (vendor берёт 0) */
    union {
        u16 lo_power_stg2_bias;                /* 0x36: не меньше 5, < 0x10 */
        u8  lo_power_stg2_bias_b;              /*       в установку — байтом */
    };
    u16 vga_bias;                              /* 0x38: < 0x10 — все строки RX-таблицы */
    u16 vga_stg1_fine_bias;                    /* 0x3a: < 0x10 */
    u8  rsv_3c[6];
    u16 lo_power_gc_ctrl;                      /* 0x42: vendor перезаписывает 0xf (> 0xf → 0xc) */
    u8  rsv_44[2];
    u16 bb_sensor_tamb;                        /* 0x46: калибровка BB-сенсора температуры: Tamb */
    u16 bb_sensor_temp0;                       /* 0x48: … начальная температура */
    u8  rsv_4a[2];
};
SYSCFG_OFF(struct flash_ids, mac, 0x02);
SYSCFG_OFF(struct flash_ids, ppm, 0x2c);
SYSCFG_OFF(struct flash_ids, lo_power_xif_gc, 0x34);
SYSCFG_OFF(struct flash_ids, lo_power_stg2_bias, 0x36);
SYSCFG_OFF(struct flash_ids, vga_bias, 0x38);
SYSCFG_OFF(struct flash_ids, vga_stg1_fine_bias, 0x3a);
SYSCFG_OFF(struct flash_ids, lo_power_gc_ctrl, 0x42);
SYSCFG_OFF(struct flash_ids, bb_sensor_tamb, 0x46);
SYSCFG_OFF(struct flash_ids, bb_sensor_temp0, 0x48);
_Static_assert(sizeof(struct flash_ids) == 0x4c, "flash_ids");

/* Экземпляр в SRAM — символ fw/fw.ld. */
extern struct flash_ids flash_ids;

/* Заголовок блока статистики fw (0x853800, весь блок — FW_STATS_BLK_SIZE; адрес — в
 * boot_diag.fw_stats_addr; fw_stats_blk__init 0x8f538c). Дальше в блоке — temp_snap, журналы
 * калибровки (calib.h, calib_engine.h), общие с uc fw_stats_dash и mac_mon_pub (fwsh.h). */
#define FW_STATS_BLK_SIZE 0x1c0
struct fw_stats_hdr {
    u32 ver;                                   /* 0x00: = 5 */
    u16 size;                                  /* 0x04: = FW_STATS_BLK_SIZE */
    u16 rsv_06;
};
_Static_assert(sizeof(struct fw_stats_hdr) == 8, "fw_stats_hdr");
extern struct fw_stats_hdr fw_stats_hdr;       /* 0x853800 (fw/fw.ld) */

/* Параметры ARC action point (arc_action_point__arm 0x8c3af0): AMV/AMM/AC точки idx —
 * aux 0x220 + 3·idx .. 0x222 + 3·idx; AC = target | ttype << 4 | mode << 6 | pair << 7 |
 * ac8 << 8. */
struct arc_ap_cfg {
    u32 idx;                                   /* 0x00: номер точки (< 2) */
    u32 value;                                 /* 0x04: AMV */
    u32 mask;                                  /* 0x08: AMM */
    u32 target;                                /* 0x0c: AC[3:0] — 2: адрес ld/st */
    u32 ttype;                                 /* 0x10: AC[5:4] — 1: запись, 3: любой доступ */
    u32 mode;                                  /* 0x14: AC[6] M */
    u32 pair;                                  /* 0x18: AC[7] P */
    u32 ac8;                                   /* 0x1c: AC[8] (у всех вызывающих 1) */
};
_Static_assert(sizeof(struct arc_ap_cfg) == 0x20, "arc_ap_cfg");

/* Конфигурация SDP-портов 0..8 (DCCM 0x800c34; SDP::sdp_init 0x8f83c0, sdp__drive_value
 * 0x8e4abc): слово порта — [4:0] пин, [7:5] функция GPIO (4 — не трогать), [8] выход
 * разрешён, [10:9] начальное значение выхода (0/1 — выставить), [12:11] прерывание (0/1 —
 * настроить), [14:13] персональность. Экземпляр — fw/hw_init.c (FWDATA 800c34). */
#define SDP_PORT_COUNT 9
extern u32 sdp_port_cfg[SDP_PORT_COUNT];

/* Описание платы (DCCM 0x8009b4, в образе нули; указатель — [gp,-0x18] = 0x80016c).
 * Известны поля, которые пишет boot__publish_ids (0x8e8578) и читает set_old_wilocity_vs. */
struct plat_board_info {
    u8  rsv_00[0x28];
    u32 uc_field28;                            /* 0x28: = boot_uc_shared_field28 */
    u8  publish_id[4];                         /* 0x2c: boot_publish_id побайтно (байты платы VS) */
};
_Static_assert(__builtin_offsetof(struct plat_board_info, publish_id) == 0x2c, "plat_board_info.publish_id");
_Static_assert(sizeof(struct plat_board_info) == 0x30, "plat_board_info");
extern struct plat_board_info plat_board;                  /* 0x8009b4 (fw/platform.c) */
extern struct plat_board_info *volatile plat_board_info;   /* 0x80016c */

#endif
