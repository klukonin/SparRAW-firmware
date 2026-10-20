/* rx_flow_step @ 0x92db44, 804 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run
 * Зовёт сам: rx__mac_prepare, rx__switch_to_rx_mode, rx_flow__lookup_mcs_ctx, rx_flow_substep, rx_nav_bi_step, uc_wait_event_busy, us_from_ticks165
 * Глобалы (через gp): 0x800534, 0x800540, 0x80056c, 0x800608
 */
	.section .text.rx_flow_step,"ax",@progbits
	.global rx_flow_step
rx_flow_step:
	.global L_92db44
L_92db44:
	st.a r13,[sp,-0x18]
L_92db48:
	st blink,[sp, 0x4]
L_92db4c:
	st_s r14,[sp,0x8]
L_92db4e:
	st_s r15,[sp,0xc]
L_92db50:
	st r16,[sp, 0x10]
L_92db54:
	st r17,[sp, 0x14]
L_92db58:
	sub_s sp,sp,0x4
L_92db5a:
	mov_s r13,r0
L_92db5c:
	mov_s r16,r1
L_92db5e:
	mov_s r14,0x0
L_92db60:
	mov_s r0,0xeeee0b
L_92db66:
	mov_s r32,r0
L_92db68:
	st.ab r0,[r25,0x4]
L_92db6c:
	bclr r25,r25,0xa
L_92db70:
	ld r8,[r13, 0x18]
L_92db74:
	brhs.d r8,r16,L_92db88
L_92db78:
	mov r15,0x0
L_92db7c:
	mov r5,r42
L_92db80:
	btst r5,0x7
L_92db84:
	mov.eq r15,0x1
	.global L_92db88
L_92db88:
	extb r15,r15
L_92db8c:
	bl.d L_9374f0
L_92db90:
	mov r0,r13
L_92db94:
	cmp_s r0,0x1
L_92db96:
	mov r17,0x0
L_92db9a:
	mov.ne r17,r15
L_92db9e:
	mov_s r1,r42
L_92dba0:
	bbit1 r1,0x10,L_92dbb0
L_92dba4:
	mov_s r0,0x0
L_92dba6:
	bset_s r0,r0,0x10
L_92dba8:
	bl.d L_931808
L_92dbac:
	mov r1,0x0
	.global L_92dbb0
L_92dbb0:
	mov r4,r38
L_92dbb4:
	btst r4,0xf
L_92dbb8:
	bl.eq L_9248e8
L_92dbbc:
	ldb r7,[gp, -0xf3]
L_92dbc0:
	breq r7,0x0,L_92dc60
	.global L_92dbc4
L_92dbc4:
	mov_s r2,r38
L_92dbc6:
	bbit0 r2,0xb,L_92dc20
L_92dbca:
	lsr r11,r38,0x8
L_92dbce:
	bmsk r3,r11,0x2
L_92dbd2:
	ld.as r9,[gp,0x6]
L_92dbd6:
	st r3,[0x801418]
L_92dbde:
	btst r9,0x0
L_92dbe2:
	btst.eq r9,0x1
L_92dbe6:
	bne_s L_92dc20
L_92dbe8:
	asl r10,r3,0x2
L_92dbec:
	add1 r10,r10,r10
L_92dbf0:
	ld r0,[r10,0x8016d8]
L_92dbf8:
	sub.f r0,r0,0x0
L_92dbfc:
	mov.ne r0,0x1
L_92dc00:
	extb.f 0x0,r0
L_92dc04:
	bne_s L_92dc20
L_92dc06:
	mov_s r2,0x800a0c
L_92dc0c:
	ldb r7,[r2]
L_92dc10:
	ldb r11,[r2, 0x1]
L_92dc14:
	brge r7,r11,L_92dc20
L_92dc18:
	stb r7,[r2, 0x1]
L_92dc1c:
	stb r3,[r2, 0x2]
	.global L_92dc20
L_92dc20:
	bl L_92ee48
L_92dc24:
	and r16,r0,r17
L_92dc28:
	brne r16,0x1,L_92dcf0
L_92dc2c:
	and.f 0x0,r36,0x6
L_92dc30:
	beq_s L_92dc94
L_92dc32:
	and.f 0x0,r38,0x30000
L_92dc3a:
	bne_s L_92dc94
L_92dc3c:
	lsr r2,r36,0x13
L_92dc40:
	bmsk_s r2,r2,0x4
L_92dc42:
	st_s r2,[r13,0x8]
L_92dc44:
	mov_s r0,r38
L_92dc46:
	ld_s r3,[r13,0x4]
L_92dc48:
	asl r8,0x1,r3
L_92dc50:
	bbit0 r0,0x19,L_92dc8c
L_92dc54:
	mov_s r0,0x0
L_92dc56:
	st_s r0,[r13,0x2c]
L_92dc58:
	b.d L_92dcbc
L_92dc5c:
	mov r1,0x2
	.global L_92dc60
L_92dc60:
	ldb r6,[gp, -0xf9]
L_92dc64:
	bmsk r6,r6,0x0
L_92dc68:
	or r6,r6,0x32000000
L_92dc70:
	mov r32,r6
L_92dc74:
	st.ab r6,[r25,0x4]
L_92dc78:
	bclr r25,r25,0xa
L_92dc7c:
	ldb r4,[gp, -0xf9]
L_92dc80:
	add r4,r4,0x1
L_92dc84:
	b.d L_92dbc4
L_92dc88:
	stb r4,[gp, -0xf9]
	.global L_92dc8c
L_92dc8c:
	b.d L_92dcbc
L_92dc90:
	mov r1,0x1
	.global L_92dc94
L_92dc94:
	ld_s r1,[r13,0x4]
L_92dc96:
	ld.as r5,[gp,0x11]
L_92dc9a:
	asl r8,0x1,r1
L_92dca2:
	tst r5,r8
L_92dca6:
	beq_s L_92dcb8
L_92dca8:
	ld.as r6,[gp,0x3]
L_92dcac:
	st r6,[r13, 0x8]
L_92dcb0:
	b.d L_92dcbc
L_92dcb4:
	mov r1,0x2
	.global L_92dcb8
L_92dcb8:
	mov r1,0x0
	.global L_92dcbc
L_92dcbc:
	st_s r1,[r13,0x20]
L_92dcbe:
	ld_s r1,[r13]
L_92dcc0:
	ld r4,[0x8019e8]
L_92dcc8:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_92dcca:
	add3_s r1,r1,r1
L_92dccc:
	ld r14,[r1,0x801198]
L_92dcd4:
	tst r4,r8
L_92dcd8:
	mov_s r15,0x801418
L_92dcde:
	beq_s L_92dd74
L_92dce0:
	ld.as r2,[gp,0x38]
L_92dce4:
	bset r2,r2,0x1e
L_92dce8:
	b.d L_92dd74
L_92dcec:
	st.as r2,[gp,0x38]
	.global L_92dcf0
L_92dcf0:
	bl L_92b7c4
L_92dcf4:
	mov_s r2,r38
L_92dcf6:
	mov_s r15,0x801418
L_92dcfc:
	bbit0 r2,0xb,L_92dd1c
L_92dd00:
	ld r6,[0x801a78]
L_92dd08:
	ld r10,[r15]
L_92dd0c:
	ld r11,[r6]
L_92dd10:
	breq r10,r11,L_92dd1c
L_92dd14:
	ld_s r0,[gp,0xe0]
L_92dd16:
	bset_s r0,r0,0x6
L_92dd18:
	st.as r0,[gp,0x38]
	.global L_92dd1c
L_92dd1c:
	brne r17,0x0,L_92dd58
L_92dd20:
	ld.as r3,[gp,0x38]
L_92dd24:
	bset r3,r3,0xa
L_92dd28:
	st.as r3,[gp,0x38]
L_92dd2c:
	mov r9,r42
L_92dd30:
	bbit0 r9,0x7,L_92dd58
L_92dd34:
	ld.as r7,[gp,-0xf]
L_92dd38:
	breq r7,0x0,L_92dd58
L_92dd3c:
	mov r8,0x1
L_92dd40:
	st.as r8,[gp,-0xe]
L_92dd44:
	mov r8,0x1f000601
L_92dd4c:
	mov r32,r8
L_92dd50:
	st.ab r8,[r25,0x4]
L_92dd54:
	bclr r25,r25,0xa
	.global L_92dd58
L_92dd58:
	mov r3,r38
L_92dd5c:
	bbit0 r3,0x1c,L_92dd74
L_92dd60:
	bl.d L_92fb20
L_92dd64:
	ld r0,[r15]
L_92dd68:
	ld.as r9,[gp,0x38]
L_92dd6c:
	bset r9,r9,0xa
L_92dd70:
	st.as r9,[gp,0x38]
	.global L_92dd74
L_92dd74:
	bmsk r9,r16,0x0
L_92dd78:
	ld r4,[r15, 0x10]
L_92dd7c:
	asl r6,r9
L_92dd80:
	bclr r4,r4,0x1
L_92dd84:
	or r6,r6,r4
L_92dd88:
	st r6,[r15, 0x10]
L_92dd8c:
	ld r5,[r13, 0xc]
L_92dd90:
	cmp r16,0x1
L_92dd94:
	bclr r5,r5,0x0
L_92dd98:
	or r5,r5,r9
L_92dd9c:
	bne.d L_92de50
L_92dda0:
	st r5,[r13, 0xc]
L_92dda4:
	mov r7,0x4d000000
L_92ddac:
	mov r32,r7
L_92ddb0:
	st.ab r7,[r25,0x4]
L_92ddb4:
	bclr r25,r25,0xa
L_92ddb8:
	nop_s
L_92ddba:
	nop_s
L_92ddbc:
	nop_s
L_92ddbe:
	stw r55,[sp]
L_92ddc2:
	mov_s r13,0x801660
L_92ddc8:
	ldb r10,[r13]
L_92ddcc:
	ldb r11,[sp]
L_92ddd0:
	add r10,r10,r11
L_92ddd4:
	add r0,r10,0xd
L_92ddd8:
	bl.d L_931c98
L_92dddc:
	add r1,sp,0x2
L_92dde0:
	ldb r1,[sp, 0x1]
L_92dde4:
	ldb_s r0,[r13,0x1]
L_92dde6:
	ldb r2,[sp, 0x3]
L_92ddea:
	add_s r0,r0,r1
L_92ddec:
	add r0,r0,r2
L_92ddf0:
	stb r0,[sp, 0x3]
L_92ddf4:
	ldw r1,[sp, 0x2]
L_92ddf8:
	mov r4,0x14000206
L_92de00:
	st r1,[0x886d10]
L_92de08:
	mov r32,r4
L_92de0c:
	st.ab r4,[r25,0x4]
L_92de10:
	bclr r25,r25,0xa
L_92de14:
	mov r6,0x37000005
L_92de1c:
	mov r32,r6
L_92de20:
	st.ab r6,[r25,0x4]
L_92de24:
	bclr r25,r25,0xa
L_92de28:
	mov r5,0x37000002
L_92de30:
	mov r32,r5
L_92de34:
	st.ab r5,[r25,0x4]
L_92de38:
	bclr r25,r25,0xa
L_92de3c:
	or r14,r14,0x3f000000
L_92de44:
	mov r32,r14
L_92de48:
	st.ab r14,[r25,0x4]
L_92de4c:
	bclr r25,r25,0xa
	.global L_92de50
L_92de50:
	add_s sp,sp,0x4
L_92de52:
	ld blink,[sp, 0x4]
L_92de56:
	ld_s r14,[sp,0x8]
L_92de58:
	ld_s r15,[sp,0xc]
L_92de5a:
	ld r16,[sp, 0x10]
L_92de5e:
	ld r17,[sp, 0x14]
L_92de62:
	j_s.d [blink]
L_92de64:
	ld.ab r13,[sp,0x18]
