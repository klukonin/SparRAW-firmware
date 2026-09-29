/* uc_log__emit2 @ 0x92d27c, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_unexpected, brp_initiator_flow_successful_receive_training, brp_responder_flow_enter, brp_responder_transmission_flow, brp_update_omni_sector_idx, dma_is_idle_uc, dti_worker__scheduled_dti_allocation_event, dump_pring_hw, dump_vring_pring_info, fwif_write_qh
 * Зовёт сам: uc_sysassert__snapshot_mac
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_log__emit2
uc_log__emit2:
	.global L_92d27c
L_92d27c:
	st.a r13,[sp,-0xc]
L_92d280:
	st blink,[sp, 0x4]
L_92d284:
	st_s r14,[sp,0x8]
L_92d286:
	bmsk r9,r0,0x3
L_92d28a:
	lsr_s r0,r0,0x4
L_92d28c:
	mov_s r13,0x803234
L_92d292:
	add r4,r13,0x4
L_92d296:
	ldb r5,[r4,r9]
L_92d29a:
	bmsk_s r0,r0,0x1
L_92d29c:
	sub sp,sp,0x8
L_92d2a0:
	bbit0.d r5,r0,L_92d328
L_92d2a4:
	mov_s r14,r1
L_92d2a6:
	ld r4,[r13]
L_92d2aa:
	mov_s r0,0x0
L_92d2ac:
	add r1,r4,0x3
L_92d2b0:
	extb_s r1,r1
L_92d2b2:
	add2 r1,r13,r1
L_92d2b6:
	st_s r3,[r1,0x14]
L_92d2b8:
	add r4,r4,0x2
L_92d2bc:
	extb r4,r4
L_92d2c0:
	add2 r4,r13,r4
L_92d2c4:
	st r2,[r4, 0x14]
L_92d2c8:
	mov r1,sp
L_92d2cc:
	bl.d L_93756c
L_92d2d0:
	mov r2,r0
L_92d2d4:
	ld r6,[sp, 0x4]
L_92d2d8:
	mov r8,0xff
L_92d2dc:
	cmp r6,0xff
L_92d2e0:
	mov.cc r5,r8
L_92d2e4:
	mov.cs r5,r6
L_92d2e8:
	ld r6,[r13]
L_92d2ec:
	ld_s r2,[sp,0x0]
L_92d2ee:
	add r7,r6,0x1
L_92d2f2:
	extb r7,r7
L_92d2f6:
	add2 r7,r13,r7
L_92d2fa:
	st r2,[r7, 0x14]
L_92d2fe:
	bmsk_s r14,r14,0x13
L_92d300:
	or r14,r14,0xa8000000
L_92d308:
	extb r5,r5
L_92d30c:
	asl r5,r5,0x12
L_92d310:
	or r14,r14,r5
L_92d314:
	extb r3,r6
L_92d318:
	add2 r3,r13,r3
L_92d31c:
	st r14,[r3, 0x14]
L_92d320:
	add r6,r6,0x4
L_92d324:
	st r6,[r13]
	.global L_92d328
L_92d328:
	add_s sp,sp,0x8
L_92d32a:
	ld blink,[sp, 0x4]
L_92d32e:
	ld_s r14,[sp,0x8]
L_92d330:
	j.d [blink]
L_92d334:
	ld.ab r13,[sp,0xc]
