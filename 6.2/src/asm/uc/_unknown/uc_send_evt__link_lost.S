/* uc_send_evt__link_lost @ 0x927690, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__report_link_lost
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, irq_safe__deref_field_04, memcpy_uc, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_send_evt__link_lost
uc_send_evt__link_lost:
	.global L_927690
L_927690:
	push_s blink
L_927692:
	bl L_920234
L_927696:
	mov_s r14,r0
L_927698:
	mov_s r0,0x802470
L_92769e:
	bl L_920d4c
L_9276a2:
	mov_s r1,r14
L_9276a4:
	mov_s r13,r0
L_9276a6:
	bl.d L_920330
L_9276aa:
	mov_s r2,0xc
L_9276ac:
	mov_s r0,r13
L_9276ae:
	mov_s r1,0x9
L_9276b0:
	mov_s r2,0xc
L_9276b2:
	bl.d L_927958
L_9276b6:
	mov_s r3,0x0
L_9276b8:
	b L_9202a4
