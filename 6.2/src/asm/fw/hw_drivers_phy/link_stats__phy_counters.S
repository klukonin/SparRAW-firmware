/* link_stats__phy_counters @ 0x8d27d8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LINK_STATS PHY_ERROR_CP=%d PHY_ERROR_DP=%d
 * Зовут его: link_stats__report
 * Зовёт сам: fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_stats__phy_counters
link_stats__phy_counters:
	.global L_8d27d8
L_8d27d8:
	mov_s r3,0x883800
L_8d27de:
	ld.as r2,[r3,0x6d]
L_8d27e2:
	mov_s r1,0x101db34
L_8d27e8:
	ld.as r3,[r3,0x5e]
L_8d27ec:
	b.d L_8dcc80
L_8d27f0:
	mov_s r0,0x20
L_8d27f2:
	nop_s
