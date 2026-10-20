/* pcie__read_app_debug_if @ 0x8d13a4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_lost_diag__dump_pcie
 * Зовёт сам: hwd_pcie__is_ep_under_serdes
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__read_app_debug_if
pcie__read_app_debug_if:
	.global L_8d13a4
L_8d13a4:
	push_s blink
L_8d13a6:
	bl L_8d1470
L_8d13aa:
	breq_s r0,0,L_8d13b6
L_8d13ac:
	mov_s r0,0x882580
L_8d13b2:
	ld_s r0,[r0,0x10]
L_8d13b4:
	b_s L_8d13be
	.global L_8d13b6
L_8d13b6:
	mov_s r0,0x882080
L_8d13bc:
	ld_s r0,[r0,0x44]
	.global L_8d13be
L_8d13be:
	pop_s blink
L_8d13c0:
	j_s [blink]
L_8d13c2:
	nop_s
