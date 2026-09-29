/* hwf_vga_dc__calibrate @ 0x8d3a70, 380 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_flows_vga_dc_calibration.c
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_bb_gain_dc__vga_dc_fine, calib_row_step, calib_vga_gain_step, hwf_dc_calib_fix_dac1
 * Зовёт сам: __ld_r24_to_r13_ret, __st_r24_to_r13, fw_sysassert_fatal, hwd_abif__get_agc_field, hwd_abif__rgf_88a200_8cc674, hwd_abif__set_agc_field, hwf_vga_dc__measure
 */
	.section .text.hwf_vga_dc__calibrate,"ax",@progbits
	.global hwf_vga_dc__calibrate
hwf_vga_dc__calibrate:
	.global L_8d3a70
L_8d3a70:
	push_s blink
L_8d3a72:
	bl L_8c029c
L_8d3a76:
	mov_s r15,r0
L_8d3a78:
	mov_s r17,r1
L_8d3a7a:
	st.a r2,[sp,-0xc]
L_8d3a7e:
	mov_s r23,r3
L_8d3a80:
	mov_s r0,0x802ef8
L_8d3a86:
	ld_s r0,[r0]
L_8d3a88:
	mov_s r13,r4
L_8d3a8a:
	st_s r0,[sp,0x4]
L_8d3a8c:
	mov_s r14,0x1
L_8d3a8e:
	mov r16,0x4
	.global L_8d3a92
L_8d3a92:
	extb r2,r17
L_8d3a96:
	mov_s r0,r15
L_8d3a98:
	bl.d L_8cc834
L_8d3a9c:
	mov_s r1,r14
L_8d3a9e:
	sub r22,sp,0x1
L_8d3aa2:
	add r12,r22,r14
L_8d3aa6:
	stb_s r0,[r12,0x4]
L_8d3aa8:
	sub r16,r16,0x1
L_8d3aac:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d3aae:
	brhs.d r16,0x1,L_8d3a92
L_8d3ab2:
	extb_s r14,r14
L_8d3ab4:
	mov_s r0,0x0
L_8d3ab6:
	bl.d L_8cc674
L_8d3aba:
	mov_s r1,r0
L_8d3abc:
	mov_s r0,0x1
L_8d3abe:
	bl.d L_8cc674
L_8d3ac2:
	mov_s r1,r15
L_8d3ac4:
	mov_s r0,r17
L_8d3ac6:
	bl.d L_8d3d74
L_8d3aca:
	ld_s r1,[sp,0x0]
L_8d3acc:
	lsr r1,r0,0x1f
L_8d3ad0:
	abs_s r2,r0
L_8d3ad2:
	extb_s r2,r2
L_8d3ad4:
	cmp r23,r2
L_8d3ad8:
	mov r24,0x1
L_8d3adc:
	sub.ge r24,r24,r24
L_8d3ae0:
	mov_s r3,r24
L_8d3ae2:
	add r14,r22,r13
L_8d3ae6:
	ldb_s r14,[r14,0x4]
L_8d3ae8:
	b_s L_8d3b76
	.global L_8d3aea
L_8d3aea:
	brne r19,0x0,L_8d3af8
L_8d3aee:
	add r14,r18,0x1
L_8d3af2:
	min r14,r14,0x1f
L_8d3af6:
	b_s L_8d3b00
	.global L_8d3af8
L_8d3af8:
	sub r14,r18,0x1
L_8d3afc:
	max r14,r14,0x0
	.global L_8d3b00
L_8d3b00:
	extb_s r14,r14
L_8d3b02:
	extb r16,r17
L_8d3b06:
	mov_s r0,r15
L_8d3b08:
	mov_s r1,r13
L_8d3b0a:
	mov_s r2,r16
L_8d3b0c:
	bl.d L_8cc3c8
L_8d3b10:
	mov_s r3,r14
L_8d3b12:
	mov_s r0,0x0
L_8d3b14:
	bl.d L_8cc674
L_8d3b18:
	mov_s r1,r0
L_8d3b1a:
	mov_s r0,0x1
L_8d3b1c:
	bl.d L_8cc674
L_8d3b20:
	mov_s r1,r15
L_8d3b22:
	mov_s r0,r17
L_8d3b24:
	bl.d L_8d3d74
L_8d3b28:
	ld_s r1,[sp,0x0]
L_8d3b2a:
	lsr r1,r0,0x1f
L_8d3b2e:
	abs_s r2,r0
L_8d3b30:
	extb_s r2,r2
L_8d3b32:
	brne r1,r19,L_8d3b42
L_8d3b36:
	cmp_s r0,0x0
L_8d3b38:
	cmp.ne r14,0x1f
L_8d3b3c:
	cmp.ne r14,0x0
L_8d3b40:
	bne_s L_8d3b66
	.global L_8d3b42
L_8d3b42:
	brge r20,r2,L_8d3b58
L_8d3b46:
	mov_s r0,r15
L_8d3b48:
	mov_s r1,r13
L_8d3b4a:
	mov_s r2,r16
L_8d3b4c:
	bl.d L_8cc3c8
L_8d3b50:
	mov_s r3,r18
L_8d3b52:
	mov_s r2,r20
L_8d3b54:
	mov_s r1,r19
L_8d3b56:
	mov_s r0,r21
	.global L_8d3b58
L_8d3b58:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d3b5a:
	extb_s r13,r13
L_8d3b5c:
	brlt r13,0x1,L_8d3b66
L_8d3b60:
	add r14,r22,r13
L_8d3b64:
	ldb_s r14,[r14,0x4]
	.global L_8d3b66
L_8d3b66:
	cmp_s r2,r23
L_8d3b68:
	mov.le r3,0x0
L_8d3b6c:
	ble_s L_8d3b76
L_8d3b6e:
	cmp_s r13,0x0
L_8d3b70:
	mov_s r3,0x1
L_8d3b72:
	sub.le r3,r3,r3
	.global L_8d3b76
L_8d3b76:
	mov_s r21,r0
L_8d3b78:
	mov_s r19,r1
L_8d3b7a:
	mov_s r20,r2
L_8d3b7c:
	mov_s r18,r14
L_8d3b7e:
	breq r3,0x1,L_8d3aea
L_8d3b82:
	brne r24,0x1,L_8d3bbc
L_8d3b86:
	mov_s r14,0x1
L_8d3b88:
	mov_s r13,0x4
	.global L_8d3b8a
L_8d3b8a:
	extb r2,r17
L_8d3b8e:
	mov_s r0,r15
L_8d3b90:
	bl.d L_8cc834
L_8d3b94:
	mov_s r1,r14
L_8d3b96:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d3b98:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d3b9a:
	brhs.d r13,0x1,L_8d3b8a
L_8d3b9e:
	extb_s r14,r14
L_8d3ba0:
	brlt r15,0x1,L_8d3bc4
L_8d3ba4:
	cmp_s r15,0x3f
L_8d3ba6:
	bgt_s L_8d3bc4
	.global L_8d3ba8
L_8d3ba8:
	asl r0,r17,0x6
L_8d3bac:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8d3bae:
	add_s r0,r0,r15
L_8d3bb0:
	add r1,r0,0x854820
L_8d3bb8:
	stb r21,[r1]
	.global L_8d3bbc
L_8d3bbc:
	brge r23,r20,L_8d3bdc
L_8d3bc0:
	mov_s r0,0x2
L_8d3bc2:
	b_s L_8d3be4
	.global L_8d3bc4
L_8d3bc4:
	mov_s r0,blink
L_8d3bc6:
	mov_s r2,0x1017a00
L_8d3bcc:
	mov_s r1,0x12f2
L_8d3bd2:
	bl.d L_8c82c0
L_8d3bd6:
	mov r3,0x1c8
L_8d3bda:
	b_s L_8d3ba8
	.global L_8d3bdc
L_8d3bdc:
	cmp r24,0x1
L_8d3be0:
	mov_s r0,0x1
L_8d3be2:
	sub_s.ne r0,r0,r0
	.global L_8d3be4
L_8d3be4:
	b.d L_8c02e4
L_8d3be8:
	add_s sp,sp,0xc
L_8d3bea:
	nop_s
