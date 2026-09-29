/* rf_chain__set_mode_field @ 0x8ea598, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_chain__program_sector_desc
 * Зовёт сам: rf_chain__bits_set32_s22_w2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_chain__set_mode_field
rf_chain__set_mode_field:
	.global L_8ea598
L_8ea598:
	push_s blink
L_8ea59a:
	cmp_s r1,0x1
L_8ea59c:
	cmp.ne r1,0x2
L_8ea5a0:
	mov_s r1,0x0
L_8ea5a2:
	bne_s L_8ea5a6
L_8ea5a4:
	mov_s r1,0x2
	.global L_8ea5a6
L_8ea5a6:
	bl L_8ed448
L_8ea5aa:
	pop_s blink
L_8ea5ac:
	j_s [blink]
L_8ea5ae:
	nop_s
