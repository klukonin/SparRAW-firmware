/* state_sm_803424__action_8f05f4 @ 0x8f05f4, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   action_burst_fail(), failed to hanedle
 *   action_burst_fail(), delete timer pending event
 *   action_burst_fail(), send abort event
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, fw_log_emit0, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_803424__action_8f05f4
state_sm_803424__action_8f05f4:
	.global L_8f05f4
L_8f05f4:
	push_s blink
L_8f05f6:
	bl L_8c01e0
L_8f05fa:
	mov_s r13,r0
L_8f05fc:
	ld_s r0,[r0,0x10]
L_8f05fe:
	mov_s r15,r1
L_8f0600:
	brne_s r0,0,L_8f0610
L_8f0602:
	mov_s r1,0x1019d80
L_8f0608:
	bl.d L_8dcba8
L_8f060c:
	mov_s r0,0x2b
L_8f060e:
	b_s L_8f0646
	.global L_8f0610
L_8f0610:
	ld_s r0,[r13,0xc]
L_8f0612:
	mov_s r14,0x0
L_8f0614:
	breq_s r0,0,L_8f062a
L_8f0616:
	mov_s r1,0x1019da8
L_8f061c:
	bl.d L_8dcba8
L_8f0620:
	mov_s r0,0x2b
L_8f0622:
	bl.d L_8c8de0
L_8f0626:
	ld_s r0,[r13,0xc]
L_8f0628:
	st_s r14,[r13,0xc]
	.global L_8f062a
L_8f062a:
	mov_s r1,0x1019ddc
L_8f0630:
	bl.d L_8dcba8
L_8f0634:
	mov_s r0,0x2b
L_8f0636:
	mov_s r0,r13
L_8f0638:
	mov_s r1,0x7
L_8f063a:
	mov_s r2,r15
L_8f063c:
	mov_s r3,0x2
L_8f063e:
	bl.d L_8d9b6c
L_8f0642:
	mov r4,0x0
	.global L_8f0646
L_8f0646:
	b L_8c024c
L_8f064a:
	nop_s
