/* flash_cfg__set_lo_power_xif_gc @ 0x8e68ac, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__load_from_flash
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global flash_cfg__set_lo_power_xif_gc
flash_cfg__set_lo_power_xif_gc:
	.global L_8e68ac
L_8e68ac:
	j_s.d [blink]
L_8e68ae:
	stb r0,[gp, 0xd2]
L_8e68b2:
	nop_s
