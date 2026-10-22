// SPDX-License-Identifier: AGPL-3.0-or-later
/* PCP/AP и PBSS: список станций PBSS (DMG Capabilities от PCP в Information Response),
 * добавление/удаление станций PBSS, параметры бикона (LMAC-команда 0x0b CMD_BCON_MGT),
 * LMAC-команда 0x30.
 *
 * Список станций PBSS записи mid (obj = mid + 0x48): 8 записей по 0x11 Б с obj + 0x6f
 * (индекс — AID): копия тела элемента DMG Capabilities (0x94) — адрес STA (6 Б), AID
 * (+6, 0..7; 8 — запись свободна), DMG STA Capability Info (8 Б), DMG PCP/AP Capability
 * Info (2 Б). Байт AID записи i — obj + 0x75 + i·0x11.
 */
#include "../include/types.h"
#include "../include/sys_cfg.h"
#include "../include/rf_sets.h"
#include "../include/mid.h"
#include "../include/rf_obj.h"
#include "../include/mbox.h"
#include "../include/conn.h"
#include "../include/lmac_cmd.h"


/* Глобальные функции этого файла (прототипы — для порядка определения). */

#define RA()  __builtin_return_address(0)      /* blink vendor для fw_sysassert_fatal */

#define PBSS_FREE_AID         8
/* AID записи списка PBSS — volatile-доступ (ldb/stb), как прежде B(). */

/* ======================= список станций PBSS ======================= */

/* mid__copy_mac_addr (0x8c75b0, 14 Б): MAC записи mid (+0x1c, 6 Б) → dst. */
void mid_copy_mac_addr(u32 obj, u8 *dst)
{
    memcpy_fw(dst, (const void *)(obj + 0x1c), 6);
}

/* ======================= бикон: CMD_BCON_MGT (LMAC 0x0b) ======================= */

/* Параметры бикона — 8-байтная структура по значению в r(n):r(n+1) (w0 — байты 0..3, w1 —
 * 4..7; vendor кладёт её в стек и читает побайтно). Тело команды — struct lmac_cmd_bcn_sweep
 * (0x70 Б, пул 0x804280, include/lmac_cmd.h): op = a0, ss — список секторов, bi.bi_mode = a1,
 * bi.* — поля BI, bi.mac — MAC (6 Б), bi.flags — флаги. Доступы volatile (как прежде). */

static u8 bp_byte(u32 w0, u32 w1, u32 i)
{
    return (u8)((i < 4 ? w0 : w1) >> ((i & 3) * 8));
}

/* bcn_tx_init_bi_cfg (0x8c45d4, 142 Б): поля интервала бикона из структуры s:
 * n_bi_abft (+0x54) = s[3] >> 5, abft_cnt_mod (+0x55) = (u16 s[4..5] >> 6) & 0x3f,
 * fss (+0x57) = (s[1] >> 2) & 0xf, x8 (+0x58) = 0, x9 (+0x59) = (u16 s[2..3] >> 6) & 0x7f,
 * abft_len (+0x5a) = (u16 s[0..1] >> 7) & 7; флаги bi.flags (+0x64): бит 0 = s[0] б0,
 * бит 1 = s[0] б1, бит 2 = 0, бит 3 = s[5] б4.
 * (add3 r2,r0,8 = cmd + 0x40, поля — от него +0x14..+0x1a.) Журнал discovery_mode = бит 1. */
void bcn_tx_init_bi_cfg(volatile struct lmac_cmd_bcn_sweep *cmd, u32 w0, u32 w1)
{
    u8 s0 = bp_byte(w0, w1, 0), s1 = bp_byte(w0, w1, 1), s2 = bp_byte(w0, w1, 2);
    u8 s3 = bp_byte(w0, w1, 3), s5 = bp_byte(w0, w1, 5);
    u32 f;
    cmd->bi.n_bi_abft = (u8)(s3 >> 5);
    cmd->bi.abft_cnt_mod = (u8)(((w1 & 0xffffu) >> 6) & 0x3f);
    cmd->bi.fss = (u8)((s1 >> 2) & 0xf);
    cmd->bi.x8 = 0;
    cmd->bi.x9 = (u8)((((u32)s3 << 8 | s2) >> 6) & 0x7f);
    f = cmd->bi.flags;
    f = (f & ~1u) | (s0 & 1u);
    f = (f & ~2u) | (((s0 >> 1) & 1u) << 1);
    f &= ~0xcu;                                     /* bic 0xc: бит 2 — 0 */
    f |= ((s5 >> 4) & 1u) << 3;
    cmd->bi.flags = f;
    cmd->bi.abft_len = (u8)((((u32)s1 << 8 | s0) >> 7) & 7);
    fw_log_emit1(0x25, 0x1004ad8, (f >> 1) & 1);
}

/* bcn_tx_init_ss_params (0x8c4664, 166 Б): список секторов бикона cmd->ss (+4). Нет платы
 * ([gp-0x18] = 0x80016c == 0) — ассерт 0x104d (и дальше). Конфигураций ucode
 * ([0x85773c]) < 2 — у vendor сектора 0..63 подряд (ss.order, +0xc), число 0x40, x0/host_set = 0; у нас — список
 * TX-секторов board file, при пустом — 0..63;
 * иначе — список RF-объекта 0x8042c8 (sector_list__validate, a = b = 0; ошибка — ассерт
 * 0x1369). Бит 1 байта s[0] (discovery) — число секторов 0x10. w1 не используется. */
void bcn_tx_init_ss_params(volatile struct lmac_cmd_bcn_sweep *cmd, u32 w0, u32 w1)
{
    u32 ok, i;
    (void)w1;
    if (plat_board_info == 0)
        fw_sysassert_fatal(RA(), 0x104d);
    if ((s32)(u32)VOL(fwsh_sets.n_sec[1][0]) < 2) {
        /* Один набор RF: маяки — по TX-секторам board file (brd_if_build_tx_sector_list), а не всегда 0..63:
         * каждый лишний маяк — TXTIME + SBIFS ≈ 20,7 мкс эфира в каждом BI (64 — 1,33 мс). Пустой или негодный
         * список — прежние 0..63. */
        if (sector_list_validate((struct ss_cfg_s *)&cmd->ss, rf_if_tx_sectors(&rf_obj), 0, 0) == 0) {
            for (i = 0; i < 64; i++)                /* lp 64: stb i,[cmd+0xc+i] */
                cmd->ss.order[i] = (u8)i;
            cmd->ss.n_frames = 0x40;
            cmd->ss.x0 = 0;
            cmd->ss.host_set = 0;
        }
        ok = 1;
    } else {
        ok = sector_list_validate((struct ss_cfg_s *)&cmd->ss, rf_if_tx_sectors(&rf_obj), 0, 0);
    }
    if (ok == 0)
        fw_sysassert_fatal(RA(), 0x1369);
    if (w0 & 2u) {
        cmd->ss.n_frames = 0x10;
        fw_log_emit0(0x20, 0x1004a74);
    }
    fw_log_emit1(0x20, 0x1004aac, cmd->ss.n_frames);
}

/* lmac_if__build_bcon_cfg (0x8db260, 40 Б): op = a0, сектора и поля BI из структуры
 * {w0, w1}. */
void lmac_if_build_bcon_cfg(volatile struct lmac_cmd_bcn_sweep *cmd, u32 a0, u32 w0, u32 w1)
{
    cmd->op = a0;
    bcn_tx_init_ss_params(cmd, w0, w1);
    bcn_tx_init_bi_cfg(cmd, w0, w1);
}

/* lmac_if__send_bcon_mgt (0x8db288, 114 Б): CMD_BCON_MGT — LMAC 0x0b (0x70 Б) из пула
 * 0x804280 (нет буфера — ничего): MAC (если задан) в bi.mac (+0x5b), a1 в bi.bi_mode
 * (+0x50), остальное — build_bcon_cfg; журнал pcp_assoc_ready (бит 3 флагов) и
 * discovery_mode (бит 1). Незаполненные поля у vendor — остаток слота пула, у нас нули (mem_pool_alloc_locked обнуляет). */
void lmac_if_send_bcon_mgt(u32 a0, u32 a1, u32 w0, u32 w1, const u8 *mac)
{
    volatile struct lmac_cmd_bcn_sweep *cmd = mem_pool_alloc_locked(&lmac_mbox.mb);
    u32 f;
    if (cmd == 0)
        return;
    if (mac != 0)
        memcpy_fw((void *)cmd->bi.mac, mac, 6);
    cmd->bi.bi_mode = a1;
    lmac_if_build_bcon_cfg(cmd, a0, w0, w1);
    f = cmd->bi.flags;
    fw_log_emit2(0x25, 0x1004b04, (f >> 3) & 1, (f >> 1) & 1);
    lmac_if_post_cmd(cmd, 0xb, 0x70, 0);
}

/* lmac_if_send_cmd_0x30 (0x8db7f8, 36 Б): LMAC-команда 0x30 {a, b, c} (3 Б). */
void lmac_if_send_cmd_0x30(u32 a, u32 b, u32 c)
{
    struct lmac_cmd_sta_byte2 *p = lmac_cmd_pool_alloc();
    p->cid = (u8)a;
    p->mode = (u8)b;
    p->val = (u8)c;
    lmac_if_post_cmd(p, 0x30, 3, 0);
}
