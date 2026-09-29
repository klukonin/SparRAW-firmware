/* mac_parser__set_886200 @ 0x8dbac8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__configure
 */
	.section .text.mac_parser__set_886200,"ax",@progbits
	.global mac_parser__set_886200
mac_parser__set_886200:
	.global L_8dbac8
L_8dbac8:
	asl_s r0,r0,0x10
L_8dbaca:
	or_s r1,r1,r0
L_8dbacc:
	asl_s r2,r2,0x18
L_8dbace:
	or_s r1,r1,r2
L_8dbad0:
	asl r0,r3,0x8
L_8dbad4:
	or_s r0,r0,r1
L_8dbad6:
	mov_s r1,0x886200
L_8dbadc:
	st_s r0,[r1,0x58]
L_8dbade:
	st_s r3,[r1,0x5c]
L_8dbae0:
	j_s [blink]
L_8dbae2:
	nop_s
