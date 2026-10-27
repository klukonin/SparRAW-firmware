// SPDX-License-Identifier: AGPL-3.0-or-later
/* Свои строки журнала SparRAW (fw и uc).
 *
 * Запись журнала хранит не текст, а токен 0x1000000 + смещение строки в таблице строк; таблица vendor
 * (6.2/ref/strings-fw.bin, 0x20c64 Б; uc — 0x32c0 Б) нашего текста не содержит. Свои строки — в
 * include/logstr_fw.def и logstr_uc.def по одной записи X(ИМЯ, "формат") (в SparRAW-pro — ещё logstr_fw_pro.def,
 * за открытыми); токен — LS_FW(ИМЯ) / LS_UC(ИМЯ):
 * база + offsetof в структуре из тех же записей (char[sizeof строки] подряд, без выравнивания), то есть
 * ровно смещение строки в таблице, которую tools/build_fw.py собирает из того же .def и кладёт в образ
 * записью-комментарием (магия LOGSTR_MAGIC_FW / _UC, u32 база, строки через \0). Декодеры
 * tools/hwdbg/fwlog.py и uclog.py читают .def из репозитория или запись из образа (--fw).
 *
 * База: в заголовке записи журнала биты 18..25 — старший байт TSF (fw_log_put, uc_log_emit*), поэтому
 * смещение строки должно быть < 0x40000. fw — 0x30000 (выше таблицы vendor), uc — 0x10000. */
#ifndef LOGSTR_H
#define LOGSTR_H

#include <stddef.h>
/* Подключается ко всем исходникам fw/ и uc/ через -include (Makefile). */

#define LOGSTR_BASE_FW  0x1030000u
#define LOGSTR_BASE_UC  0x1010000u
#define LOGSTR_MAGIC_FW 0x57464c53u   /* "SLFW" */
#define LOGSTR_MAGIC_UC 0x43554c53u   /* "SLUC" */

#define X(name, s) char name[sizeof(s)];
struct logstr_fw {
#include "logstr_fw.def"
#if __has_include("logstr_fw_pro.def")
#include "logstr_fw_pro.def"               /* строки SparRAW-pro — отдельным файлом, чтобы слияния open не конфликтовали */
#endif
};
struct logstr_uc {
#include "logstr_uc.def"
};
#undef X

#define LS_FW(name) (LOGSTR_BASE_FW + (unsigned int)offsetof(struct logstr_fw, name))
#define LS_UC(name) (LOGSTR_BASE_UC + (unsigned int)offsetof(struct logstr_uc, name))

_Static_assert(sizeof(struct logstr_fw) <= 0x10000, "logstr_fw.def: таблица больше 64 КБ (смещение >= 0x40000)");
_Static_assert(sizeof(struct logstr_uc) <= 0x30000, "logstr_uc.def: таблица выходит за 0x40000");

#endif
