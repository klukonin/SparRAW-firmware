/* bi__dispatch_by_role @ 0x92b448, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__main_step
 * Зовёт сам: bi_manager__start_tx_or_initiator, bi_rx__slot_handler, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi__dispatch_by_role
bi__dispatch_by_role:
	.global L_92b448
L_92b448:
	push_s blink
L_92b44a:
	ld_s r1,[r0,0x38]
L_92b44c:
	breq_s r1,0,L_92b464
L_92b44e:
	breq r1,0x1,L_92b474
L_92b452:
	breq r1,0x2,L_92b480
L_92b456:
	mov_s r0,blink
L_92b458:
	bl.d L_926618
L_92b45c:
	mov r1,0x68
L_92b460:
	pop_s blink
L_92b462:
	j_s [blink]
	.global L_92b464
L_92b464:
	mov r0,blink
L_92b468:
	bl.d L_926618
L_92b46c:
	mov r1,0x67
L_92b470:
	pop_s blink
L_92b472:
	j_s [blink]
	.global L_92b474
L_92b474:
	bl.d L_92b48c
L_92b478:
	add r0,r0,0x20
L_92b47c:
	pop_s blink
L_92b47e:
	j_s [blink]
	.global L_92b480
L_92b480:
	bl.d L_92b4d8
L_92b484:
	add r0,r0,0x24
L_92b488:
	pop_s blink
L_92b48a:
	j_s [blink]
