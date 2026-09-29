/* rx_flow__check_status @ 0x92ef40, 364 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_flow.c
 * Зовёт сам: bap_q_avail__check, rx_flow__check_ppdu_and_ctx, uc_sysassert
 * Глобалы (через gp): 0x800608
 */
	.section .text.rx_flow__check_status,"ax",@progbits
	.global rx_flow__check_status
rx_flow__check_status:
L_92ef40:
	mov r10,r36
L_92ef44:
	btst r10,0x9
L_92ef48:
	beq L_92f11c
L_92ef4c:
	mov r4,r38
L_92ef50:
	btst r4,0xf
L_92ef54:
	bne L_92f11c
L_92ef58:
	mov r8,r38
L_92ef5c:
	btst r8,0xc
L_92ef60:
	beq L_92f11c
L_92ef64:
	ldb r11,[gp, -0xe9]
L_92ef68:
	breq r11,0x0,L_92efd4
L_92ef6c:
	mov r0,r53
L_92ef70:
	bbit1 r0,0x0,L_92efb8
L_92ef74:
	mov r9,0x23010003
L_92ef7c:
	mov r32,r9
L_92ef80:
	st.ab r9,[r25,0x4]
L_92ef84:
	bclr r25,r25,0xa
L_92ef88:
	mov r4,0x2000200
L_92ef90:
	mov r32,r4
L_92ef94:
	st.ab r4,[r25,0x4]
L_92ef98:
	bclr r25,r25,0xa
L_92ef9c:
	nop_s
L_92ef9e:
	nop_s
L_92efa0:
	mov 0x0,0x0
	.global L_92efa4
L_92efa4:
	mov_s r3,r42
L_92efa6:
	bbit1 r3,0x9,L_92efb0
L_92efaa:
	mov_s r2,r53
L_92efac:
	bbit0 r2,0x0,L_92efa4
	.global L_92efb0
L_92efb0:
	mov_s r1,r42
L_92efb2:
	btst_s r1,0x9
L_92efb4:
	bne L_92f094
	.global L_92efb8
L_92efb8:
	and r11,r53,0x10
L_92efbc:
	st.as r11,[gp,-0x33]
L_92efc0:
	mov r8,0x1c000001
L_92efc8:
	mov r32,r8
L_92efcc:
	st.ab r8,[r25,0x4]
L_92efd0:
	bclr r25,r25,0xa
	.global L_92efd4
L_92efd4:
	ld.as r7,[gp,-0x33]
L_92efd8:
	cmp r7,0x0
L_92efdc:
	/* bne_s 0x0092f11c */
	.byte 0xa0,0xf4
L_92efde:
	mov_s r13,0x1
L_92efe0:
	lsr r0,r53,0x8
L_92efe4:
	bmsk r1,r0,0x6
L_92efe8:
	lsr r3,r53,0x10
L_92efec:
	mov r9,0x801118
L_92eff4:
	ld r4,[r9]
L_92eff8:
	bmsk r3,r3,0x6
L_92effc:
	add r4,r4,r1
L_92f000:
	ld r5,[r9, 0x4]
L_92f004:
	st r4,[r9]
L_92f008:
	add r5,r5,r3
L_92f00c:
	ld r6,[r9, 0x8]
L_92f010:
	st r5,[r9, 0x4]
L_92f014:
	add r6,r6,0x1
L_92f018:
	brlt.d r14,0x1,L_92f028
L_92f01c:
	st r6,[r9, 0x8]
L_92f020:
	mov r8,0x1
L_92f024:
	st r8,[r9, 0x14]
	.global L_92f028
L_92f028:
	ld r0,[0x801418]
L_92f030:
	asl r10,r0,0x2
L_92f034:
	add1 r10,r10,r10
L_92f038:
	ld r7,[r10,0x8016d8]
L_92f040:
	sub.f r7,r7,0x0
L_92f044:
	mov.ne r7,0x1
L_92f048:
	extb.f 0x0,r7
L_92f04c:
	bl.ne.d L_92c4b8
L_92f050:
	mov.ne r2,r3
L_92f054:
	ld.as r10,[gp,0x38]
L_92f058:
	btst r10,0x1e
L_92f05c:
	/* beq_s 0x0092f11c */
	.byte 0x60,0xf2
L_92f05e:
	ld r9,[0x801a78]
L_92f066:
	mov r5,0x8019e8
L_92f06e:
	ld r3,[r9, 0x4]
L_92f072:
	ld r8,[r5]
L_92f076:
	bclr r10,r10,0x1e
L_92f07a:
	bclr r8,r8,r3
L_92f07e:
	st r8,[r5]
L_92f082:
	st.as r10,[gp,0x38]
L_92f086:
	mov_s r0,r13
L_92f088:
	ld blink,[sp, 0x4]
L_92f08c:
	ld_s r14,[sp,0x8]
L_92f08e:
	j_s.d [blink]
L_92f090:
	ld.ab r13,[sp,0xc]
	.global L_92f094
L_92f094:
	mov_s r0,blink
L_92f096:
	mov_s r2,0x10010dc
L_92f09c:
	mov r1,0x3b
L_92f0a0:
	bl.d L_925548
L_92f0a4:
	mov r3,0x6f
L_92f0a8:
	b L_92efb8
