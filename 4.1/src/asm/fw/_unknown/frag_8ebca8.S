/* frag_8ebca8 @ 0x8ebca8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: conn__inject_evt4, conn_mgr__by_cid
 */
	.section .text.frag_8ebca8,"ax",@progbits
	.global frag_8ebca8
frag_8ebca8:
L_8ebca8:
	j_s [blink]
	.global sub_8ebcaa
sub_8ebcaa:
L_8ebcaa:
	nop_s
L_8ebcac:
	push_s blink
L_8ebcae:
	bl L_8c9e44
L_8ebcb2:
	bl L_8c9688
L_8ebcb6:
	pop_s blink
L_8ebcb8:
	j_s [blink]
L_8ebcba:
	nop_s
