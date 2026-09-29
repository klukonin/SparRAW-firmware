/* l1_task__phase_of @ 0x92b648, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__main_step
 * Зовёт сам: l1__rx_then_check_bf_abort, l1_task__dispatch, l1_task__rx_flow_thunk, l1_task__rx_flow_thunk_b, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__phase_of
l1_task__phase_of:
	.global L_92b648
L_92b648:
	st.a r13,[sp,-0x8]
L_92b64c:
	ld r1,[r0, 0x38]
L_92b650:
	st blink,[sp, 0x4]
L_92b654:
	breq.d r1,0x0,L_92b670
L_92b658:
	mov_s r13,0x0
L_92b65a:
	breq r1,0x1,L_92b678
L_92b65e:
	breq r1,0x2,L_92b684
L_92b662:
	mov_s r0,blink
L_92b664:
	bl.d L_926618
L_92b668:
	mov r1,0x65
L_92b66c:
	b L_92b690
	.global L_92b670
L_92b670:
	bl L_92b6a8
L_92b674:
	b L_92b68c
	.global L_92b678
L_92b678:
	bl.d L_92b6ac
L_92b67c:
	add r0,r0,0x20
L_92b680:
	b L_92b68c
	.global L_92b684
L_92b684:
	bl.d L_92b6f8
L_92b688:
	add r0,r0,0x24
	.global L_92b68c
L_92b68c:
	mov r13,r0
	.global L_92b690
L_92b690:
	mov r0,0x5
L_92b694:
	bl.d L_934e30
L_92b698:
	mov r1,r13
L_92b69c:
	ld blink,[sp, 0x4]
L_92b6a0:
	j.d [blink]
L_92b6a4:
	ld.ab r13,[sp,0x8]
