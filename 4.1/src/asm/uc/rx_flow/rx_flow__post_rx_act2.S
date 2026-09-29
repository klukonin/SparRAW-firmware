/* rx_flow__post_rx_act2 @ 0x92e89c, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: mtp_service__dispatch, rx_flow__post_rx_tail, rx_rfc_step
 * Глобалы (через gp): 0x800610, 0x800614
 */
	.section .text.rx_flow__post_rx_act2,"ax",@progbits
	.global rx_flow__post_rx_act2
rx_flow__post_rx_act2:
L_92e89c:
	ld_s r1,[r14]
L_92e89e:
	mov_s r0,0x1
L_92e8a0:
	ld r2,[r14, 0x8]
L_92e8a4:
	bl.d L_92a404
L_92e8a8:
	mov r3,0xff
	.global L_92e8ac
L_92e8ac:
	mov r10,r43
L_92e8b0:
	bbit0 r10,0x1f,L_92e8ac
L_92e8b4:
	mov_s r1,r51
L_92e8b6:
	bmsk r10,r1,0x3
L_92e8ba:
	st.as r10,[gp,0x3a]
L_92e8be:
	lsr_s r1,r1,0x4
L_92e8c0:
	st.as r1,[gp,0x3b]
L_92e8c4:
	lsr r0,r43,0x10
L_92e8c8:
	bmsk_s r0,r0,0x4
L_92e8ca:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_92e8cc:
	or r0,r0,0x3e000000
L_92e8d4:
	mov r32,r0
L_92e8d8:
	st.ab r0,[r25,0x4]
L_92e8dc:
	bclr r25,r25,0xa
L_92e8e0:
	mov_s r3,0x37000020
L_92e8e6:
	mov_s r32,r3
L_92e8e8:
	st.ab r3,[r25,0x4]
L_92e8ec:
	bclr r25,r25,0xa
L_92e8f0:
	mov r11,0x801458
L_92e8f8:
	ld r9,[r11, 0xc]
L_92e8fc:
	add r9,r9,0x1
L_92e900:
	st r9,[r11, 0xc]
L_92e904:
	mov r9,0x2008000
L_92e90c:
	mov r32,r9
L_92e910:
	st.ab r9,[r25,0x4]
L_92e914:
	bclr r25,r25,0xa
L_92e918:
	mov_s r0,0x19000001
L_92e91e:
	mov_s r32,r0
L_92e920:
	st.ab r0,[r25,0x4]
L_92e924:
	bclr r25,r25,0xa
	.global L_92e928
L_92e928:
	mov r11,r45
L_92e92c:
	bbit0 r11,0x1f,L_92e928
L_92e930:
	mov_s r3,0x18
L_92e932:
	asl_s r3,r3,0x18
L_92e934:
	mov r32,r3
L_92e938:
	st.ab r3,[r25,0x4]
L_92e93c:
	bclr r25,r25,0xa
L_92e940:
	mov r0,r14
L_92e944:
	bl.d L_92f12c
L_92e948:
	mov r1,0x1
L_92e94c:
	b L_92ea78
