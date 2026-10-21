// SPDX-License-Identifier: AGPL-3.0-or-later
/* Загрузка конфигурации из flash — boot__load_from_flash (0x8f2f9c): заголовок flash
 * (struct flash_hdr) и секция идентификаторов/калибровок (struct flash_ids, 0x840040) —
 * include/sys_cfg.h. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/sys_cfg.h"


/* flash_cfg_set_* — запись калибровочных параметров в глобальные байты. */
/* flash_cfg__set_bb_sensor_calib (0x8e62fc): sth.as [gp,69]/[gp,70] — .as у sth
 * масштабирует смещение на 2: 0x80020e = 0x80020e (Tamb) и 0x800210 (начальная
 * температура), их читает temp_service. Прежде писалось в 0x800298/0x80029c (масштаб 4) —
 * затирались счётчик в fw_sysassert_fatal и поле cfg_w10_field (mac_bringup.c). */
void flash_cfg_set_bb_sensor_calib(u16 a, u16 b)
{
    temp_bb_otp_tamb = (s16)a;
    temp_bb_otp_t0 = (s16)b;
}
void flash_cfg_set_lo_power_gc_ctrl(s8 v)
{
    calib_lo_power_gc_ctrl = (u8)v;  /* [gp,0xd0] */
}
void flash_cfg_set_lo_power_stg2_bias(u8 v)
{
    calib_lo_power_stg2_bias = v;      /* [gp,0xd1] */
}
void flash_cfg_set_lo_power_xif_gc(u32 v)
{
    calib_lo_power_xif_gc = (u8)v;  /* [gp,0xd2] */
}


/* Сохранить MAC-адрес из flash-конфига в глобальный буфер. */
void boot_save_mac_address(u8 *mac)
{
    memcpy_fw(dev_mac_addr, mac, 6);
}

/* Конфигурация ABIF через регистр 0x88afb4 (v — 6-битное значение). */
void hwd_abif_uses_rgf_88af80(s32 v)
{
    if (v & ~0x3f)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_ABIF_CTRL_B4) = ((u32)v << 8) | (MMIO32(HW_ABIF_CTRL_B4) & 0xffffc0ffu);
}

void boot_load_from_flash(void)
{
    struct flash_hdr hdr;
    struct flash_ids *cfg = &flash_ids;

    fw_log_emit0(0x20, 0x1001754);

    if (!hwd_spi_read(0, sizeof(hdr), &hdr)) {
        fw_log_emit0(0x0, 0x100176c);
        return;
    }

    if (!hwd_spi_read(hdr.ids_section_off, sizeof(*cfg), cfg)) {
        fw_log_emit0(0x0, 0x100178c);
        return;
    }

    /* vendor 0x8f2fe6: r2 = [cfg+6], r3 = [cfg+4], r4 = [cfg+2] (прежде порядок был
     * [2],[6],[4] — в журнале MAC печатался переставленным). */
    fw_log_emit3(0x20, 0x10017b4, cfg->mac_h[2], cfg->mac_h[1], cfg->mac_h[0]);
    boot_save_mac_address(cfg->mac);

    dashboard.ssid_len = 0;
    fw_log_emit0(0x20, 0x10017d8);

    u32 r15 = cfg->ppm;
    fw_log_emit1(0x20, 0x1001810, r15);          /* «ppm value from flash: %d» */
    if (r15 > 0x3f) {
        fw_log_emit2(0x10, 0x100182c, r15, 0x3f);
        r15 = 0;
    }
    hwd_abif_uses_rgf_88af80((s32)r15);

    fw_log_emit1(0x20, 0x1001860, cfg->lo_power_xif_gc);
    fw_log_emit1(0x20, 0x1001860, 0);
    flash_cfg_set_lo_power_xif_gc(0);

    u32 r13 = cfg->lo_power_stg2_bias;
    fw_log_emit1(0x20, 0x1001888, r13);
    if (r13 < 5)
        r13 = 5;
    fw_log_emit1(0x20, 0x1001888, r13);
    if (r13 >= 0x10) {
        fw_log_emit2(0x10, 0x10018b0, r13, 0xf);
    } else {
        flash_cfg_set_lo_power_stg2_bias(cfg->lo_power_stg2_bias_b);
    }

    u16 *c82 = &cfg->lo_power_gc_ctrl;
    fw_log_emit1(0x20, 0x10018e8, *c82);
    *c82 = 0xf;
    fw_log_emit1(0x20, 0x10018e8, 0xf);
    u32 r2 = *c82;
    if (r2 >= 0x10) {
        fw_log_emit2(0x0, 0x1001910, r2, 0xf);
        r2 = 0xc;
        *c82 = 0xc;
    }
    flash_cfg_set_lo_power_gc_ctrl((s8)r2);

    u32 r15b = cfg->vga_bias;
    fw_log_emit1(0x20, 0x100193c, r15b);
    if (r15b >= 0x10) {
        fw_log_emit2(0x10, 0x100195c, r15b, 0xf);
    } else {
        hwd_abif_rx_table_config_vga_bias_all_rows(0, 0x3f, 1, (s8)r15b);
    }

    u32 r14 = cfg->vga_stg1_fine_bias;
    fw_log_emit1(0x20, 0x100198c, r14);
    if (r14 >= 0x10) {
        fw_log_emit2(0x10, 0x10019b4, r14, 0xf);
    } else {
        hwd_abif_rx_table_config_vga_stg1_fine_bias_all_rows(0, 0x3f, (s8)r14);
    }

    flash_cfg_set_bb_sensor_calib(cfg->bb_sensor_tamb, cfg->bb_sensor_temp0);
}
