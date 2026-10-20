/* brp_responder_flow_enter @ 0x922eec, 796 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HH Enter RESPONDER FLOW rf modules for brp = 0x%8x count = %d
 * Зовут его: bf_sm__on_brp_resp
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bf__flow_exit, bf__store_flow_status, brp__init_ctx, brp__is_peer_ctrl_frame, brp__parse_request_fields, brp__program_and_measure, brp__rank_insert, brp__read_rf_id, brp__rf_module_done, brp__split_id
 * Глобалы (через gp): 0x8005b8, 0x8005f4, 0x8005f8, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp_responder_flow_enter
brp_responder_flow_enter:
	.global L_922eec
L_922eec:
	push_s blink
L_922eee:
	bl L_920220
L_922ef2:
	mov_s r18,r0
L_922ef4:
	mov_s r13,0x8006b4
L_922efa:
	ldb_s r0,[r13,0x5]
L_922efc:
	mov r16,0x1000
L_922f04:
	norm r0,r0
L_922f08:
	rsub r1,r0,0x1e
L_922f0c:
	extb_s r1,r1
L_922f0e:
	st.a r1,[sp,-0x8]
L_922f12:
	bl.d L_92828c
L_922f16:
	ldb_s r0,[r13,0x3]
L_922f18:
	bl.d L_928c68
L_922f1c:
	mov_s r19,r0
L_922f1e:
	st_s r0,[sp,0x4]
L_922f20:
	bl.d L_92b068
L_922f24:
	extb r0,r18
L_922f28:
	ldb_s r2,[r13,0x3]
L_922f2a:
	mov_s r1,0x1000998
L_922f30:
	mov_s r0,0x0
L_922f32:
	bl.d L_92d27c
L_922f36:
	mov_s r3,r19
L_922f38:
	/* mulu64 r19,0x10d18 */
	.byte 0x05,0x2b,0x93,0x2f,0x01,0x00,0x18,0x0d
L_922f40:
	mov_s r0,0x0
L_922f42:
	bl.d L_93512c
L_922f46:
	mov_s r1,mlo
L_922f48:
	ldw_s r0,[gp,0x90]
L_922f4a:
	mov_s r15,0x1
L_922f4c:
	bbit0 r0,r18,L_922f74
L_922f50:
	ldb_s r0,[gp,-0xf2]
L_922f52:
	brne r0,0x0,L_922fa2
L_922f56:
	ldb_s r0,[gp,-0xf9]
L_922f58:
	bmsk_s r0,r0,0x0
L_922f5a:
	bset_s r0,r0,0x19
L_922f5c:
	bset_s r0,r0,0x1c
L_922f5e:
	bset_s r0,r0,0x1d
L_922f60:
	mov_s r32,r0
L_922f62:
	st.ab r0,[r25,0x4]
L_922f66:
	bclr r25,r25,0xa
L_922f6a:
	ldb_s r0,[gp,-0xf9]
L_922f6c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922f6e:
	stb r0,[gp, -0xf9]
L_922f72:
	b_s L_922fa2
	.global L_922f74
L_922f74:
	mov_s r0,0x2011000
L_922f7a:
	mov_s r32,r0
L_922f7c:
	st.ab r0,[r25,0x4]
L_922f80:
	bclr r25,r25,0xa
L_922f84:
	mov_s r0,0x14000100
L_922f8a:
	mov_s r32,r0
L_922f8c:
	st.ab r0,[r25,0x4]
L_922f90:
	bclr r25,r25,0xa
L_922f94:
	mov_s r0,0x14
L_922f96:
	asl_s r0,r0,0x18
L_922f98:
	mov_s r32,r0
L_922f9a:
	st.ab r0,[r25,0x4]
L_922f9e:
	bclr r25,r25,0xa
	.global L_922fa2
L_922fa2:
	mov_s r0,0x80
L_922fa4:
	bset_s r0,r0,0x19
L_922fa6:
	mov_s r32,r0
L_922fa8:
	st.ab r0,[r25,0x4]
L_922fac:
	bclr r25,r25,0xa
	.global L_922fb0
L_922fb0:
	mov_s r2,0x0
L_922fb2:
	mov_s r0,0x800824
L_922fb8:
	st_s r2,[r0,0x64]
L_922fba:
	mov_s r0,r16
L_922fbc:
	bl.d L_9367e4
L_922fc0:
	mov_s r1,0x40
L_922fc2:
	mov_s r0,r42
L_922fc4:
	bbit0 r0,0xc,L_923022
L_922fc8:
	bl L_923280
L_922fcc:
	breq_s r15,0,L_922fe4
L_922fce:
	mov_s r13,0x80
L_922fd0:
	bset_s r13,r13,0xc
L_922fd2:
	mov_s r0,0x80
L_922fd4:
	bset_s r0,r0,0x19
L_922fd6:
	mov_s r32,r0
L_922fd8:
	st.ab r0,[r25,0x4]
L_922fdc:
	bclr r25,r25,0xa
L_922fe0:
	mov_s r15,0x0
L_922fe2:
	mov_s r16,r13
	.global L_922fe4
L_922fe4:
	mov_s r0,r36
L_922fe6:
	btst_s r0,0x19
L_922fe8:
	mov_s r13,0x800824
L_922fee:
	beq_s L_9230e2
L_922ff0:
	bl L_92bdbc
L_922ff4:
	cmp_s r0,0x0
L_922ff6:
	beq_s L_9230e2
L_922ff8:
	bl.d L_92e1e4
L_922ffc:
	mov_s r0,r18
L_922ffe:
	st_s r0,[r13,0x64]
L_923000:
	mov_s r14,0x0
L_923002:
	bbit0 r0,0x0,L_92308e
L_923006:
	ld_s r0,[r13,0x60]
L_923008:
	bbit0 r0,0x0,L_923030
L_92300c:
	ldb r0,[r13, 0x58]
L_923010:
	mov_s r1,r14
L_923012:
	bl.d L_923678
L_923016:
	ld_s r2,[sp,0x0]
L_923018:
	breq_s r0,0,L_92302c
L_92301a:
	bl.d L_923208
L_92301e:
	ld_s r0,[sp,0x0]
L_923020:
	b_s L_92308e
	.global L_923022
L_923022:
	mov r16,0x800824
L_92302a:
	b_s L_923100
	.global L_92302c
L_92302c:
	st_s r14,[r13,0x64]
L_92302e:
	b_s L_92308e
	.global L_923030
L_923030:
	ld_s r0,[gp,-0x44]
L_923032:
	and r0,r0,0xffff0fff
L_92303a:
	bset r1,r0,0xd
L_92303e:
	bset_s r1,r1,0xf
L_923040:
	or r0,r0,0x1d00a000
L_923048:
	st.as r1,[gp,-0x11]
L_92304c:
	mov_s r32,r0
L_92304e:
	st.ab r0,[r25,0x4]
L_923052:
	bclr r25,r25,0xa
L_923056:
	nop_s
L_923058:
	nop_s
L_92305a:
	nop_s
L_92305c:
	ld_s r0,[gp,-0x48]
L_92305e:
	or r0,r0,0x27007300
L_923066:
	mov_s r32,r0
L_923068:
	st.ab r0,[r25,0x4]
L_92306c:
	bclr r25,r25,0xa
L_923070:
	mov_s r0,0x2004000
L_923076:
	mov_s r32,r0
L_923078:
	st.ab r0,[r25,0x4]
L_92307c:
	bclr r25,r25,0xa
L_923080:
	nop_s
L_923082:
	nop_s
L_923084:
	nop_s
L_923086:
	mov_s r0,0x0
L_923088:
	bl.d L_9366dc
L_92308c:
	bset_s r0,r0,0xe
	.global L_92308e
L_92308e:
	bl L_923314
L_923092:
	bl.d L_929f94
L_923096:
	mov_s r0,0x0
L_923098:
	ld_s r2,[r13,0x5c]
L_92309a:
	mov_s r0,0x8006b4
L_9230a0:
	ldb_s r0,[r0,0x5]
L_9230a2:
	breq_s r2,0,L_9230ce
L_9230a4:
	and.f r1,r2,r0
L_9230a8:
	bne_s L_9230b8
L_9230aa:
	norm r14,r2
L_9230ae:
	rsub r3,r14,0x1e
L_9230b2:
	bset r0,r0,r3
L_9230b6:
	extb_s r0,r0
	.global L_9230b8
L_9230b8:
	breq_s r1,0,L_9230c8
L_9230ba:
	norm r1,r1
L_9230be:
	rsub r2,r1,0x1e
L_9230c2:
	extb_s r2,r2
L_9230c4:
	st_s r2,[sp,0x0]
L_9230c6:
	b_s L_9230da
	.global L_9230c8
L_9230c8:
	norm r2,r2
L_9230cc:
	b_s L_9230d2
	.global L_9230ce
L_9230ce:
	norm r2,r0
	.global L_9230d2
L_9230d2:
	rsub r1,r2,0x1e
L_9230d6:
	extb_s r1,r1
L_9230d8:
	st_s r1,[sp,0x0]
	.global L_9230da
L_9230da:
	bl.d L_928b8c
L_9230de:
	mov_s r1,0x0
L_9230e0:
	b_s L_9230e8
	.global L_9230e2
L_9230e2:
	bl L_9232d4
L_9230e6:
	brne_s r0,0,L_9230fe
	.global L_9230e8
L_9230e8:
	ld_s r0,[r13,0x60]
L_9230ea:
	ldb_s r2,[r13,0x4]
L_9230ec:
	lsr_s r0,r0
L_9230ee:
	extb_s r0,r0
L_9230f0:
	cmp_s r0,r2
L_9230f2:
	mov_s r1,0x800824
L_9230f8:
	bne_s L_922fb0
L_9230fa:
	mov_s r16,r1
L_9230fc:
	b_s L_923100
	.global L_9230fe
L_9230fe:
	mov_s r16,r13
	.global L_923100
L_923100:
	ld r0,[r16, 0x60]
L_923104:
	ldb r1,[r16, 0x4]
L_923108:
	lsr_s r0,r0
L_92310a:
	extb_s r0,r0
L_92310c:
	brne r0,r1,L_923178
L_923110:
	mov_s r0,0x8006b4
L_923116:
	ldb_s r0,[r0,0x3]
L_923118:
	b_s L_92312a
	.global L_92311a
L_92311a:
	mov_s r0,r14
L_92311c:
	bl.d L_925050
L_923120:
	ldb r1,[r16, 0x58]
L_923124:
	bclr r0,r17,r14
L_923128:
	extb_s r0,r0
	.global L_92312a
L_92312a:
	mov.f r17,r0
L_92312e:
	beq_s L_92315c
L_923130:
	norm r0,r0
L_923134:
	rsub r14,r0,0x1e
L_923138:
	extb_s r14,r14
L_92313a:
	mov_s r13,0x0
L_92313c:
	mov_s r15,0x20
	.global L_92313e
L_92313e:
	asl_s r0,r14,0x5
L_923140:
	add_s r0,r0,r13
L_923142:
	mov_s r1,0x801ef4
L_923148:
	ldb_s r1,[r1,r0]
L_92314a:
	extb_s r2,r13
L_92314c:
	bl.d L_92e904
L_923150:
	mov_s r0,r14
L_923152:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_923154:
	/* brhs.d r15,0x1,0x0092313e */
	.byte 0xeb,0x0f,0x75,0x90
L_923158:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_92315a:
	b_s L_92311a
	.global L_92315c
L_92315c:
	bl.d L_92e0a8
L_923160:
	extb r0,r18
L_923164:
	bl.d L_925998
L_923168:
	mov_s r0,0x0
L_92316a:
	mov_s r0,0x52
L_92316c:
	asl_s r0,r0,0x18
L_92316e:
	mov_s r32,r0
L_923170:
	st.ab r0,[r25,0x4]
L_923174:
	bclr r25,r25,0xa
	.global L_923178
L_923178:
	ld r0,[r16, 0x60]
L_92317c:
	ldb r1,[r16, 0x4]
L_923180:
	lsr_s r0,r0
L_923182:
	extb_s r0,r0
L_923184:
	cmp_s r0,r1
L_923186:
	mov_s r1,0x1
L_923188:
	sub_s.ne r1,r1,r1
L_92318a:
	bl.d L_923970
L_92318e:
	mov_s r0,r18
L_923190:
	ld r1,[r16, 0x60]
L_923194:
	ldb r2,[r16, 0x4]
L_923198:
	lsr_s r1,r1
L_92319a:
	extb_s r1,r1
L_92319c:
	ldb r0,[r16, 0x58]
L_9231a0:
	cmp_s r1,r2
L_9231a2:
	mov_s r1,0x33
L_9231a4:
	mov.ne r1,0x34
L_9231a8:
	bl L_9357cc
L_9231ac:
	mov_s r0,0x0
L_9231ae:
	st.as r0,[gp,0x33]
L_9231b2:
	bl.d L_925998
L_9231b6:
	st.as r0,[gp,0x34]
L_9231ba:
	mov_s r0,0x52
L_9231bc:
	asl_s r0,r0,0x18
L_9231be:
	mov_s r32,r0
L_9231c0:
	st.ab r0,[r25,0x4]
L_9231c4:
	bclr r25,r25,0xa
L_9231c8:
	bl.d L_921c50
L_9231cc:
	ldb r0,[r16, 0x58]
L_9231d0:
	brlt r19,0x2,L_9231ec
L_9231d4:
	mov_s r0,0x8006b4
L_9231da:
	bl.d L_92ed5c
L_9231de:
	ldb_s r0,[r0,0x5]
L_9231e0:
	mov_s r0,0x889480
L_9231e6:
	ld_s r0,[r0,0x8]
L_9231e8:
	st.as r0,[gp,0x5e]
	.global L_9231ec
L_9231ec:
	ld_s r0,[sp,0x4]
L_9231ee:
	bl.d L_928b8c
L_9231f2:
	mov_s r1,0x0
L_9231f4:
	mov_s r0,0x801024
L_9231fa:
	bl.d L_934dc8
L_9231fe:
	ld_s r0,[r0]
L_923200:
	b.d L_92027c
L_923204:
	add_s sp,sp,0x8
L_923206:
	nop_s
