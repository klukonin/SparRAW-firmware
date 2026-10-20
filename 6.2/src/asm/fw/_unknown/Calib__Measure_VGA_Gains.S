/* Calib__Measure_VGA_Gains @ 0x8d4a08, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_calib_bb_gain_alg() BB_GAIN Calib::Measure_VGA_Gains:: cal_status = CAL_CORRECTION_NON_CONVERGED (iter_kick=%d)
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit1, hwf_calib_bb_gain_create_table, hwf_calib_bb_gain_rows, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global Calib__Measure_VGA_Gains
Calib__Measure_VGA_Gains:
	.global L_8d4a08
L_8d4a08:
	push_s blink
L_8d4a0a:
	bl L_8c01d4
L_8d4a0e:
	sub_s sp,sp,0x18
L_8d4a10:
	mov_s r14,0x2
L_8d4a12:
	mov_s r13,0x0
L_8d4a14:
	b_s L_8d4a52
	.global L_8d4a16
L_8d4a16:
	mov_s r3,0x801930
L_8d4a1c:
	ld r4,[r3, 0x10]
L_8d4a20:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d4a22:
	ld r5,[r3, 0x14]
L_8d4a26:
	ld r6,[r3, 0x18]
L_8d4a2a:
	ld_s r0,[r3,0x20]
L_8d4a2c:
	ld r7,[r3, 0x1c]
L_8d4a30:
	st_s r0,[sp,0x0]
L_8d4a32:
	add_s r0,sp,0x10
L_8d4a34:
	st_s r0,[sp,0x4]
L_8d4a36:
	mov_s r0,0x8423e4
L_8d4a3c:
	st_s r0,[sp,0x8]
L_8d4a3e:
	ld_s r0,[r3]
L_8d4a40:
	ld_s r1,[r3,0x4]
L_8d4a42:
	ld_s r2,[r3,0x8]
L_8d4a44:
	bl.d L_8d4eb4
L_8d4a48:
	ld_s r3,[r3,0xc]
L_8d4a4a:
	extb_s r13,r13
L_8d4a4c:
	mov_s r14,r0
L_8d4a4e:
	breq r0,0x2,L_8d4a6e
	.global L_8d4a52
L_8d4a52:
	brne r14,0x2,L_8d4a5a
L_8d4a56:
	brlt r13,0x3,L_8d4a16
	.global L_8d4a5a
L_8d4a5a:
	brne r14,0x2,L_8d4a7e
L_8d4a5e:
	mov_s r1,0x101cb68
L_8d4a64:
	mov_s r0,0x16
L_8d4a66:
	bl.d L_8dcc10
L_8d4a6a:
	mov_s r2,r13
L_8d4a6c:
	b_s L_8d4ac0
	.global L_8d4a6e
L_8d4a6e:
	mov_s r1,0x101cb68
L_8d4a74:
	mov_s r0,0x16
L_8d4a76:
	bl.d L_8dcc10
L_8d4a7a:
	mov_s r2,r13
L_8d4a7c:
	b_s L_8d4a52
	.global L_8d4a7e
L_8d4a7e:
	brne r14,0x1,L_8d4ac0
L_8d4a82:
	mov_s r13,0x801930
L_8d4a88:
	mov_s r0,sp
L_8d4a8a:
	add r1,r13,0x14
L_8d4a8e:
	ld r18,[r13, 0x4]
L_8d4a92:
	ld r17,[r13, 0x8]
L_8d4a96:
	ld r16,[r13, 0xc]
L_8d4a9a:
	ld_s r15,[r13,0x10]
L_8d4a9c:
	bl.d L_8c0380
L_8d4aa0:
	mov_s r2,0x10
L_8d4aa2:
	ld_s r1,[sp,0x10]
L_8d4aa4:
	mov_s r0,0x8423e4
L_8d4aaa:
	ld_s r2,[sp,0x14]
L_8d4aac:
	mov r4,r18
L_8d4ab0:
	ld_s r3,[r13]
L_8d4ab2:
	mov r5,r17
L_8d4ab6:
	mov r6,r16
L_8d4aba:
	bl.d L_8d4ac8
L_8d4abe:
	mov_s r7,r15
	.global L_8d4ac0
L_8d4ac0:
	mov_s r0,r14
L_8d4ac2:
	b.d L_8c0234
L_8d4ac6:
	add_s sp,sp,0x18
