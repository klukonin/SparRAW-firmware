/* tx_mtp_queue_gate @ 0x93413c, 496 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_flow_size_step, tx_initiator_substep
 * Зовёт сам: __ld_r13_ret_uc, mac__program_tx_rate, mac__set_rf_chain_state, mac_counter__program_0008, mtp_queue__release_mgmt, tail_uc_wait_two_events, tx_mtp__open_window, txop__open_window, uc_spin_until_event
 * Глобалы (через gp): 0x800534, 0x80056c, 0x800570, 0x800604, 0x800608, 0x800610, 0x800614
 */
	.section .text.tx_mtp_queue_gate,"ax",@progbits
	.global tx_mtp_queue_gate
tx_mtp_queue_gate:
	.global L_93413c
L_93413c:
	push_s blink
L_93413e:
	push_s r13
L_934140:
	mov_s r0,0x801a18
L_934146:
	ld_s r13,[r0,0x60]
L_934148:
	sub_s sp,sp,0xc
L_93414a:
	ld_s r3,[r13,0x4]
L_93414c:
	ld_s r0,[gp,0x44]
L_93414e:
	mov_s r2,0x1
L_934150:
	btst r0,r3
L_934154:
	mov_s r1,0x0
L_934156:
	mov.eq r2,r1
L_93415a:
	beq_s L_934160
L_93415c:
	ld_s r0,[gp,0xc]
L_93415e:
	st_s r0,[r13,0x8]
	.global L_934160
L_934160:
	ld_s r0,[gp,0xe0]
L_934162:
	mov_s r1,sp
L_934164:
	and r0,r0,0x40000000
L_93416c:
	sub.f r3,r0,0x0
L_934170:
	mov.ne r3,0x1
L_934174:
	bl.d L_937b84
L_934178:
	mov_s r0,r13
L_93417a:
	breq_s r0,0,L_9341b6
L_93417c:
	ld_s r1,[r13]
L_93417e:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_934180:
	add1_s r1,r1,r1
L_934182:
	add_s r1,r1,0x8016d8
L_934188:
	ld_s r2,[r1]
L_93418a:
	mov_s r0,0x0
L_93418c:
	breq r2,0x2,L_9341a8
L_934190:
	ld_s r1,[r1,0x4]
L_934192:
	cmp_s r1,0x3
L_934194:
	cmp.ne r1,0x4
L_934198:
	cmp.ne r1,0x5
L_93419c:
	bne_s L_9341a0
L_93419e:
	mov_s r0,0x1
	.global L_9341a0
L_9341a0:
	extb.f 0x0,r0
L_9341a4:
	mov_s r0,0x0
L_9341a6:
	beq_s L_9341aa
	.global L_9341a8
L_9341a8:
	mov_s r0,0x1
	.global L_9341aa
L_9341aa:
	extb.f 0x0,r0
L_9341ae:
	bne_s L_9341b6
L_9341b0:
	mov_s r0,r42
L_9341b2:
	bbit0 r0,0x7,L_9341c0
	.global L_9341b6
L_9341b6:
	mov_s r0,r13
L_9341b8:
	bl.d L_9247c0
L_9341bc:
	ld_s r1,[sp,0x0]
L_9341be:
	b_s L_934326
	.global L_9341c0
L_9341c0:
	ld_s r0,[gp,0xe8]
L_9341c2:
	ld.as r1,[gp,0x3b]
L_9341c6:
	bic r0,r0,-0x3
L_9341ca:
	cmp_s r0,0x2
L_9341cc:
	mov_s r0,0x1
L_9341ce:
	sub_s.ne r0,r0,r0
L_9341d0:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_9341d2:
	or r0,r0,0x19000b00
L_9341da:
	asl_s r1,r1,0xe
L_9341dc:
	or_s r0,r0,r1
L_9341de:
	mov_s r32,r0
L_9341e0:
	st.ab r0,[r25,0x4]
L_9341e4:
	bclr r25,r25,0xa
L_9341e8:
	mov_s r1,sp
L_9341ea:
	bl.d L_93409c
L_9341ee:
	mov_s r0,r13
L_9341f0:
	brne_s r0,0,L_934208
L_9341f2:
	mov_s r1,0x801458
L_9341f8:
	ld_s r0,[r1,0x4]
L_9341fa:
	st.as 0x800,[gp,0x38]
L_934202:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_934204:
	st_s r0,[r1,0x4]
L_934206:
	b_s L_934326
	.global L_934208
L_934208:
	ld_s r0,[gp,-0x48]
L_93420a:
	or r0,r0,0x27004000
L_934212:
	mov_s r32,r0
L_934214:
	st.ab r0,[r25,0x4]
L_934218:
	bclr r25,r25,0xa
L_93421c:
	mov_s r0,0x2004000
L_934222:
	mov_s r32,r0
L_934224:
	st.ab r0,[r25,0x4]
L_934228:
	bclr r25,r25,0xa
L_93422c:
	ld_s r0,[gp,0xe0]
L_93422e:
	and.f 0x0,r0,0x20004
L_934236:
	bne_s L_9342b6
L_934238:
	mov_s r1,0x801a18
L_93423e:
	ld_s r0,[r1,0x60]
L_934240:
	mov_s r2,0x801131
L_934246:
	ld_s r0,[r0,0x4]
L_934248:
	add1_s r0,r0,r0
L_93424a:
	ldb_s r0,[r2,r0]
L_93424c:
	breq_s r0,0,L_934268
L_93424e:
	lsr r0,r45,0x5
L_934252:
	bxor r0,r0,0x0
L_934256:
	ld_s r2,[r1,0x60]
L_934258:
	bbit1 r0,0x0,L_934268
L_93425c:
	ld_s r0,[r2,0xc]
L_93425e:
	bset_s r0,r0,0x1
L_934260:
	st_s r0,[r2,0xc]
L_934262:
	ld_s r0,[r1,0x60]
L_934264:
	mov_s r2,0x0
L_934266:
	st_s r2,[r0,0x1c]
	.global L_934268
L_934268:
	ld_s r0,[r1,0x60]
L_93426a:
	ld_s r0,[r0,0xc]
L_93426c:
	bbit1 r0,0x8,L_9342b6
L_934270:
	lsr r0,r43,0xe
L_934274:
	bmsk.f r0,r0,0x1
L_934278:
	beq_s L_934290
L_93427a:
	brne r0,0x1,L_9342b6
L_93427e:
	mov_s r0,0x801a18
L_934284:
	ld_s r1,[r0,0x60]
L_934286:
	ld_s r0,[r1,0xc]
L_934288:
	or r0,r0,0xe
L_93428c:
	st_s r0,[r1,0xc]
L_93428e:
	b_s L_9342b6
	.global L_934290
L_934290:
	mov_s r1,r43
L_934292:
	ld_s r0,[gp,0xe0]
L_934294:
	btst_s r1,0x1b
L_934296:
	bset.ne r0,r0,0x1
L_93429a:
	bset.eq r0,r0,0x0
L_93429e:
	st.as r0,[gp,0x38]
L_9342a2:
	bbit1 r0,0x12,L_9342b6
L_9342a6:
	mov_s r0,0x801a18
L_9342ac:
	ld_s r1,[r0,0x60]
L_9342ae:
	mov_s r0,0x1
L_9342b0:
	bl.d L_9372dc
L_9342b4:
	ld_s r1,[r1,0x4]
	.global L_9342b6
L_9342b6:
	mov_s r0,0x0
L_9342b8:
	bl.d L_9317fc
L_9342bc:
	bset_s r0,r0,0xe
L_9342be:
	ld_s r0,[gp,0xdc]
L_9342c0:
	ld_s r2,[r13]
L_9342c2:
	and r3,r0,0x2
L_9342c6:
	mov_s r0,0x0
L_9342c8:
	or.f 0x0,r3,r0
L_9342cc:
	ld.as r1,[gp,0x38]
L_9342d0:
	beq_s L_9342dc
L_9342d2:
	bic r1,r1,-0x120
L_9342d6:
	cmp r1,0x100
L_9342da:
	beq_s L_93430a
	.global L_9342dc
L_9342dc:
	ld_s r0,[gp,0x48]
L_9342de:
	mov_s r1,0x801a18
L_9342e4:
	ld_s r3,[r1,0x60]
L_9342e6:
	breq_s r0,0,L_9342f6
L_9342e8:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_9342ea:
	mov_s r0,0x801194
L_9342f0:
	add3_s r2,r2,r2
L_9342f2:
	ld_s r0,[r0,r2]
L_9342f4:
	st_s r0,[r3,0x28]
	.global L_9342f6
L_9342f6:
	ld_s r1,[r1,0x60]
L_9342f8:
	mov_s r0,0x1
L_9342fa:
	bl.d L_92b934
L_9342fe:
	ld_s r1,[r1,0x28]
L_934300:
	ld_s r0,[gp,0x48]
L_934302:
	breq_s r0,0,L_93430a
L_934304:
	mov_s r0,0x0
L_934306:
	st.as r0,[gp,0x12]
	.global L_93430a
L_93430a:
	mov_s r0,0x0
L_93430c:
	bl.d L_9317fc
L_934310:
	bset_s r0,r0,0xf
L_934312:
	ld_s r0,[r13,0xc]
L_934314:
	btst_s r0,0x3
L_934316:
	mov.ne r0,r13
L_93431a:
	bl.ne.d L_933f90
L_93431e:
	sub_s.ne r1,r1,r1
L_934320:
	bl.d L_9316a8
L_934324:
	mov_s r0,0x6
	.global L_934326
L_934326:
	b.d L_92028c
L_93432a:
	add_s sp,sp,0xc
