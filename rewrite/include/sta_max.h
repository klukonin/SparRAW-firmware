/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef SPARRAW_STA_MAX_H
#define SPARRAW_STA_MAX_H
/* Число станций (cid) — единый параметр fw и uc. Запись SPARRAW_PEER_UNKNOWN (= SPARRAW_MAX_STA) — неизвестный пир
 * (ответчик A-BFT до ассоциации, широковещательное кольцо AP): таблицы, где она есть, — на SPARRAW_STA_SLOTS.
 * Многие таблицы лежат по фиксированным адресам DCCM uc и общей памяти fw/uc (раскладка vendor 6.2); их размер
 * задан через этот параметр и закреплён _Static_assert — при изменении числа станций сборка укажет, что
 * перекладывать. Маски станций — u8/u16 (vendor): больше 8/16 станций потребует и их расширения. */
#define SPARRAW_MAX_STA       8u
#define SPARRAW_PEER_UNKNOWN  SPARRAW_MAX_STA
#define SPARRAW_STA_SLOTS     (SPARRAW_MAX_STA + 1u)
#endif
