/* calib_lo_leakage__sweep @ 0x8e4cd4, 324 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, abif__get_rx_table_index_force_val, basic_sm__handle_event, ber_test__measure, calib_lo__set_result, calib_lo_leakage__prepare_ctx, calib_lo_leakage_step, calib_lo_leakage_substep, fw_sysassert_fatal, hwd_abif__rx_table_config_vga_dc, hwf__set_agc_index_1c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_lo_leakage__sweep
calib_lo_leakage__sweep:
	.global L_8e4cd4
L_8e4cd4:
	push_s blink
L_8e4cd6:
	bl L_8c01d0
L_8e4cda:
	mov_s r19,r0
L_8e4cdc:
	mov_s r18,r1
L_8e4cde:
	mov_s r17,r2
L_8e4ce0:
	mov_s r16,r3
L_8e4ce2:
	mov_s r1,0x8037ec
L_8e4ce8:
	ld_s r2,[r1]
L_8e4cea:
	ld_s r0,[r1,0x4]
L_8e4cec:
	st.a r2,[sp,-0x4c]
L_8e4cf0:
	st_s r0,[sp,0x4]
L_8e4cf2:
	mov r0,-0x1
L_8e4cf6:
	st_s r0,[sp,0x40]
L_8e4cf8:
	st_s r0,[sp,0x44]
L_8e4cfa:
	ld_s r0,[r1,0x8]
L_8e4cfc:
	mov_s r14,0x0
L_8e4cfe:
	st_s r0,[sp,0x48]
L_8e4d00:
	add_s r13,sp,0x48
L_8e4d02:
	mov_s r0,r19
L_8e4d04:
	bl.d L_8c839c
L_8e4d08:
	mov_s r1,r13
L_8e4d0a:
	add_s r15,sp,0x8
L_8e4d0c:
	mov_s r0,r15
L_8e4d0e:
	mov_s r1,r14
L_8e4d10:
	mov_s r2,0x7f
L_8e4d12:
	mov_s r3,r14
L_8e4d14:
	bl.d L_8f1d08
L_8e4d18:
	mov_s r4,r2
L_8e4d1a:
	b_s L_8e4d78
	.global L_8e4d1c
L_8e4d1c:
	ld r4,[r0, 0x4]
L_8e4d20:
	mov_s r0,r15
L_8e4d22:
	bl.d L_8f8f9c
L_8e4d26:
	mov r5,r4
L_8e4d2a:
	ld_s r1,[sp,0x0]
L_8e4d2c:
	mov_s r0,r19
L_8e4d2e:
	bl.d L_8e67a4
L_8e4d32:
	ld_s r2,[sp,0x4]
L_8e4d34:
	mov_s r0,r19
L_8e4d36:
	bl.d L_8dc5bc
L_8e4d3a:
	mov_s r1,r13
L_8e4d3c:
	mov_s r0,r19
L_8e4d3e:
	bl.d L_8c839c
L_8e4d42:
	mov_s r1,r13
L_8e4d44:
	mov r0,0x320
L_8e4d48:
	mov lp_count,r0
L_8e4d4c:
	nop_s
L_8e4d4e:
	lp L_8e4d56
L_8e4d52:
	nop_s
L_8e4d54:
	nop_s
	.global L_8e4d56
L_8e4d56:
	mov_s r0,r19
L_8e4d58:
	bl.d L_8dc5bc
L_8e4d5c:
	mov_s r1,r13
L_8e4d5e:
	mov_s r0,r19
L_8e4d60:
	bl.d L_8c839c
L_8e4d64:
	mov_s r1,r13
L_8e4d66:
	mov r4,sp
L_8e4d6a:
	add_s r3,sp,0x40
L_8e4d6c:
	mov_s r0,r19
L_8e4d6e:
	mov_s r1,r15
L_8e4d70:
	bl.d L_8e8360
L_8e4d74:
	mov_s r2,r4
L_8e4d76:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8e4d78
L_8e4d78:
	add3 r0,r16,r14
L_8e4d7c:
	ld_s r3,[r0]
L_8e4d7e:
	ld_s r1,[sp,0x0]
L_8e4d80:
	ld_s r2,[sp,0x4]
L_8e4d82:
	brne r3,0x0,L_8e4d1c
L_8e4d86:
	mov_s r0,0x853880
L_8e4d8c:
	st_s r1,[r0,0x48]
L_8e4d8e:
	st_s r2,[r0,0x4c]
L_8e4d90:
	st r1,[r18]
L_8e4d94:
	ld_s r1,[sp,0x4]
L_8e4d96:
	bl.d L_8cf5ec
L_8e4d9a:
	st r1,[r17]
L_8e4d9e:
	mov_s r16,r0
L_8e4da0:
	mov_s r14,0x1
L_8e4da2:
	mov_s r13,0x4
	.global L_8e4da4
L_8e4da4:
	add r3,sp,r14
L_8e4da8:
	ldb r3,[r3, 0x47]
L_8e4dac:
	mov_s r0,r16
L_8e4dae:
	mov_s r1,r14
L_8e4db0:
	bl.d L_8cf36c
L_8e4db4:
	mov_s r2,0x1
L_8e4db6:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e4db8:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e4dba:
	brhs.d r13,0x1,L_8e4da4
L_8e4dbe:
	extb_s r14,r14
L_8e4dc0:
	b.d L_8c022c
L_8e4dc4:
	add_s sp,sp,0x4c
L_8e4dc6:
	nop_s
L_8e4dc8:
	push_s blink
L_8e4dca:
	bl L_8c01d0
L_8e4dce:
	mov_s r14,r0
L_8e4dd0:
	mov_s r15,r1
L_8e4dd2:
	mov_s r16,r2
L_8e4dd4:
	mov.f r13,r3
L_8e4dd8:
	mov r19,r4
L_8e4ddc:
	mov r17,r5
L_8e4de0:
	mov r18,r6
L_8e4de4:
	beq_s L_8e4e0c
	.global L_8e4de6
L_8e4de6:
	st r19,[r13, 0x1c]
L_8e4dea:
	st r17,[r13, 0x18]
L_8e4dee:
	st_s r15,[r13,0xc]
L_8e4df0:
	st r16,[r13, 0x10]
L_8e4df4:
	stb r18,[r13, 0x20]
L_8e4df8:
	add r0,r14,0x28
L_8e4dfc:
	mov_s r1,0xa
L_8e4dfe:
	mov_s r2,r13
L_8e4e00:
	mov_s r3,0x0
L_8e4e02:
	bl.d L_8d9b6c
L_8e4e06:
	mov_s r4,r3
L_8e4e08:
	b L_8c022c
	.global L_8e4e0c
L_8e4e0c:
	mov_s r0,blink
L_8e4e0e:
	mov_s r1,0x8b
L_8e4e10:
	/* bl.d 0x008c9b28 */
	.byte 0x1a,0x0d,0x6f,0xf2
L_8e4e14:
	/* _asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8e4e16:
	b_s L_8e4de6
