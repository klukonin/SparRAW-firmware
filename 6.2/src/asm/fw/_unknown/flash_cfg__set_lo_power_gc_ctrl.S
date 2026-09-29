/* flash_cfg__set_lo_power_gc_ctrl @ 0x8e689c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__load_from_flash
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global flash_cfg__set_lo_power_gc_ctrl
flash_cfg__set_lo_power_gc_ctrl:
	.global L_8e689c
L_8e689c:
	j_s.d [blink]
L_8e689e:
	stb r0,[gp, 0xd0]
L_8e68a2:
	nop_s
