/* link_stats__phy_counters @ 0x8cfb40, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LINK_STATS PHY_INA_SYNC_CP=%d PHY_INA_SYNC_DP=%d
 *   LINK_STATS PHY_SFD_SYNC_CP=%d PHY_SFD_SYNC_DP=%d
 *   LINK_STATS PHY_ERROR_CP=%d PHY_ERROR_DP=%d
 * Зовут его: link_stats__report
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2
 */
	.section .text.link_stats__phy_counters,"ax",@progbits
	.global link_stats__phy_counters
link_stats__phy_counters:
	.global L_8cfb40
L_8cfb40:
	push_s blink
L_8cfb42:
	bl.d L_8c02c4
L_8cfb46:
	mov_s r0,0x0
L_8cfb48:
	mov_s r13,0x883980
L_8cfb4e:
	ld_s r3,[r13,0x20]
L_8cfb50:
	mov_s r2,0x1018978
L_8cfb56:
	ld r4,[r13, 0x20]
L_8cfb5a:
	mov_s r14,0x883800
L_8cfb60:
	bl.d L_8edff8
L_8cfb64:
	mov_s r1,0x2
L_8cfb66:
	ld_s r3,[r13,0x30]
L_8cfb68:
	mov_s r2,0x10189ac
L_8cfb6e:
	ld.as r4,[r14,0x5d]
L_8cfb72:
	mov_s r0,0x0
L_8cfb74:
	bl.d L_8edff8
L_8cfb78:
	mov_s r1,0x2
L_8cfb7a:
	ld_s r3,[r13,0x34]
L_8cfb7c:
	mov_s r2,0x10189e0
L_8cfb82:
	ld.as r4,[r14,0x5e]
L_8cfb86:
	mov_s r0,0x0
L_8cfb88:
	bl.d L_8edff8
L_8cfb8c:
	mov_s r1,0x2
L_8cfb8e:
	b L_8c0334
L_8cfb92:
	nop_s
