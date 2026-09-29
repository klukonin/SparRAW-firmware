/* get_g_80045c @ 0x8c18b0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Глобалы (через gp): 0x80045c, 0x800460
 */
	.section .text.get_g_80045c,"ax",@progbits
	.global get_g_80045c
get_g_80045c:
L_8c18b0:
	st_s r0,[r13,0x50]
	.global sub_8c18b2
sub_8c18b2:
L_8c18b2:
	nop_s
L_8c18b4:
	ld_s r0,[gp,0x2ec]
L_8c18b6:
	add1 r1,r0,r0
L_8c18ba:
	add_s r0,r0,r1
L_8c18bc:
	j_s.d [blink]
L_8c18be:
	.byte 0xbc,0x1a
