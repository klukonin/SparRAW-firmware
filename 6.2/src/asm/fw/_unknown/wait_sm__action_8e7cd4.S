/* wait_sm__action_8e7cd4 @ 0x8e7cd4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: ba_sm__send_delba, basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wait_sm__action_8e7cd4
wait_sm__action_8e7cd4:
	.global L_8e7cd4
L_8e7cd4:
	push_s blink
L_8e7cd6:
	mov_s r1,r0
L_8e7cd8:
	ldb_s r0,[r0,0xc]
L_8e7cda:
	breq_s r0,0,L_8e7ce6
L_8e7cdc:
	ld_s r0,[r1,0x10]
L_8e7cde:
	bl.d L_8e530c
L_8e7ce2:
	ldw_s r1,[r1,0xa]
L_8e7ce4:
	b_s L_8e7cf4
	.global L_8e7ce6
L_8e7ce6:
	mov_s r0,r1
L_8e7ce8:
	mov_s r1,0x2
L_8e7cea:
	mov_s r2,0x0
L_8e7cec:
	mov_s r3,r2
L_8e7cee:
	bl.d L_8d9b6c
L_8e7cf2:
	mov_s r4,r2
	.global L_8e7cf4
L_8e7cf4:
	pop_s blink
L_8e7cf6:
	j_s [blink]
