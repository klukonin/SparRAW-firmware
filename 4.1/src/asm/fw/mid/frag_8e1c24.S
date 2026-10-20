/* frag_8e1c24 @ 0x8e1c24, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.frag_8e1c24,"ax",@progbits
	.global frag_8e1c24
frag_8e1c24:
	.byte 0x0f
	.byte 0xef
	.global sub_8e1c26
sub_8e1c26:
L_8e1c26:
	nop_s
L_8e1c28:
	stw_s r1,[r0,0x2e]
L_8e1c2a:
	j_s.d [blink]
L_8e1c2c:
	stb r2,[r0, 0x30]
