/* uc_send_evt__rs_done @ 0x927738, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rs_end
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, irq_safe__deref_field_04, memcpy_uc, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_send_evt__rs_done
uc_send_evt__rs_done:
	.global L_927738
L_927738:
	push_s blink
L_92773a:
	bl L_920234
L_92773e:
	mov_s r14,r0
L_927740:
	mov_s r0,0x802470
L_927746:
	bl L_920d4c
L_92774a:
	mov_s r1,r14
L_92774c:
	mov_s r13,r0
L_92774e:
	bl.d L_920330
L_927752:
	mov_s r2,0x30
L_927754:
	mov_s r0,r13
L_927756:
	mov_s r1,0x14
L_927758:
	mov_s r2,0x30
L_92775a:
	bl.d L_927958
L_92775e:
	mov_s r3,0x0
L_927760:
	b L_9202a4
