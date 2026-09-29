/* info_flow__start_periodic @ 0x8dc75c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Starting Information flow periodic_info_flow
 *   Connection:%d, Is either NULL or not associated.
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn_mgr__by_cid, fw_log__emit0, fw_log__emit1, info_flow__run, mid__state_is_2_or_3, mid_list__by_mid, stream_mgr__send_info_response
 */
	.section .text.info_flow__start_periodic,"ax",@progbits
	.global info_flow__start_periodic
info_flow__start_periodic:
L_8dc75c:
	push_s blink
L_8dc75e:
	bl L_8c02bc
L_8dc762:
	bl.d L_8ca1b0
L_8dc766:
	mov_s r15,r0
L_8dc768:
	mov_s r16,r0
L_8dc76a:
	mov_s r13,0x0
L_8dc76c:
	st.as r13,[gp,-0x21]
L_8dc770:
	bl.d L_8d73c4
L_8dc774:
	mov_s r0,r15
L_8dc776:
	breq_s r0,0,L_8dc7cc
L_8dc778:
	mov_s r2,0x100ea78
L_8dc77e:
	mov_s r0,0xb
L_8dc780:
	bl.d L_8edfb0
L_8dc784:
	mov_s r1,0x2
L_8dc786:
	mov_s r14,r13
L_8dc788:
	b_s L_8dc79c
	.global L_8dc78a
L_8dc78a:
	mov_s r2,0x100eaa8
L_8dc790:
	mov_s r0,0xb
L_8dc792:
	mov_s r1,0x2
L_8dc794:
	bl.d L_8edfcc
L_8dc798:
	mov_s r3,r14
	.global L_8dc79a
L_8dc79a:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8dc79c
L_8dc79c:
	brge r14,0x8,L_8dc7c2
L_8dc7a0:
	bl.d L_8c9e44
L_8dc7a4:
	mov_s r0,r14
L_8dc7a6:
	mov.f r1,r0
L_8dc7aa:
	beq_s L_8dc78a
L_8dc7ac:
	ldb r0,[r1, 0xb0]
L_8dc7b0:
	brne r0,0x2,L_8dc78a
L_8dc7b4:
	mov_s r0,r16
L_8dc7b6:
	mov_s r2,0x0
L_8dc7b8:
	bl.d L_8d54ec
L_8dc7bc:
	mov_s r3,r2
L_8dc7be:
	mov_s r13,0x1
L_8dc7c0:
	b_s L_8dc79a
	.global L_8dc7c2
L_8dc7c2:
	cmp_s r13,0x0
L_8dc7c4:
	bl.ne.d L_8d5374
L_8dc7c8:
	mov.ne r0,r15
	.global L_8dc7cc
L_8dc7cc:
	b L_8c0324
