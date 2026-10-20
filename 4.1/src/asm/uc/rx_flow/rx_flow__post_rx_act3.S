/* rx_flow__post_rx_act3 @ 0x92e950, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: mtp_service__dispatch, rx_flow__post_rx_tail, rx_rfc_step
 * Глобалы (через gp): 0x800610, 0x800614
 */
	.section .text.rx_flow__post_rx_act3,"ax",@progbits
	.global rx_flow__post_rx_act3
rx_flow__post_rx_act3:
L_92e950:
	mov r4,0x20000400
L_92e958:
	mov r32,r4
L_92e95c:
	st.ab r4,[r25,0x4]
L_92e960:
	bclr r25,r25,0xa
L_92e964:
	ld_s r1,[r14]
L_92e966:
	mov_s r0,0x5
L_92e968:
	ld r2,[r14, 0x8]
L_92e96c:
	bl.d L_92a404
L_92e970:
	mov r3,0xff
	.global L_92e974
L_92e974:
	mov_s r0,r43
L_92e976:
	bbit0 r0,0x1f,L_92e974
L_92e97a:
	mov_s r1,r51
L_92e97c:
	bmsk r0,r1,0x3
L_92e980:
	st.as r0,[gp,0x3a]
L_92e984:
	lsr_s r1,r1,0x4
L_92e986:
	st.as r1,[gp,0x3b]
L_92e98a:
	lsr r0,r43,0x10
L_92e98e:
	bmsk_s r0,r0,0x4
L_92e990:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_92e992:
	or r0,r0,0x3e000000
L_92e99a:
	mov_s r32,r0
L_92e99c:
	st.ab r0,[r25,0x4]
L_92e9a0:
	bclr r25,r25,0xa
L_92e9a4:
	mov r4,0x37000020
L_92e9ac:
	mov r32,r4
L_92e9b0:
	st.ab r4,[r25,0x4]
L_92e9b4:
	bclr r25,r25,0xa
L_92e9b8:
	mov_s r0,0x801458
L_92e9be:
	ld r11,[r0, 0xc]
L_92e9c2:
	mov_s r1,0x2008000
L_92e9c8:
	add r11,r11,0x1
L_92e9cc:
	st r11,[r0, 0xc]
L_92e9d0:
	mov r32,r1
L_92e9d4:
	st.ab r1,[r25,0x4]
L_92e9d8:
	bclr r25,r25,0xa
L_92e9dc:
	mov_s r2,0x19000001
L_92e9e2:
	mov_s r32,r2
L_92e9e4:
	st.ab r2,[r25,0x4]
L_92e9e8:
	bclr r25,r25,0xa
	.global L_92e9ec
L_92e9ec:
	mov r1,r45
L_92e9f0:
	bbit0 r1,0x1f,L_92e9ec
L_92e9f4:
	mov r5,0x18000000
L_92e9fc:
	mov r32,r5
L_92ea00:
	st.ab r5,[r25,0x4]
L_92ea04:
	bclr r25,r25,0xa
L_92ea08:
	mov r0,r14
L_92ea0c:
	bl.d L_92f12c
L_92ea10:
	mov r1,0x5
L_92ea14:
	mov_s r2,0x80088c
L_92ea1a:
	ldw r1,[r2, 0xae]
L_92ea1e:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92ea20:
	b.d L_92ea78
L_92ea24:
	stw r1,[r2, 0xae]
