/* bi_manager__start_tx_or_initiator @ 0x92b48c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__dispatch_by_role
 * Зовёт сам: bi_tx__check_idle_and_start_uc, fixed_sched__run_tx_slot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_manager__start_tx_or_initiator
bi_manager__start_tx_or_initiator:
	.global L_92b48c
L_92b48c:
	push_s r13
L_92b48e:
	mov_s r3,0x802f80
L_92b494:
	ld r1,[r3, 0x20]
L_92b498:
	sub.f r1,r1,0x0
L_92b49c:
	mov.ne r1,0x1
L_92b4a0:
	extb.f 0x0,r1
L_92b4a4:
	beq.d L_92b4cc
L_92b4a8:
	mov_s r13,blink
L_92b4aa:
	ld_s r0,[r3,0x18]
L_92b4ac:
	breq r0,0x0,L_92b4cc
L_92b4b0:
	bl.d L_93696c
L_92b4b4:
	mov r0,0x2
L_92b4b8:
	mov_s r2,0x81
L_92b4ba:
	asl_s r2,r2,0x12
L_92b4bc:
	mov r32,r2
L_92b4c0:
	st.ab r2,[r25,0x4]
L_92b4c4:
	bclr r25,r25,0xa
L_92b4c8:
	b L_92b4d0
	.global L_92b4cc
L_92b4cc:
	bl L_93768c
	.global L_92b4d0
L_92b4d0:
	mov_s blink,r13
L_92b4d2:
	j_s.d [blink]
L_92b4d4:
	pop_s r13
L_92b4d6:
	nop_s
