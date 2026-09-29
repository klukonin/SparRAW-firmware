// SPDX-License-Identifier: AGPL-3.0-or-later
/* Демонстрационный модуль: проверка, что наш код линкуется в свободный хвост
 * fw_code и зовёт вендорские функции по именам из ld/symbols.ld.
 *
 * Сигнатуры вендорских функций восстановлены реверсом; тип аргументов — наша
 * интерпретация, компилятору они неизвестны, поэтому объявляем вручную.
 */

/* Логгер прошивки с одним аргументом: (модуль, уровень, строка, значение).
 * Восстановлен по вызовам вида FUN_008edfcc(5, 2, &"...", v). */
extern void sub_008edfcc(int module, int level, const void *fmt, int a);

/* bcn_tx_init_bi_cfg(cmd, bi_ctrl_lo, bi_ctrl_hi) — заполняет поля
 * Beacon Interval Control в команде CMD_BCON_MGT. */
extern void bcn_tx_init_bi_cfg(void *cmd, unsigned lo, unsigned hi);

/* Счётчик в нашей собственной области данных (.bss.ext). */
static unsigned ext_calls;

void ext_demo(unsigned v)
{
    ext_calls++;
    sub_008edfcc(0xc, 2, (const void *)0x01012990, (int)v);
}

void ext_touch_bi_cfg(void *cmd, unsigned lo, unsigned hi)
{
    bcn_tx_init_bi_cfg(cmd, lo, hi);
}

/* Обработчик хука на tx_bcon (0x8c2190). Вызывается ДО оригинального кода;
 * аргументы вендорской функции сохранены трамплином, так что здесь можно
 * работать свободно. */
static unsigned tx_bcon_calls;

void ext_on_tx_bcon(void)
{
    tx_bcon_calls++;
}
