/* sm_pring__slot_optimized @ 0x8ea298, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PRING #%d slot optimized recognized at %d.
 * Зовут его: sm_pring__connectivity_update
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit2, fw_sysassert_fatal, mac_tx_cnt__delta_88_net_of_20, sm_pring__notify_vring_state, u_schd__cancel, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_pring__slot_optimized
sm_pring__slot_optimized:
	.global L_8ea298
L_8ea298:
	push_s blink
L_8ea29a:
	bl L_8c01dc
L_8ea29e:
	mov_s r14,r0
L_8ea2a0:
	bl.d L_8dd768
L_8ea2a4:
	mov_s r16,r1
L_8ea2a6:
	mov_s r15,r0
L_8ea2a8:
	ld_s r0,[r14,0x2c]
L_8ea2aa:
	breq_s r0,0,L_8ea2e2
	.global L_8ea2ac
L_8ea2ac:
	ld_s r0,[r14,0x10]
L_8ea2ae:
	mov_s r13,0x0
L_8ea2b0:
	st_s r13,[r14,0x2c]
L_8ea2b2:
	brne r15,r0,L_8ea2de
L_8ea2b6:
	ld_s r0,[r14,0x28]
L_8ea2b8:
	breq_s r0,0,L_8ea2c0
L_8ea2ba:
	bl L_8c8de0
L_8ea2be:
	st_s r13,[r14,0x28]
	.global L_8ea2c0
L_8ea2c0:
	bl L_8e9524
L_8ea2c4:
	ldw_s r2,[r14]
L_8ea2c6:
	mov_s r3,r0
L_8ea2c8:
	mov_s r1,0x100d06c
L_8ea2ce:
	mov_s r0,0x27
L_8ea2d0:
	bl.d L_8dcc80
L_8ea2d4:
	/* _asl_s r3,r3,0x4 */
	.byte 0x04,0xbb
L_8ea2d6:
	ldw_s r0,[r14]
L_8ea2d8:
	bl.d L_8ea1b4
L_8ea2dc:
	mov_s r1,r16
	.global L_8ea2de
L_8ea2de:
	b L_8c0244
	.global L_8ea2e2
L_8ea2e2:
	mov_s r0,blink
L_8ea2e4:
	mov_s r1,0xe7
L_8ea2e6:
	bl.d L_8c9b28
L_8ea2ea:
	bset_s r1,r1,0xc
L_8ea2ec:
	b_s L_8ea2ac
L_8ea2ee:
	nop_s
