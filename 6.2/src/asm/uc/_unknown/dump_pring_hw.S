/* dump_pring_hw @ 0x9291d8, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PRING: hw_head    %d hw_tail    %d  on hwd_dma_pring_no_pending_request
 *   PRING: hw_wb_head %d hw_wb_tail %d
 * Зовут его: vring__disconnect_flush
 * Зовёт сам: uc_log__emit2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dump_pring_hw
dump_pring_hw:
	.global L_9291d8
L_9291d8:
	st.a r13,[sp,-0xc]
L_9291dc:
	st blink,[sp, 0x4]
L_9291e0:
	st_s r14,[sp,0x8]
L_9291e2:
	asl r7,r0,0x3
L_9291e6:
	sub r7,r7,r0
L_9291ea:
	asl r7,r7,0x7
L_9291ee:
	add r10,r7,0x4409800
L_9291f6:
	lsr r4,r10,0x3
L_9291fa:
	bic r4,r4,0x3
L_9291fe:
	ld r2,[r4]
L_929202:
	bmsk r10,r10,0x4
L_929206:
	lsr r2,r2,r10
L_92920a:
	bmsk_s r2,r2,0x3
L_92920c:
	add r9,r7,0x4409840
L_929214:
	lsr r3,r9,0x3
L_929218:
	bic r3,r3,0x3
L_92921c:
	ld_s r3,[r3]
L_92921e:
	bmsk r9,r9,0x4
L_929222:
	lsr r3,r3,r9
L_929226:
	bmsk_s r3,r3,0x3
L_929228:
	add r8,r7,0x4409820
L_929230:
	lsr r5,r8,0x3
L_929234:
	bic r5,r5,0x3
L_929238:
	ld r13,[r5]
L_92923c:
	bmsk r8,r8,0x4
L_929240:
	lsr r13,r13,r8
L_929244:
	bmsk_s r13,r13,0x3
L_929246:
	add r7,r7,0x4409860
L_92924e:
	lsr r6,r7,0x3
L_929252:
	bic r6,r6,0x3
L_929256:
	ld r14,[r6]
L_92925a:
	bmsk r7,r7,0x4
L_92925e:
	lsr r14,r14,r7
L_929262:
	bmsk_s r14,r14,0x3
L_929264:
	cmp r2,r3
L_929268:
	cmp.eq r13,r14
L_92926c:
	cmp.eq r2,r13
L_929270:
	beq.d L_92929c
L_929274:
	mov_s r0,0x1
L_929276:
	mov_s r1,0x1002e88
L_92927c:
	bl.d L_92d27c
L_929280:
	mov r0,0x20
L_929284:
	mov_s r1,0x1002de0
L_92928a:
	mov_s r0,0x20
L_92928c:
	mov r2,r13
L_929290:
	bl.d L_92d27c
L_929294:
	mov r3,r14
L_929298:
	mov r0,0x0
	.global L_92929c
L_92929c:
	ld blink,[sp, 0x4]
L_9292a0:
	ld_s r14,[sp,0x8]
L_9292a2:
	j_s.d [blink]
L_9292a4:
	ld.ab r13,[sp,0xc]
