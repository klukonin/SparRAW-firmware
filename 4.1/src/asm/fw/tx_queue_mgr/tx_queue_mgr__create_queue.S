/* tx_queue_mgr__create_queue @ 0x8d68d8, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_queue_mgr.cpp
 * Зовут его: sniffer_mode_step
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, fw_sysassert_fatal, tx_macq__config_ring_params, tx_macq__setup
 */
	.section .text.tx_queue_mgr__create_queue,"ax",@progbits
	.global tx_queue_mgr__create_queue
tx_queue_mgr__create_queue:
	.global L_8d68d8
L_8d68d8:
	push_s blink
L_8d68da:
	bl L_8c02a0
L_8d68de:
	mov_s r16,r0
L_8d68e0:
	mov_s r18,r1
L_8d68e2:
	mov_s r15,r2
L_8d68e4:
	mov_s r17,r3
L_8d68e6:
	mov r21,r4
L_8d68ea:
	ld_s r0,[sp,0x30]
L_8d68ec:
	mov r20,r6
L_8d68f0:
	mov r19,r5
L_8d68f4:
	mov r23,r7
L_8d68f8:
	breq r0,0x4,L_8d6956
	.global L_8d68fc
L_8d68fc:
	add r0,r18,r16
L_8d6900:
	mov_s r13,0x8062f4
L_8d6906:
	brhs.d r18,r0,L_8d69b8
L_8d690a:
	add3 r13,r13,r18
L_8d690e:
	mov_s r14,r18
	.global L_8d6910
L_8d6910:
	stb_s r14,[r13]
L_8d6912:
	mov r22,0x80345c
L_8d691a:
	ld r0,[r22, 0xc]
L_8d691e:
	cmp_s r0,0x0
L_8d6920:
	mov.ne r20,0x1f28
L_8d6928:
	stw r20,[r13, 0x6]
L_8d692c:
	extw_s r1,r15
L_8d692e:
	extw r2,r17
L_8d6932:
	extw r3,r21
L_8d6936:
	extw r4,r19
L_8d693a:
	mov_s r0,r13
L_8d693c:
	bl.d L_8de5d8
L_8d6940:
	mov r5,r20
L_8d6944:
	ld_s r1,[sp,0x30]
L_8d6946:
	mov_s r0,0x0
L_8d6948:
	brne r1,0x3,L_8d696c
L_8d694c:
	ld r0,[r22, 0xc]
L_8d6950:
	breq_s r0,0,L_8d696a
L_8d6952:
	mov_s r0,0x6
L_8d6954:
	b_s L_8d696c
	.global L_8d6956
L_8d6956:
	mov_s r0,blink
L_8d6958:
	mov_s r2,0x1015a48
L_8d695e:
	mov_s r1,0x8d
L_8d6960:
	bset_s r1,r1,0xc
L_8d6962:
	bl.d L_8c82c0
L_8d6966:
	mov_s r3,0x84
L_8d6968:
	b_s L_8d68fc
	.global L_8d696a
L_8d696a:
	mov_s r0,0x7
	.global L_8d696c
L_8d696c:
	mov_s r1,0x801488
L_8d6972:
	ld_s r3,[r1,0x4]
L_8d6974:
	mov_s r2,0x1
L_8d6976:
	cmp_s r3,0x0
L_8d6978:
	sub_s.ne r2,r2,r2
L_8d697a:
	cmp_s r3,0x1
L_8d697c:
	mov_s r3,0x1
L_8d697e:
	sub_s.ne r3,r3,r3
L_8d6980:
	extb r4,r0
L_8d6984:
	mov_s r0,r13
L_8d6986:
	ld_s r1,[sp,0x30]
L_8d6988:
	mov r5,0x0
L_8d698c:
	mov r6,r5
L_8d6990:
	bl.d L_8d63fc
L_8d6994:
	mov r7,r5
L_8d6998:
	add r1,r21,r19
L_8d699c:
	add r0,r15,r17
L_8d69a0:
	cmp r23,0x0
L_8d69a4:
	mov.eq r21,r1
L_8d69a8:
	mov.eq r15,r0
L_8d69ac:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d69ae:
	add r0,r18,r16
L_8d69b2:
	brlo.d r14,r0,L_8d6910
L_8d69b6:
	add_s r13,r13,0x8
	.global L_8d69b8
L_8d69b8:
	b L_8c02ec
