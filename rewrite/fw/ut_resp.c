// SPDX-License-Identifier: AGPL-3.0-or-later
/* Ответы модулей юнит-тестов WMI 0x900 (WMI_UT_RESPONSE, событие 0x1900). */
#include "../include/types.h"
#include "../include/ut.h"
#include "../include/mbox.h"


/* ut__begin_response (0x8eae60, 22 Б): буфер события из пула ящика mb, {u16 module, u16 subtype}. */
struct ut_rsp *ut_begin_response(struct wmi_mbox *mb, u32 module, u32 subtype)
{
    struct ut_rsp *p = mem_pool_alloc_locked(&mb->mb);
    p->module_id = (u16)module;
    p->subtype_id = (u16)subtype;
    return p;
}

/* wmi_evt__send_words (0x8eae78, 80 Б): событие 0x1900 длиной len. Длина больше размера
 * элемента пула событий (wmi_mbox.tx_entry_size, +0x74) — ассерт 0x10ce, после него vendor
 * всё равно отправляет. Счётный цикл vendor ((len - 8) >> 2 итераций) результата не
 * имеет — опущен. */
void wmi_evt_send_words(struct wmi_mbox *mb, volatile struct ut_rsp *buf, u32 len)
{
    if (mb->tx_entry_size < len)
        fw_sysassert_fatal(__builtin_return_address(0), 0xce | (1u << 12));
    wmi_evt_post(mb, (void *)buf, 0, 0x1900, len, 0, 0, 0);
}
