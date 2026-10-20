/* tx_queue_mgr__create_queue @ 0x8d9978, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: disc_sm__sw_data_stopped
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, fw_sysassert_fatal, tx_macq__config_ring_params, tx_macq__setup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_queue_mgr__create_queue
tx_queue_mgr__create_queue:
	.global L_8d9978
L_8d9978:
	push_s blink
L_8d997a:
	bl L_8c01c0
L_8d997e:
	mov_s r18,r0
L_8d9980:
	mov_s r16,r1
L_8d9982:
	mov_s r15,r2
L_8d9984:
	mov_s r17,r3
L_8d9986:
	mov r21,r4
L_8d998a:
	ld_s r0,[sp,0x30]
L_8d998c:
	mov r20,r6
L_8d9990:
	mov r19,r5
L_8d9994:
	mov r23,r7
L_8d9998:
	breq r0,0x4,L_8d99f6
	.global L_8d999c
L_8d999c:
	asl r13,r16,0x4
L_8d99a0:
	add_s r13,r13,0x806014
L_8d99a6:
	add r0,r16,r18
L_8d99aa:
	brhs r16,r0,L_8d9a50
L_8d99ae:
	mov_s r14,r16
	.global L_8d99b0
L_8d99b0:
	stb_s r14,[r13,0xa]
L_8d99b2:
	mov r22,0x803c00
L_8d99ba:
	ld r0,[r22, 0xc]
L_8d99be:
	cmp_s r0,0x0
L_8d99c0:
	mov.ne r20,0x1f28
L_8d99c8:
	stw r20,[r13, 0x6]
L_8d99cc:
	extw_s r1,r15
L_8d99ce:
	extw r2,r17
L_8d99d2:
	extw r3,r21
L_8d99d6:
	extw r4,r19
L_8d99da:
	mov_s r0,r13
L_8d99dc:
	bl.d L_8e29b8
L_8d99e0:
	mov r5,r20
L_8d99e4:
	ld_s r1,[sp,0x30]
L_8d99e6:
	mov_s r0,0x0
L_8d99e8:
	brne r1,0x3,L_8d9a04
L_8d99ec:
	ld r0,[r22, 0xc]
L_8d99f0:
	breq_s r0,0,L_8d9a02
L_8d99f2:
	mov_s r0,0x6
L_8d99f4:
	b_s L_8d9a04
	.global L_8d99f6
L_8d99f6:
	mov_s r0,blink
L_8d99f8:
	mov_s r1,0x8d
L_8d99fa:
	bl.d L_8c9b28
L_8d99fe:
	bset_s r1,r1,0xc
L_8d9a00:
	b_s L_8d999c
	.global L_8d9a02
L_8d9a02:
	mov_s r0,0x7
	.global L_8d9a04
L_8d9a04:
	mov_s r1,0x8031c8
L_8d9a0a:
	ldb_s r3,[r1,0x1]
L_8d9a0c:
	mov_s r2,0x1
L_8d9a0e:
	cmp_s r3,0x0
L_8d9a10:
	sub_s.ne r2,r2,r2
L_8d9a12:
	cmp_s r3,0x1
L_8d9a14:
	mov_s r3,0x1
L_8d9a16:
	sub_s.ne r3,r3,r3
L_8d9a18:
	extb r4,r0
L_8d9a1c:
	mov_s r0,r13
L_8d9a1e:
	ld_s r1,[sp,0x30]
L_8d9a20:
	mov r5,0x0
L_8d9a24:
	mov r6,r5
L_8d9a28:
	bl.d L_8d944c
L_8d9a2c:
	mov r7,r5
L_8d9a30:
	add r1,r21,r19
L_8d9a34:
	add r0,r15,r17
L_8d9a38:
	cmp r23,0x0
L_8d9a3c:
	mov.eq r21,r1
L_8d9a40:
	mov.eq r15,r0
L_8d9a44:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d9a46:
	add r0,r16,r18
L_8d9a4a:
	brlo.d r14,r0,L_8d99b0
L_8d9a4e:
	add_s r13,r13,0x10
	.global L_8d9a50
L_8d9a50:
	b L_8c020c
