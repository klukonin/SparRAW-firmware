// SPDX-License-Identifier: AGPL-3.0-or-later
/* Версия прошивки (перереализация). */
#ifndef REWRITE_VERSION_H
#define REWRITE_VERSION_H

/* Драйвер wil6210 читает строку версии из заголовка образа (после «FW version: »); её же пишет
 * tools/build_fw.py. Числа версии и дата сборки (WMI_FW_VER, регистры 0x880a10…0x880a38) — fw/fw_data.c
 * (fw_ver_*, fw_build_*), менять вместе. */
#define FW_VERSION_STRING "6.4.1.0"

#endif
