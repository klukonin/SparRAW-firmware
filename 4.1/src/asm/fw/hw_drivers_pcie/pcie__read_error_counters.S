/* pcie__read_error_counters @ 0x8ce6a8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_lost_diag__dump_pcie
 * Зовёт сам: get_reg8825bc_bit3_inv
 */
	.section .text.pcie__read_error_counters,"ax",@progbits
	.global pcie__read_error_counters
pcie__read_error_counters:
	.global L_8ce6a8
L_8ce6a8:
	push_s blink
L_8ce6aa:
	bl L_8ce774
L_8ce6ae:
	breq_s r0,0,L_8ce6ba
L_8ce6b0:
	mov_s r0,0x882580
L_8ce6b6:
	ld_s r0,[r0,0x10]
L_8ce6b8:
	b_s L_8ce6c2
	.global L_8ce6ba
L_8ce6ba:
	mov_s r0,0x882080
L_8ce6c0:
	ld_s r0,[r0,0x44]
	.global L_8ce6c2
L_8ce6c2:
	pop_s blink
L_8ce6c4:
	j_s [blink]
L_8ce6c6:
	nop_s
