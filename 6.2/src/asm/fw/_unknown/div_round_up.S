/* div_round_up @ 0x8cbea0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__get_chunk_8cbbc4, marlon_r_if_class__load_brd_parameters_section, marlon_r_if_class__load_brd_rf_cfg_section
 * Зовёт сам: fw_divmod_unsigned
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global div_round_up
div_round_up:
	.global L_8cbea0
L_8cbea0:
	push_s blink
L_8cbea2:
	bl.d L_8c02d4
L_8cbea6:
	ld_s r0,[r0,0xc]
L_8cbea8:
	sub.f r1,r1,0x0
L_8cbeac:
	mov.ne r1,0x1
L_8cbeb0:
	add_s r0,r0,r1
L_8cbeb2:
	pop_s blink
L_8cbeb4:
	j_s [blink]
L_8cbeb6:
	nop_s
