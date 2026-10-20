/* rx_meas__capture_frame @ 0x927f6c, 432 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti__bi2_event_step, bti_bi2__track_best_metric, rx_flow__handle_frame, rx_flow_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf_pending__set_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_meas__capture_frame
rx_meas__capture_frame:
	.global L_927f6c
L_927f6c:
	push_s blink
L_927f6e:
	bl L_920234
L_927f72:
	mov_s r13,r0
L_927f74:
	breq_s r1,0,L_927f7a
L_927f76:
	ld_s r0,[r1]
L_927f78:
	b_s L_927fbe
	.global L_927f7a
L_927f7a:
	ld_s r0,[gp,-0x44]
L_927f7c:
	and r0,r0,0xffff0fff
L_927f84:
	bset r1,r0,0xc
L_927f88:
	bset_s r1,r1,0xe
L_927f8a:
	bset_s r1,r1,0xf
L_927f8c:
	or r0,r0,0x1d00d000
L_927f94:
	st.as r1,[gp,-0x11]
L_927f98:
	mov_s r32,r0
L_927f9a:
	st.ab r0,[r25,0x4]
L_927f9e:
	bclr r25,r25,0xa
L_927fa2:
	nop_s
L_927fa4:
	nop_s
L_927fa6:
	nop_s
L_927fa8:
	lsr r0,r40,0x9
L_927fac:
	bmsk_s r0,r0,0xa
L_927fae:
	sub r1,r0,0x800
L_927fb6:
	cmp r0,0x3ff
L_927fba:
	mov.hi r0,r1
	.global L_927fbe
L_927fbe:
	st_s r0,[r13,0x38]
L_927fc0:
	mov_s r1,0x883000
L_927fc6:
	ld_s r0,[r1,0x6c]
L_927fc8:
	mov_s r2,0x0
L_927fca:
	bmsk_s r0,r0,0x5
L_927fcc:
	st_s r0,[r13,0x48]
L_927fce:
	ld r0,[r1, 0xec]
L_927fd2:
	bset_s r2,r2,0x10
L_927fd4:
	bmsk r1,r0,0x4
L_927fd8:
	stb r1,[r13, 0x52]
L_927fdc:
	lsr_s r0,r0,0x5
L_927fde:
	bmsk_s r0,r0,0x11
L_927fe0:
	st_s r0,[r13,0x3c]
L_927fe2:
	mov_s r1,0x883780
L_927fe8:
	ld_s r0,[r1,0x58]
L_927fea:
	mov_s r3,0x7fff
L_927ff0:
	extw_s r0,r0
L_927ff2:
	sub r14,r0,r2
L_927ff6:
	cmp_s r0,r3
L_927ff8:
	mov.ls r14,r0
L_927ffc:
	st_s r14,[r13,0x44]
L_927ffe:
	ld_s r1,[r1,0x5c]
L_928000:
	add r14,r13,0x30
L_928004:
	extw_s r1,r1
L_928006:
	sub r0,r1,r2
L_92800a:
	cmp_s r1,r3
L_92800c:
	mov.ls r0,r1
L_928010:
	st_s r0,[r13,0x40]
L_928012:
	ld_s r0,[gp,-0x44]
L_928014:
	and r0,r0,0xffff0fff
L_92801c:
	bset r1,r0,0xc
L_928020:
	bset_s r1,r1,0xe
L_928022:
	or r0,r0,0x1d005000
L_92802a:
	st.as r1,[gp,-0x11]
L_92802e:
	mov_s r32,r0
L_928030:
	st.ab r0,[r25,0x4]
L_928034:
	bclr r25,r25,0xa
L_928038:
	nop_s
L_92803a:
	nop_s
L_92803c:
	nop_s
L_92803e:
	st r40,[r14]
L_928042:
	ld_s r0,[gp,-0x44]
L_928044:
	and r0,r0,0xffff0fff
L_92804c:
	bset r1,r0,0xd
L_928050:
	bset_s r1,r1,0xe
L_928052:
	or r0,r0,0x1d006000
L_92805a:
	st.as r1,[gp,-0x11]
L_92805e:
	mov_s r32,r0
L_928060:
	st.ab r0,[r25,0x4]
L_928064:
	bclr r25,r25,0xa
L_928068:
	nop_s
L_92806a:
	nop_s
L_92806c:
	nop_s
L_92806e:
	st r40,[r14, 0x4]
L_928072:
	mov_s r0,0x8006b4
L_928078:
	ldb_s r0,[r0,0x3]
L_92807a:
	norm r0,r0
L_92807e:
	rsub r1,r0,0x1e
L_928082:
	mov_s r0,0x80141c
L_928088:
	ldb_s r0,[r0,r1]
L_92808a:
	st_s r0,[r13,0x4c]
L_92808c:
	ld_s r0,[gp,-0x2c]
L_92808e:
	lsr_s r0,r0,0x8
L_928090:
	bmsk_s r0,r0,0xe
L_928092:
	stb r0,[r13, 0x50]
L_928096:
	mov_s r0,r38
L_928098:
	bbit0 r0,0xb,L_9280a4
L_92809c:
	lsr r0,r38,0x8
L_9280a0:
	bmsk_s r0,r0,0x2
L_9280a2:
	b_s L_9280a6
	.global L_9280a4
L_9280a4:
	mov_s r0,0x8
	.global L_9280a6
L_9280a6:
	stb r0,[r13, 0x51]
L_9280aa:
	ld_s r0,[gp,-0x44]
L_9280ac:
	add r14,r13,0x18
L_9280b0:
	and r0,r0,0xffff0fff
L_9280b8:
	bset r1,r0,0xc
L_9280bc:
	bset_s r1,r1,0xe
L_9280be:
	st.as r1,[gp,-0x11]
L_9280c2:
	or r0,r0,0x1d005000
L_9280ca:
	mov_s r32,r0
L_9280cc:
	st.ab r0,[r25,0x4]
L_9280d0:
	bclr r25,r25,0xa
L_9280d4:
	nop_s
L_9280d6:
	nop_s
L_9280d8:
	nop_s
L_9280da:
	st r40,[r14]
L_9280de:
	ld_s r0,[gp,-0x44]
L_9280e0:
	and r0,r0,0xffff0fff
L_9280e8:
	bset r1,r0,0xd
L_9280ec:
	bset_s r1,r1,0xe
L_9280ee:
	or r0,r0,0x1d006000
L_9280f6:
	st.as r1,[gp,-0x11]
L_9280fa:
	mov_s r32,r0
L_9280fc:
	st.ab r0,[r25,0x4]
L_928100:
	bclr r25,r25,0xa
L_928104:
	nop_s
L_928106:
	nop_s
L_928108:
	nop_s
L_92810a:
	st r40,[r14, 0x4]
L_92810e:
	mov_s r0,0x1
L_928110:
	st_s r0,[r13,0xc]
L_928112:
	bl.d L_9216f8
L_928116:
	mov_s r0,0x0
L_928118:
	b L_9202a4
