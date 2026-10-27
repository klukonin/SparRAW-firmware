// SPDX-License-Identifier: AGPL-3.0-or-later
/* Инициализация аппаратуры: GPIO, персональность платы, счётчики. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/sys_cfg.h"
#include "../include/fwdata.h"

/* Таблица конфигурации SDP-портов (0x800c34) — значения vendor-образа. */
FWDATA(800c34) u32 sdp_port_cfg[SDP_PORT_COUNT] = {
    0x5484, 0x1545, 0x1546, 0x1547, 0x530c, 0x040d, 0x040e, 0x510f, 0x510f,
};



/* SDP::hwd_sdp_is_defined_mode (0x8f4330): режим GPIO < 4, иначе лог + сисассерт 0x1414. */
static void sdp_check_defined_mode(u32 mode)
{
    if (mode >= 4) {
        fw_log_emit1(0, 0x101f3b4, mode);
        fw_sysassert_fatal(__builtin_return_address(0), 0x1414);
    }
}

/* SDP::hwd_sdp_is_gpio_sdp (0x8f4378): порт — SDP (0x8f4354) и >= 5, иначе 0x1415. */
static void sdp_check_gpio_sdp(u32 pin)
{
    SDP_hwd_sdp_is_defined_sdp(pin);
    if (pin < 5) {
        fw_log_emit1(0, 0x101f400, pin);
        fw_sysassert_fatal(__builtin_return_address(0), 0x1415);
    }
}

/* Установить функцию GPIO-пина + дамп (0x8f4294). Регистр — 0x880068 + ((pin-5) >> 3) * 4
 * (vendor add2_s; прежде было *2 — для пина 15 запись уходила по невыровненному 0x88006a),
 * поле — 4 бита на пин. */
void gpio_set_pin_func_and_dump(u32 func, u32 pin)
{
    sdp_check_defined_mode(func);
    sdp_check_gpio_sdp(pin);
    u32 idx = pin - 5;
    u32 reg = HW_GPIO_FUNC_SEL_0 + (idx >> 3) * 4;
    u32 shift = (idx & 7) << 2;
    u32 v = MMIO32(reg);
    v &= ~(0xfu << shift);
    v |= func << shift;
    MMIO32(reg) = v;
    fw_log_emit3(0x20, 0x101f450, MMIO32(HW_GPIO_FUNC_SEL_0), MMIO32(HW_GPIO_FUNC_SEL_1), MMIO32(HW_GPIO_FUNC_SEL_2));
}

/* Взвести/сбросить бит "defined" SDP (0x8f43d4). */
void sdp_set_defined_bit(u32 on, u32 bit)
{
    SDP_hwd_sdp_is_defined_sdp(bit);
    u32 mask = 1u << bit;
    u32 v = MMIO32(HW_SDP_GPIO_ENABLE);
    MMIO32(HW_SDP_GPIO_ENABLE) = on == 0 ? (v & ~mask) : (v | mask);
}


/* Шаг персональности SDP-GPIO (0x8f1920). */
u32 sdp_gpio_personality_step(u32 i)
{
    u32 r2 = sdp_port_cfg[i];
    u32 r0 = (r2 >> 13) & 3;
    /* 0x880ab8 — hw_personality (REGS-KNOWN); имя адреса — BL_MAGIC (раскладка загрузчика,
     * второе имя не заводим). */
    u32 p = MMIO32(BL_MAGIC);
    switch (r0) {
    case 0: return (p == 0) ? 1 : 0;
    case 1: return (p == 1) ? 1 : 0;
    case 2: return 1;
    case 3: return 0;
    }
    fw_log_emit1(0, 0x1008ed0, r2 & 0x1f);   /* bmsk_s r2,r2,4 */
    fw_sysassert_fatal((void *)0, 0x1311);
    return 1;
}

/* Проверить, что индекс SDP в диапазоне (0x8f4354). */
u32 SDP_hwd_sdp_is_defined_sdp(u32 i)
{
    if (i >= 0x1c) {
        fw_log_emit1(0, 0x101f2ac, i);
        fw_sysassert_fatal((void *)0, 0x1312);
    }
    return i;
}

/* Импульс GPIO-пина 18 (0x880b60). */
/* Бит 18 user-ICR — команда хоста в operational-ящике (vendor 0x8cd724): маска + задача
 * mbox__drain_operational; маску снимает vt[2] ящика после разбора. */
void gpio_pulse_880b60_18(void)
{
    MMIO32(HW_RGF_USER_USER_ICR_IMS) = 0x40000;
    u_schd_add(mbox_drain_operational, 0, 0, 1);
}

/* Импульс GPIO-пина 19 (0x880b60). */
void gpio_pulse_880b60_19(void)
{
    gpio19_pulse_count += 1;
    MMIO32(HW_RGF_USER_USER_ICR_IMS) = 0x80000;
    u_schd_add(mbox_drain_debug, 0, 0, 1);   /* vendor 0x8cd744 */
}

/* Прочитать strap-пин персональности. */
u32 hw_personality_read_strap(u32 i)
{
    u32 pin = SDP_hwd_sdp_is_defined_sdp(i);
    u32 v = MMIO32(HW_SDP_GPIO_STRAP_IN);
    return ((1u << pin) & v) >> pin;
}

/* Сброс GPIO-конфигурации (0x8f4444). */
void gpio_reset_config(void)
{
    fw_log_emit0(0x20, 0x101f330);
    MMIO32(HW_GPIO_FUNC_SEL_0) = 0x22222;
    MMIO32(HW_GPIO_FUNC_SEL_1) = 0;
    MMIO32(HW_GPIO_FUNC_SEL_2) = 0;
    MMIO32(HW_GPIO_CFG_3) = 0;
    MMIO32(HW_GPIO_CFG_4) = 0;
    MMIO32(HW_GPIO_CFG_5) = 0;
    MMIO32(HW_SDP_GPIO_ENABLE) = 0;
    MMIO32(HW_SDP_GPIO_CFG_B70) = 0;
    gpio_write_ctrl_b84(1);   /* 0x880b84=1 — «взвести» GPIO-контроллер (иначе 0x880b88/90 виснет) */
}

/* Запись GPIO-контрола в 0x880b84. */
void gpio_write_ctrl_b84(u32 v)
{
    MMIO32(HW_SDP_GPIO_CTRL) = v;
}

/* Определить персональность платы, записать в 0x880ab8. */
void hw_personality_detect(void)
{
    u32 r1 = (dashboard.cfg.special_flags >> 13) & 3;
    u32 r0;
    if (r1 == 1) {
        fw_log_emit0(0x20, 0x1008e9c);
        r0 = 0;
    } else {
        /* vendor 0x8f84e2: bl.d read_strap, bmsk_s r0,r0,4 в слоте задержки — маскируется
         * аргумент (номер пина), а не результат (прежде — ассерт 0x1312 при загрузке). */
        r0 = hw_personality_read_strap(sdp_port_cfg[0] & 0x1f);
        if (r0 != 0) {
            fw_log_emit0(0x20, 0x1008eb8);
            r0 = 1;
        } else {
            fw_log_emit0(0x20, 0x1008e9c);
            r0 = 0;
        }
    }
    MMIO32(BL_MAGIC) = r0;   /* [0x880a3c+0x7c] hw_personality (в hw.h — BL_MAGIC) */
}

/* SparRAW: ожидание бита регистра с пределом (want = 1 — установлен, 0 — снят). vendor ждал готовности
 * железа без предела — при зависшем блоке fw висела молча. Таймаут — запись с адресом, значением и маской,
 * возврат 0; что делать дальше, решает вызывающий (отказ или ассерт 0x3002 — место видно хосту). */
u32 hw_poll_bit(u32 addr, u32 mask, u32 want)
{
    u32 n;

    for (n = 0; n < HW_POLL_MAX; n++)
        if (((MMIO32(addr) & mask) != 0) == (want != 0))
            return 1;
    fw_log_emit3(0, LS_FW(HW_POLL_TIMEOUT), addr, MMIO32(addr), mask);
    return 0;
}

/* Таймаут HW_POLL_WHILE_SET (include/hw.h): запись и ассерт 0x3002; caller — место опроса. Отдельной
 * функцией, чтобы цикл опроса оставался коротким. */
__attribute__((noinline, cold)) void hw_poll_fail(u32 addr, u32 mask)
{
    fw_log_emit3(0, LS_FW(HW_POLL_TIMEOUT), addr, MMIO32(addr), mask);
    fw_sysassert_fatal(__builtin_return_address(0), 0x3002);
}

/* cnt_handler__clear_all (0x8f6424): команды очистки счётчиков MAC в 0x887008 с опросом
 * готовности (биты 30/31) — до N+1 опросов. Баг vendor (lp со счётчиком неудач, проверка «== 0» после
 * цикла): настоящий таймаут (все N+1 опросов неудачны, счётчик −1) не замечался, а успех ровно на последнем
 * опросе считался таймаутом. SparRAW: таймаут — неудача всех опросов; фаза 1 повторяет команду (+1 к
 * [0x8003d8]), повторный таймаут и таймауты фаз 2/3 — запись в журнал (фаза, регистр) и дальше: vendor на
 * настоящем таймауте тоже продолжал, а ассерты 0x1187..0x1189 на этом пути не нужны — счётчики не критичны. */
static u32 cnt_poll(u32 mask, u32 n)
{
    u32 i;

    for (i = 0; i < n + 1; i++)
        if ((MMIO32(HW_MAC_CNT_CTRL) & mask) == mask)
            return 1;
    return 0;
}

void cnt_handler_clear_all(void)
{
    /* Фаза 1: 0x3d8000, ждём биты 30 и 31. */
    MMIO32(HW_MAC_CNT_CTRL) = 0x3d8000;
    if (!cnt_poll(3u << 30, 1000)) {
        mac_cnt_clear_retry_count += 1;    /* [gp,596]: счётчик повторов */
        MMIO32(HW_MAC_CNT_CTRL) = 0x3d8000; /* r1 = 0x7b << 15 */
        if (!cnt_poll(3u << 30, 1000))
            fw_log_emit2(0, LS_FW(MAC_CNT_CLEAR_TIMEOUT), 1, MMIO32(HW_MAC_CNT_CTRL));
    }

    /* Фаза 2: 0x2a4000, ждём бит 31. */
    MMIO32(HW_MAC_CNT_CTRL) = 0x2a4000;
    if (!cnt_poll(1u << 31, 10000))
        fw_log_emit2(0, LS_FW(MAC_CNT_CLEAR_TIMEOUT), 2, MMIO32(HW_MAC_CNT_CTRL));

    /* Фаза 3: 0x1a2000, ждём бит 30. */
    MMIO32(HW_MAC_CNT_CTRL) = 0x1a2000;
    if (!cnt_poll(1u << 30, 10000))
        fw_log_emit2(0, LS_FW(MAC_CNT_CLEAR_TIMEOUT), 3, MMIO32(HW_MAC_CNT_CTRL));
}

/* sdp_gpio__boot_init (0x8f8384): сброс GPIO → пустая задержка (lp 800 × 2 nop_s) →
 * определение персональности → SDP_sdp_init_2 для портов 0..8, включённых при этой
 * персональности (0x8f1920). */
static inline __attribute__((always_inline)) void sdp_nop_delay(u32 n)
{
    /* vendor: lp_count = n; nop_s; lp, тело — 2 nop_s (0x8f8390, 0x8f840e, 0x8f8466). n > 0. */
    arc_zol_nops2_mb(n);
}

__attribute__((section(".textlate"))) void sdp_gpio_boot_init(void)
{
    u32 i;

    gpio_reset_config();
    sdp_nop_delay(800);
    hw_personality_detect();

    for (i = 0; i < 9; i++) {
        if (sdp_gpio_personality_step(i) != 0)
            SDP_sdp_init_2(i);
    }
}

/* SDP::hwd_sdp_is_int_ctrl_sdp (0x8f43a4): SDP-порт (0x8f4354) из 10..15, иначе лог +
 * сисассерт 0x1310. */
static void sdp_check_int_ctrl_sdp(u32 pin)
{
    SDP_hwd_sdp_is_defined_sdp(pin);
    if (pin < 0xa || pin >= 0x10) {
        fw_log_emit1(0, 0x101f350, pin);
        fw_sysassert_fatal(__builtin_return_address(0), 0x1310);
    }
}

/* SDP::hwd_sdp_int_mask (0x8f42fc): бит (pin - 10) регистра 0x880bb4 — on ? set : clear. */
static void sdp_set_int_enable(u32 on, u32 pin)
{
    sdp_check_int_ctrl_sdp(pin);
    u32 m = 1u << (u8)(pin - 0xa);
    u32 v = MMIO32(HW_SDP_GPIO_INT_CTRL);
    MMIO32(HW_SDP_GPIO_INT_CTRL) = (on == 0) ? (v & ~m) : (v | m);
}

/* SDP::hwd_sdp_int_ack_unmask (0x8f42e4): проверка порта (0x8f43a4), затем бит pin + 11
 * user-ICR: квитировать (0x880b50, 0x8d4758) и размаскировать (0x880b64, 0x8d477c). */
static void sdp_int_ack_unmask(u32 pin)
{
    sdp_check_int_ctrl_sdp(pin);
    u32 m = 1u << (pin + 0xb);
    MMIO32(HW_RGF_USER_USER_ICR_ICR) = m;
    MMIO32(HW_RGF_USER_USER_ICR_IMC) = m;
}

/* SDP::sdp_init (0x8f83c0). Слово конфигурации порта (таблица 0x800c34): [4:0] пин,
 * [7:5] функция GPIO (4 — не трогать), [8] выход разрешён, [10:9] начальное значение
 * выхода (0/1 — выставить, 2/3 — не трогать), [12:11] прерывание (0/1 — настроить),
 * [14:13] персональность. Прежде: пин маскировался 4 битами вместо 5, функция — 2 битами
 * вместо 3, начальное значение 0 не выставлялось (vendor: bmsk.f + cmp.ne → 0 и 1 оба
 * проходят — так на SDP 0xf выставляется 0), задержка порта 4 после выхода и настройка
 * прерываний отсутствовали. */
__attribute__((section(".textlate"))) void SDP_sdp_init_2(u32 i)
{
    volatile u32 *tbl = sdp_port_cfg;
    u32 r13 = tbl[i];
    u32 pin = r13 & 0x1f;

    fw_log_emit1(0x20, 0x1008f24, pin);            /* "Configuring SDP %d" */
    u32 func = (tbl[i] >> 5) & 7;
    if (func != 4)
        gpio_set_pin_func_and_dump(func, pin);

    u32 r15 = tbl[i];
    sdp_set_defined_bit((r15 >> 8) & 1, pin);
    if (i == 4)
        sdp_nop_delay(0x13880);

    u32 init = (tbl[i] >> 9) & 3;
    if (init == 0 || init == 1) {
        if (!(r15 & (1u << 8))) {
            fw_log_emit1(0, 0x1008f38, pin);
            fw_sysassert_fatal(__builtin_return_address(0), 0x1416);
        }
        hwd_sdp_drive_value(init, pin);
        if (i == 4)
            sdp_nop_delay(0x13880);
    }

    u32 irq = (tbl[i] >> 11) & 3;
    if (irq == 0 || irq == 1) {
        if (r15 & (1u << 8)) {
            fw_log_emit1(0, 0x1008fac, pin);
            fw_sysassert_fatal(__builtin_return_address(0), 0x1413);
        }
        sdp_set_int_enable(irq, pin);
        sdp_int_ack_unmask(pin);
    }
}

/* Управление SDP-пином (0x8f4258): value==1 → 0x880b90 (HIGH), иначе → 0x880b88 (LOW). */
void hwd_sdp_drive_value(u32 value, u32 pin)
{
    fw_log_emit2(0x20, 0x101f2fc, value, pin);
    SDP_hwd_sdp_is_defined_sdp(pin);
    u32 m = 1u << pin;
    if (value == 1)
        MMIO32(HW_SDP_GPIO_OUT_SET) = m; /* GPIO set → HIGH (деассерт сброса RF) */
    else
        MMIO32(HW_SDP_GPIO_OUT_CLR) = m; /* GPIO clear → LOW (ассерт сброса RF) */
}

/* Порт SDP → реальный GPIO-пин (0x8e4abc). Проверка порта — 0x8e4b04. */
void SDP_sdp_drive_value(u32 value, u32 port)
{
    if (port >= 9) {
        fw_log_emit1(0, 0x1009004, port);
        fw_sysassert_fatal((void *)0, 0x1410);
    }
    u32 v = sdp_port_cfg[port];
    if (!(v & 0x100)) {
        fw_log_emit1(0, 0x1009054, v & 0x1f);
        fw_sysassert_fatal((void *)0, 0x140f);
    }
    hwd_sdp_drive_value(value, v & 0x1f);
}

/* Программирование ARC action point (0x8c3af0). */
__attribute__((section(".textlate"))) void arc_action_point_arm(const struct arc_ap_cfg *cfg)
{
    arc_sr(0x1000000u, 5);   /* aux DEBUG = бит 24 — до проверки индекса, как vendor */
    if (cfg->idx >= 2)
        fw_sysassert_fatal(__builtin_return_address(0), 0xf6);

    /* vendor: [cfg+0xc] | [cfg+0x10] << 4 (сдвигается ttype, не target) */
    u32 r2 = cfg->target | (cfg->ttype << 4);
    r2 |= (cfg->mode << 6);
    r2 |= (cfg->pair << 7);
    u32 r1 = (cfg->ac8 << 8) | r2;

    /* add1_s r0,r0,r0 = r0 + (r0 << 1) = 3 × индекс: тройка AMV/AMM/AC точки N —
     * aux 0x220 + 3N .. 0x222 + 3N. Прежде было 2N — для N = 1 (ICCM) писались
     * 0x222..0x224 (AC0, AMV1, AMM1), а AC1 (0x225) не включался. */
    u32 r0 = cfg->idx * 3;
    arc_sr(cfg->value, 0x220 + r0);
    arc_sr(cfg->mask, 0x221 + r0);
    arc_sr(r1, 0x222 + r0);
}

/* sdp__drive_pin_timed (0x8d6e88): выдержка hold = max([0x8004c6] u16, 0x2328) (пишется
 * обратно). v == 0: снимок TSF в [0x800500..504]. v != 0: если снимок ненулевой — ждать,
 * пока TSF ≥ снимок + hold (64 бит), и обнулить снимок (при нулевом снимке ожидания нет).
 * Затем SDP-порт 4 = v (0x8e4abc), пустая задержка 0x13880×2 nop; при v == 1 и
 * [0x8004c8] (u16) != 0 — ещё [0x8004c8]×80 ×2 nop. */

__attribute__((section(".textlate"))) void sdp_drive_pin_timed(u32 v)
{
    u16 hold = rf_pwr_on_hold;
    if (hold < 0x2328)
        hold = 0x2328;
    rf_pwr_on_hold = hold;

    volatile u32 *snap = rf_pwr_snap_tsf;
    if (v == 0) {
        mac_read_tsf64(0, (u32 *)rf_pwr_snap_tsf, 0);
    } else if ((snap[0] | snap[1]) != 0) {
        /* vendor: r16:r15 = снимок + hold (add.f/adc), опрос TSF пока цель > TSF (bhi). */
        u32 lo = snap[0] + hold;
        u32 hi = snap[1] + (lo < hold ? 1u : 0u);
        u32 now[2];
        do {
            mac_read_tsf64(0, now, 0);
        } while (hi > now[1] || (hi == now[1] && lo > now[0]));
        snap[0] = 0;
        snap[1] = 0;
    }

    SDP_sdp_drive_value(v, 4);              /* порт 4 = RF reset/power → пин 12 */
    /* Пустая задержка vendor: lp_count = 0x13880; nop_s; lp, тело — 2 nop_s (0x8d6ef6..0x8d6f08). */
    arc_zol_nops2_mb(0x13880);
    if (v == 1) {
        u32 d = rf_pwr_on_extra_delay;  /* ldw: u16 */
        if (d != 0) {
            d = (d << 4) * 5;               /* asl 4; add2_s r0,r0,r0 → ×80 */
            arc_zol_nops2_mb(d);            /* vendor 0x8d6f1c: lp d × 2 nop_s */
        }
    }
}
