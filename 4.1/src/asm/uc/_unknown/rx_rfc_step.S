/* rx_rfc_step @ 0x92f12c, 340 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__post_rx_act1, rx_flow__post_rx_act2, rx_flow__post_rx_act3, rx_flow__post_rx_act7, rx_flow__post_rx_act8, rx_flow__post_rx_act9, rx_funcs__handle_ppdu_report
 * Зовёт сам: mac__select_sector_and_wait_b, mac__set_rf_chain_state, rfc_ctrl__switch, uc_read_tsf_lo, uc_spin_until_event
 * Глобалы (через gp): 0x800538, 0x800570, 0x800604, 0x800608
 */
	.section .text.rx_rfc_step,"ax",@progbits
	.global rx_rfc_step
rx_rfc_step:
	.global L_92f12c
L_92f12c:
	st.a r13,[sp,-0xc]
L_92f130:
	st blink,[sp, 0x4]
L_92f134:
	st_s r14,[sp,0x8]
L_92f136:
	mov_s r13,r0
L_92f138:
	ld.as r6,[gp,-0x11]
L_92f13c:
	mov r14,r1
L_92f140:
	and r6,r6,0xffff0fff
L_92f148:
	st.as r6,[gp,-0x11]
L_92f14c:
	or r6,r6,0x1d000000
L_92f154:
	mov r32,r6
L_92f158:
	st.ab r6,[r25,0x4]
L_92f15c:
	bclr r25,r25,0xa
L_92f160:
	nop_s
L_92f162:
	nop_s
L_92f164:
	mov 0x0,0x0
L_92f168:
	bmsk r7,r40,0x2
L_92f16c:
	or r7,r7,0xcac000
L_92f174:
	mov r32,r7
L_92f178:
	st.ab r7,[r25,0x4]
L_92f17c:
	bclr r25,r25,0xa
L_92f180:
	ld r8,[0x8006b4]
L_92f188:
	lr r8,[r8]
L_92f18c:
	bmsk r8,r8,0x17
L_92f190:
	mov r32,r8
L_92f194:
	st.ab r8,[r25,0x4]
L_92f198:
	bclr r25,r25,0xa
L_92f19c:
	bmsk r9,r40,0x2
L_92f1a0:
	or r9,r9,0xcac100
L_92f1a8:
	mov r32,r9
L_92f1ac:
	st.ab r9,[r25,0x4]
L_92f1b0:
	bclr r25,r25,0xa
L_92f1b4:
	ld r0,[0x8006b4]
L_92f1bc:
	lr r0,[r0]
L_92f1c0:
	bmsk_s r0,r0,0x17
L_92f1c2:
	mov_s r32,r0
L_92f1c4:
	st.ab r0,[r25,0x4]
L_92f1c8:
	bclr r25,r25,0xa
L_92f1cc:
	bl.d L_931664
L_92f1d0:
	mov r0,0x6
L_92f1d4:
	brne r14,0x5,L_92f1e4
L_92f1d8:
	mov r0,0x1
L_92f1dc:
	bl.d L_92b9d0
L_92f1e0:
	ld r1,[r13]
	.global L_92f1e4
L_92f1e4:
	ld.as r8,[gp,0x37]
L_92f1e8:
	ld r5,[0x801418]
L_92f1f0:
	and r9,r8,0x2
L_92f1f4:
	mov r1,0x0
L_92f1f8:
	or.f 0x0,r9,r1
L_92f1fc:
	beq.d L_92f210
L_92f200:
	ld.as r4,[gp,0x38]
L_92f204:
	bic r4,r4,-0x120
L_92f208:
	cmp r4,0x100
L_92f20c:
	beq L_92f254
	.global L_92f210
L_92f210:
	ld.as r10,[gp,0x12]
L_92f214:
	mov r7,0x801a18
L_92f21c:
	breq.d r10,0x0,L_92f23c
L_92f220:
	ld r6,[r7, 0x60]
L_92f224:
	asl r5,r5,0x3
L_92f228:
	add3 r5,r5,r5
L_92f22c:
	ld r3,[r5,0x801194]
L_92f234:
	st r3,[r6, 0x28]
L_92f238:
	ld r6,[r7, 0x60]
	.global L_92f23c
L_92f23c:
	mov r0,0x1
L_92f240:
	bl.d L_92b934
L_92f244:
	ld r1,[r6, 0x28]
L_92f248:
	ld_s r0,[gp,0x48]
L_92f24a:
	breq_s r0,0,L_92f254
L_92f24c:
	mov r2,0x0
L_92f250:
	st.as r2,[gp,0x12]
	.global L_92f254
L_92f254:
	mov r0,0x0
L_92f258:
	bl.d L_9317fc
L_92f25c:
	bset r0,r0,0xf
L_92f260:
	bl.d L_931664
L_92f264:
	mov r0,0x5
L_92f268:
	bl L_9315e8
L_92f26c:
	st.as r0,[gp,0x4]
L_92f270:
	ld blink,[sp, 0x4]
L_92f274:
	mov_s r0,0x1
L_92f276:
	ld_s r14,[sp,0x8]
L_92f278:
	j.d [blink]
L_92f27c:
	ld.ab r13,[sp,0xc]
