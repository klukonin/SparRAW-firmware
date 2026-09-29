/* get_g_800118_8dd454 @ 0x8dd454, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.get_g_800118_8dd454,"ax",@progbits
	.global get_g_800118_8dd454
get_g_800118_8dd454:
	.byte 0x4f
	.byte 0xf1
	.global sub_8dd456
sub_8dd456:
L_8dd456:
	nop_s
L_8dd458:
	ld_s r0,[gp,-0x58]
L_8dd45a:
	ld_s r1,[r0,0x8]
L_8dd45c:
	ld_s r1,[r1,0x20]
L_8dd45e:
	j_s [r1]
