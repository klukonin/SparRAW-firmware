/* uc_send_evt__ps_awake_peer @ 0x92757c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dti_worker__scheduled_dti_allocation_event, tx_ctx__post_status
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, irq_safe__deref_field_04, memcpy_uc, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_send_evt__ps_awake_peer
uc_send_evt__ps_awake_peer:
	.global L_92757c
L_92757c:
	push_s blink
L_92757e:
	bl L_920234
L_927582:
	mov_s r14,r0
L_927584:
	mov_s r0,0x802470
L_92758a:
	bl L_920d4c
L_92758e:
	mov_s r1,r14
L_927590:
	mov_s r13,r0
L_927592:
	bl.d L_920330
L_927596:
	mov_s r2,0xc
L_927598:
	mov_s r0,r13
L_92759a:
	mov_s r1,0x16
L_92759c:
	mov_s r2,0xc
L_92759e:
	bl.d L_927958
L_9275a2:
	mov_s r3,0x0
L_9275a4:
	b L_9202a4
