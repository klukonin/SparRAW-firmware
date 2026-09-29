/* calib_lo_leakage__prepare_ctx @ 0x8f0c40, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_lo_leakage_run
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.calib_lo_leakage__prepare_ctx,"ax",@progbits
	.global calib_lo_leakage__prepare_ctx
calib_lo_leakage__prepare_ctx:
	.global L_8f0c40
L_8f0c40:
	sub_s sp,sp,0x8
L_8f0c42:
	push_s blink
L_8f0c44:
	bl L_8c02c0
L_8f0c48:
	mov_s r13,r4
L_8f0c4a:
	mul64_s r3,r13
L_8f0c4c:
	st_s r3,[r0,0x28]
L_8f0c4e:
	st_s r1,[r0,0x10]
L_8f0c50:
	st_s r2,[r0,0x14]
L_8f0c52:
	sub r14,r1,mlo
L_8f0c56:
	ld_s r15,[r0]
L_8f0c58:
	add r13,mlo,r1
L_8f0c5c:
	st_s r14,[r0,0x18]
L_8f0c5e:
	brge.d r14,r15,L_8f0c72
L_8f0c62:
	st_s r13,[r0,0x1c]
L_8f0c64:
	sub_s r15,r15,r14
L_8f0c66:
	add_s r14,r14,r15
L_8f0c68:
	st_s r14,[r0,0x18]
L_8f0c6a:
	add_s r13,r13,r15
L_8f0c6c:
	st_s r13,[r0,0x1c]
L_8f0c6e:
	add_s r1,r1,r15
L_8f0c70:
	st_s r1,[r0,0x10]
	.global L_8f0c72
L_8f0c72:
	ld_s r15,[r0,0x4]
L_8f0c74:
	brge r15,r13,L_8f0c8a
L_8f0c78:
	sub r1,r13,r15
L_8f0c7c:
	sub_s r14,r14,r1
L_8f0c7e:
	sub_s r13,r13,r1
L_8f0c80:
	st_s r13,[r0,0x1c]
L_8f0c82:
	ld_s r13,[r0,0x10]
L_8f0c84:
	st_s r14,[r0,0x18]
L_8f0c86:
	sub_s r13,r13,r1
L_8f0c88:
	st_s r13,[r0,0x10]
	.global L_8f0c8a
L_8f0c8a:
	mov_s r1,r5
L_8f0c8c:
	mul64_s r3,r1
L_8f0c8e:
	sub r1,r2,mlo
L_8f0c92:
	ld_s r3,[r0,0x8]
L_8f0c94:
	add_s r2,r2,mlo
L_8f0c96:
	st_s r1,[r0,0x20]
L_8f0c98:
	brge.d r1,r3,L_8f0cae
L_8f0c9c:
	st_s r2,[r0,0x24]
L_8f0c9e:
	sub_s r3,r3,r1
L_8f0ca0:
	add_s r1,r1,r3
L_8f0ca2:
	st_s r1,[r0,0x20]
L_8f0ca4:
	add_s r2,r2,r3
L_8f0ca6:
	ld_s r13,[r0,0x14]
L_8f0ca8:
	st_s r2,[r0,0x24]
L_8f0caa:
	add_s r3,r3,r13
L_8f0cac:
	st_s r3,[r0,0x14]
	.global L_8f0cae
L_8f0cae:
	ld_s r13,[r0,0xc]
L_8f0cb0:
	brge r13,r2,L_8f0cc6
L_8f0cb4:
	sub r3,r2,r13
L_8f0cb8:
	sub_s r1,r1,r3
L_8f0cba:
	st_s r1,[r0,0x20]
L_8f0cbc:
	sub_s r2,r2,r3
L_8f0cbe:
	ld_s r1,[r0,0x14]
L_8f0cc0:
	st_s r2,[r0,0x24]
L_8f0cc2:
	sub_s r1,r1,r3
L_8f0cc4:
	st_s r1,[r0,0x14]
	.global L_8f0cc6
L_8f0cc6:
	mov_s r12,0xc
L_8f0cc8:
	b L_8c032e
