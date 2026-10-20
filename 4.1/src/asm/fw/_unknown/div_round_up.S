/* div_round_up @ 0x8c9d5c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__get_chunk_8c9b3c, marlon_r_if_class__load_brd_parameters_section, marlon_r_if_class__load_brd_rf_cfg_section
 * Зовёт сам: fw_div_unsigned
 */
	.section .text.div_round_up,"ax",@progbits
	.global div_round_up
div_round_up:
	.global L_8c9d5c
L_8c9d5c:
	push_s blink
L_8c9d5e:
	bl.d L_8c03b4
L_8c9d62:
	ld_s r0,[r0,0xc]
L_8c9d64:
	sub.f r1,r1,0x0
L_8c9d68:
	mov.ne r1,0x1
L_8c9d6c:
	add_s r0,r0,r1
L_8c9d6e:
	pop_s blink
L_8c9d70:
	j_s [blink]
L_8c9d72:
	nop_s
