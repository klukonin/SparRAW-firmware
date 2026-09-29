/* frag_8e55c0 @ 0x8e55c0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__store_linkup_field
 */
	.section .text.frag_8e55c0,"ax",@progbits
	.global frag_8e55c0
frag_8e55c0:
	.byte 0xcd
	.byte 0x00
	.global sub_8e55c2
sub_8e55c2:
L_8e55c2:
	nop_s
	.global L_8e55c4
L_8e55c4:
	j_s.d [blink]
L_8e55c6:
	st.as r1,[r0,0x42]
L_8e55ca:
	nop_s
