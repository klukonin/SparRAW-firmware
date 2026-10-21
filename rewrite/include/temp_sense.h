/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Служба температуры (fw/temp_service.c, fw/lmac.c): колбэк запроса temp_sense__get_cached. */
#ifndef TEMP_SENSE_H
#define TEMP_SENSE_H
#include "types.h"

/* Колбэк результата измерения: температура BB (м°C), активного RF (м°C), ctx запроса. */
typedef void (*temp_done_fn)(u32 bb_mdeg, u32 rf_mdeg, u32 ctx);

extern volatile temp_done_fn temp_pending_cb;  /* 0x8000a8: колбэк ожидающего запроса, 0 — нет */

#endif
