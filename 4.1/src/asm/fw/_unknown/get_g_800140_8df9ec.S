/* get_g_800140_8df9ec @ 0x8df9ec, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.get_g_800140_8df9ec,"ax",@progbits
	.global get_g_800140_8df9ec
get_g_800140_8df9ec:
	.byte 0x4f
	.byte 0xf0
	.global sub_8df9ee
sub_8df9ee:
L_8df9ee:
	nop_s
L_8df9f0:
	mov_s r1,r0
L_8df9f2:
	ld_s r0,[gp,-0x30]
L_8df9f4:
	ld_s r2,[r0]
L_8df9f6:
	ld_s r2,[r2,0x24]
L_8df9f8:
	j_s [r2]
L_8df9fa:
	nop_s
