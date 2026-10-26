// SPDX-License-Identifier: AGPL-3.0-or-later
/* Определение типа RF — rf__identify_type (0x8f4d3c). */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/hw.h"
#include "../include/fwdata.h"
#include "../include/rf_obj.h"
#include "../include/rf_sets.h"

/* Объект RF marlon_r_if_class (0x8042c8, 0x574 Б): в образе нули, поля задаёт конструктор
 * (fw/ctors.c) и разбор board-файла (fw/brd_if.c). */
FWDATA(8042c8) struct rf_obj rf_obj = { 0 };


/* Чтение RFC-регистра: проверка + до 5 попыток с рестартом делителя
 * (0x8d3588). */
u32 hwd_rfc_read_rgf(u32 a, u32 b)
{
    (void)a;
    u32 r3 = (MMIO32(HW_ABIF_DVS_RF_CTRL) >> 8) & 0xff;   /* vendor extb_s — байт без знака */
    u32 r15 = 0xdeadbeef;
    if (((0u - r3) & r3) != r3) {               /* не один бит (0 проходит) */
        fw_log_emit2(0, 0x101e1e4, b, (u32)r3);
        fw_sysassert_fatal((void *)0, 0x1513);
    }

    u32 r14;
    for (r14 = 0; r14 < 5; r14++) {
        MMIO32(HW_RFC_RESET_CTRL) |= (1u << 6);
        MMIO32(HW_RFC_RESET_CTRL) &= ~(1u << 6);
        hwd_rfc_write_core_fw(0, 4, b, 0);
        if (MMIO32(HW_RFC_READ_VALID) == 1) {
            r15 = MMIO32(HW_RFC_CORE_DATA);   /* ld r15,[0x889000+0xd8] — результат чтения */
            break;
        }
        hwd_abif_rfc_divider_restart(1);
    }
    if (r15 == 0xdeadbeef)
        fw_log_emit2(0, 0x101e218, 5, 0xdeadbeef);
    (void)r14;
    return r15;
}

/* Тип RF известен, если поле 0x880a8e ненулевое. */
u32 rf_type_is_known(void)
{
    return *(volatile u16 *)HW_REV_ID_RF_TYPE != 0;
}


/* RF присутствует, если тип не задан жёстко и тип известен (0x8da5d8). */
u32 rf_is_present(void)
{
    if (*(volatile u32 *)RF_STATUS != 0)
        return 0;
    return rf_type_is_known() != 0;
}


/* Ожидание завершения сброса RF (0x8d6ff4): SDP-пин 0, затем 1, журнал. Прежняя
 * «экспериментальная» naked-версия вместо журнала писала 0x5a01 в 0x800144 — это vendor
 * [gp-0x40], указатель radio_mgr (0x806214). */
void hwf_rf_wait_ready_log(void)
{
    sdp_drive_pin_timed(0);
    sdp_drive_pin_timed(1);
    fw_log_emit0(0x20, 0x101b3b4);
}

/* RFC-поле 0x434 = 0x2ec33 (0x8d414c). */
void rfc_write_field_434_2ec33(void)
{
    rfc_field_write(0, 0x434, 0x2ec33, 0);
}

/* 0x803908: исходная таблица TX-мощности RFC — 13 байт, словами в 0x8891b4.. (fw_main,
 * hwd_rfc_tx_power_cfg). */
FWDATA(803908) u8 rfc_tx_power_tbl_init[13] = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00 };

/* 0x80391d: 7 байт (шаг 0x1f) — обращений в vendor-коде не найдено (база 0x803908 читается
 * только по +0x10 и +0x1c..+0x28). Держит образ. */
FWDATA(80391d) __attribute__((aligned(1))) const u8 rfc_unref_80391d[7] = { 0x17, 0x36, 0x55, 0x74, 0x93, 0xb2, 0xd1 };

/* rfc_tx_power_tbl_load: цикл vendor fw_main (0x8f00ec, lp 13) — байты таблицы 0x803908
 * (fw_data) словами в 0x8891b4..0x8891e4. Прежде таблица была зашита в код константой,
 * а запись [0x857730] = -3 (следующая инструкция fw_main) жила здесь — теперь она в fw_main. */
__attribute__((section(".textlate"))) void rfc_tx_power_tbl_load(void)
{
    u32 i;
    for (i = 0; i < 13; i++)
        *(u32 *)(RFC_TX_POWER_TBL + i * 4) = *(volatile u8 *)&rfc_tx_power_tbl_init[i];
}

/* Накопление битов XPM (0x8d6f68): опрос 8 битов через RFC. */
u32 xpm_accumulate_bits(void)
{
    u32 r17 = 0;
    u32 r13;
    for (r13 = 0; r13 < 8; r13++) {
        u32 r16 = (u8)(1u << r13);
        u32 r14;
        hwd_abif_dvs_rfca_cmd_enable(r16, 0);
        hwd_abif_dvs_rf_activate(r16);
        for (r14 = 0; r14 < 5; r14++) {
            u32 r15 = r13 + 0x12123434u;
            rfc_write_field_434_2ec33();
            rfc_field_write(0, 0x4a8, r15, 0);
            rfc_field_write(0, 0x4ac, r13 + 0x56567878u, 0);
            if (hwd_rfc_read_rgf(0, 0x4a8) == r15) {
                r17 |= r16;
                break;
            }
            hwd_abif_rfc_divider_restart(0);
        }
    }
    return r17;
}

/* Ожидание сброса RF (0x8d70b8): только a == 0 поддержан, иначе ассерт 0x131a. */
void hwf_rf_wait_reset_done(u32 a)
{
    if (a == 0)
        hwf_rf_wait_ready_log();
    else
        fw_sysassert_fatal(__builtin_return_address(0), 0x131a);   /* blink не тронут */
}


/* Установка режима loopback калибровки (0x8d7560). */
void hwm_calib_set_loopback_mode(u32 flag)
{
    if (flag) {
        hwd_abif_caf_lpbk_mode(0);
        hwd_abif_lpbk_mode_switches_config(3, 2, 0);
        hwd_mac_sxd_rx_mode_entry();
    } else {
        hwd_mac_sxd_mode_neutral();
    }
}


/* Программирование группы регистров 0x889 (0x8d31dc). */
void hwd_program_889_group(u32 v)
{
    if (v == 1) {
        MMIO32(HW_ABIF_FS_CTRL) &= ~(1u << 3);
        MMIO32(HW_ABIF_DVS_RF_CTRL) = (MMIO32(HW_ABIF_DVS_RF_CTRL) & 0xff00ffffu) | (0xffu << 16);
        MMIO32(HW_RFC_RFCA_CFG) |= (1u << 11) | (1u << 16);
        MMIO32(HW_ABIF_DVS_RF_CTRL) &= 0xff00ffffu;
        hwd_abif_dvs_lo_splitter_config_buf_val(2, 8);
        u32 r0 = (u16)MMIO32(RFC_CTRL_F8);              /* vendor extw — без знака */
        MMIO32(RFC_CTRL_F8) = r0 | (1u << 19) | (1u << 22) | (1u << 23);
        MMIO32(HW_RFC_DIVIDER_CTRL) |= 1u;
        MMIO32(HW_ABIF_DVS_CLK_CFG) = (MMIO32(HW_ABIF_DVS_CLK_CFG) & ~0x1e0u) | 0xc0u;
        MMIO32(HW_ABIF_DVS_CLK_CFG) = (MMIO32(HW_ABIF_DVS_CLK_CFG) & ~0x1e00u) | (1u << 10) | (1u << 11) | (1u << 12);
        MMIO32(HW_ABIF_DVS_CLK_CFG) = (MMIO32(HW_ABIF_DVS_CLK_CFG) & ~0x1e0000u) | (1u << 19) | (1u << 20);
    } else {
        MMIO32(HW_ABIF_DVS_RF_CTRL) = (MMIO32(HW_ABIF_DVS_RF_CTRL) & 0xff00ffffu) | (0xffu << 16);
        MMIO32(HW_RFC_RFCA_CFG) &= ~((1u << 11) | (1u << 16));   /* vendor: одно чтение/запись */
        MMIO32(HW_ABIF_DVS_RF_CTRL) &= 0xff00ffffu;
        MMIO32(HW_RFC_DIVIDER_CTRL) &= ~1u;
        MMIO32(HW_ABIF_FS_CTRL) |= (1u << 3);
    }
}

/* SPI-enable RFC (0x8d37a8, hwd_rfc__uses_rgf_889100): сбросить bit4,
 * задержка 0x3a980×2 nop, установить bit4. В vendor вызывается только из
 * UT-хэндлера, НО RFC-SPI у нас стартует в reset (bit4=0, bit25=1) — включаем
 * явно до core-fw boot (mode1 в rf_configure_chain). */
void hwd_rfc_uses_rgf_889100(void)
{
    MMIO32(HW_RFC_RESET_CTRL) &= ~(1u << 4);
    arc_zol_nops2(0x3a980);             /* vendor 0x8d37bc: lp 0x3a980 × 2 nop_s */
    MMIO32(HW_RFC_RESET_CTRL) |= (1u << 4);
}

/* init_rf_hw (0x8f590c): последовательность инициализации RF (сверено с дизасмом 6.2). */
void init_rf_hw(struct rf_obj *this)
{
    /* vendor init_rf_hw НЕ пишет 0x880b00/0x886d5c/0x886d60 (они из других функций).
     * Убраны для побайтового совпадения. */
    hwd_abif_fs_off((u32)this);
    hwd_abif_fs_on(1);
    hwd_abif_uses_rgf_889480(0);
    hwd_abif_dvs_if_splitter_enable(0xff);
    hwd_abif_dvs_lo_splitter_enable(0xff);
    hwd_abif_dvs_rf_activate(0xff);
    hwf_rf_wait_reset_done(0);

    /* vendor init_rf_hw 0x8f5940: delay 0x3a980 (lp_count) × 2 nop_s — точное совпадение тайминга. */
    arc_zol_nops2(0x3a980);

    hwm_calib_set_loopback_mode(1);
    hwm_calib_set_loopback_mode(0);
    hwd_program_889_group(1);
    rf_connected_mask = (u8)xpm_accumulate_bits();

    if (marlon_r_if_class_init_board_file_interface(this) == 0)
        fw_log_emit0(0, 0x1005c1c);

    u8 mask = this->tx_mask;
    u8 acc = rf_connected_mask;
    if (mask == 0) {
        acc = (u8)(acc & ~(acc - 1));      /* младший установленный бит */
        this->rf_mask = acc;
    } else {
        acc &= mask;
        this->rf_mask = acc;
        if (mask != acc) {
            fw_log_emit2(0, 0x1005cb0, rf_connected_mask, mask);
            fw_sysassert_fatal((void *)0, 0x1452);
        }
    }

    ut_hw_modes_chain_3(0xff);
    rf_configure_chain(0, 0);

    u8 flag = this->rf_mask;
    u8 lowest = (u8)(flag & ~(flag - 1));
    rf_active_mask = lowest;
    fw_log_emit3(0x20, 0x1005d00, rf_connected_mask, flag, lowest);

    ut_hw_modes_chain_3(flag);
    hwd_abif_dvs_rfca_cmd_enable(rf_active_mask, 0);
}

/* Цепочка hw-мод: IF/LO/RF + RFCA command (0x8d7500). */
void ut_hw_modes_chain_3(u32 obj)
{
    hwd_abif_dvs_if_splitter_enable(obj);
    hwd_abif_dvs_lo_splitter_enable(obj);
    hwd_abif_dvs_rf_activate(obj);
    hwd_abif_dvs_rfca_cmd_enable(obj, 0);
    if (obj)
        rfc_write_field_434_2ec33();
}


/* Запись в RFC core-fw (0x8d415c): команда в 0x8890d0/d4/d8 + триггер. */
void hwd_rfc_write_core_fw(u32 a, u32 b, u32 c, u32 d)
{
    /* 6.2 asm 0x8d415c. RFC busy = бит 29 [0x8890cc]; старт команды = бит 30. */
    u32 ra = (u32)__builtin_return_address(0);
    u32 i;
    if ((s32)a >= 0x10)
        fw_sysassert_fatal((void *)ra, 0x1135);
    if ((s32)b >= 0x10)
        fw_sysassert_fatal((void *)ra, 0x45 << 6);
    if (c > 0x7fff)
        fw_sysassert_fatal((void *)ra, 0x1141);
    u32 r17 = (b & 0xf) << 4;

    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {         /* занят до команды: подождать */
        fw_log_emit3(0x10, 0x101e0f0, b, c, d);
        for (i = 0; i < 0x30d40; i++)
            if (!(MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)))
                break;
        if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {
            fw_log_emit0(0, 0x101e148);
            fw_sysassert_fatal((void *)ra, 0x134a);
        }
    }
    if (r17 & 0xffff8000u)
        fw_sysassert_fatal((void *)ra, 0xac);
    MMIO32(HW_RFC_CORE_OPCODE) = (r17 << 16) | (MMIO32(HW_RFC_CORE_OPCODE) & 0x8000ffffu);
    (void)MMIO32(HW_RFC_CORE_ADDR);                      /* vendor: чтение перед записью */
    MMIO32(HW_RFC_CORE_ADDR) = c;
    (void)MMIO32(HW_RFC_CORE_DATA);
    MMIO32(HW_RFC_CORE_DATA) = d;
    MMIO32(HW_RFC_CORE_CTRL) |= (1u << 30);              /* старт */
    for (i = 0; i < 0x30d40; i++)
        if (!(MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)))
            break;
    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29))
        fw_log_emit1(0, 0x101e0c0, ra);

    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {         /* повтор команды */
        fw_log_emit3(0x10, 0x101e168, b, c, d);
        fw_log_emit1(0x10, 0x101e1c0, MMIO32(HW_RFC_MAC_GO_WHEN_BUSY_ERR_CNT) & 0x7fff);
        /* vendor (0x8d4280) здесь НЕ делает divider_restart — только re-trigger bit30. */
        MMIO32(HW_RFC_CORE_CTRL) |= (1u << 30);
        for (i = 0; i < 0x30d40; i++)
            if (!(MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)))
                break;
        if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {
            fw_log_emit0(0, 0x101e148);
            fw_sysassert_fatal((void *)ra, 0x133d);
        }
    }
    rfc_cmd_count[a] += 1;             /* add2: счётчик команд модуля a */
}

/* Запись поля RFC через core-fw (0x8d4308). mask игнорируется. */
void rfc_field_write(u32 p, u32 field, u32 val, u32 mask)
{
    (void)p;
    (void)mask;
    if (field > 0x7fff)
        fw_sysassert_fatal((void *)0, 0x1142);
    hwd_rfc_write_core_fw(0, 0, field, val);
}

/* hwd_rfc_write_core_fw(a, 1, 0, 0) (0x8d33ec). */
void hwd_rfc_write_core_fw_mode1(u32 a)
{
    hwd_rfc_write_core_fw(a, 1, 0, 0);
}

/* RFC-поле 0x4cc = {a, b, c} в битах 0..2 (0x8d3e58). */
void rfc_write_chain_field(u32 p, u32 a, u32 b, u32 c)
{
    u32 v = ((b << 1) & 2) | (a & 1);
    v &= ~(1u << 2);
    v |= (c << 2) & 4;
    rfc_field_write(p, 0x4cc, v, c << 2);
}

/* RFC-поле 0x33c — упакованные a1..a7 (0x8d3e80). */
void rfc_write_packed_fields(u32 a0, u32 a1, u32 a2, u32 a3,
                             u32 a4, u32 a5, u32 a6, u32 a7)
{
    (void)a0;
    u32 v = (a1 & 3)
          | ((a2 << 2) & 0x1c)
          | ((a3 << 5) & 0x1e0)
          | ((a4 << 9) & 0x1e00)
          | ((a5 << 13) & 0x1e000)
          | ((a6 << 17) & 0x20000)
          | ((a7 << 18) & 0x40000);
    rfc_field_write(0, 0x33c, v, 0);
}

/* Конфигурация RF-цепочки (0x8d705c). b != 0 не поддержан: ассерт 0x1462 (он
 * возвращается) — и тогда vendor пишет a5 = 0xa + 1. */
u32 rf_configure_chain(u32 a, u32 b)
{
    rfc_write_chain_field(a, 1, 0, 0);
    if (b != 0)
        fw_sysassert_fatal((void *)0, 0x1462);
    rfc_write_packed_fields(a, 1, 2, 7, 7, (u8)((b != 0 ? 1u : 0u) + 0xa), 1, 1);
    hwd_abif_uses_rgf_889380(0x47974700, 0x17);
    hwd_rfc_write_core_fw_mode1(0);
    return 1;
}

/* Кадр rf_configure_role_power (vendor sp+0, 0x40 Б): пара окна 1, два окна сверки,
 * их набор. */
struct rf_role_power_frame {
    struct rf_reg_pair pwr;                    /* 0x00: пара, попавшая в окно 1 */
    struct brd_win win[2];                     /* 0x08: окно 0 → gain2_tbl, окно 1 → pwr */
    struct brd_bounds bounds;                  /* 0x38 */
};
_Static_assert(sizeof(struct rf_role_power_frame) == 0x40, "rf_role_power_frame");

/* 0x801fac: начальный кадр rf_configure_role_power (vendor 0x801fa4 + 8): окна адресов
 * RF-регистров секции 1 board-файла — [0x224, 0x2a0] на 0x20 пар и [0x44c, 0x44c] на одну;
 * указатели (pairs/first, bounds.win) ставит код, число окон 2. Читается по полям —
 * не const, чтобы чтения остались чтениями DCCM, как у vendor. */
FWDATA(801fac) struct rf_role_power_frame rf_role_power_tpl = {
    .pwr = { .addr = 0, .val = 0 },
    .win = {
        { .lo = 0x224, .hi = 0x2a0, .pairs = 0, .first = 0, .cap = 0x20, .cnt = 0, .mode = 2 },
        { .lo = 0x44c, .hi = 0x44c, .pairs = 0, .first = 0, .cap = 1, .cnt = 0, .mode = 2 },
    },
    .bounds = { .win = 0, .n_w = 2 },
};

/* Конфигурация role/power RF (0x8e2e88). this — модуль RF. */
u32 rf_configure_role_power(struct rf_obj *this)
{
    /* кадр vendor (0x40 Б), начальные значения — rf_role_power_tpl */
    struct rf_role_power_frame buf;

    if (rf_is_present() == 0) {
        fw_log_emit0(0x10, 0x10057bc);
        return 1;
    }

    buf.pwr.addr = rf_role_power_tpl.pwr.addr;
    buf.pwr.val = rf_role_power_tpl.pwr.val;
    memcpy_fw(buf.win, rf_role_power_tpl.win, 0x30);
    buf.win[0].pairs = this->gain2_tbl;
    buf.win[1].pairs = &buf.pwr;
    buf.bounds.win = buf.win;
    buf.bounds.n_w = rf_role_power_tpl.bounds.n_w;

    if (marlon_r_if_class_load_brd_rf_cfg_section(this, 1, &buf.bounds, 0x80, 1) == 0) {
        fw_log_emit0(0x0, 0x10057f4);
        return 2;
    }
    if (buf.pwr.val != 0) {
        fw_log_emit0(0x20, 0x100584c);
        this->role_pwr_flag = 1;
    }
    txpwr_brd_loaded();                     /* SparRAW: мощность TX хоста (fw/tx_power.c) */
    return 0;
}

/* rf__identify_type (0x8f4d3c). this — RF-объект (rf_obj): vendor `bl.d 0x8cae70;
 * mov_s r14,r0` — r14 = this из слота задержки, а результат rfc_read_or_dead
 * не используется. Прежний порт писал байт статуса по адресу, равному прочитанному
 * значению RFC-регистра 0x3e0 (в т.ч. 0xdeadbeef). Счётчик RFC (0x428), прочитанный
 * дважды, вырос на 1 и 0x8004c0 != 0 — Sparrow-R (тип 2, rf_idx = 0); иначе тип 0,
 * rf_idx = 0xa и 0x880a68 = 1 (RF нет). */
void rf_identify_type(struct rf_obj *this)
{
    u32 r13 = 0, r15, r16;

    (void)rfc_read_or_dead();
    r15 = hwd_rfc_read_rgf(0, 0x428);
    r16 = hwd_rfc_read_rgf(0, 0x428);
    fw_log_emit3(0x20, 0x10051a4, 0, r15, r16);

    if (rf_sparrow_r_detect_en != 0 && r15 + 1 == r16) {
        r15 = 2;
        this->rf_idx = 0;
        fw_log_emit0(0x20, 0x10051e0);
    } else {
        r13 = 1;
        this->rf_idx = 0xa;
        r15 = 0;
        fw_log_emit0(0, 0x1005204);              /* vendor: r0 = 0 */
    }

    *(volatile u32 *)RF_STATUS = r13;              /* [0x880a3c+0x2c] — RF нет */
    *(volatile u16 *)HW_REV_ID_RF_TYPE = (u16)r15;         /* [0x880a3c+0x52] — тип RF */

    if (rf_type_is_known() == 1)
        check_rf_boardfile(this);
}

/* Установить нижний ниббл 0x889494 (0x8d3...). */
void rf_set_889494_low_nibble(u32 on)
{
    if (on != 0) {
        MMIO32(RF_REGD_CTRL) |= 3u;
        MMIO32(RF_REGD_CTRL) |= 0xcu;
    } else {
        MMIO32(RF_REGD_CTRL) &= ~3u;
        MMIO32(RF_REGD_CTRL) &= ~0xcu;
    }
}

/* Конфигурация TX-мощности RFC (0x8d4070). */
void hwd_rfc_tx_power_cfg(u32 a)
{
    fw_log_emit1(0x20, 0x101e8b4, a);
    if (a != 0) {
        u32 i;
        for (i = 0; i < 0xd; i++)
            *(u32 *)(RFC_TX_POWER_TBL + i * 4) = 0;
        fwsh_sets.rx_gain_ofs_lo_mcs = 0;
    } else {
        u32 i;
        for (i = 0; i < 0xd; i++)
            *(u32 *)(RFC_TX_POWER_TBL + i * 4) = rfc_tx_power_tbl_init[i];
        fwsh_sets.rx_gain_ofs_lo_mcs = 0xfffffffd;
    }
}

/* Тип RF — Marlon (0x8da594). */
u32 rf_type_is_marlon(void)
{
    return (*(volatile u16 *)HW_REV_ID_RF_TYPE == 1) ? 1 : 0;
}

/* Тип RF — Sparrow-R (0x8da584). */
u32 rf_type_is_sparrow_r(void)
{
    return (*(volatile u16 *)HW_REV_ID_RF_TYPE == 2) ? 1 : 0;
}


/* Проверка board-file RF (0x8f19b8): платформа из 0x880014 должна совпасть с
 * типом RF (0 — Marlon, 1 — Sparrow-R), board-file привязан (brd_if). Иначе
 * 0x880a68 = 2, rf_idx = 0xa и ассерт 0x1048 (vendor: mov_s r1,0x48 + bset_s r1,r1,12
 * в слоте задержки; прежний порт — 0xc48). */
void check_rf_boardfile(struct rf_obj *this)
{
    u32 plat;
    u32 err = 0;

    rf_boardfile_read_platform_info(this, &plat, 0, 0);
    if (this->brd_if == 0) {
        err = 1;
    } else if (plat == 0) {
        if (rf_type_is_marlon())
            fw_log_emit0(0x20, 0x100505c);
        else {
            fw_log_emit0(0, 0x100509c);
            err = 1;
        }
    } else if (plat == 1) {
        if (rf_type_is_sparrow_r())
            fw_log_emit0(0x20, 0x1005118);
        else {
            fw_log_emit0(0, 0x1005158);
            err = 1;
        }
    } else {
        fw_log_emit0(0, 0x100502c);
        err = 1;
    }

    if (err) {
        *(volatile u32 *)RF_STATUS = 2;
        this->rf_idx = 0xa;
        fw_log_emit0(0, 0x10050e8);
        fw_sysassert_fatal((void *)0, 0x1048);
    }
}

/* Получить маску подключённых RF (0x8ccb38). */
u32 rf_get_connected_mask(struct rf_obj *a)
{
    (void)a;
    return rf_connected_mask;
}

/* Получить RF-маску по смещению 0x45e (0x8ccb3c). */
u32 rf_cfg_get_rf_mask_45e(struct rf_obj *p)
{
    return p->rf_mask;
}

/* Запись RFC-полей 0x1e4/0x1e8/0x1ec (0x8d3...). */
void rfc_write_field_484(u32 a0, u32 *in)
{
    u8 v = (u8)a0;
    rfc_field_write(v, 0x1e4, in[0], 0);
    rfc_field_write(v, 0x1e8, in[1], 0);
    rfc_field_write(v, 0x1ec, in[2], 0);
}

/* Чтение platform-info из board-file (0x8f3478). */
void rf_boardfile_read_platform_info(struct rf_obj *a, u32 *out0, u32 *out1, u32 *out2)
{
    (void)a;
    u32 r0 = MMIO32(HW_RGF_USER_USAGE_5);     /* RF/platform/revision (NAMES-EXTRA) */
    u32 r16 = r0 >> 28;
    u32 r17 = (u32)(u16)(r0 >> 12);
    u32 r18 = r0 & 0xfff;                   /* bmsk r18,r0,0xb — 12 бит (0x8f349c) */
    fw_log_emit3(0x20, 0x1004fec, r16, r17, r18);
    if (out0) *out0 = r16;
    if (out1) *out1 = r17;
    if (out2) *out2 = r18;
}

/* ============================================================================
 * Конфигурация канала marlon_r_if_class::config_channel (0x8c6d00) и всё, что
 * она вызывает (кроме загрузчика board-file 0x8dc830 — brd_if.c — и rf_power_off 0x8e2fa8).
 * Порт по дизасму 6.2; адреса — у каждой функции.
 * ========================================================================== */

/* Число установленных битов: vendor-цикл `v &= v - 1; n++` (extw — 16 бит). */
static u32 rf_popcount(u32 v)
{
    u32 n = 0;
    while (v != 0) {
        v &= v - 1;
        n = (u16)(n + 1);
    }
    return n;
}

/* k-й (с 1) младший установленный бит маски m — vendor-идиома
 * `r1=m-1; lp k-1: { m &= r1; r1 = m-1 }; bit = m & ~r1`. */
static u32 rf_kth_set_bit(u32 m, u32 k)
{
    u32 r1 = m - 1;
    u32 i;
    for (i = 1; i < k; i++) {
        m &= r1;
        r1 = m - 1;
    }
    return m & ~r1;
}

/* rf_utils_auto_fill_set_pattern (0x8e3268): 6 слов шаблона buf->pat — в
 * RF-регистры 0x524 + block*0x20 подряд (vendor: ((block<<8) + (1316<<3)) >> 3 & ~3,
 * add3 со сдвигом непосредственного операнда), через hwd_args_to_regs(маска RF = rf_mask). */
void rf_utils_auto_fill_set_pattern(const struct rf_auto_fill *buf)
{
    const u32 *pat;
    u32 rf, addr, n;

    if (buf == 0 || buf->pat == 0) {
        fw_log_emit1(0, 0x1008d80, (u32)buf);
        return;
    }
    pat = buf->pat;
    rf = buf->rf_mask;
    addr = ((((u32)buf->block << 8) + (1316u << 3)) >> 3) & ~3u;
    for (n = 6; n >= 1; n--) {
        hwd_args_to_regs(rf, addr, *pat++, 0);
        addr += 4;
    }
}

/* rf_utils_auto_fill (0x8e3060). buf — дескриптор struct rf_auto_fill (include/rf_obj.h).
 * Пишет (шаблон →) слово {first, last, word_mask} и 1 в RF-регистры блока (0x53c/0x524 +
 * block*0x20), затем для каждого RF маски: ждёт сброса бита 0 регистра 0x4f0 (2 чтения)
 * и, если заданы verify и шаблон, сверяет слова шаблона с RF-регистрами 0x1000/0x2000+.
 * mode != 0 — ошибки фатальны (vendor: ассерт возвращается, и тогда для 0x1567 цикл
 * по RF продолжается, а для 0x1565/0x1566 функция возвращает 0). */
u32 rf_utils_auto_fill(const struct rf_auto_fill *buf, u32 mode)
{
    u32 words[64];   /* vendor: sub sp,sp,256 */
    u32 addr, val, n, i, rf, k, left;

    if (buf == 0 || buf->block >= 2) {
        fw_log_emit1(0, 0x1008cd4, (u32)buf);
        return 1;
    }
    addr = ((((u32)buf->block << 8) + (1340u << 3)) >> 3) & ~3u;
    val = (u32)buf->first | ((u32)buf->last << 8) | ((u32)buf->word_mask << 16);

    i = 0;
    if (buf->pat != 0) {
        memcpy_fw(words, buf->pat, 0x18);
        i = 6;
        addr = ((((u32)buf->block << 8) + (1316u << 3)) >> 3) & ~3u;
    }
    words[i] = val;
    n = (u16)(i + 1);
    words[n] = 1;
    n = (u16)(n + 1);

    rf = buf->rf_mask;
    for (i = 0; n >= 1; n--, i++) {
        hwd_args_to_regs(rf, addr, words[i], 0);
        addr += 4;
    }

    left = rf_popcount(rf);
    if ((s32)left < 1)
        return 1;
    for (k = 1; ; k = (u16)(k + 1)) {
        u32 bit = (u8)rf_kth_set_bit(rf, k);
        u32 busy = 1, tries = 0, ok;

        hwd_abif_dvs_rfca_cmd_enable(bit, 0);
        while (tries < 2 && busy != 0) {
            u32 r = hwd_rfc_read_rgf(0, 0x4f0);
            if (r == 0xdeadbeefu) {
                fw_log_emit1(0, 0x1008d14, bit);
                if (mode != 0)
                    fw_sysassert_fatal((void *)0, 0x1565);
                return 0;
            }
            busy = r & 1;
            tries = (u16)(tries + 1);
        }
        if (busy != 0) {
            fw_log_emit0(0, 0x1008d5c);
            if (mode != 0)
                fw_sysassert_fatal((void *)0, 0x1566);
            return 0;
        }

        ok = 1;
        if (buf->verify != 0 && buf->pat != 0) {
            const u32 *pat = buf->pat;
            u32 reg = (buf->block == 1 ? 1u : 0u) * 0x1000u + 0x1000u;
            u32 idx;
            for (idx = buf->first; (s32)buf->last >= (s32)idx && ok; idx = (u8)(idx + 1)) {
                u32 m = 1, j;
                for (j = 0; j < 6; j = (u8)(j + 1)) {
                    if (buf->word_mask & m) {
                        u32 r = hwd_rfc_read_rgf(0, reg);
                        if (pat[j] != r) {
                            fw_log_emit3(0, 0x1008c7c, bit, idx, r);
                            if (mode != 0)
                                fw_sysassert_fatal((void *)0, 0x1567);
                            ok = 0;
                            break;
                        }
                    }
                    m = (u8)(m << 1);
                    reg += 4;
                }
            }
        }
        if (mode == 0 && ok == 0)
            return 0;
        left--;
        if (left == 0)
            break;
    }
    return 1;
}

/* rf_utils__fill_default_patterns (0x8d9a54): шаблоны по умолчанию для всех RF маски
 * [gp+0xbf] (0x800243). Шаблон 6 слов — копия rf_auto_fill_pat0 (0x801fec), дескриптор
 * auto_fill — копия rf_auto_fill_dflt_tpl (0x802004; vendor add3 r1,0x801fa4,9/0xc: +0x48/+0x60). Первым vendor вызывает
 * метод board-file vt[6] (+0x18, число TX-секторов) объекта this+0x58; результат
 * не используется. */
void rf_utils_fill_default_patterns(struct rf_obj *this)
{
    u32 pat[6];
    struct rf_auto_fill d;

    (void)rf_if_num_tx_sectors(this);
    memcpy_fw(pat, rf_auto_fill_pat0, 0x18);
    memcpy_fw(&d, &rf_auto_fill_dflt_tpl, 0x10);
    d.pat = pat;
    d.rf_mask = rf_connected_mask;
    rf_utils_auto_fill(&d, 1);
    d.block = 1;
    d.first = 0;
    d.last = 0x7f;
    d.pat = pat;
    rf_utils_auto_fill(&d, 1);
    d.pat = pat;
    pat[5] = 0x3f000000u;
    rf_utils_auto_fill_set_pattern(&d);
}

/* 0x802004: дескриптор auto_fill по умолчанию (rf_utils__fill_default_patterns). */
FWDATA(802004) struct rf_auto_fill rf_auto_fill_dflt_tpl = {
    .rf_mask = 0, .block = 0, .first = 0, .last = 0x7f, .pat = 0, .verify = 1, .word_mask = 0x3f,
};
/* 0x8021c8: дескриптор auto_fill BRP-блока (rf_utils__auto_fill_8021c8). */
FWDATA(8021c8) struct rf_auto_fill rf_auto_fill_brp_tpl = {
    .rf_mask = 0, .block = 1, .first = 0x40, .last = 0x5f, .pat = 0, .verify = 0, .word_mask = 0x3f,
};

/* rf_utils__auto_fill_8021c8 (0x8e33ac): дескриптор-шаблон rf_auto_fill_brp_tpl (0x8021c8),
 * маска RF = rf. */
u32 rf_utils_auto_fill_8021c8(u32 rf, u32 mode)
{
    struct rf_auto_fill d;
    memcpy_fw(&d, &rf_auto_fill_brp_tpl, 0x10);
    d.rf_mask = (u8)rf;
    return rf_utils_auto_fill(&d, mode);
}

/* marlon_r_if_class__config_brp_sectors (0x8e32b4): для каждого RF маски rf_mask —
 * BRP-сектора из маски 0x85776c[номер RF]: на каждый сектор i три RFC-поля
 * 0x2608/0x2610/0x2614 (+0x18 на сектор): бит сектора и 6 << 3*(i/4) + (1|2)<<28. */
void marlon_r_if_class_config_brp_sectors(u32 rf_mask)
{
    u32 left = rf_popcount(rf_mask);
    u32 k;

    if ((s32)left < 1)
        return;
    for (k = 1; ; k = (u16)(k + 1)) {
        u32 bit = (u8)rf_kth_set_bit(rf_mask, k);
        u32 idx = 0, sectors, cnt, i, reg = 0x13u << 9;

        hwd_abif_dvs_rfca_cmd_enable(bit, 0);
        if ((s32)bit > 8) {
            idx = 4;
            bit >>= 4;
        }
        if ((s32)bit >= 3) {
            idx = (u8)(idx + 2);
            bit >>= 2;
        }
        bit -= 1;
        idx = (u8)(idx + bit);
        sectors = fwsh_sets.brp_cfg_mask[idx];
        cnt = rf_popcount(sectors);
        for (i = 0; cnt != 0; i++) {
            u32 sb = 1u << (i & 31);
            if (sb & sectors) {
                u32 v = 6u << (((i >> 2) * 3) & 31);
                rfc_field_write(0, reg + 0x14, sb, 0);
                rfc_field_write(0, reg + 0x8, sb, 0);
                v += (i <= 0xf) ? 0x10000000u : 0x20000000u;
                rfc_field_write(0, reg + 0x10, v, 0);
                reg += 0x18;
                cnt--;
            }
        }
        left--;
        if (left == 0)
            break;
    }
}

/* marlon_r_if__read_step (0x8c6ccc): auto_fill 0x8021c8 + BRP-сектора для RF маски
 * 0x800243; маска RFCA восстанавливается. 0 — только при ошибке auto_fill и mode == 0. */
u32 marlon_r_if_read_step(struct rf_obj *this, u32 mode)
{
    u32 saved = rfca_get_rf_mask();
    u32 r;

    (void)this;
    r = rf_utils_auto_fill_8021c8(rf_connected_mask, mode);
    if (mode == 0 && r == 0)
        return 0;
    marlon_r_if_class_config_brp_sectors(rf_connected_mask);
    hwd_abif_dvs_rfca_cmd_enable(saved, 0);
    return 1;
}

/* 0x802014: шаблон 6 пар (адрес RF-регистра, слово) handle_omni_sector_info — регистры
 * 0x25e8..0x25fc, слова заполняет код. */
FWDATA(802014) const struct rf_reg_pair rf_omni_pairs_tpl[6] = {
    { 0x25e8, 0 }, { 0x25ec, 0 }, { 0x25f0, 0 }, { 0x25f4, 0 }, { 0x25f8, 0 }, { 0x25fc, 0 },
};

/* handle_omni_sector_info (0x8cd940). this — RF-объект (rf_obj), bnd — окно сверки
 * адресов (struct brd_win, include/brd_if.h), которое заполнил разбор board-file секции
 * канала: first — первая попавшая запись данных, cnt — число записей.
 * На каждый RF маски rx_mask — q = n / (6 * число RF) групп по 6 слов; RF с
 * ненулевыми данными — в маску omni_rf_mask. Данные первого такого RF — в 6 записей
 * (адрес, слово) копии шаблона rf_omni_pairs_tpl (0x802014), которые при единственном RF
 * пишутся во все RF маски rf_mask. Далее fwsh_sets.n_sec[1][0] (0x85773c) = q, и если
 * rf_set_ranges[0][0].last == 0 — rf_set_ranges[0][i].last = n_sec[0][0] − 1 для i < q. */
void handle_omni_sector_info(struct rf_obj *this, const struct brd_win *bnd)
{
    struct rf_reg_pair buf[6];
    u32 rfs = this->rx_mask;
    const u32 *src = bnd->first;
    u32 nrf, q, left, k, first = 1, found = 0, mode;

    memcpy_fw(buf, rf_omni_pairs_tpl, sizeof(buf));
    if ((this->rf_mask & rfs) != rfs) {
        fw_log_emit2(0x10, 0x1005d5c, rfs, this->rf_mask);
        return;
    }
    if (src == 0) {
        fw_log_emit0(0, 0x1005dc0);
        fw_sysassert_fatal((void *)0, 0x1571);
    }

    nrf = rf_popcount(rfs);
    if (nrf == 0)                                   /* vendor: деление на 0 при пустой RX-маске секции */
        return;
    this->sector_cfg_cnt = (u16)fw_divmod_signed(bnd->cnt, nrf * 6);  /* знаковое (0x8c02dc) */
    q = this->sector_cfg_cnt;

    k = 0;
    if ((s32)nrf >= 1) {
        for (left = nrf; ; ) {
            u32 any = 0, j;
            for (j = 0; (s32)j < 6; j = (u16)(j + 1)) {
                if (first != 0)
                    buf[j].val = src[j];
                any |= src[j];
            }
            k = (u16)(k + 1);
            if (any != 0) {
                this->omni_rf_mask |= (u8)rf_kth_set_bit(rfs, k);
                found = (u16)(found + 1);
                first = 0;
            }
            left--;
            src += q * 6;            /* vendor add2 r19,r19,r6 — в задержке ветки */
            if (left == 0)
                break;
        }
    }

    if (found == 0)
        return;
    mode = this->sets_mode;
    if (found != 1) {
        if (mode != 2)
            fw_log_emit2(0, 0x1005e4c, this->sector_cfg_cnt, mode);
        return;
    }
    if (mode != 3 && mode != 1)
        fw_log_emit1(0, 0x1005dfc, mode);

    left = rf_popcount(this->rf_mask);
    if ((s32)left >= 1) {
        for (k = 1; ; k = (u16)(k + 1)) {
            hwd_abif_dvs_rfca_cmd_enable((u8)rf_kth_set_bit(this->rf_mask, k), 0);
            marlon_r_if_class_rf_write_with_block_retries(this, 0, buf, 6, 0x10, 5, 1);
            left--;
            if (left == 0)
                break;
        }
    }

    /* vendor 0x8cdacc..0x8cdafa: sector_cfg_cnt читается заново (ldw) до записи, перед циклом
     * и в каждой итерации, запись n_sec — до чтения rf_set_ranges. Через volatile: с
     * именованными объектами gcc иначе переставляет запись с чтением и схлопывает чтения. */
    const volatile struct rf_obj *vt = this;

    *(volatile u8 *)&fwsh_sets.n_sec[1][0] = (u8)vt->sector_cfg_cnt;
    if (*(volatile u8 *)&rf_set_ranges[0][0].last != 0)
        return;
    {
        u8 v = (u8)(fwsh_sets.n_sec[0][0] - 1);
        u32 i;
        /* vendor: счётчик u8 при sector_cfg_cnt ≥ 256 — вечный цикл; запись за rf_set_ranges[0][32] при > 32 */
        for (i = 0; i < vt->sector_cfg_cnt && i < ARRAY_SIZE(rf_set_ranges[0]); i++)
            rf_set_ranges[0][i].last = v;
    }
}

/* Кадр границ секции канала marlon_r_if_class::config_channel (vendor sp+0, 0x20 Б): окно
 * сверки адресов и набор окон. */
struct rf_channel_bounds_frame {
    struct brd_win win;                        /* 0x00 */
    struct brd_bounds bounds;                  /* 0x18 */
};
_Static_assert(sizeof(struct rf_channel_bounds_frame) == 0x20, "rf_channel_bounds_frame");

/* 0x802044: начальный кадр config_channel (vendor 0x801fa4 + 0xa0): окно [0x2000, 0x22fc]
 * на 0x600 записей, режим 2; одно окно (bounds.win ставит код). n_w читается по значению —
 * не const (чтение DCCM, как у vendor). */
FWDATA(802044) struct rf_channel_bounds_frame rf_channel_bounds_tpl = {
    .win = { .lo = 0x2000, .hi = 0x22fc, .pairs = 0, .first = 0, .cap = 0x600, .cnt = 0, .mode = 2 },
    .bounds = { .win = 0, .n_w = 1 },
};

/* marlon_r_if_class::config_channel (0x8c6d00): канал ch (0..3) — шаблоны
 * по умолчанию, read_step, затем board-file секции канала 2*ch+2 (с границами по
 * шаблону rf_channel_bounds_tpl 0x802044 → handle_omni_sector_info) и 2*ch+3; channel = ch.
 * mode != 0 — ошибки загрузки фатальны. Нет RF — 1 (успех) без настройки.
 * Прежняя версия после загрузки писала 6 RFC-полей 0x34c/0x440/0x444/0x45c/0x454/0x44c —
 * это тело 0x8d3164 (зовёт только temp_sense__prepare_no_rf 0x8d7014), в 0x8c6d00 его нет. */
u32 marlon_r_if_class_config_channel(struct rf_obj *this, u32 ch, u32 mode)
{
    struct brd_win bnd;
    struct brd_bounds desc;

    if (rf_is_present() == 0) {
        fw_log_emit0(0x10, 0x1005ea8);
        return 1;
    }
    if (ch > 3)
        fw_sysassert_fatal((void *)0, 0x119b);
    rf_utils_fill_default_patterns(this);
    if (marlon_r_if_read_step(this, mode) == 0 && mode == 0) {
        fw_log_emit0(0, 0x1005eec);
        return 0;
    }
    fw_log_emit1(0x20, 0x1005f2c, ch + 1);

    memcpy_fw(&bnd, &rf_channel_bounds_tpl.win, 0x18);
    desc.win = &bnd;
    desc.n_w = rf_channel_bounds_tpl.bounds.n_w;
    if (marlon_r_if_class_load_brd_rf_cfg_section(this, ch * 2 + 2, &desc, 0x80, mode) == 0) {
        rf_power_off();
        fw_log_emit1(0, 0x1005f74, ch + 1);
        if (mode != 0)
            fw_sysassert_fatal((void *)0, 0x1191);
        return 0;
    }
    /* vendor: breq r17,0 — r17 = sp+0x18 (адрес desc), всегда не 0 */
    handle_omni_sector_info(this, desc.win);
    fw_log_emit1(0x20, 0x1005fcc, ch + 1);

    if (marlon_r_if_class_load_brd_rf_cfg_section(this, ch * 2 + 3, 0, 0x80, mode) == 0) {
        rf_power_off();
        fw_log_emit1(0, 0x1006014, ch + 1);
        if (mode != 0)
            fw_sysassert_fatal((void *)0, 0x1192);
        return 0;
    }
    this->channel = ch;
    fw_log_emit1(0x20, 0x100606c, ch);
    return 1;
}

/* RFC-регистр 0x3e0: импульс бита 15 с верификацией (0x8cae70). Возврат vendor —
 * r0 последнего вызова: 0xdeadbeef, если чтение не удалось, иначе результат второй
 * hwd_rfc_write_verify (1/0). */
u32 rfc_read_or_dead(void)
{
    u32 r = hwd_rfc_read_rgf(0, 0x3e0);
    if (r == 0xdeadbeefu)
        return r;
    hwd_rfc_write_verify(0, 0x3e0, r | (1u << 15), 6);
    return hwd_rfc_write_verify(0, 0x3e0, r, 6);
}

/* Запись RFC-поля с верификацией (0x8d4468): до d попыток; 1 — прочитано то же
 * значение, 0 — нет (статистика 0x800460/0x800464/0x800468). */
u32 hwd_rfc_write_verify(u32 a, u32 b, u32 c, u32 d)
{
    u32 r17 = a, r14 = b, r15 = c, r16 = d;
    u32 r13 = 0;
    u32 r4;
    for (;;) {
        if (r13 != 0)
            fw_log_emit2(0x10, 0x101e26c, r13, r14);
        rfc_field_write((u8)r17, r14, r15, 0);
        r4 = hwd_rfc_read_rgf((u8)r17, r14);
        if (r13 + 1 >= r16)
            break;
        if (r15 == r4)
            break;
        r13++;
    }
    rfc_wrv_retry_count += r13;
    if (r15 == r4)
        return 1;
    rfc_wrv_last_fail_reg = r14;
    rfc_wrv_fail_count += 1;
    fw_log_emit3(0, 0x101e2b0, r14, r15, r4);
    return 0;
}

/* === RFC-калибровка (цепочка hwd_rfc_read_calibrate 0x8f3f7c) === */

/* rfc__read_core_result_fw (0x8d3628, 80 Б): прочитать результат RFC-ядра. */
__attribute__((section(".textlate"))) u32 rfc_read_core_result_fw(u32 field, u32 *result)
{
    *result = 0;
    MMIO32(HW_RFC_RESET_CTRL) |= (1u << 6);
    MMIO32(HW_RFC_RESET_CTRL) &= ~(1u << 6);
    hwd_rfc_write_core_fw(0, 4, field, 0);
    if (MMIO32(HW_RFC_READ_VALID) == 1) {
        *result = 1;
        return MMIO32(HW_RFC_CORE_DATA);
    }
    return 0xdeadbeefu;
}

/* rfc__read_calib_block (0x8f3610, 136 Б): читать калибровочный блок (n итераций). */
__attribute__((section(".textlate"))) u32 rfc_read_calib_block(u32 n)
{
    u32 r16 = hwd_rfc_read_rgf(0, 1064);
    u32 r13 = 0, r17 = 0, r15 = 0;
    if (r16 == 0xdeadbeefu)
        return 0xffffffffu;
    while (n >= 1) {
        hwd_abif_rfc_divider_restart(0);
        arc_zol_nops2(0x50);            /* vendor 0x8f3648: lp 0x50 × 2 nop_s */
        {
            u32 res, r;
            r = rfc_read_core_result_fw(1064, &res);
            r13++;
            if (res != 1) {
                r15++;
            } else {
                u32 d = r - r16;
                r13 -= d;
                r17 += r13;
                r13 = 0;
                r16 = r;
            }
        }
        n--;
    }
    {
        u32 r = r15 - r13;
        if (r13 == 0) r = r15;
        return r - r17;
    }
}

/* === Мелкие helper'ы hwd_rfc_read_calibrate === */

/* hwd_rfc_read_get_result (0x8f41ac): bb_rdac_val + 6. */
u8 hwd_rfc_read_get_result(void)
{
    return rf_rdac_val + 6;
}

/* rfca__get_rf_mask (0x8ce9c4, 16 Б): маска RFCA = байт [0x889488]>>8. */
__attribute__((section(".textlate"))) u8 rfca_get_rf_mask(void)
{
    return (u8)(MMIO32(HW_ABIF_DVS_RF_CTRL) >> 8);
}

/* === Оставшиеся helper'ы hwd_rfc_read_calibrate === */

/* rfc_read_calib_get_min_failures (0x8f8060, 52 Б): минимум по arr[0..10]. */
__attribute__((section(".textlate"))) u32 rfc_read_calib_get_min_failures(u32 *arr)
{
    u32 r13 = (u32)-1;
    u32 i;
    for (i = 0; i < 0xa; i++) {   /* vendor lp_count=0xa → 10 элементов */
        u32 v = arr[i];
        if (r13 >= v) r13 = v;
    }
    fw_log_emit1(0x20, 0x101ea30, r13);
    return r13;
}

/* get_min_failures_mid_biggest_range_index (0x8f35a8, 104 Б): середина наибольшего
 * непрерывного отрезка значений == min. */
__attribute__((section(".textlate"))) u32 get_min_failures_mid_biggest_range_index(u32 *arr)
{
    u32 min = rfc_read_calib_get_min_failures(arr);
    u32 i, run_len = 0, run_start = 0, max_len = 0, best_start = 0, best_mid = 0;
    if (min == (u32)-1)
        return 0xf;
    for (i = 0; i < 0xa; i++) {   /* vendor brhs r1,0xa → тело 0..9 */
        if (min == arr[i]) {
            if (run_len == 0) run_start = i;
            run_len++;
            if (max_len < run_len) {
                max_len = run_len;
                best_start = i;
                best_mid = run_start;
            }
        } else {
            run_len = 0;
        }
    }
    fw_log_emit2(0x20, 0x101ea64, best_mid, best_start);
    return (best_start + best_mid) >> 1;
}

/* hwd_rfc_read_handle_driver_input (0x8f41c8, 144 Б): обработать ввод драйвера. */
__attribute__((section(".textlate"))) u32 hwd_rfc_read_handle_driver_input(void)
{
    u32 r = MMIO32(RGF_USER_FW_CALIB_RESULT);
    u32 i;
    if ((r & 0x1100) != 0x1100)
        return 0;
    {
        u32 r14 = (u8)r;
        MMIO32(RFC_READ_HYST) = (MMIO32(RFC_READ_HYST) & ~6u) | 2u;  /* vendor bset r0,r0,0x1 = бит 1 (0x2), не бит 0 */
        if (r & 0xF0u)   /* vendor: bic.f r1,r1,-0xf1 → проверка (v & 0xF0)!=0 */
            fw_sysassert_fatal(0, 0xac);
        MMIO32(HW_RFC_RFCA_CFG) = (MMIO32(HW_RFC_RFCA_CFG) & 0xffff0fffu) | (r14 << 12);
        for (i = 0; i < 0xa; i++)   /* vendor lp_count=0xa → 10 слотов */
            rf_rdac_fail_cnt[i] = (u32)-1;
        rf_rdac_val = (u8)(r14 - 6);
        fw_log_emit2(0x20, 0x101e9e0, r14, MMIO32(RGF_USER_FW_CALIB_RESULT));
    }
    return 1;
}

/* === top-level: hwd_rfc_read_calibrate (0x8f3f7c, 560 Б) === */


/* hwd_rfc_read_calibrate (0x8f3f7c, 560 Б): чтение и обработка RFC-калибровки.
 * ЭКСПЕРИМЕНТ: убрал .textlate (vendor 0x8f3f7c в обычном fw_code, не в .textlate).
 * Проверка гипотезы, что вызов к 0x8cbeb8 в .textlate виснет. */
void hwd_rfc_read_calibrate(u32 count)
{
    u32 tsf0[2], tsf1[2];
    u8 mask = rfca_get_rf_mask();
    u32 r22 = MMIO32(HW_RFC_RFCA_CFG);
    u32 r17 = MMIO32(RFC_READ_HYST);
    u32 r24 = 0xc80000u;

    mac_read_tsf64(0, tsf0, 0);

    if (hwd_rfc_read_handle_driver_input() == 1)
        return;

    MMIO32(RFC_CTRL_F8) = (u16)MMIO32(RFC_CTRL_F8) | r24;   /* vendor extw_s — без знака */
    /* Инициализировать слоты failure-счётчиков в 0 (vendor: BSS обнулён стартом).
     * Иначе слоты = мусор (-1) → `if (*slot == -1) continue` пропускает ВСЮ калибровку
     * rdac-свипа → RFC не калибруется → VCO не на частоте → RSSI=0.
     * Слотов 10 (ступени 0..9, ниже r14 < 0xa). Прежде цикл шёл до 0xa включительно: 11-я
     * запись 0x801ab4 попадала в abif_rx_sar_dc_word[0..3] (там нули образа, кодом не
     * пишутся — состояние не менялось); за границу массива не пишем. */
    {
        u32 _i;
        for (_i = 0; _i < 0xa; _i++)
            rf_rdac_fail_cnt[_i] = 0;
    }

    {
        u8 r13 = rf_cfg_get_rf_mask_45e(&rf_obj);
        u32 bitmap = r13;

        while (bit_iter_has_more(&bitmap) != 0) {
            u32 bit = bitmap_alloc_bit(&bitmap);
            hwd_abif_dvs_rfca_cmd_enable((u8)(1u << bit), 0);

            MMIO32(HW_RFC_RFCA_CFG) = r22;
            MMIO32(RFC_READ_HYST) = r17;
            rfc_read_or_dead();
            MMIO32(RFC_READ_HYST) = (MMIO32(RFC_READ_HYST) & ~6u) | 2u;  /* vendor bset r0,r0,0x1 = бит 1 (0x2), не бит 0 */

            {
                u32 r14;
                for (r14 = 0; r14 < 0xa; r14++) {   /* vendor brhs r14,0xa → тело 0..9 */
                    u32 *slot = &rf_rdac_fail_cnt[r14];
                    u8 r15 = (u8)(r14 + 6);
                    if (*slot == (u32)-1)
                        continue;
                    if (r15 & 0xF0u)
                        fw_sysassert_fatal(0, 0xac);
                    MMIO32(HW_RFC_RFCA_CFG) =
                        (MMIO32(HW_RFC_RFCA_CFG) & 0xffff0fffu) | ((u32)r15 << 12);
                    {
                        u32 r = rfc_read_calib_block(count);
                        if (r != (u32)-1)
                            r += *slot;
                        *slot = r;
                    }
                }
            }
        }
    }

    {
        u32 idx = get_min_failures_mid_biggest_range_index(rf_rdac_fail_cnt);
        u8 r2 = (u8)idx;
        rf_rdac_val = (u8)idx;

        if (r2 == 0xf) {
            MMIO32(HW_RFC_RFCA_CFG) = r22;
            MMIO32(RFC_READ_HYST) = r17;
            rf_rdac_val = (u8)(((MMIO32(HW_RFC_RFCA_CFG) >> 12) & 7u) - 6);
        } else {
            u8 r13 = (u8)(r2 + 6);
            if (r13 & 0xF0u)
                fw_sysassert_fatal(0, 0xac);
            MMIO32(HW_RFC_RFCA_CFG) =
                (MMIO32(HW_RFC_RFCA_CFG) & 0xffff0fffu) | ((u32)r13 << 12);
        }
    }

    /* Свип сам выбирает RDAC по минимуму failures (SPI-read теперь работает —
     * round 32: VCO-поле 1064 читается как 0x1b75, не 0xdeadbeef). Хардкод RDAC=12
     * убран: он закреплял VCO на неверной частоте → 0x889104≠0xffff. */
    (void)0;

    hwd_abif_dvs_rfca_cmd_enable(mask, 0);
    MMIO32(RFC_CTRL_F8) = (u16)MMIO32(RFC_CTRL_F8) | r24;   /* vendor extw_s — без знака */
    mac_read_tsf64(0, tsf1, 0);
    (void)tsf1;
    /* ИНТЕГРАЦИЯ (следующий шаг): vendor запускает silent_rssi-калибровку
     * (find_rf_gain/start -> set_agc_start_val -> set_rf_gain_index), заполняющую
     * AGC-конфиг gp+148..182 и включающую RX-цепь RF. Портированы в calib.c,
     * пока не вызываются. */
}

/* === silent_rssi RF-фирма сателлиты (round 193) === */
/* rfc__write_core_reg6 (0x8d32a4): hwd_rfc_write_core_fw(a, 6, b & 0x7fff, 0) (bmsk 14). */
__attribute__((section(".textlate"))) void rfc_write_core_reg6(u32 a, u32 b)
{
    hwd_rfc_write_core_fw(a, 6, b & 0x7fffu, 0);
}

/* rfc__write_field_1136: rfc_field_write((u8)a, 0x470, 0x10). */
__attribute__((section(".textlate"))) void rfc_write_field_1136(u32 a)
{
    rfc_field_write((u8)a, 0x470, 0x10, 0);
}

/* hwd__setup_pair (0x8d33f8): rfc_write_core_reg6(0,1) + hwd_rfc_write_core_fw(a,8,0,0), затем
 * журнал «hwd_RFC_POWERDOWN_DEEP_ENTRY» (0x8d3412: fw_log_emit0(0x21, 0x101e304); прежний
 * порт его терял). */
__attribute__((section(".textlate"))) void hwd_setup_pair(u32 a, u32 b)
{
    (void)b;
    rfc_write_core_reg6(0, 1);
    hwd_rfc_write_core_fw(a, 8, 0, 0);
    fw_log_emit0(0x21, 0x101e304);
}

/* rf__set_txrx_sets_save_fw (0x8d3efc): сохранить+установить TX/RX-сеты. */
__attribute__((section(".textlate"))) void rf_set_txrx_sets_save_fw(u32 a, u32 b, u32 *out1, u32 *out2)
{
    if (out1) *out1 = MMIO32(HW_ABIF_DVS_RF_CTRL);
    if (out2) *out2 = MMIO32(HW_RFC_RFCA_CFG);
    if (b & ~0xffu) fw_sysassert_fatal(0, 0xac);
    MMIO32(HW_ABIF_DVS_RF_CTRL) = (MMIO32(HW_ABIF_DVS_RF_CTRL) & 0xff00ffffu) | (b << 16);
    if (a & ~0xfu) fw_sysassert_fatal(0, 0xad);
    /* vendor: bits 0-3 = a, bits 4-7 = a (a * 0x11), НЕ только a&0xf */
    MMIO32(HW_RFC_RFCA_CFG) = (MMIO32(HW_RFC_RFCA_CFG) & ~0xffu) | ((a & 0xfu) | ((a & 0xfu) << 4));
}

/* rfc__restore_txrx_sets_fw (0x8d3???): восстановить TX/RX-сеты. */
__attribute__((section(".textlate"))) void rfc_restore_txrx_sets_fw(void)
{
    u32 s1, s2;
    rf_set_txrx_sets_save_fw(0xf, 0xff, &s1, &s2);
    MMIO32(HW_RFC_RESET_CTRL) &= ~(1u << 4);
    /* vendor 0x8d347c: ldb [gp,0xc0]; asl_s 4; add2_s → n = байт × 80; lp n × 2 nop_s (без
     * проверки n == 0). Прежний цикл по volatile-счётчику на стеке был в разы длиннее. */
    arc_zol_nops2((u32)rf_restore_sets_delay * 80u);
    MMIO32(HW_RFC_RESET_CTRL) |= (1u << 4);
    MMIO32(HW_ABIF_DVS_RF_CTRL) = s1;
    MMIO32(HW_RFC_RFCA_CFG) = s2;
    rfc_write_core_reg6(0, 0);
    rfc_write_field_1136(0);
}
