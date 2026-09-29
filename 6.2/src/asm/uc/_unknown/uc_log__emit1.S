/* uc_log__emit1 @ 0x92d1d0, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__process_request_fifo, brp_initiator_flow_successful_receive_training, brp_restore_sectors, dma_is_tx_pipe_idle, dti_worker__scheduled_dti_allocation_event, dump_vring_pring_info, hwd_rfc_powerdown_deep_all_rfs, hwd_rfc_powerup_deep_all_rfs, hwd_rfc_write_core, internal_tx_isr
 * Зовёт сам: uc_sysassert__snapshot_mac
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_log__emit1
uc_log__emit1:
	.global L_92d1d0
L_92d1d0:
	st.a r13,[sp,-0xc]
L_92d1d4:
	st_s r14,[sp,0x8]
L_92d1d6:
	mov_s r14,r1
L_92d1d8:
	bmsk r9,r0,0x3
L_92d1dc:
	lsr_s r0,r0,0x4
L_92d1de:
	mov_s r13,0x803234
L_92d1e4:
	add r4,r13,0x4
L_92d1e8:
	ldb r1,[r4,r9]
L_92d1ec:
	bmsk r0,r0,0x1
L_92d1f0:
	st blink,[sp, 0x4]
L_92d1f4:
	bbit0.d r1,r0,L_92d26c
L_92d1f8:
	sub_s sp,sp,0x8
L_92d1fa:
	ld_s r3,[r13]
L_92d1fc:
	mov_s r1,sp
L_92d1fe:
	/* add_s r3,0x2 */
	.byte 0x02,0xe3
L_92d200:
	extb_s r3,r3
L_92d202:
	add2 r3,r13,r3
L_92d206:
	st_s r2,[r3,0x14]
L_92d208:
	mov r0,0x0
L_92d20c:
	bl.d L_93756c
L_92d210:
	mov r2,r0
L_92d214:
	ld r5,[sp, 0x4]
L_92d218:
	mov r8,0xff
L_92d21c:
	cmp r5,0xff
L_92d220:
	mov.cc r4,r8
L_92d224:
	ld r6,[r13]
L_92d228:
	mov.cs r4,r5
L_92d22c:
	add r7,r6,0x1
L_92d230:
	extb r7,r7
L_92d234:
	ld r2,[sp]
L_92d238:
	add2 r7,r13,r7
L_92d23c:
	st r2,[r7, 0x14]
L_92d240:
	bmsk r5,r14,0x13
L_92d244:
	or r5,r5,0xa4000000
L_92d24c:
	extb r4,r4
L_92d250:
	asl r4,r4,0x12
L_92d254:
	or r4,r4,r5
L_92d258:
	extb r3,r6
L_92d25c:
	add2 r3,r13,r3
L_92d260:
	st r4,[r3, 0x14]
L_92d264:
	add r6,r6,0x3
L_92d268:
	st r6,[r13]
	.global L_92d26c
L_92d26c:
	add_s sp,sp,0x8
L_92d26e:
	ld blink,[sp, 0x4]
L_92d272:
	ld_s r14,[sp,0x8]
L_92d274:
	j.d [blink]
L_92d278:
	ld.ab r13,[sp,0xc]
