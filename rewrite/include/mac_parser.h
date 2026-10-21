/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* MAC-парсер / RX-фильтр (fw/mac_parser.c): правило таблицы — 2 слова, которые
 * mac_parser__uses_rgf_886280 (0x8dfbd8) и mac_parser__pack_rule_halfword пишут в DATA0/DATA1
 * (0x886298/0x88629c, 0x886280/0x886284). Строители правил пишут его словами или
 * полусловами (X — [0], Y — [1], Z — слово [1]; MAC пира — полуслова 0..2). */
#ifndef MAC_PARSER_H
#define MAC_PARSER_H
#include "types.h"

struct prs_rule {
    union {
        u32 w[2];
        u16 h[4];
    };
};
_Static_assert(sizeof(struct prs_rule) == 8, "prs_rule");

#endif
