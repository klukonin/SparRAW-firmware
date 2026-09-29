/* frag_8c19a8 @ 0x8c19a8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.frag_8c19a8,"ax",@progbits
	.global frag_8c19a8
frag_8c19a8:
	.byte 0x18
	.byte 0x00
	.global sub_8c19aa
sub_8c19aa:
L_8c19aa:
	nop_s
L_8c19ac:
	mov_s r1,0x803dbc
L_8c19b2:
	mov_s r0,0x800730
L_8c19b8:
	j_s.d [blink]
L_8c19ba:
	st_s r0,[r1,0x44]
