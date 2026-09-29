/* rx__arm_window @ 0x9228d4, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__exchange_request, brp_initiator_brp_transaction_flow
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x800578
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__arm_window
rx__arm_window:
	.global L_9228d4
L_9228d4:
	push_s blink
L_9228d6:
	mov_s r0,0x0
L_9228d8:
	bset_s r0,r0,0x10
L_9228da:
	bl.d L_9366e8
L_9228de:
	mov_s r1,0x0
L_9228e0:
	ldb_s r0,[gp,-0xf2]
L_9228e2:
	brne_s r0,0,L_922900
L_9228e4:
	ldb_s r0,[gp,-0xf9]
L_9228e6:
	bmsk_s r0,r0,0x0
L_9228e8:
	bset_s r0,r0,0x19
L_9228ea:
	bset_s r0,r0,0x1c
L_9228ec:
	bset_s r0,r0,0x1d
L_9228ee:
	mov_s r32,r0
L_9228f0:
	st.ab r0,[r25,0x4]
L_9228f4:
	bclr r25,r25,0xa
L_9228f8:
	ldb_s r0,[gp,-0xf9]
L_9228fa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9228fc:
	stb r0,[gp, -0xf9]
	.global L_922900
L_922900:
	ld_s r0,[gp,0x50]
L_922902:
	mov_s r1,0x8022c8
L_922908:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92290a:
	st.as r0,[gp,0x14]
L_92290e:
	ld_s r0,[r1,0x3c]
L_922910:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922912:
	st_s r0,[r1,0x3c]
L_922914:
	mov_s r0,0x2011000
L_92291a:
	mov_s r32,r0
L_92291c:
	st.ab r0,[r25,0x4]
L_922920:
	bclr r25,r25,0xa
L_922924:
	pop_s blink
L_922926:
	j_s [blink]
