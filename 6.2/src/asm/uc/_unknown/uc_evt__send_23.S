/* uc_evt__send_23 @ 0x92787c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_req__claim_and_report_23
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, irq_safe__deref_field_04, memcpy_uc, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__send_23
uc_evt__send_23:
	.global L_92787c
L_92787c:
	push_s blink
L_92787e:
	bl L_920234
L_927882:
	mov_s r14,r0
L_927884:
	mov_s r0,0x802470
L_92788a:
	bl L_920d4c
L_92788e:
	mov_s r1,r14
L_927890:
	mov_s r13,r0
L_927892:
	bl.d L_920330
L_927896:
	mov_s r2,0x24
L_927898:
	mov_s r0,r13
L_92789a:
	mov_s r1,0x23
L_92789c:
	mov_s r2,0x24
L_92789e:
	bl.d L_927958
L_9278a2:
	mov_s r3,0x0
L_9278a4:
	b L_9202a4
