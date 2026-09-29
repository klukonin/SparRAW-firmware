/* state_sm_803424__action_8f08c0 @ 0x8f08c0, 308 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, basic_sm__handle_event, host_if__send_pair, low_sme__send_evt2sw, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_803424__action_8f08c0
state_sm_803424__action_8f08c0:
	.global L_8f08c0
L_8f08c0:
	push_s blink
L_8f08c2:
	bl L_8c01c4
L_8f08c6:
	sub_s sp,sp,0x20
L_8f08c8:
	ld_s r13,[r0,0x1c]
L_8f08ca:
	mov_s r17,r1
L_8f08cc:
	cmp_s r13,0x0
L_8f08ce:
	mov_s r16,r0
L_8f08d0:
	ldb r21,[r13, 0xc]
L_8f08d4:
	beq_s L_8f09d2
L_8f08d6:
	bl L_8c32d8
L_8f08da:
	mov_s r14,r0
L_8f08dc:
	ldb_s r0,[r13,0x1c]
L_8f08de:
	st_s r0,[r14]
L_8f08e0:
	mov_s r0,0x6
L_8f08e2:
	stb_s r0,[r14,0xa]
L_8f08e4:
	ld r0,[r17, 0x4]
L_8f08e8:
	stb_s r0,[r14,0xb]
L_8f08ea:
	ld_s r0,[r13,0x10]
L_8f08ec:
	st_s r0,[r14,0x4]
L_8f08ee:
	ldw_s r0,[r13,0x14]
L_8f08f0:
	stw_s r0,[r14,0x8]
L_8f08f2:
	ldb_s r0,[r13,0x9]
L_8f08f4:
	bic r0,r0,-0x3
L_8f08f8:
	asr_s r0,r0
L_8f08fa:
	stb_s r0,[r14,0xc]
L_8f08fc:
	ldb_s r0,[r13,0xb]
L_8f08fe:
	stb_s r0,[r14,0xd]
L_8f0900:
	ldb_s r0,[r13,0xc]
L_8f0902:
	stb_s r0,[r14,0xe]
L_8f0904:
	ldb_s r0,[r13,0xd]
L_8f0906:
	stb_s r0,[r14,0xf]
L_8f0908:
	ldw_s r0,[r13,0xe]
L_8f090a:
	stw_s r0,[r14,0x10]
L_8f090c:
	mov_s r0,0x857300
L_8f0912:
	ld_s r0,[r0,0x64]
L_8f0914:
	st_s r0,[r14,0x14]
L_8f0916:
	ldw r0,[r17, 0xc]
L_8f091a:
	cmp_s r0,0x0
L_8f091c:
	sub_s r1,r0,0x1
L_8f091e:
	mov.ne r18,r1
L_8f0922:
	mov.eq r18,r0
L_8f0926:
	extb.f 0x0,r18
L_8f092a:
	stb r18,[r14, 0x18]
L_8f092e:
	mov_s r0,0x1
L_8f0930:
	stw_s r0,[r14,0x12]
L_8f0932:
	beq_s L_8f09b6
L_8f0934:
	brlo.d r18,0x1,L_8f09b6
L_8f0938:
	mov_s r15,0x0
L_8f093a:
	mov r19,r18
L_8f093e:
	mov_s r20,r15
L_8f0940:
	b_s L_8f0946
	.global L_8f0942
L_8f0942:
	mov_s r15,r22
L_8f0944:
	mov_s r20,r1
	.global L_8f0946
L_8f0946:
	add r22,r15,0x1
L_8f094a:
	asl r13,r22,0x5
L_8f094e:
	add1_s r13,r13,r13
L_8f0950:
	add_s r13,r13,0x857340
L_8f0956:
	ld_s r0,[r13,0x8]
L_8f0958:
	add r1,r13,0x18
L_8f095c:
	st_s r0,[sp,0x0]
L_8f095e:
	ldw_s r0,[r13,0xc]
L_8f0960:
	sub r19,r19,0x1
L_8f0964:
	stw r0,[sp, 0x4]
L_8f0968:
	add r0,sp,0x6
L_8f096c:
	bl.d L_8c0380
L_8f0970:
	mov_s r2,0x6
L_8f0972:
	add_s r0,sp,0xc
L_8f0974:
	add r1,r13,0x1e
L_8f0978:
	bl.d L_8c0380
L_8f097c:
	mov_s r2,0x6
L_8f097e:
	add r0,sp,0x12
L_8f0982:
	add r1,r13,0xe
L_8f0986:
	bl.d L_8c0380
L_8f098a:
	mov_s r2,0x6
L_8f098c:
	ldw_s r0,[r13,0x16]
L_8f098e:
	stw r20,[sp, 0x1c]
L_8f0992:
	stw r0,[sp, 0x1a]
L_8f0996:
	ldw_s r0,[r13,0x14]
L_8f0998:
	stw r20,[sp, 0x1e]
L_8f099c:
	stw r0,[sp, 0x18]
L_8f09a0:
	add r1,r14,0x20
L_8f09a4:
	asl_s r0,r15,0x5
L_8f09a6:
	add_s r0,r0,r1
L_8f09a8:
	mov_s r1,sp
L_8f09aa:
	bl.d L_8c0380
L_8f09ae:
	mov_s r2,0x20
L_8f09b0:
	brhs.d r19,0x1,L_8f0942
L_8f09b4:
	mov_s r1,0x0
	.global L_8f09b6
L_8f09b6:
	asl r2,r18,0x5
L_8f09ba:
	add_s r2,r2,0x20
L_8f09bc:
	extw_s r2,r2
L_8f09be:
	mov_s r0,r14
L_8f09c0:
	mov_s r1,0x1995
L_8f09c6:
	mov_s r3,0x0
L_8f09c8:
	mov_s r4,r3
L_8f09ca:
	mov_s r5,r3
L_8f09cc:
	bl.d L_8e5474
L_8f09d0:
	mov_s r6,r3
	.global L_8f09d2
L_8f09d2:
	ld r0,[r17]
L_8f09d6:
	cmp_s r0,0x2
L_8f09d8:
	cmp.ne r21,0x0
L_8f09dc:
	bne_s L_8f09ee
L_8f09de:
	mov_s r0,r16
L_8f09e0:
	mov_s r1,0x8
L_8f09e2:
	ld r2,[r17, 0x4]
L_8f09e6:
	mov_s r3,0x0
L_8f09e8:
	bl.d L_8d9b6c
L_8f09ec:
	mov_s r4,r3
	.global L_8f09ee
L_8f09ee:
	b.d L_8c0214
L_8f09f2:
	add_s sp,sp,0x20
