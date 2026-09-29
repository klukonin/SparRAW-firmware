/* calib_battery_phy_step @ 0x8d6b2c, 336 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power_measure
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, calib__delta__8d6c7c, calib_battery__prepare, hwd_abif_battery_config, hwd_phy__rx_cal_corr_config
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_battery_phy_step
calib_battery_phy_step:
	.global L_8d6b2c
L_8d6b2c:
	push_s blink
L_8d6b2e:
	bl L_8c01c0
L_8d6b32:
	sub_s sp,sp,0x3c
L_8d6b34:
	mov_s r14,r0
L_8d6b36:
	mov_s r15,r1
L_8d6b38:
	mov_s r16,r2
L_8d6b3a:
	mov_s r12,0x1
L_8d6b3c:
	asl r0,r12,r0
L_8d6b40:
	mov_s r1,0x1
L_8d6b42:
	mov_s r13,0x0
L_8d6b44:
	bl.d L_8d2418
L_8d6b48:
	mov_s r2,r13
L_8d6b4a:
	mov_s r0,0x3
L_8d6b4c:
	bl.d L_8ce534
L_8d6b50:
	mov_s r1,r13
L_8d6b52:
	add_s r0,sp,0xc
L_8d6b54:
	bl.d L_8d6e20
L_8d6b58:
	mov_s r1,r14
L_8d6b5a:
	mov_s r0,0x2
L_8d6b5c:
	bl.d L_8ce534
L_8d6b60:
	mov_s r1,r13
L_8d6b62:
	mov_s r0,sp
L_8d6b64:
	bl.d L_8d6e20
L_8d6b68:
	mov_s r1,r14
L_8d6b6a:
	mov_s r0,0x1
L_8d6b6c:
	bl.d L_8ce534
L_8d6b70:
	mov_s r1,r13
L_8d6b72:
	mov_s r0,r16
L_8d6b74:
	bl.d L_8d6e20
L_8d6b78:
	mov_s r1,r14
L_8d6b7a:
	mov_s r0,r13
L_8d6b7c:
	bl.d L_8ce534
L_8d6b80:
	mov_s r1,r13
L_8d6b82:
	ld_s r2,[sp,0x0]
L_8d6b84:
	ld r1,[r16]
L_8d6b88:
	sub r0,r2,r1
L_8d6b8c:
	abs r4,r0
L_8d6b90:
	ldb r0,[sp, 0x9]
L_8d6b94:
	brne_s r0,0,L_8d6ba2
L_8d6b96:
	ldb r0,[r16, 0x9]
L_8d6b9a:
	cmp_s r0,0x0
L_8d6b9c:
	mov.eq r19,r13
L_8d6ba0:
	beq_s L_8d6ba6
	.global L_8d6ba2
L_8d6ba2:
	mov r19,0x1
	.global L_8d6ba6
L_8d6ba6:
	ld_s r0,[sp,0xc]
L_8d6ba8:
	ldb r5,[sp, 0x8]
L_8d6bac:
	sub r3,r0,r2
L_8d6bb0:
	abs r23,r3
L_8d6bb4:
	ldb_s r3,[sp,0x14]
L_8d6bb6:
	mov_s r2,0x0
L_8d6bb8:
	cmp_s r3,0x0
L_8d6bba:
	cmp.eq r5,0x0
L_8d6bbe:
	mov.ne r2,0x1
L_8d6bc2:
	mov_s r20,r2
L_8d6bc4:
	sub_s r0,r0,r1
L_8d6bc6:
	abs r17,r0
L_8d6bca:
	rsub r0,r14,0x19
L_8d6bce:
	mov r21,0x0
L_8d6bd2:
	bset r21,r21,r0
L_8d6bd6:
	add r1,r21,0x15c92492
L_8d6bde:
	rsub r22,r14,0x1a
L_8d6be2:
	asr r0,r4,0x2
L_8d6be6:
	asr r1,r1,r22
L_8d6bea:
	bl.d L_8d6c7c
L_8d6bee:
	mov_s r2,r14
L_8d6bf0:
	mov_s r18,r0
L_8d6bf2:
	add r1,r21,0x3c5b6db7
L_8d6bfa:
	asr r0,r17,0x2
L_8d6bfe:
	asr r1,r1,r22
L_8d6c02:
	bl.d L_8d6c7c
L_8d6c06:
	mov_s r2,r14
L_8d6c08:
	mov_s r17,r0
L_8d6c0a:
	add r1,r21,0x26924925
L_8d6c12:
	asr r0,r23,0x2
L_8d6c16:
	asr r1,r1,r22
L_8d6c1a:
	bl.d L_8d6c7c
L_8d6c1e:
	mov_s r2,r14
L_8d6c20:
	st r17,[r15]
L_8d6c24:
	stb r20,[r15, 0x4]
L_8d6c28:
	stb r19,[r15, 0x5]
L_8d6c2c:
	sub r1,r18,r0
L_8d6c30:
	abs_s r1,r1
L_8d6c32:
	cmp_s r1,0x8000
L_8d6c38:
	mov_s r1,0x1
L_8d6c3a:
	ldb_s r0,[sp,0x14]
L_8d6c3c:
	sub.le r1,r1,r1
L_8d6c40:
	cmp_s r0,0x0
L_8d6c42:
	mov_s r0,0x1
L_8d6c44:
	sub_s.ne r0,r0,r0
L_8d6c46:
	tst_s r0,r1
L_8d6c48:
	beq_s L_8d6c4e
L_8d6c4a:
	st r18,[r15]
	.global L_8d6c4e
L_8d6c4e:
	ldb_s r0,[sp,0x14]
L_8d6c50:
	ldb_s r1,[sp,0x8]
L_8d6c52:
	cmp_s r0,0x1
L_8d6c54:
	mov_s r0,0x1
L_8d6c56:
	sub_s.ne r0,r0,r0
L_8d6c58:
	cmp_s r1,0x0
L_8d6c5a:
	mov_s r1,0x1
L_8d6c5c:
	sub_s.ne r1,r1,r1
L_8d6c5e:
	and_s r0,r0,r1
L_8d6c60:
	ldb r1,[r16, 0x9]
L_8d6c64:
	cmp_s r1,0x0
L_8d6c66:
	mov_s r1,0x1
L_8d6c68:
	sub_s.ne r1,r1,r1
L_8d6c6a:
	tst_s r1,r0
L_8d6c6c:
	beq_s L_8d6c74
L_8d6c6e:
	st r18,[r15]
L_8d6c72:
	stb_s r13,[r15,0x4]
	.global L_8d6c74
L_8d6c74:
	b.d L_8c020c
L_8d6c78:
	add_s sp,sp,0x3c
L_8d6c7a:
	nop_s
