/* state_sm_8034c0__action_step @ 0x8cb5a4, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: state_sm_8034c0__action_8f0a24
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, get_connection_by_addr, mac_read_tsf64, state_sm_8034c0__step_b, tof_mgr__aoa_session_start, tof_mgr__ftm_error_handler, tx_list__remove
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_8034c0__action_step
state_sm_8034c0__action_step:
	.global L_8cb5a4
L_8cb5a4:
	push_s blink
L_8cb5a6:
	bl L_8c01e0
L_8cb5aa:
	mov_s r14,r0
L_8cb5ac:
	mov_s r13,r1
L_8cb5ae:
	ldw_s r15,[r1,0x16]
L_8cb5b0:
	add r1,r0,0x18
L_8cb5b4:
	mov_s r0,0x0
L_8cb5b6:
	bl.d L_8e9900
L_8cb5ba:
	mov_s r2,r0
L_8cb5bc:
	mov_s r0,r14
L_8cb5be:
	bl.d L_8e1dc8
L_8cb5c2:
	mov_s r1,r13
L_8cb5c4:
	brne r15,0x1,L_8cb5e2
L_8cb5c8:
	mov_s r0,r14
L_8cb5ca:
	bl.d L_8c3930
L_8cb5ce:
	mov_s r1,r13
L_8cb5d0:
	brne_s r0,0,L_8cb5e2
L_8cb5d2:
	add r0,r14,0xc
L_8cb5d6:
	bl.d L_8e2884
L_8cb5da:
	mov_s r1,r13
L_8cb5dc:
	bl.d L_8cb210
L_8cb5e0:
	mov_s r0,r14
	.global L_8cb5e2
L_8cb5e2:
	brne_s r15,0,L_8cb600
L_8cb5e4:
	add r0,r14,0x20
L_8cb5e8:
	bl.d L_8cb560
L_8cb5ec:
	mov_s r1,r13
L_8cb5ee:
	brne_s r0,0,L_8cb600
L_8cb5f0:
	add r0,r14,0xc
L_8cb5f4:
	bl.d L_8e2884
L_8cb5f8:
	mov_s r1,r13
L_8cb5fa:
	bl.d L_8cb210
L_8cb5fe:
	mov_s r0,r14
	.global L_8cb600
L_8cb600:
	b L_8c024c
