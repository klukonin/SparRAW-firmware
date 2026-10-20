/* mac_mode_program_a @ 0x922f60, 840 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode_brp_step, mac_mode_step_b
 * Зовёт сам: __ld_r18_to_r13_ret_uc, __st_r18_to_r13_uc, bf_b_s0_w5_uc, bf_s11_w5_uc, direct_tx__program_cmd34, hw_modes_mac__switch_core, mac__program_rf_mode, mac__program_tx_common, mac__select_sector_and_wait_b, mac__set_rf_chain_state, mac_mode__send_direct_frame, set_reg_884060
 * Глобалы (через gp): 0x800604, 0x800610, 0x800614
 */
	.section .text.mac_mode_program_a,"ax",@progbits
	.global mac_mode_program_a
mac_mode_program_a:
	.global L_922f60
L_922f60:
	push_s blink
L_922f62:
	bl L_920204
L_922f66:
	sub_s sp,sp,0xc
L_922f68:
	mov_s r13,0x800734
L_922f6e:
	bl.d L_927944
L_922f72:
	ldb r16,[r13, 0xc]
L_922f76:
	mov_s r14,0x38000300
L_922f7c:
	ld_s r1,[r13,0x10]
L_922f7e:
	mov r17,0x3f000000
L_922f86:
	mov_s r13,0x3e
L_922f88:
	asl_s r13,r13,0x18
L_922f8a:
	mov_s r15,0x37000020
L_922f90:
	asl r0,r16,0x3
L_922f94:
	add3_s r0,r0,r0
L_922f96:
	add_s r0,r0,0x801190
L_922f9c:
	mov r18,0x801458
L_922fa4:
	st_s r0,[sp,0x0]
L_922fa6:
	bbit0 r1,0x9,L_923022
L_922faa:
	mov_s r0,0x2
L_922fac:
	bset_s r0,r0,0x19
L_922fae:
	mov_s r32,r0
L_922fb0:
	st.ab r0,[r25,0x4]
L_922fb4:
	bclr r25,r25,0xa
L_922fb8:
	bl.d L_9317fc
L_922fbc:
	mov_s r0,0x2
L_922fbe:
	mov_s r0,0x14000100
L_922fc4:
	mov_s r32,r0
L_922fc6:
	st.ab r0,[r25,0x4]
L_922fca:
	bclr r25,r25,0xa
L_922fce:
	ld_s r0,[sp,0x0]
L_922fd0:
	ld_s r0,[r0,0x8]
L_922fd2:
	st_s r0,[sp,0x4]
L_922fd4:
	mov_s r32,r14
L_922fd6:
	st.ab r14,[r25,0x4]
L_922fda:
	bclr r25,r25,0xa
L_922fde:
	mov_s r0,0x3600003f
L_922fe4:
	mov_s r32,r0
L_922fe6:
	st.ab r0,[r25,0x4]
L_922fea:
	bclr r25,r25,0xa
L_922fee:
	mov_s r0,0x6000105
L_922ff4:
	mov_s r32,r0
L_922ff6:
	st.ab r0,[r25,0x4]
L_922ffa:
	bclr r25,r25,0xa
L_922ffe:
	mov_s r0,0x37000005
L_923004:
	mov_s r32,r0
L_923006:
	st.ab r0,[r25,0x4]
L_92300a:
	bclr r25,r25,0xa
L_92300e:
	mov_s r0,0x37000002
L_923014:
	mov_s r32,r0
L_923016:
	st.ab r0,[r25,0x4]
L_92301a:
	bclr r25,r25,0xa
L_92301e:
	ld_s r0,[sp,0x4]
L_923020:
	b_s L_92308a
	.global L_923022
L_923022:
	bl.d L_9296c8
L_923026:
	mov_s r0,0x0
L_923028:
	mov_s r0,0x1f006000
L_92302e:
	mov_s r32,r0
L_923030:
	st.ab r0,[r25,0x4]
L_923034:
	bclr r25,r25,0xa
L_923038:
	ld_s r0,[sp,0x0]
L_92303a:
	ld_s r0,[r0,0x8]
L_92303c:
	st_s r0,[sp,0x8]
L_92303e:
	mov_s r32,r14
L_923040:
	st.ab r14,[r25,0x4]
L_923044:
	bclr r25,r25,0xa
L_923048:
	mov_s r0,0x3600003f
L_92304e:
	mov_s r32,r0
L_923050:
	st.ab r0,[r25,0x4]
L_923054:
	bclr r25,r25,0xa
L_923058:
	mov_s r0,0x6000101
L_92305e:
	mov_s r32,r0
L_923060:
	st.ab r0,[r25,0x4]
L_923064:
	bclr r25,r25,0xa
L_923068:
	mov_s r0,0x37000005
L_92306e:
	mov_s r32,r0
L_923070:
	st.ab r0,[r25,0x4]
L_923074:
	bclr r25,r25,0xa
L_923078:
	mov_s r0,0x37000002
L_92307e:
	mov_s r32,r0
L_923080:
	st.ab r0,[r25,0x4]
L_923084:
	bclr r25,r25,0xa
L_923088:
	ld_s r0,[sp,0x8]
	.global L_92308a
L_92308a:
	or r0,r0,r17
L_92308e:
	mov_s r32,r0
L_923090:
	st.ab r0,[r25,0x4]
L_923094:
	bclr r25,r25,0xa
L_923098:
	mov_s r32,r13
L_92309a:
	st.ab r13,[r25,0x4]
L_92309e:
	bclr r25,r25,0xa
L_9230a2:
	mov_s r32,r15
L_9230a4:
	st.ab r15,[r25,0x4]
L_9230a8:
	bclr r25,r25,0xa
L_9230ac:
	ld r1,[r18, 0xc]
L_9230b0:
	asl r0,r16,0x3
L_9230b4:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_9230b6:
	st r1,[r18, 0xc]
L_9230ba:
	add3_s r0,r0,r0
L_9230bc:
	mov_s r1,0x801198
L_9230c2:
	ld_s r0,[r1,r0]
L_9230c4:
	or r0,r0,0x3f000000
L_9230cc:
	mov_s r32,r0
L_9230ce:
	st.ab r0,[r25,0x4]
L_9230d2:
	bclr r25,r25,0xa
L_9230d6:
	mov_s r0,0x0
L_9230d8:
	mov_s r2,0x800764
L_9230de:
	mov_s r1,r0
L_9230e0:
	stb_s r1,[r2,0x1b]
L_9230e2:
	lsr_s r1,r1,0x8
L_9230e4:
	stb_s r1,[r2,0x1c]
L_9230e6:
	lsr_s r1,r1,0x8
L_9230e8:
	stb_s r1,[r2,0x1d]
L_9230ea:
	lsr_s r1,r1,0x8
L_9230ec:
	stb_s r1,[r2,0x1e]
L_9230ee:
	st_s r0,[r2,0x20]
L_9230f0:
	stw_s r0,[r2,0x24]
L_9230f2:
	mov_s r0,0x886544
L_9230f8:
	ld_s r0,[r0]
L_9230fa:
	mov_s r3,0x886500
L_923100:
	bmsk_s r0,r0,0xb
L_923102:
	add_s r1,r0,0x1
L_923104:
	asl_s r1,r1,0x10
L_923106:
	and r1,r1,0xfff0000
L_92310e:
	bset_s r1,r1,0x1c
L_923110:
	st_s r1,[r3,0x44]
L_923112:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_923114:
	stw_s r0,[r2,0x16]
L_923116:
	asl r0,r16,0x3
L_92311a:
	add3_s r0,r0,r0
L_92311c:
	add_s r0,r0,0x801190
L_923122:
	ldw_s r1,[r0,0x2c]
L_923124:
	stw_s r1,[r2,0x4]
L_923126:
	ldw_s r1,[r0,0x2e]
L_923128:
	stw_s r1,[r2,0x6]
L_92312a:
	ldw_s r1,[r0,0x30]
L_92312c:
	stw_s r1,[r2,0x8]
L_92312e:
	ld_s r1,[r2,0x20]
L_923130:
	bset_s r1,r1,0x8
L_923132:
	st_s r1,[r2,0x20]
L_923134:
	mov_s r1,0x5
L_923136:
	stb r1,[r2, 0x20]
L_92313a:
	ld_s r1,[r0,0x8]
L_92313c:
	add r0,r2,0x1b
L_923140:
	lsr_s r1,r1,0x8
L_923142:
	bmsk_s r1,r1,0x5
L_923144:
	bl L_93794c
L_923148:
	mov_s r0,0x800734
L_92314e:
	ld_s r0,[r0,0x10]
L_923150:
	bbit0 r0,0x2,L_923176
L_923154:
	ld_s r0,[r2,0x24]
L_923156:
	mov_s r1,0x10
L_923158:
	bset_s r0,r0,0xa
L_92315a:
	st_s r0,[r2,0x24]
L_92315c:
	add r0,r2,0x1b
L_923160:
	bl L_937958
L_923164:
	mov_s r0,0x20000400
L_92316a:
	mov_s r32,r0
L_92316c:
	st.ab r0,[r25,0x4]
L_923170:
	bclr r25,r25,0xa
L_923174:
	b_s L_9231c4
	.global L_923176
L_923176:
	bbit0 r0,0x0,L_923194
L_92317a:
	add r0,r2,0x1b
L_92317e:
	mov_s r1,0x10
L_923180:
	bl L_937958
L_923184:
	mov_s r0,0x20000400
L_92318a:
	mov_s r32,r0
L_92318c:
	st.ab r0,[r25,0x4]
L_923190:
	bclr r25,r25,0xa
	.global L_923194
L_923194:
	mov_s r0,0x800734
L_92319a:
	ld_s r0,[r0,0x14]
L_92319c:
	bbit0 r0,0x2,L_9231c4
L_9231a0:
	lsr_s r0,r0,0x4
L_9231a2:
	bmsk_s r0,r0,0x4
L_9231a4:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9231a6:
	bic r0,r0,-0x1f1
L_9231aa:
	bset_s r0,r0,0xa
L_9231ac:
	bset_s r0,r0,0x1d
L_9231ae:
	mov_s r32,r0
L_9231b0:
	st.ab r0,[r25,0x4]
L_9231b4:
	bclr r25,r25,0xa
L_9231b8:
	mov_s r1,0x800764
L_9231be:
	ld_s r0,[r1,0x20]
L_9231c0:
	bset_s r0,r0,0xa
L_9231c2:
	st_s r0,[r1,0x20]
	.global L_9231c4
L_9231c4:
	mov_s r0,0x18
L_9231c6:
	bl.d L_924ea8
L_9231ca:
	mov_s r1,0x26
L_9231cc:
	bl L_92a3c0
L_9231d0:
	mov_s r0,0x2008000
L_9231d6:
	mov_s r32,r0
L_9231d8:
	st.ab r0,[r25,0x4]
L_9231dc:
	bclr r25,r25,0xa
L_9231e0:
	ld_s r0,[gp,0xdc]
L_9231e2:
	and r1,r0,0x10
L_9231e6:
	mov_s r0,0x0
L_9231e8:
	or.f 0x0,r1,r0
L_9231ec:
	beq_s L_92320e
L_9231ee:
	ld_s r0,[gp,0xe8]
L_9231f0:
	ld.as r1,[gp,0x3b]
L_9231f4:
	bic r0,r0,-0x3
L_9231f8:
	cmp_s r0,0x2
L_9231fa:
	mov_s r0,0x1
L_9231fc:
	sub_s.ne r0,r0,r0
L_9231fe:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_923200:
	or r0,r0,0x19800830
L_923208:
	asl_s r1,r1,0xe
L_92320a:
	or_s r0,r0,r1
L_92320c:
	b_s L_923214
	.global L_92320e
L_92320e:
	mov_s r0,0x19000001
	.global L_923214
L_923214:
	mov_s r32,r0
L_923216:
	st.ab r0,[r25,0x4]
L_92321a:
	bclr r25,r25,0xa
	.global L_92321e
L_92321e:
	mov_s r0,r45
L_923220:
	bbit0 r0,0x1f,L_92321e
L_923224:
	ld_s r0,[gp,0xdc]
L_923226:
	and r1,r0,0x10
L_92322a:
	mov_s r0,0x0
L_92322c:
	or.f 0x0,r1,r0
L_923230:
	mov_s r0,0x18
L_923232:
	asl.ne r0,r0,0x18
L_923236:
	mov.eq r0,0x18001000
L_92323e:
	mov_s r32,r0
L_923240:
	st.ab r0,[r25,0x4]
L_923244:
	bclr r25,r25,0xa
L_923248:
	bl L_92b444
L_92324c:
	bl.d L_931664
L_923250:
	mov_s r0,0x6
L_923252:
	mov_s r1,0x80087c
L_923258:
	mov_s r0,0x1
L_92325a:
	bl.d L_92b934
L_92325e:
	ld_s r1,[r1]
L_923260:
	mov_s r0,0x0
L_923262:
	bl.d L_9317fc
L_923266:
	bset_s r0,r0,0xf
L_923268:
	bl.d L_9316a8
L_92326c:
	mov_s r0,0x6
L_92326e:
	bl.d L_9274f0
L_923272:
	mov_s r0,0x0
L_923274:
	mov_s r0,0x0
L_923276:
	bset_s r0,r0,0x1d
L_923278:
	mov_s r32,r0
L_92327a:
	st.ab r0,[r25,0x4]
L_92327e:
	bclr r25,r25,0xa
L_923282:
	mov_s r1,0x800734
L_923288:
	ld_s r0,[r1,0x10]
L_92328a:
	bbit0 r0,0x9,L_9232a0
L_92328e:
	bclr_s r0,r0,0x9
L_923290:
	st_s r0,[r1,0x10]
L_923292:
	mov_s r0,0x80
L_923294:
	bset_s r0,r0,0x19
L_923296:
	mov_s r32,r0
L_923298:
	st.ab r0,[r25,0x4]
L_92329c:
	bclr r25,r25,0xa
	.global L_9232a0
L_9232a0:
	b.d L_920264
L_9232a4:
	add_s sp,sp,0xc
L_9232a6:
	nop_s
