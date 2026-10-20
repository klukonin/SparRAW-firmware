/* flash_cfg__set_lo_power_stg2_bias @ 0x8e68a4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__load_from_flash
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global flash_cfg__set_lo_power_stg2_bias
flash_cfg__set_lo_power_stg2_bias:
	.global L_8e68a4
L_8e68a4:
	j_s.d [blink]
L_8e68a6:
	stb r0,[gp, 0xd1]
L_8e68aa:
	nop_s
