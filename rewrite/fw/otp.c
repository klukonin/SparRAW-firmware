// SPDX-License-Identifier: AGPL-3.0-or-later
/* OTP (XPM) RF-модуля при загрузке — otp_init (0x8f6cb0) и цепочка чтения XPM:
 * hwf_rf_xpm_read_block (0x8f4b70) → hwf_rf_xpm_read_byte (0x8f4bd8) →
 * hwd_rfc_xpm_read_byte (0x8d45e0) → команда 0xc RFC-ядру (0x8d4600) + опрос выхода
 * (0x8d44e4). Прежде hwf_rf_xpm_read_block был weak-заглушкой с возвратом 0 — отсюда на
 * стенде «otp_init(): OTP read failed» при «xpm read success» ×N у vendor. */
#include "../include/types.h"
#include "../include/rf_obj.h"
#include "../include/fwdata.h"

/* 0x80522c: 8 Б OTP активного RF (otp__read_rf; журнал otp_init — u32, u8, u8, u16). */
struct otp_info {
    u32 w0;                                    /* 0x00 */
    u8  b4;                                    /* 0x04 */
    u8  b5;                                    /* 0x05 */
    u16 h6;                                    /* 0x06 */
};
_Static_assert(sizeof(struct otp_info) == 8, "otp_info");
FWDATA(80522c) struct otp_info otp_info = { 0 };
#define XPM_BITS 0x2000u     /* размер XPM в битах */

static inline void *caller(void) { return __builtin_return_address(0); }

/* rf__check_rf_id (0x8e2f18): RF нет — 0; rf < 8 — 1; иначе журнал (имя функции —
 * строковый токен name), при flag — ассерт 0x155a, возврат 3. */
u32 rf_check_rf_id(u32 rf, u32 name, u32 flag)
{
    if (rf_is_present() == 0)
        return 0;
    if (rf < 8)
        return 1;
    fw_log_emit_str1(0, 0x101cf18, name);          /* "Function %s: " */
    fw_log_emit2(0, 0x101cf28, rf, 8);             /* "[NNL] invalid rf_id=%d (max=%d)" */
    if (flag != 0)
        fw_sysassert_fatal(caller(), 0x155a);
    return 3;
}

/* hwf_rf_xpm_single_byte_access_check_inputs (0x8f4c28): 1 — можно, 3 — нет. */
u32 xpm_byte_check_inputs(u32 rf, u32 bit_addr, u32 flag)
{
    const u32 name = 0x101b5d4;                    /* "hwf_rf_xpm_single_byte_access_check_inputs" */
    u32 ok = 1;

    if (rf_check_rf_id(rf, name, flag) != 1)
        return 3;
    if (bit_addr >= XPM_BITS) {
        ok = 0;
        fw_log_emit_str2(0, 0x101b600, name, 0x101b60c);   /* "%s : <%s>=", "xpm_bit_address" */
        fw_log_emit2(0, 0x101b61c, bit_addr, XPM_BITS);
        if (flag != 0)
            fw_sysassert_fatal(caller(), 0x155b);
    }
    return ok != 0 ? 1 : 3;
}

/* hwf_rf_xpm_block_access_check_inputs (0x8f46f4): len в [1, max], конечный бит
 * addr + 8·len − 1 < 0x2000, dst != 0 (последнее — ассерт 0x155e без учёта flag). */
u32 xpm_block_check_inputs(u32 rf, u32 addr, u32 len, const void *dst, u32 max, u32 flag)
{
    const u32 name = 0x101b658;                    /* "hwf_rf_xpm_block_access_check_inputs" */
    u32 ok = 1, last;

    if (rf_check_rf_id(rf, name, flag) != 1)
        return 3;
    if (max < len || len == 0) {
        ok = 0;
        fw_log_emit_str2(0, 0x101b680, name, 0x101b694);   /* "%s : Value <%s>=", "num_bytes" */
        fw_log_emit3(0, 0x101b6a0, len, 1, max);
        if (flag != 0)
            fw_sysassert_fatal(caller(), 0x155c);
    }
    last = addr + (len << 3);
    last = (last != 0) ? last - 1 : 0;
    if (last >= XPM_BITS) {
        ok = 0;
        fw_log_emit_str2(0, 0x101b600, name, 0x101b6c4);   /* "(xpm_start_bit_address+8*num_bytes-1)" */
        fw_log_emit2(0, 0x101b61c, last, XPM_BITS);
        if (flag != 0)
            fw_sysassert_fatal(caller(), 0x155d);
    }
    if (dst == 0)
        fw_sysassert_fatal(caller(), 0x155e);
    return ok != 0 ? 1 : 3;
}

/* hwd_rfc__xpm_read_cmd (0x8d4600): команда 0xc RFC-ядру с битовым адресом XPM. */
static void hwd_rfc_xpm_read_cmd(u32 rf, u32 bit_addr)
{
    hwd_rfc_write_core_fw((u8)rf, 0xc, 0, (u16)bit_addr);
}

/* hwd_rfc_xpm_get_data_output (0x8d44e4): опрос RFC-регистра 0x3d0 — бит 10 сброшен и
 * бит 8 взведён → в младшем байте данные XPM. wait == 0 — одно чтение; иначе до
 * max_iter + 1 чтений, затем журнал тайм-аута. *dst = байт или 0xff; возврат — успех. */
u32 hwd_rfc_xpm_get_data_output(u32 rf, u8 *dst, u32 wait, u32 max_iter)
{
    u32 val = 0, iter = 0, b10 = 0, b8 = 0, ok = 0;

    for (;;) {
        if (wait != 0 && max_iter < iter) {
            fw_log_emit3(0, 0x101e8dc, iter, b10, b8);
            fw_log_emit1(0, 0x101e964, val);       /* "[NNL] rgf_val=0x%x" */
            break;
        }
        val = hwd_rfc_read_rgf(rf, 0x3d0);
        b10 = val & 0x400;
        b8 = val & 0x100;
        ok = (!(val & 0x400) && (val & 0x100)) ? 1 : 0;
        iter++;
        if (wait == 0 || ok != 0)
            break;
    }
    *dst = ok != 0 ? (u8)val : 0xff;
    return ok;
}

/* hwd_rfc_xpm_read_byte (0x8d45e0): команда чтения + ожидание до 4000 опросов. */
static u32 hwd_rfc_xpm_read_byte(u32 rf, u32 bit_addr, u8 *dst)
{
    hwd_rfc_xpm_read_cmd(rf, bit_addr);
    return hwd_rfc_xpm_get_data_output(rf, dst, 1, 0x7d << 5);
}

/* hwf_rf_xpm_read_byte (0x8f4bd8): проверка входа (с ассертами), чтение байта, журнал. */
u32 hwf_rf_xpm_read_byte(u32 rf, u32 bit_addr, u8 *dst)
{
    u32 r;

    if (xpm_byte_check_inputs(rf, bit_addr, 1) != 1)
        return 0;
    r = hwd_rfc_xpm_read_byte((u8)rf, bit_addr, dst);
    if (r != 0) {
        fw_log_emit2(0x20, 0x101b6ec, bit_addr, *dst);
        return 1;
    }
    fw_log_emit2(0, 0x101b73c, bit_addr, *dst);
    return 0;
}

/* hwf_rf_xpm_read_block (0x8f4b70): len байт XPM с битового адреса addr (шаг 8 бит) в
 * dst. 0 — ошибка (журнал с адресом и номером байта). */
u32 hwf_rf_xpm_read_block(u32 rf, u32 addr, u32 len, void *dst)
{
    u8 *out = dst;
    u32 i;

    if (xpm_block_check_inputs(rf, addr, len, dst, len, 1) != 1)
        return 0;
    for (i = 0; i < len; i++) {
        u32 a = addr + (i << 3);                   /* add3 r14,r15,r13 */
        if (hwf_rf_xpm_read_byte(rf, a, &out[i]) == 0) {
            fw_log_emit3(0, 0x101b798, a, i, len);
            return 0;
        }
    }
    return 1;
}

/* otp__read_rf (0x8f6d0c): 8 Б XPM/OTP активного RF с адреса 0 в dst. */
static u32 otp_read_rf(struct otp_info *dst)
{
    return hwf_rf_xpm_read_block(rf_obj.rf_idx, 0, 8, dst);
}

/* otp_init (0x8f6cb0): если RF отвечает (rf_comm_test) — прочитать OTP и вывести в
 * журнал поля 0x80522c..0x805233; иначе — только журнал ошибки. */
void otp_init(void)
{
    if (rf_comm_test(&rf_obj, rf_obj.rf_idx) == 0) {
        fw_log_emit0(0x10, 0x1013438);
        return;
    }
    if (otp_read_rf(&otp_info) == 0) {
        fw_log_emit0(0x10, 0x101341c);
        return;
    }
    fw_log_emit2(0x20, 0x101339c, otp_info.w0, otp_info.b4);
    fw_log_emit2(0x20, 0x10133dc, otp_info.b5, otp_info.h6);
}
