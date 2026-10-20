/* frag_8dcc4c @ 0x8dcc4c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: sm_pring__timeout
 */
	.section .text.frag_8dcc4c,"ax",@progbits
	.global frag_8dcc4c
frag_8dcc4c:
L_8dcc4c:
	/* b_s 0x008dcc1c */
	.byte 0xe8,0xf1
	.global sub_8dcc4e
sub_8dcc4e:
L_8dcc4e:
	nop_s
L_8dcc50:
	mul64 r0,0x38
L_8dcc54:
	add r0,mlo,0x8045a4
L_8dcc5c:
	b L_8e43c8
