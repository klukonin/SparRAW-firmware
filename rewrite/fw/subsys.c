// SPDX-License-Identifier: AGPL-3.0-or-later
/* Инициализация конфигурации подсистем — boot__init_subsystems (0x8f519c): заполняет
 * dashboard (0x803b80) и вложенную конфигурацию системы sys_cfg (0x803c00) —
 * include/sys_cfg.h. */
#include "../include/types.h"
#include "../include/fwdata.h"
#include "../include/sys_cfg.h"

/* dashboard (0x803b80, 0xd4 Б): в образе fw_data — нули. */
FWDATA(803b80) struct dashboard dashboard = { 0 };

/* 0x801ba8: пароль по умолчанию (boot_init_subsystems копирует 9 Б с нулём). */
FWDATA(801ba8) const char boot_default_password[9] = "12345678";

/* Записи — через volatile-вид объекта: vendor пишет поля по одному (stb/stw) в порядке
 * исходника; без volatile gcc сливает соседние байты и полуслова (0x94/0x95, LED-схемы) в
 * sth/st и переставляет записи. */
void boot_init_subsystems(struct dashboard *dash)
{
    volatile struct dashboard *d = dash;
    u8 name[12];

    memcpy_fw(name, boot_default_password, 9); /* пароль по умолчанию «12345678» */

    d->pcp_channel = 1;
    d->ssid_len = 0;

    /* Пароль по умолчанию: имя → passphrase, длина + 1 → passphrase_len. */
    u32 idx = boot_init_named_object(dash, name, 0, dash->passphrase);
    d->passphrase_len = (u16)(idx + 1);

    d->pcp_security_en = 0;
    d->pcp_sec_offload_en = 0;
    d->rsv_74[0] = 1;
    d->rsv_74[1] = 1;
    d->rsv_74[2] = 1;

    /* add3 r14,r15,0x10 = d + (0x10 << 3): база sys_cfg = d + 0x80 (0x803c00). */
    volatile struct sys_cfg *c = &d->cfg;
    c->host_assert_notify_en = 1;
    c->assert_led_en = 1;
    c->rsv_08 = 0;
    c->oob_r1_mode = 0;                         /* OOB R1/R2 (по strap) — только SparRAW-pro */
    c->oob_r2_mode = 0;
    c->ap_sme_offload_mode = 0;

    c->cca_bi_avg_num = 0xff;
    c->rsv_18 = 0;

    /* special_flags: очистить биты 0x2f и 6..12, затем поля 13..14 и 15..31. */
    volatile u32 *f = &c->special_flags;
    *f = (*f & ~0x2fu) & 0xffffe03fu;
    bits_set_word((u32 *)f, 13, 2, 0);
    bits_set_word((u32 *)f, 15, 17, 0);

    /* LED-схемы 0..6 {on, period, duration_ms} — по возрастанию адреса. vendor пишет
     * sys_cfg +0x2a..+0x3e от базы r14, затем +0x40..+0x52 от d + 0xc0 (sth.aw r13,[r15,192]). */
    c->led[0].on = 0;
    c->led[0].period = 0x64;
    c->led[0].duration_ms = 0;
    c->led[1].on = 0x64;
    c->led[1].period = 0;
    c->led[1].duration_ms = 0;
    c->led[2].on = 0x64;
    c->led[2].period = 0;
    c->led[2].duration_ms = 0;
    c->led[3].on = 0x64;
    c->led[3].period = 0;
    c->led[3].duration_ms = 0;
    c->led[4].on = 0;
    c->led[4].period = 0x64;
    c->led[4].duration_ms = 0;
    c->led[5].on = 0x64;
    c->led[5].period = 0x64;
    c->led[5].duration_ms = 0;
    c->led[6].on = 0;
    c->led[6].period = 0x64;
    c->led[6].duration_ms = 0;
}
