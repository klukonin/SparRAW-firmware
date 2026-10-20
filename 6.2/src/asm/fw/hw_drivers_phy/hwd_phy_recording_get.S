/* hwd_phy_recording_get @ 0x8d1f24, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_phy_recording_get: ram_base_addr=0x%x
 *   hwd_phy_recording_get: start_addr=0x%x
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy_recording_get
hwd_phy_recording_get:
	.global L_8d1f24
L_8d1f24:
	push_s blink
L_8d1f26:
	bl L_8c01dc
L_8d1f2a:
	mov_s r13,r1
L_8d1f2c:
	mov_s r1,0x880180
L_8d1f32:
	ld_s r3,[r1,0x60]
L_8d1f34:
	add r16,r2,0x8
L_8d1f38:
	lsr_s r3,r3,0x6
L_8d1f3a:
	ld_s r14,[r1,0x60]
L_8d1f3c:
	bmsk_s r3,r3,0x0
L_8d1f3e:
	lsr_s r14,r14,0x7
L_8d1f40:
	bmsk_s r14,r14,0x0
L_8d1f42:
	ld_s r1,[r1,0x60]
L_8d1f44:
	add_s r14,r14,r3
L_8d1f46:
	lsr_s r1,r1,0x8
L_8d1f48:
	bmsk_s r1,r1,0x0
L_8d1f4a:
	add_s r14,r14,r1
L_8d1f4c:
	mov_s r3,0x883580
L_8d1f52:
	ld_s r1,[r3,0x24]
L_8d1f54:
	extb_s r14,r14
L_8d1f56:
	bmsk_s r1,r1,0xc
L_8d1f58:
	brlo.d r13,0x21,L_8d1f64
L_8d1f5c:
	st_s r1,[r2,0x4]
L_8d1f5e:
	mov_s r0,0x3
L_8d1f60:
	st_s r0,[r2]
L_8d1f62:
	b_s L_8d1fc4
	.global L_8d1f64
L_8d1f64:
	add_s r1,r13,r0
L_8d1f66:
	asl_s r14,r14,0xe
L_8d1f68:
	brhs r14,r1,L_8d1f72
L_8d1f6c:
	mov_s r0,0x2
L_8d1f6e:
	st_s r0,[r2]
L_8d1f70:
	b_s L_8d1fc4
	.global L_8d1f72
L_8d1f72:
	mov_s r1,0x1
L_8d1f74:
	st_s r1,[r2]
L_8d1f76:
	ld_s r1,[r3,0x24]
L_8d1f78:
	asl_s r15,r0,0x2
L_8d1f7a:
	bmsk_s r1,r1,0xc
L_8d1f7c:
	st_s r1,[r2,0x4]
L_8d1f7e:
	lsr r0,r15,0x10
L_8d1f82:
	asl_s r0,r0,0x10
L_8d1f84:
	rsub r14,r0,0x8f0000
L_8d1f8c:
	mov_s r1,0x101d8ac
L_8d1f92:
	mov_s r0,0x21
L_8d1f94:
	bl.d L_8dcc10
L_8d1f98:
	mov_s r2,r14
L_8d1f9a:
	extw_s r15,r15
L_8d1f9c:
	add_s r14,r14,r15
L_8d1f9e:
	mov_s r1,0x101d8d8
L_8d1fa4:
	mov_s r0,0x21
L_8d1fa6:
	bl.d L_8dcc10
L_8d1faa:
	mov_s r2,r14
L_8d1fac:
	mov_s r0,0x0
L_8d1fae:
	cmp_s r13,0x0
L_8d1fb0:
	mov.hi lp_count,r13
L_8d1fb4:
	lphi L_8d1fc4
L_8d1fb8:
	ld.as r1,[r14,r0]
L_8d1fbc:
	add2 r12,r16,r0
L_8d1fc0:
	st_s r1,[r12]
L_8d1fc2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8d1fc4
L_8d1fc4:
	b L_8c0244
