// SPDX-License-Identifier: AGPL-3.0-or-later
/* Прерывания: уровень IRQ, глобальное разрешение. */
#include "../include/types.h"
#include "../include/arc.h"

/* Установить уровень (0/1) конкретной линии IRQ. Вспомогательный регистр
 * 0x200 — маска/уровень прерываний. */
void irq_set_level(u32 irq, u32 level)
{
    u32 v = arc_lr(0x200);
    v &= ~(1u << irq);
    v |= (level & 1) << irq;
    arc_sr(v, 0x200);
}

/* cpu__aux28_set_bits12_fw — три точки входа «разрешить прерывания»:
 * установить биты 1+2 (обе линии), только бит 1, только бит 2. */
void irq_enable_all(void)
{
    /* Биты 1+2 STATUS32 = E1+E2 (обе линии прерываний). vendor 0x8c02a4: lr; or 6; flag.
     * Прежде было sr [STATUS32] — на ARC600 STATUS32 так не пишется (только flag),
     * и прерывания fw не включались вовсе (STATUS32 в главном цикле = 0x800). */
    arc_flag(arc_lr(ARC_STATUS32) | 0x6);
}
void irq_enable_line1(void)
{
    arc_flag(arc_lr(ARC_STATUS32) | 0x2);
}
void irq_enable_line2(void)
{
    arc_flag(arc_lr(ARC_STATUS32) | 0x4);
}

/* cpu__aux28_clear_bits12_fw — парные «запретить». */
void irq_disable_all(void)
{
    arc_flag(arc_lr(ARC_STATUS32) & ~0x6u);
}
void irq_disable_line1(void)
{
    arc_flag(arc_lr(ARC_STATUS32) & ~0x2u);
}
void irq_disable_line2(void)
{
    arc_flag(arc_lr(ARC_STATUS32) & ~0x4u);
}
