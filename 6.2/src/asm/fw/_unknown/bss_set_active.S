/* bss_set_active @ 0x8c4ec8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bss_set_active (mode %x)
 * Зовут его: l2_mgr__connect, l2_mgr__pcp_start_flow
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bss_set_active
bss_set_active:
	.global L_8c4ec8
L_8c4ec8:
	push_s blink
L_8c4eca:
	push_s r13
L_8c4ecc:
	mov_s r13,r0
L_8c4ece:
	mov_s r1,0x100c420
L_8c4ed4:
	mov_s r0,0x2b
L_8c4ed6:
	bl.d L_8dcc10
L_8c4eda:
	ld_s r2,[r13,0x8]
L_8c4edc:
	mov_s r0,0x2
L_8c4ede:
	b.d L_8c025c
L_8c4ee2:
	st_s r0,[r13,0x4]
