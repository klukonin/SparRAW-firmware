/* rf_chain__get_default_desc_bit0 @ 0x8ccec0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_chain__program_sector_desc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_chain__get_default_desc_bit0
rf_chain__get_default_desc_bit0:
	.global L_8ccec0
L_8ccec0:
	j_s.d [blink]
L_8ccec2:
	ld_s r0,[gp,-0x170]
