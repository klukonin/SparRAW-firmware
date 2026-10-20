/* fw_mailbox__has_pending @ 0x8c37ec, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_mbox__drain_task, mbox__drain_debug, mbox__drain_operational
 * Зовёт сам: fw_mailbox__is_empty
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_mailbox__has_pending
fw_mailbox__has_pending:
	.global L_8c37ec
L_8c37ec:
	push_s blink
L_8c37ee:
	bl.d L_8da150
L_8c37f2:
	add_s r0,r0,0x24
L_8c37f4:
	cmp_s r0,0x0
L_8c37f6:
	mov_s r0,0x1
L_8c37f8:
	sub_s.ne r0,r0,r0
L_8c37fa:
	pop_s blink
L_8c37fc:
	j_s [blink]
L_8c37fe:
	nop_s
