/* rx_flow__decide_imm_ack @ 0x92ee7c, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_flow.c
 * Зовёт сам: rx_flow__check_ppdu_and_ctx, uc_sysassert
 */
	.section .text.rx_flow__decide_imm_ack,"ax",@progbits
	.global rx_flow__decide_imm_ack
rx_flow__decide_imm_ack:
L_92ee7c:
	j_s [r0]
	.global sub_92ee7e
sub_92ee7e:
L_92ee7e:
	mov_s r3,r36
L_92ee80:
	btst r3,0x8
L_92ee84:
	beq L_92f11c
L_92ee88:
	mov r5,r38
L_92ee8c:
	btst r5,0xf
L_92ee90:
	bne L_92f11c
L_92ee94:
	mov r6,r38
L_92ee98:
	bbit0 r6,0xc,L_92ef08
L_92ee9c:
	ldb r4,[gp, -0xe9]
L_92eea0:
	breq r4,0x0,L_92ef08
L_92eea4:
	mov r5,r53
L_92eea8:
	bbit1 r5,0x0,L_92eef0
L_92eeac:
	mov r7,0x23010003
L_92eeb4:
	mov r32,r7
L_92eeb8:
	st.ab r7,[r25,0x4]
L_92eebc:
	bclr r25,r25,0xa
L_92eec0:
	mov_s r1,0x2000200
L_92eec6:
	mov_s r32,r1
L_92eec8:
	st.ab r1,[r25,0x4]
L_92eecc:
	bclr r25,r25,0xa
L_92eed0:
	nop_s
L_92eed2:
	nop_s
L_92eed4:
	mov 0x0,0x0
	.global L_92eed8
L_92eed8:
	mov r6,r42
L_92eedc:
	bbit1 r6,0x9,L_92eee8
L_92eee0:
	mov r7,r53
L_92eee4:
	bbit0 r7,0x0,L_92eed8
	.global L_92eee8
L_92eee8:
	mov r9,r42
L_92eeec:
	bbit1 r9,0x9,L_92ef28
	.global L_92eef0
L_92eef0:
	and r3,r53,0x10
L_92eef4:
	st.as r3,[gp,-0x33]
L_92eef8:
	mov_s r3,0x1c000001
L_92eefe:
	mov_s r32,r3
L_92ef00:
	st.ab r3,[r25,0x4]
L_92ef04:
	bclr r25,r25,0xa
	.global L_92ef08
L_92ef08:
	cmp r14,0x0
L_92ef0c:
	ble.d L_92f11c
L_92ef10:
	mov_s r13,0x1
L_92ef12:
	st r13,[0x80112c]
L_92ef1a:
	mov_s r0,r13
L_92ef1c:
	ld blink,[sp, 0x4]
L_92ef20:
	ld_s r14,[sp,0x8]
L_92ef22:
	j_s.d [blink]
L_92ef24:
	ld.ab r13,[sp,0xc]
	.global L_92ef28
L_92ef28:
	mov_s r0,blink
L_92ef2a:
	mov_s r2,0x10010dc
L_92ef30:
	mov r1,0x3b
L_92ef34:
	bl.d L_925548
L_92ef38:
	mov r3,0x6f
L_92ef3c:
	b L_92eef0
