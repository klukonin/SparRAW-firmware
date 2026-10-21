// SPDX-License-Identifier: AGPL-3.0-or-later
/* abort() для libgcc/newlib: фатальный ассерт с кодом 0xdead (не vendor).
 * Сам фатальный ассерт — fw/sysassert.c. */
#include "../include/types.h"


__attribute__((section(".textlate"))) void abort(void) { fw_sysassert_fatal((void *)0, 0xdead); }
