/* mask__bit_from_index_plus8 @ 0x9262a0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fixed_sched__slot_setup
 * Зовёт сам: __ld_r13_to_r13_ret, dma__write_881c28, macq_hw__disable_queue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mask__bit_from_index_plus8
mask__bit_from_index_plus8:
	.global L_9262a0
L_9262a0:
	push_s blink
L_9262a2:
	push_s r13
L_9262a4:
	mov_s r13,r1
L_9262a6:
	add r0,r1,0x8
L_9262aa:
	mov_s r12,0x1
L_9262ac:
	asl r0,r12,r0
L_9262b0:
	bl.d L_928dfc
L_9262b4:
	mov_s r1,0x1
L_9262b6:
	bl.d L_9292a8
L_9262ba:
	mov_s r0,r13
L_9262bc:
	b L_9202ac
