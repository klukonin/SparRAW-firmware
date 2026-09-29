/* mac_parser__set_886200 @ 0x8dfba0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__configure
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__set_886200
mac_parser__set_886200:
	.global L_8dfba0
L_8dfba0:
	asl_s r0,r0,0x10
L_8dfba2:
	or_s r1,r1,r0
L_8dfba4:
	asl_s r2,r2,0x18
L_8dfba6:
	or_s r1,r1,r2
L_8dfba8:
	asl r0,r3,0x8
L_8dfbac:
	or_s r0,r0,r1
L_8dfbae:
	mov_s r1,0x886200
L_8dfbb4:
	st_s r0,[r1,0x58]
L_8dfbb6:
	st_s r3,[r1,0x5c]
L_8dfbb8:
	j_s [blink]
L_8dfbba:
	nop_s
