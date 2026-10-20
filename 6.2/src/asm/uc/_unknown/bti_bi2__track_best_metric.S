/* bti_bi2__track_best_metric @ 0x93dc80, 716 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_transmitter_bi2_flow
 * Зовёт сам: bf_pending__set_bit, bti__arm_period_gp0, bti__request_bf_metric, bti_worker_bi2_step, rx_capture__match_filter, rx_meas__append_sample, rx_meas__capture_frame, rx_meas__finish_with_8830ec, uc_sysassert, uc_wait_event1_or_event4
 * Глобалы (через gp): 0x800598
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti_bi2__track_best_metric
bti_bi2__track_best_metric:
	.global L_93dc80
L_93dc80:
	st.a r13,[sp,-0x18]
L_93dc84:
	st blink,[sp, 0x4]
L_93dc88:
	st_s r14,[sp,0x8]
L_93dc8a:
	st_s r15,[sp,0xc]
L_93dc8c:
	st r16,[sp, 0x10]
L_93dc90:
	st r17,[sp, 0x14]
L_93dc94:
	sub_s sp,sp,0x8
L_93dc96:
	mov_s r17,r0
L_93dc98:
	mov r16,0x140
L_93dc9c:
	mov_s r2,0x2011000
L_93dca2:
	mov_s r32,r2
L_93dca4:
	st.ab r2,[r25,0x4]
L_93dca8:
	bclr r25,r25,0xa
L_93dcac:
	b L_93dcbc
	.global L_93dcb0
L_93dcb0:
	st r11,[r5, 0x18]
L_93dcb4:
	mov r11,0x1
L_93dcb8:
	stb r11,[r5, 0x14]
	.global L_93dcbc
L_93dcbc:
	mov_s r0,0x0
L_93dcbe:
	bset_s r0,r0,0xc
L_93dcc0:
	mov r1,r16
L_93dcc4:
	bl.d L_9367e4
L_93dcc8:
	mov r2,0x0
L_93dccc:
	mov_s r3,r42
L_93dcce:
	btst_s r3,0xc
L_93dcd0:
	beq L_93dec4
L_93dcd4:
	ld r0,[r17]
L_93dcd8:
	bl.d L_923a84
L_93dcdc:
	mov r1,0x0
L_93dce0:
	breq r0,0x0,L_93dcbc
L_93dce4:
	ld.as r8,[gp,-0x11]
L_93dce8:
	and r8,r8,0xffff0fff
L_93dcf0:
	or r4,r8,0xd000
L_93dcf8:
	or r8,r8,0x1d00d000
L_93dd00:
	st.as r4,[gp,-0x11]
L_93dd04:
	mov r32,r8
L_93dd08:
	st.ab r8,[r25,0x4]
L_93dd0c:
	bclr r25,r25,0xa
L_93dd10:
	nop_s
L_93dd12:
	nop_s
L_93dd14:
	nop_s
L_93dd16:
	lsr r7,r40,0x9
L_93dd1a:
	bmsk r7,r7,0xa
L_93dd1e:
	sub r9,r7,0x800
L_93dd26:
	cmp r7,0x3ff
L_93dd2a:
	mov.ls r9,r7
L_93dd2e:
	mov_s r13,0x803134
L_93dd34:
	ld r10,[r13, 0xc]
L_93dd38:
	st r9,[sp]
L_93dd3c:
	cmp r10,0x2
L_93dd40:
	mov r15,0x1
L_93dd44:
	bne.d L_93de2c
L_93dd48:
	mov_s r14,sp
L_93dd4a:
	ld r9,[r13]
L_93dd4e:
	cmp r9,0x0
L_93dd52:
	beq_s L_93de2c
L_93dd54:
	cmp r9,0x6
L_93dd58:
	bhi L_93de2c
L_93dd5c:
	bl.d L_93e56c
L_93dd60:
	mov r0,r13
L_93dd64:
	cmp_s r0,0x0
L_93dd66:
	beq_s L_93de2c
L_93dd68:
	ld r8,[r13]
L_93dd6c:
	sub.f r8,r8,0x1
L_93dd70:
	beq L_93de04
L_93dd74:
	breq r8,0x1,L_93de14
L_93dd78:
	breq r8,0x2,L_93de20
L_93dd7c:
	breq r8,0x3,L_93de2c
L_93dd80:
	brne r8,0x4,L_93de2c
L_93dd84:
	ld.as r6,[gp,-0x11]
L_93dd88:
	add r14,r13,0x18
L_93dd8c:
	and r6,r6,0xffff0fff
L_93dd94:
	or r1,r6,0x5000
L_93dd9c:
	st.as r1,[gp,-0x11]
L_93dda0:
	or r6,r6,0x1d005000
L_93dda8:
	mov r32,r6
L_93ddac:
	st.ab r6,[r25,0x4]
L_93ddb0:
	bclr r25,r25,0xa
L_93ddb4:
	nop_s
L_93ddb6:
	nop_s
L_93ddb8:
	mov 0x0,0x0
L_93ddbc:
	st r40,[r14]
L_93ddc0:
	ld.as r8,[gp,-0x11]
L_93ddc4:
	and r8,r8,0xffff0fff
L_93ddcc:
	or r2,r8,0x6000
L_93ddd4:
	or r8,r8,0x1d006000
L_93dddc:
	st.as r2,[gp,-0x11]
L_93dde0:
	mov r32,r8
L_93dde4:
	st.ab r8,[r25,0x4]
L_93dde8:
	bclr r25,r25,0xa
L_93ddec:
	nop_s
L_93ddee:
	nop_s
L_93ddf0:
	nop_s
L_93ddf2:
	st r40,[r14, 0x4]
L_93ddf6:
	st_s r15,[r13,0xc]
L_93ddf8:
	bl.d L_9216f8
L_93ddfc:
	mov r0,0x0
L_93de00:
	b L_93de2c
	.global L_93de04
L_93de04:
	mov r0,r13
L_93de08:
	bl.d L_928854
L_93de0c:
	mov r1,r14
L_93de10:
	b L_93de2c
	.global L_93de14
L_93de14:
	bl.d L_92893c
L_93de18:
	mov r0,r13
L_93de1c:
	b L_93de2c
	.global L_93de20
L_93de20:
	mov r0,r13
L_93de24:
	bl.d L_927f6c
L_93de28:
	mov r1,r14
	.global L_93de2c
L_93de2c:
	mov r8,0x802f14
L_93de34:
	ldb r9,[r8, 0x1f]
L_93de38:
	breq r9,0x1,L_93de90
	.global L_93de3c
L_93de3c:
	ld.as r10,[gp,0x1c]
L_93de40:
	breq r10,0x0,L_93de50
L_93de44:
	ld r7,[0x801424]
L_93de4c:
	bbit1 r7,0x0,L_93de64
	.global L_93de50
L_93de50:
	cmp r10,0x0
L_93de54:
	bne_s L_93dcbc
L_93de56:
	ld r2,[0x801424]
L_93de5e:
	btst_s r2,0x0
L_93de60:
	bne L_93dcbc
	.global L_93de64
L_93de64:
	mov r9,0x801030
L_93de6c:
	ldb r5,[r9, 0x50]
L_93de70:
	ld r11,[sp]
L_93de74:
	asl r5,r5,0x3
L_93de78:
	add2 r5,r5,r5
L_93de7c:
	add r5,r5,r9
L_93de80:
	ld r10,[r5, 0x18]
L_93de84:
	cmp r11,r10
L_93de88:
	ble L_93dcbc
L_93de8c:
	b L_93dcb0
	.global L_93de90
L_93de90:
	ld r7,[sp]
L_93de94:
	ld r0,[r8, 0x10]
L_93de98:
	brge r0,r7,L_93de3c
L_93de9c:
	st r7,[r8, 0x10]
L_93dea0:
	mov r9,0x804010
L_93dea8:
	ldw r6,[r9, 0x12]
L_93deac:
	lsr r6,r6,0xa
L_93deb0:
	stb r6,[r8, 0xc]
L_93deb4:
	ldw r7,[r9, 0x14]
L_93deb8:
	bmsk r7,r7,0x1
L_93debc:
	b.d L_93de3c
L_93dec0:
	stb r7,[r8, 0xd]
	.global L_93dec4
L_93dec4:
	mov r6,r54
L_93dec8:
	bbit1 r6,0x6,L_93dee0
L_93decc:
	mov r3,r54
L_93ded0:
	bbit0 r3,0x8,L_93df3c
L_93ded4:
	bl.d L_923c8c
L_93ded8:
	mov r16,0x40
L_93dedc:
	b L_93dcbc
	.global L_93dee0
L_93dee0:
	mov r13,0x802f14
L_93dee8:
	ldb r5,[r13, 0x1]
L_93deec:
	brne r5,0x0,L_93df18
	.global L_93def0
L_93def0:
	ldb_s r1,[r13,0x1f]
L_93def2:
	cmp_s r1,0x0
L_93def4:
	bl.ne L_9307bc
L_93def8:
	mov_s r0,0x1
L_93defa:
	stb r0,[r17, 0x4]
L_93defe:
	add_s sp,sp,0x8
L_93df00:
	ld blink,[sp, 0x4]
L_93df04:
	ld_s r14,[sp,0x8]
L_93df06:
	ld_s r15,[sp,0xc]
L_93df08:
	ld r16,[sp, 0x10]
L_93df0c:
	ld r17,[sp, 0x14]
L_93df10:
	j.d [blink]
L_93df14:
	ld.ab r13,[sp,0x18]
	.global L_93df18
L_93df18:
	mov_s r1,0x49000040
L_93df1e:
	mov_s r32,r1
L_93df20:
	st.ab r1,[r25,0x4]
L_93df24:
	bclr r25,r25,0xa
L_93df28:
	mov_s r0,0x49000100
L_93df2e:
	mov_s r32,r0
L_93df30:
	st.ab r0,[r25,0x4]
L_93df34:
	bclr r25,r25,0xa
L_93df38:
	b L_93def0
	.global L_93df3c
L_93df3c:
	mov r0,blink
L_93df40:
	bl.d L_926618
L_93df44:
	mov r1,0x5a
L_93df48:
	b L_93dcbc
