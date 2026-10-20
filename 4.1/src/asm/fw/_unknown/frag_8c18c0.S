/* frag_8c18c0 @ 0x8c18c0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.frag_8c18c0,"ax",@progbits
	.global frag_8c18c0
frag_8c18c0:
	.byte 0x18
	.byte 0x30
	.global sub_8c18c2
sub_8c18c2:
L_8c18c2:
	nop_s
L_8c18c4:
	mov_s r0,0x8004d8
L_8c18ca:
	ldb_s r1,[r0]
L_8c18cc:
	ldb.x r0,[gp, 0xbd]
L_8c18d0:
	add_s r0,r0,r1
L_8c18d2:
	stb r0,[gp, 0xb9]
L_8c18d6:
	mov_s r1,0x800d08
L_8c18dc:
	j_s.d [blink]
L_8c18de:
	stb_s r0,[r1,0x7]
