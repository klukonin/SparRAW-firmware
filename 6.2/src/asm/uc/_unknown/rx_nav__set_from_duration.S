/* rx_nav__set_from_duration @ 0x92dd30, 348 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx__update_nav_from_frame, rx_nav_update
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bi__state_from_g800600, nav__read_hw_duration_flag, sta__get_sweep_byte, uc_read_tsf_lo, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_nav__set_from_duration
rx_nav__set_from_duration:
	.global L_92dd30
L_92dd30:
	push_s blink
L_92dd32:
	bl L_92022c
L_92dd36:
	mov_s r15,r0
L_92dd38:
	st.a r1,[sp,-0x10]
L_92dd3c:
	mov_s r0,0x886e80
L_92dd42:
	ld_s r0,[r0,0x4]
L_92dd44:
	mov_s r13,r2
L_92dd46:
	mov_s r14,0x80146c
L_92dd4c:
	ldw_s r1,[r14,0x18]
L_92dd4e:
	extw_s r0,r0
L_92dd50:
	cmp_s r1,r0
L_92dd52:
	mov.cs r0,r1
L_92dd56:
	brhs.d r1,r2,L_92dd68
L_92dd5a:
	mov_s r16,r3
L_92dd5c:
	breq r13,r0,L_92ddfc
	.global L_92dd60
L_92dd60:
	ldw_s r0,[r14,0x1a]
L_92dd62:
	ldw_s r13,[r14,0x18]
L_92dd64:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92dd66:
	stw_s r0,[r14,0x1a]
	.global L_92dd68
L_92dd68:
	mov_s r0,0x4d
L_92dd6a:
	asl_s r0,r0,0x18
L_92dd6c:
	mov_s r32,r0
L_92dd6e:
	st.ab r0,[r25,0x4]
L_92dd72:
	bclr r25,r25,0xa
L_92dd76:
	nop_s
L_92dd78:
	nop_s
L_92dd7a:
	nop_s
L_92dd7c:
	stw r55,[sp, 0x4]
L_92dd80:
	bl L_9364c8
L_92dd84:
	ldb r1,[sp, 0x5]
L_92dd88:
	add_s r0,r0,r13
L_92dd8a:
	sub_s r0,r0,r1
L_92dd8c:
	ldb_s r1,[r14,0x1c]
L_92dd8e:
	ld_s r2,[sp,0x0]
L_92dd90:
	lsr_s r2,r2,0x2
L_92dd92:
	bmsk_s r2,r2,0x1
L_92dd94:
	add_s r1,r1,r0
L_92dd96:
	mov_s r0,0x0
L_92dd98:
	brne r2,0x1,L_92dda8
L_92dd9c:
	ld_s r2,[sp,0x0]
L_92dd9e:
	lsr_s r2,r2,0x4
L_92dda0:
	bmsk_s r2,r2,0x3
L_92dda2:
	cmp_s r2,0xe
L_92dda4:
	mov.eq r0,0x1
	.global L_92dda8
L_92dda8:
	breq r15,0x0,L_92de86
L_92ddac:
	ld_s r2,[r14,0x4]
L_92ddae:
	brne_s r0,0,L_92ddb8
L_92ddb0:
	sub r3,r1,r2
L_92ddb4:
	bbit1 r3,0x1f,L_92de86
	.global L_92ddb8
L_92ddb8:
	ld_s r3,[r14]
L_92ddba:
	mov_s r4,r3
L_92ddbc:
	bbit0 r3,0x0,L_92ddd8
L_92ddc0:
	add r3,r2,0x32
L_92ddc4:
	sub r15,r1,r3
L_92ddc8:
	btst_s r15,0x1f
L_92ddca:
	cmp.eq r0,0x0
L_92ddce:
	bne_s L_92ddd8
L_92ddd0:
	ld_s r0,[gp,-0x98]
L_92ddd2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92ddd4:
	st.as r0,[gp,-0x26]
	.global L_92ddd8
L_92ddd8:
	sub r0,r1,r2
L_92dddc:
	min r13,r0,r13
L_92dde0:
	st_s r1,[r14,0x4]
L_92dde2:
	bset r0,r4,0x0
L_92dde6:
	bl.d L_9282b4
L_92ddea:
	st_s r0,[r14]
L_92ddec:
	extb_s r0,r0
L_92ddee:
	mov_s r1,0xfffff0ff
L_92ddf4:
	brne r0,0x2,L_92de06
L_92ddf8:
	st_s r1,[r14,0xc]
L_92ddfa:
	b_s L_92de18
	.global L_92ddfc
L_92ddfc:
	mov_s r0,blink
L_92ddfe:
	bl.d L_926618
L_92de02:
	mov_s r1,0x63
L_92de04:
	b_s L_92dd60
	.global L_92de06
L_92de06:
	ld_s r0,[gp,-0xd4]
L_92de08:
	st_s r1,[r14,0x8]
L_92de0a:
	and_s r0,r0,r1
L_92de0c:
	bset_s r0,r0,0x1b
L_92de0e:
	mov_s r32,r0
L_92de10:
	st.ab r0,[r25,0x4]
L_92de14:
	bclr r25,r25,0xa
	.global L_92de18
L_92de18:
	mov lp_count,0x3
L_92de1c:
	mov_s r0,0x0
L_92de1e:
	lp L_92de32
L_92de22:
	ldw.as r2,[r16,r0]
L_92de26:
	mov_s r1,0x80147c
L_92de2c:
	add1_s r1,r1,r0
L_92de2e:
	stw_s r2,[r1]
L_92de30:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_92de32
L_92de32:
	mov_s r3,0x801498
L_92de38:
	ld_s r2,[r3]
L_92de3a:
	asr r0,r13,0x1f
L_92de3e:
	add.f r2,r2,r13
L_92de42:
	ld_s r1,[r3,0x4]
L_92de44:
	st_s r2,[r3]
L_92de46:
	adc r0,r0,r1
L_92de4a:
	st_s r0,[r3,0x4]
L_92de4c:
	mov_s r0,0x853900
L_92de52:
	st_s r2,[r0,0x14]
L_92de54:
	mov_s r0,0xff
L_92de56:
	st_s r0,[sp,0x8]
L_92de58:
	bl.d L_9290d0
L_92de5c:
	add_s r0,sp,0x8
L_92de5e:
	breq_s r0,0,L_92de7a
L_92de60:
	mov_s r0,0x0
L_92de62:
	st_s r0,[sp,0xc]
L_92de64:
	add_s r1,sp,0xc
L_92de66:
	bl.d L_93dad0
L_92de6a:
	ldb_s r0,[sp,0x8]
L_92de6c:
	mov_s r1,0x857180
L_92de72:
	add2_s r1,r1,r0
L_92de74:
	ld_s r0,[r1,0x24]
L_92de76:
	add_s r0,r0,r13
L_92de78:
	st_s r0,[r1,0x24]
	.global L_92de7a
L_92de7a:
	mov_s r1,0x8010b0
L_92de80:
	ld_s r0,[r1,0x20]
L_92de82:
	add_s r13,r13,r0
L_92de84:
	st_s r13,[r1,0x20]
	.global L_92de86
L_92de86:
	b.d L_920294
L_92de8a:
	add_s sp,sp,0x10
