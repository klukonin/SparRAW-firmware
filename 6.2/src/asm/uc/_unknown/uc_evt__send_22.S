/* uc_evt__send_22 @ 0x9275ec, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: itx__report_status_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, irq_safe__deref_field_04, memcpy_uc, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__send_22
uc_evt__send_22:
	.global L_9275ec
L_9275ec:
	push_s blink
L_9275ee:
	bl L_920234
L_9275f2:
	mov_s r14,r0
L_9275f4:
	mov_s r0,0x802470
L_9275fa:
	bl L_920d4c
L_9275fe:
	mov_s r1,r14
L_927600:
	mov_s r13,r0
L_927602:
	bl.d L_920330
L_927606:
	mov_s r2,0x10
L_927608:
	mov_s r0,r13
L_92760a:
	mov_s r1,0x22
L_92760c:
	mov_s r2,0x10
L_92760e:
	bl.d L_927958
L_927612:
	mov_s r3,0x0
L_927614:
	b L_9202a4
