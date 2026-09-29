/* fw_mailbox__has_pending @ 0x8c30bc, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_mailbox__init_rings, mbox__init_debug, mbox__init_operational
 * Зовёт сам: fw_mailbox__is_empty
 */
	.section .text.fw_mailbox__has_pending,"ax",@progbits
	.global fw_mailbox__has_pending
fw_mailbox__has_pending:
	.global L_8c30bc
L_8c30bc:
	push_s blink
L_8c30be:
	bl.d L_8d7078
L_8c30c2:
	add_s r0,r0,0x24
L_8c30c4:
	cmp_s r0,0x0
L_8c30c6:
	mov_s r0,0x1
L_8c30c8:
	sub_s.ne r0,r0,r0
L_8c30ca:
	pop_s blink
L_8c30cc:
	j_s [blink]
L_8c30ce:
	nop_s
