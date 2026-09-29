/* hwf_calib_bb_gain_alg @ 0x8d1b58, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_calib_bb_gain_alg() BB_GAIN Calib::Measure_VGA_Gains:: cal_status = CAL_CORRECTION_NON_CONVERGED (iter_kick=%d)
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_bb_gain_dc__vga_dc_fine, hwf_calib_all
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit1, hwf_calib_bb_gain_create_table, hwf_calib_bb_gain_rows, memcpy_fw
 */
	.section .text.hwf_calib_bb_gain_alg,"ax",@progbits
	.global hwf_calib_bb_gain_alg
hwf_calib_bb_gain_alg:
	.global L_8d1b58
L_8d1b58:
	push_s blink
L_8d1b5a:
	bl L_8c02b4
L_8d1b5e:
	sub_s sp,sp,0x18
L_8d1b60:
	mov_s r14,0x2
L_8d1b62:
	mov_s r13,0x0
L_8d1b64:
	b_s L_8d1ba2
	.global L_8d1b66
L_8d1b66:
	mov_s r3,0x801728
L_8d1b6c:
	ld r4,[r3, 0x10]
L_8d1b70:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d1b72:
	ld r5,[r3, 0x14]
L_8d1b76:
	ld r6,[r3, 0x18]
L_8d1b7a:
	ld_s r0,[r3,0x20]
L_8d1b7c:
	ld r7,[r3, 0x1c]
L_8d1b80:
	st_s r0,[sp,0x0]
L_8d1b82:
	add_s r0,sp,0x10
L_8d1b84:
	st_s r0,[sp,0x4]
L_8d1b86:
	mov_s r0,0x8426a0
L_8d1b8c:
	st_s r0,[sp,0x8]
L_8d1b8e:
	ld_s r0,[r3]
L_8d1b90:
	ld_s r1,[r3,0x4]
L_8d1b92:
	ld_s r2,[r3,0x8]
L_8d1b94:
	bl.d L_8d2064
L_8d1b98:
	ld_s r3,[r3,0xc]
L_8d1b9a:
	extb_s r13,r13
L_8d1b9c:
	mov_s r14,r0
L_8d1b9e:
	breq r0,0x2,L_8d1bc0
	.global L_8d1ba2
L_8d1ba2:
	brne r14,0x2,L_8d1baa
L_8d1ba6:
	brlt r13,0x3,L_8d1b66
	.global L_8d1baa
L_8d1baa:
	brne r14,0x2,L_8d1bd2
L_8d1bae:
	mov_s r2,0x1017cc8
L_8d1bb4:
	mov_s r0,0x6
L_8d1bb6:
	mov_s r1,0x1
L_8d1bb8:
	bl.d L_8edfcc
L_8d1bbc:
	mov_s r3,r13
L_8d1bbe:
	b_s L_8d1c14
	.global L_8d1bc0
L_8d1bc0:
	mov_s r2,0x1017cc8
L_8d1bc6:
	mov_s r0,0x6
L_8d1bc8:
	mov_s r1,0x1
L_8d1bca:
	bl.d L_8edfcc
L_8d1bce:
	mov_s r3,r13
L_8d1bd0:
	b_s L_8d1ba2
	.global L_8d1bd2
L_8d1bd2:
	brne r14,0x1,L_8d1c14
L_8d1bd6:
	mov_s r13,0x801728
L_8d1bdc:
	mov_s r0,sp
L_8d1bde:
	add r1,r13,0x14
L_8d1be2:
	ld r18,[r13, 0x4]
L_8d1be6:
	ld r17,[r13, 0x8]
L_8d1bea:
	ld r16,[r13, 0xc]
L_8d1bee:
	ld_s r15,[r13,0x10]
L_8d1bf0:
	bl.d L_8c0460
L_8d1bf4:
	mov_s r2,0x10
L_8d1bf6:
	ld_s r1,[sp,0x10]
L_8d1bf8:
	mov_s r0,0x8426a0
L_8d1bfe:
	ld_s r2,[sp,0x14]
L_8d1c00:
	mov r4,r18
L_8d1c04:
	ld_s r3,[r13]
L_8d1c06:
	mov r5,r17
L_8d1c0a:
	mov r6,r16
L_8d1c0e:
	bl.d L_8d1c1c
L_8d1c12:
	mov_s r7,r15
	.global L_8d1c14
L_8d1c14:
	mov_s r0,r14
L_8d1c16:
	b.d L_8c0314
L_8d1c1a:
	add_s sp,sp,0x18
