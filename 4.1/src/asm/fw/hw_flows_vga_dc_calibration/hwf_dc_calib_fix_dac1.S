/* hwf_dc_calib_fix_dac1 @ 0x8d3bec, 288 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_flows_vga_dc_calibration.c
 *   Post:hwf_dc_calib_measure_and_fix_dac1: Row %d, DC measured_7b (I)= %d ; (Q)= %d
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_sar__vt18, hwf_calib_all
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log__emit3, fw_sysassert_fatal, hwd_abif__rgf_88a200_8cc674, hwd_abif__set_agc_field, hwd_phy__read_status_pair, hwf_vga_dc__calibrate
 */
	.section .text.hwf_dc_calib_fix_dac1,"ax",@progbits
	.global hwf_dc_calib_fix_dac1
hwf_dc_calib_fix_dac1:
	.global L_8d3bec
L_8d3bec:
	push_s blink
L_8d3bee:
	bl L_8c02ac
L_8d3bf2:
	sub_s sp,sp,0x14
L_8d3bf4:
	mov_s r13,r0
L_8d3bf6:
	mov_s r14,r1
L_8d3bf8:
	mov_s r16,r2
L_8d3bfa:
	brne r2,0x1,L_8d3cac
	.global L_8d3bfe
L_8d3bfe:
	cmp_s r14,r13
L_8d3c00:
	bcs L_8d3d06
L_8d3c04:
	sub_s r14,r14,r13
L_8d3c06:
	add_s r0,r14,0x1
	.global L_8d3c08
L_8d3c08:
	mov_s r18,r13
L_8d3c0a:
	mov_s r20,r0
L_8d3c0c:
	mov r17,sp
L_8d3c10:
	mov r19,0x400
L_8d3c14:
	extb_s r13,r13
L_8d3c16:
	brne r16,0x1,L_8d3c62
L_8d3c1a:
	mov_s r0,r13
L_8d3c1c:
	mov_s r1,0x2
L_8d3c1e:
	mov_s r2,0x0
L_8d3c20:
	bl.d L_8cc3c8
L_8d3c24:
	mov_s r3,0xf
L_8d3c26:
	mov_s r0,r13
L_8d3c28:
	mov_s r1,0x3
L_8d3c2a:
	mov_s r2,0x0
L_8d3c2c:
	bl.d L_8cc3c8
L_8d3c30:
	mov_s r3,0xf
L_8d3c32:
	mov_s r0,r13
L_8d3c34:
	mov_s r1,0x4
L_8d3c36:
	mov_s r2,0x0
L_8d3c38:
	bl.d L_8cc3c8
L_8d3c3c:
	mov_s r3,0xf
L_8d3c3e:
	mov_s r0,r13
L_8d3c40:
	mov_s r1,0x2
L_8d3c42:
	mov_s r2,0x1
L_8d3c44:
	bl.d L_8cc3c8
L_8d3c48:
	mov_s r3,0xf
L_8d3c4a:
	mov_s r0,r13
L_8d3c4c:
	mov_s r1,0x3
L_8d3c4e:
	mov_s r2,0x1
L_8d3c50:
	bl.d L_8cc3c8
L_8d3c54:
	mov_s r3,0xf
L_8d3c56:
	mov_s r0,r13
L_8d3c58:
	mov_s r1,0x4
L_8d3c5a:
	mov_s r2,0x1
L_8d3c5c:
	bl.d L_8cc3c8
L_8d3c60:
	mov_s r3,0xf
	.global L_8d3c62
L_8d3c62:
	mov_s r0,0x0
L_8d3c64:
	bl.d L_8cc674
L_8d3c68:
	mov_s r1,r13
L_8d3c6a:
	mov_s r0,0x1
L_8d3c6c:
	bl.d L_8cc674
L_8d3c70:
	mov_s r1,r13
L_8d3c72:
	bl.d L_8cf6f8
L_8d3c76:
	mov_s r0,r17
L_8d3c78:
	mov_s r15,0x2
L_8d3c7a:
	mov_s r14,0x0
	.global L_8d3c7c
L_8d3c7c:
	mov_s r0,r13
L_8d3c7e:
	mov_s r1,r14
L_8d3c80:
	mov_s r2,0xa
L_8d3c82:
	mov_s r3,0x2
L_8d3c84:
	bl.d L_8d3a70
L_8d3c88:
	mov r4,0x1
L_8d3c8c:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8d3c8e:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d3c90:
	brhs.d r15,0x1,L_8d3c7c
L_8d3c94:
	extb_s r14,r14
L_8d3c96:
	bl.d L_8cf6f8
L_8d3c9a:
	mov_s r0,r17
L_8d3c9c:
	ld_s r1,[sp,0x0]
L_8d3c9e:
	brlt.d r1,0x0,L_8d3cc6
L_8d3ca2:
	ld_s r0,[sp,0x4]
L_8d3ca4:
	add_s r1,r1,r19
L_8d3ca6:
	asr_s r1,r1,0xb
L_8d3ca8:
	sexb_s r13,r1
L_8d3caa:
	b_s L_8d3cd0
	.global L_8d3cac
L_8d3cac:
	breq r16,0x2,L_8d3bfe
L_8d3cb0:
	mov_s r0,blink
L_8d3cb2:
	mov_s r2,0x1017a00
L_8d3cb8:
	mov_s r1,0x117a
L_8d3cbe:
	bl.d L_8c82c0
L_8d3cc2:
	mov_s r3,0xcd
L_8d3cc4:
	b_s L_8d3bfe
	.global L_8d3cc6
L_8d3cc6:
	sub r13,r19,r1
L_8d3cca:
	asr_s r13,r13,0xb
L_8d3ccc:
	neg_s r13,r13
L_8d3cce:
	sexb_s r13,r13
	.global L_8d3cd0
L_8d3cd0:
	brlt r0,0x0,L_8d3cdc
L_8d3cd4:
	add_s r0,r0,r19
L_8d3cd6:
	asr_s r0,r0,0xb
L_8d3cd8:
	sexb_s r14,r0
L_8d3cda:
	b_s L_8d3ce6
	.global L_8d3cdc
L_8d3cdc:
	sub r14,r19,r0
L_8d3ce0:
	asr_s r14,r14,0xb
L_8d3ce2:
	neg_s r14,r14
L_8d3ce4:
	sexb_s r14,r14
	.global L_8d3ce6
L_8d3ce6:
	mov_s r2,0x1017a20
L_8d3cec:
	mov_s r0,0x6
L_8d3cee:
	mov_s r1,0x2
L_8d3cf0:
	mov_s r3,r18
L_8d3cf2:
	mov_s r4,r13
L_8d3cf4:
	bl.d L_8ee034
L_8d3cf8:
	mov_s r5,r14
L_8d3cfa:
	sub r0,r20,0x1
L_8d3cfe:
	brhs.d r0,0x1,L_8d3c08
L_8d3d02:
	add r13,r18,0x1
	.global L_8d3d06
L_8d3d06:
	b.d L_8c0304
L_8d3d0a:
	add_s sp,sp,0x14
