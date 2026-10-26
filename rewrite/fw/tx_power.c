/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Мощность TX (open): потолок кода усиления TX-строк RF-таблиц, заданный хостом (WMI_SPARRAW_TX_POWER, 0x0f12).
 *
 * В RF две таблицы усилений по 16 строк из board-файла (секция 0xb000900d, грузится в
 * rf_configure_role_power): таблица 0 — RF-рег. 0x00…0x3c (0x8000 | три полубайта ступеней), таблица 1 —
 * 0x40…0x7c (0x40000 | два полубайта); строки 0…7 — TX, 8…15 — RX. В работе TX берёт строку 7 (стенд: понижение
 * только строки 7 снижает сигнал на пире, строк 2…6 — нет; RouterOS tx-power правит только её). Код t — потолок
 * для всех TX-строк 2…7 обеих таблиц: каждый полубайт = min(значение board-файла, t), как board-файл lowpwr на
 * стенде, — чтобы ни одна TX-строка не осталась выше заданной. Строки 0/1 (0x7000/0xf000 — другой формат) не
 * трогаются.
 *
 * Запись строк сама мощность не меняет: RF берёт новые значения по команде RF core 1 (та же, что uc шлёт
 * при BRP, rfc_clear_core_reg1). Строки + команда 1 меняют мощность сразу, на всех TX-секторах и без разрыва
 * линка. Стенд 2026-10-26 (wAP 60G, board 60deg, SNR всех 64 секторов на пире по fwsh_sect_snr, медиана): код
 * 8…15 — 0 дБ (плато), 7 — −2,5, 6 — −5,5, 5 — −10, 4 — −16, 3 — ≈ −22 (у пира рядом принимается 2…14 секторов из
 * 64); повышение и понижение — сразу, разрывов нет. Перенастройка канала тоже применяет строки, но рвёт линк
 * (перезаливает RX-секторы) — для смены на ходу не годится.
 *
 * Применение — под замком радио-менеджера (вторичный запрос без канала: uc RX выкл., TX fw на паузе на время
 * записи), чтобы команды RFC fw не пересекались с командами RFC uc. Заданный код подставляется и после каждой
 * загрузки секции из board-файла (старт, восстановление RF). 0xff — значения board-файла. Настройка не
 * сохраняется при перезагрузке прошивки. Хост: tools/txpower_ctl.sh. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/rf_obj.h"
#include "../include/radio_mgr.h"
#include "../include/wmi.h"
#include "../include/fwdata.h"

#define TXPWR_ROW_FIRST  2u                /* TX-строки 2…7: регистры 4·k (таблица 0) и 0x40 + 4·k (таблица 1) */
#define TXPWR_ROW_N      6u
#define RFC_CORE_APPLY   1u                /* команда RF core: взять значения таблиц усилений */

/* Свои переменные — в свободном промежутке 0x806920..0x8069ff (wmi_cmd.c: l2mgr_connect_*). */
FWDATA(806920) volatile u32 txpwr_brd_rows[2 * TXPWR_ROW_N] = { 0 };   /* строки 2…7 board-файла: таблица 0, 1 */
FWDATA(8069f2) volatile u8 txpwr_code1 = 0;     /* заданный код + 1; 0 — значения board-файла */
FWDATA(8069f3) volatile u8 txpwr_pending = 0;   /* запрос радио на применение отправлен */
FWDATA(8069f4) volatile u8 txpwr_brd_valid = 0; /* txpwr_brd_rows прочитаны */

/* Полубайты n (0…3) слова v ограничить сверху значением t (t > 15 — без ограничения). */
static u32 txpwr_cap(u32 v, u32 n, u32 t)
{
    u32 i;

    if (t > 15u)
        return v;
    for (i = 0; i < n; i++) {
        u32 sh = i * 4u;
        if (((v >> sh) & 0xfu) > t)
            v = (v & ~(0xfu << sh)) | (t << sh);
    }
    return v;
}

/* TX-строки 2…7 обеих таблиц = значения board-файла с потолком t (t > 15 — как в board-файле) и команда
 * применения — в каждый рабочий RF-модуль (RFCA на модуль, как load_brd_rf_cfg_section; в конце RFCA на активные
 * модули). */
static void txpwr_apply_rows(u32 t)
{
    struct rf_reg_pair p[2 * TXPWR_ROW_N];
    u32 m = rf_cfg_get_rf_mask_45e(&rf_obj);
    u32 k, bit;

    for (k = 0; k < TXPWR_ROW_N; k++) {
        p[k].addr = (TXPWR_ROW_FIRST + k) * 4u;
        p[k].val = txpwr_cap(txpwr_brd_rows[k], 3, t);
        p[TXPWR_ROW_N + k].addr = 0x40u + (TXPWR_ROW_FIRST + k) * 4u;
        p[TXPWR_ROW_N + k].val = txpwr_cap(txpwr_brd_rows[TXPWR_ROW_N + k], 2, t);
    }
    for (bit = 0; bit < 8; bit++) {
        if (!(m & (1u << bit)))
            continue;
        hwd_abif_dvs_rfca_cmd_enable(1u << bit, 0);
        marlon_r_if_class_rf_write_with_block_retries(&rf_obj, 0, p, 2 * TXPWR_ROW_N, 0x10, 5, 0);
        hwd_rfc_write_core_fw(bit, RFC_CORE_APPLY, 0, 0);
    }
    hwd_abif_dvs_rfca_cmd_enable(rf_active_mask, 0);
}

/* После загрузки секции 0xb000900d (rf_configure_role_power): запомнить строки board-файла, подставить заданный
 * код. Секция у всех модулей одна — строки читаются из активного. */
void txpwr_brd_loaded(void)
{
    u32 k;

    if (rf_is_present() == 0)
        return;
    for (k = 0; k < TXPWR_ROW_N; k++) {
        txpwr_brd_rows[k] = hwd_rfc_read_rgf(0, (TXPWR_ROW_FIRST + k) * 4u);
        txpwr_brd_rows[TXPWR_ROW_N + k] = hwd_rfc_read_rgf(0, 0x40u + (TXPWR_ROW_FIRST + k) * 4u);
    }
    txpwr_brd_valid = 1;
    if (txpwr_code1 != 0)
        txpwr_apply_rows(txpwr_code1 - 1u);
}

/* Колбэк радио-менеджера: радио у нас — применить код (0 — значения board-файла), радио отпустить. Повторные
 * команды до колбэка — только новый код. */
static void txpwr_radio_cb(struct rm_req *req, u32 arg)
{
    (void)arg;
    if (txpwr_brd_valid != 0)
        txpwr_apply_rows(txpwr_code1 != 0 ? txpwr_code1 - 1u : 0xffu);
    radio_mgr_call_method_10(req);
    txpwr_pending = 0;
}

/* WMI_SPARRAW_TX_POWER (0x0f12): потолок кода TX-строк (0…15) или 0xff — значения board-файла; применяется
 * сразу. */
void wmi_sparraw_tx_power(const struct wmi_sparraw_tx_power_cmd *cmd)
{
    u32 t = cmd->code;

    if (t > 15u && t != WMI_SPARRAW_TX_POWER_BOARD)
        return;
    txpwr_code1 = (u8)(t == WMI_SPARRAW_TX_POWER_BOARD ? 0u : t + 1u);
    if (rf_is_present() == 0 || txpwr_pending != 0)
        return;
    txpwr_pending = 1;
    radio_mgr_request(txpwr_radio_cb, 0, 0, 0xffff, 0);
}
