/* beacon_tx__build_slot_bitmap @ 0x932e00, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   beacon_tx.c
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow
 * Зовёт сам: __ld_r18_to_r13_ret_uc, __st_r18_to_r13_uc, uc_sysassert
 */
	.section .text.beacon_tx__build_slot_bitmap,"ax",@progbits
	.global beacon_tx__build_slot_bitmap
beacon_tx__build_slot_bitmap:
	.global L_932e00
L_932e00:
	push_s blink
L_932e02:
	bl L_920204
L_932e06:
	mov_s r0,0x80102c
L_932e0c:
	ldb_s r15,[r0,0x8]
L_932e0e:
	mov_s r13,0x801a9c
L_932e14:
	ld_s r0,[r13,0x5c]
L_932e16:
	mov_s r14,0x0
L_932e18:
	mul64 r0,0x1c
L_932e1c:
	add r0,r13,0x8
L_932e20:
	st_s r14,[r13,0x38]
L_932e22:
	st_s r14,[r13,0x3c]
L_932e24:
	ld r18,[r0,mlo]
L_932e28:
	st_s r14,[r13,0x44]
L_932e2a:
	st_s r14,[r13,0x48]
L_932e2c:
	b_s L_932e42
	.global L_932e2e
L_932e2e:
	add r1,r13,0x38
	.global L_932e32
L_932e32:
	ld_s r3,[r1]
L_932e34:
	bset r2,r3,r0
L_932e38:
	add_s r0,r14,0x1
L_932e3a:
	cmp_s r3,r2
L_932e3c:
	mov.ne r14,r0
L_932e40:
	st_s r2,[r1]
	.global L_932e42
L_932e42:
	breq_s r15,0,L_932e94
L_932e44:
	norm r0,r15
L_932e48:
	rsub r17,r0,0x1e
L_932e4c:
	asl r0,r17,0x3
L_932e50:
	add3_s r0,r0,r0
L_932e52:
	mov_s r1,0x801198
L_932e58:
	ld_s r0,[r1,r0]
L_932e5a:
	lsr_s r0,r0,0x8
L_932e5c:
	bmsk r16,r0,0xe
L_932e60:
	cmp r16,0x40
L_932e64:
	bhs_s L_932e82
	.global L_932e66
L_932e66:
	add r0,r18,0x3f
L_932e6a:
	sub r0,r0,r16
L_932e6e:
	bmsk_s r0,r0,0x5
L_932e70:
	brlo.d r0,0x20,L_932e2e
L_932e74:
	bclr r15,r15,r17
L_932e78:
	add r1,r13,0x3c
L_932e7c:
	sub r0,r0,0x20
L_932e80:
	b_s L_932e32
	.global L_932e82
L_932e82:
	mov_s r0,blink
L_932e84:
	mov_s r2,0x10031c8
L_932e8a:
	mov_s r1,0x5d
L_932e8c:
	bl.d L_925548
L_932e90:
	mov_s r3,0x3a
L_932e92:
	b_s L_932e66
	.global L_932e94
L_932e94:
	b.d L_920264
L_932e98:
	stw r14,[r13, 0x52]
