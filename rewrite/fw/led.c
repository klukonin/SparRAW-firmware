// SPDX-License-Identifier: AGPL-3.0-or-later
/* LED-схема — led_scheme__apply (0x8da84c). */
#include "../include/types.h"
#include "../include/sys_cfg.h"


/* Колбэк отложенного выключения LED (0x8da8b8). */
void led_scheme_apply_off(u32 a0, u32 a1)
{
    (void)a0;
    (void)a1;
    led_blink_timer = 0;
    hw_ch_enable_once(led_scheme_channel, 0, 0x64);
}

/* led_scheme__apply (0x8da84c): схема idx < 7 из таблицы 0x803c00+0x2a (шаг 6). */
void led_scheme_apply(u32 idx)
{
    if (idx >= 7)
        fw_sysassert_fatal((void *)0, 0x1158);

    u32 *state = &led_blink_timer;
    if (*state != 0) {
        u_schd_cancel(*state);
        *state = 0;
    }

    /* vendor: add_s r14,r14,r14; add1_s r14,r14,r14 → idx*6 (запись — три u16). */
    const struct led_scheme *tbl = dashboard.cfg.led, *e = tbl + idx;
    u16 dur = e->duration_ms;
    u16 a   = e->on;
    u16 b   = e->period;

    if (dur != 0) {
        u_schd_fn cb = led_scheme_apply_off;
        *state = u_schd_schedule(cb, 0, 0, 0, dur * 0x3e8, 0, 0);
    }

    hw_ch_enable_once(led_scheme_channel, a, b);
}
