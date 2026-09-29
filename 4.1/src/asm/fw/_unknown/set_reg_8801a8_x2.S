/* set_reg_8801a8_x2 @ 0x8f1058, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_spi_read
 */
	.section .text.set_reg_8801a8_x2,"ax",@progbits
	.global set_reg_8801a8_x2
set_reg_8801a8_x2:
	.global L_8f1058
L_8f1058:
	mov_s r0,0x880a3c
L_8f105e:
	st 0x4321,[r0, 0x4c]
L_8f1066:
	mov_s r1,0x0
L_8f1068:
	mov_s r0,0x880180
L_8f106e:
	st_s r1,[r0,0x28]
L_8f1070:
	j_s [blink]
L_8f1072:
	nop_s
