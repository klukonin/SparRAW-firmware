/* rm_main_sm__get_next_request @ 0x8cc5e0, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::get_next_request. Next request is type = %d. Handle:0x%x
 *   rm_main_sm::get_next_request. RX is Off --> GOTO IDLE
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit2, fw_sysassert_fatal, rm_req__get_next, sm__defer_call
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__get_next_request
rm_main_sm__get_next_request:
	.global L_8cc5e0
L_8cc5e0:
	push_s blink
L_8cc5e2:
	bl L_8c01e4
L_8cc5e6:
	mov_s r14,r0
L_8cc5e8:
	bl.d L_8cc65c
L_8cc5ec:
	ld_s r0,[r0,0x8]
L_8cc5ee:
	mov.f r13,r0
L_8cc5f2:
	beq_s L_8cc63c
L_8cc5f4:
	ldb_s r0,[r14,0x3]
L_8cc5f6:
	ld_s r2,[r13,0x14]
L_8cc5f8:
	breq_s r0,0,L_8cc608
L_8cc5fa:
	mov_s r1,0x1019184
L_8cc600:
	mov_s r0,0x28
L_8cc602:
	bl.d L_8dcc80
L_8cc606:
	mov_s r3,r13
	.global L_8cc608
L_8cc608:
	ld_s r0,[r13,0x14]
L_8cc60a:
	brne_s r0,0,L_8cc632
L_8cc60c:
	ld_s r0,[r14,0x30]
L_8cc60e:
	brne r0,0x1,L_8cc618
	.global L_8cc612
L_8cc612:
	mov_s r0,r14
L_8cc614:
	mov_s r1,0x4
L_8cc616:
	b_s L_8cc626
	.global L_8cc618
L_8cc618:
	mov_s r0,blink
L_8cc61a:
	mov_s r1,0x1175
L_8cc620:
	bl L_8c9b28
L_8cc624:
	b_s L_8cc612
	.global L_8cc626
L_8cc626:
	mov_s r2,0x0
L_8cc628:
	mov_s r3,r2
L_8cc62a:
	bl.d L_8e7044
L_8cc62e:
	mov_s r4,r2
L_8cc630:
	b_s L_8cc656
	.global L_8cc632
L_8cc632:
	brne r0,0x1,L_8cc656
L_8cc636:
	mov_s r0,r14
L_8cc638:
	mov_s r1,0x6
L_8cc63a:
	b_s L_8cc626
	.global L_8cc63c
L_8cc63c:
	ld_s r0,[r14,0x30]
L_8cc63e:
	brne_s r0,0,L_8cc656
L_8cc640:
	ldb_s r0,[r14,0x3]
L_8cc642:
	breq_s r0,0,L_8cc650
L_8cc644:
	mov_s r1,0x10191cc
L_8cc64a:
	bl.d L_8dcba8
L_8cc64e:
	mov_s r0,0x28
	.global L_8cc650
L_8cc650:
	mov_s r0,r14
L_8cc652:
	mov_s r1,0x9
L_8cc654:
	b_s L_8cc626
	.global L_8cc656
L_8cc656:
	b L_8c0254
L_8cc65a:
	nop_s
