// SPDX-License-Identifier: AGPL-3.0-or-later
/* Версия прошивки (перереализация). */
#ifndef REWRITE_VERSION_H
#define REWRITE_VERSION_H

/* Драйвер wil6210 читает строку версии из заголовка образа (после «FW version: », всего 32 Б с нулём — на
 * версию не больше 19 символов) и показывает её в журнале, ethtool -i и iw; её пишет tools/build_fw.py.
 * Суффикс -SparRAW — метка проекта (у pro — -SparRAW-PRO). Числа версии и дата сборки (WMI_FW_VER,
 * регистры 0x880a10…0x880a38) — fw/fw_data.c (fw_ver_*, fw_build_*), менять вместе. */
#define FW_VERSION_STRING "6.4.1.0-SparRAW"

/* Текст записи-комментария (тип 1) сразу за заголовком образа; %s — FW_VERSION_STRING до суффикса
 * -SparRAW. Драйвер разбирает комментарии только с известной сигнатурой, остальные пропускает. */
#define FW_ID_STRING "SparRAW firmware %s by Evil Wireless Man, https://github.com/klukonin/SparRAW-firmware"

#endif
