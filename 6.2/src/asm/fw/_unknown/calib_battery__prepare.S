/* calib_battery__prepare @ 0x8d6e20, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_battery_phy_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_phy__rx_cal_corr
 * Глобалы (через gp): 0x800217
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_battery__prepare
calib_battery__prepare:
	.global L_8d6e20
L_8d6e20:
	push_s blink
L_8d6e22:
	bl L_8c01e4
L_8d6e26:
	sub_s sp,sp,0x8
L_8d6e28:
	mov_s r13,r0
L_8d6e2a:
	mov_s r14,r1
L_8d6e2c:
	mov_s r0,0x0
L_8d6e2e:
	stb_s r0,[r13,0x8]
L_8d6e30:
	stb_s r0,[r13,0x9]
L_8d6e32:
	bl.d L_8d23a0
L_8d6e36:
	mov_s r0,sp
L_8d6e38:
	/* add_s r14,0x2 */
	.byte 0x02,0xe6
L_8d6e3a:
	mov_s r0,0x1d
L_8d6e3c:
	ld_s r1,[sp,0x0]
L_8d6e3e:
	asl_s r0,r0,r14
L_8d6e40:
	abs_s r1,r1
L_8d6e42:
	brge r0,r1,L_8d6e4a
L_8d6e46:
	mov_s r0,0x1
L_8d6e48:
	stb_s r0,[r13,0x8]
	.global L_8d6e4a
L_8d6e4a:
	ldb_s r0,[gp,0x93]
L_8d6e4c:
	ld_s r1,[sp,0x0]
L_8d6e4e:
	asl_s r0,r0,r14
L_8d6e50:
	abs_s r1,r1
L_8d6e52:
	brge r1,r0,L_8d6e5a
L_8d6e56:
	mov_s r0,0x1
L_8d6e58:
	stb_s r0,[r13,0x9]
	.global L_8d6e5a
L_8d6e5a:
	ld_s r0,[sp,0x0]
L_8d6e5c:
	st_s r0,[r13]
L_8d6e5e:
	ld_s r0,[sp,0x4]
L_8d6e60:
	st_s r0,[r13,0x4]
L_8d6e62:
	b.d L_8c0254
L_8d6e66:
	add_s sp,sp,0x8
