// SPDX-License-Identifier: AGPL-3.0-or-later
/* Версия прошивки (перереализация). */
#ifndef REWRITE_VERSION_H
#define REWRITE_VERSION_H

/* Драйвер wil6210 читает строку версии из образа (после «FW version: »).
 * Формат держим совместимым: 6.4.1.x + суффикс. */
#define FW_VERSION_STRING "6.4.1.0-rewrite"

#endif
