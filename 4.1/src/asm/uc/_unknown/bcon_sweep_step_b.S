/* bcon_sweep_step_b @ 0x930dec, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow, tail_bcon_sweep_step_b
 * Зовёт сам: __ld_r18_to_r13_ret_uc, __st_r18_to_r13_uc, bcon_sweep__next_sector, memcpy_uc
 */
	.section .text.bcon_sweep_step_b,"ax",@progbits
	.global bcon_sweep_step_b
bcon_sweep_step_b:
	.global L_930dec
L_930dec:
	push_s blink
L_930dee:
	bl L_920204
L_930df2:
	sub_s sp,sp,0x18
L_930df4:
	mov_s r16,r0
L_930df6:
	mov_s r17,r1
L_930df8:
	mov.f r14,r2
L_930dfc:
	mov_s r0,0x801c9c
L_930e02:
	mov_s r15,0x0
L_930e04:
	stb_s r3,[r0,0xc]
L_930e06:
	stb_s r15,[r0,0xe]
L_930e08:
	stb_s r15,[r0,0xd]
L_930e0a:
	ldw r1,[r16]
L_930e0e:
	ldw r0,[r16, 0x4]
L_930e12:
	mov r18,0x801d3c
L_930e1a:
	add_s r0,r0,r1
L_930e1c:
	mov_s r13,0x801cbc
L_930e22:
	st_s r0,[r13,0x2c]
L_930e24:
	st_s r15,[r13,0x28]
L_930e26:
	beq_s L_930e6a
L_930e28:
	add r0,r13,0x8
L_930e2c:
	mov_s r1,r14
L_930e2e:
	bl.d L_920310
L_930e32:
	mov_s r2,0x18
L_930e34:
	stw_s r15,[r13,0x26]
L_930e36:
	add r0,r13,0x8
L_930e3a:
	st_s r0,[r13,0x20]
L_930e3c:
	mov_s r0,sp
L_930e3e:
	mov_s r1,r17
L_930e40:
	bl.d L_920310
L_930e44:
	mov_s r2,0x18
L_930e46:
	ld_s r1,[r14]
L_930e48:
	ld_s r0,[sp,0x0]
L_930e4a:
	bic_s r0,r0,r1
L_930e4c:
	st_s r0,[sp,0x0]
L_930e4e:
	ld_s r1,[r14,0x4]
L_930e50:
	ld_s r0,[sp,0x4]
L_930e52:
	bic_s r0,r0,r1
L_930e54:
	st_s r0,[sp,0x4]
L_930e56:
	ld_s r1,[r14,0xc]
L_930e58:
	ld_s r0,[sp,0xc]
L_930e5a:
	bic_s r0,r0,r1
L_930e5c:
	st_s r0,[sp,0xc]
L_930e5e:
	ld_s r1,[r14,0x10]
L_930e60:
	ld_s r0,[sp,0x10]
L_930e62:
	bic_s r0,r0,r1
L_930e64:
	st_s r0,[sp,0x10]
L_930e66:
	mov_s r1,sp
L_930e68:
	b_s L_930e76
	.global L_930e6a
L_930e6a:
	mov_s r0,0x1
L_930e6c:
	stw_s r0,[r13,0x26]
L_930e6e:
	sub3 r0,r18,0x12
L_930e72:
	st_s r0,[r13,0x20]
L_930e74:
	mov_s r1,r17
	.global L_930e76
L_930e76:
	sub3 r0,r18,0x12
L_930e7a:
	bl.d L_920310
L_930e7e:
	mov_s r2,0x18
L_930e80:
	ldb r0,[r17, 0x18]
L_930e84:
	stw_s r0,[r13,0x24]
L_930e86:
	bl.d L_930e94
L_930e8a:
	mov_s r0,r16
L_930e8c:
	b.d L_920264
L_930e90:
	add_s sp,sp,0x18
L_930e92:
	nop_s
