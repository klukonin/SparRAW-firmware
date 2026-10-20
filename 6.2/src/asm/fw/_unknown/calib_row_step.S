/* calib_row_step @ 0x8d4e08, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_bb_gain_rows
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bytes__pick4_by_index, calib_lo_power_measure, calib_vga_gain_step, hwd_abif__config_vga_rows, hwd_abif__rx_table_read_vga_dc, hwf_vga_dc__calibrate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_row_step
calib_row_step:
	.global L_8d4e08
L_8d4e08:
	sub_s sp,sp,0x18
L_8d4e0a:
	push_s blink
L_8d4e0c:
	bl L_8c01dc
L_8d4e10:
	sub_s sp,sp,0x10
L_8d4e12:
	mov_s r14,r4
L_8d4e14:
	mov r4,r5
L_8d4e18:
	mov r5,r6
L_8d4e1c:
	mov r6,r7
L_8d4e20:
	mov_s r16,r0
L_8d4e22:
	mov_s r0,r1
L_8d4e24:
	ld r7,[sp, 0x3c]
L_8d4e28:
	mov_s r1,r2
L_8d4e2a:
	ld_s r13,[sp,0x44]
L_8d4e2c:
	mov_s r2,r3
L_8d4e2e:
	ld_s r15,[sp,0x40]
L_8d4e30:
	st_s r15,[sp,0x0]
L_8d4e32:
	st_s r13,[sp,0x4]
L_8d4e34:
	add_s r13,sp,0xc
L_8d4e36:
	st_s r13,[sp,0x8]
L_8d4e38:
	bl.d L_8d5578
L_8d4e3c:
	mov_s r3,r14
L_8d4e3e:
	mov_s r0,r16
L_8d4e40:
	bl.d L_8cf0ac
L_8d4e44:
	mov_s r1,r13
L_8d4e46:
	ldb_s r0,[sp,0x48]
L_8d4e48:
	brne r0,0x1,L_8d4e56
L_8d4e4c:
	mov_s r0,r16
L_8d4e4e:
	bl.d L_8d66cc
L_8d4e52:
	mov_s r1,r16
L_8d4e54:
	b_s L_8d4e78
	.global L_8d4e56
L_8d4e56:
	ldb_s r13,[sp,0x4c]
L_8d4e58:
	mov_s r0,r16
L_8d4e5a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d4e5c:
	min r13,r13,0x4
L_8d4e60:
	extb r4,r13
L_8d4e64:
	mov_s r1,0x0
L_8d4e66:
	mov_s r2,0xd
L_8d4e68:
	bl.d L_8d67d8
L_8d4e6c:
	mov_s r3,r1
L_8d4e6e:
	mov_s r0,r16
L_8d4e70:
	mov_s r1,0xd
L_8d4e72:
	bl.d L_8d6ca0
L_8d4e76:
	ld_s r2,[sp,0x50]
	.global L_8d4e78
L_8d4e78:
	mov_s r0,0x1
L_8d4e7a:
	mov_s r1,r0
L_8d4e7c:
	bl.d L_8cf718
L_8d4e80:
	mov_s r2,0x0
L_8d4e82:
	ld_s r13,[sp,0x54]
L_8d4e84:
	mov_s r1,0x2
L_8d4e86:
	stb_s r0,[r13]
L_8d4e88:
	mov_s r0,0x1
L_8d4e8a:
	bl.d L_8cf718
L_8d4e8e:
	mov_s r2,0x0
L_8d4e90:
	stb_s r0,[r13,0x1]
L_8d4e92:
	mov_s r0,0x1
L_8d4e94:
	mov_s r1,0x3
L_8d4e96:
	bl.d L_8cf718
L_8d4e9a:
	mov_s r2,0x0
L_8d4e9c:
	stb_s r0,[r13,0x2]
L_8d4e9e:
	mov_s r0,0x1
L_8d4ea0:
	mov_s r1,0x4
L_8d4ea2:
	bl.d L_8cf718
L_8d4ea6:
	mov_s r2,0x0
L_8d4ea8:
	stb_s r0,[r13,0x3]
L_8d4eaa:
	mov_s r12,0x1c
L_8d4eac:
	b.d L_8c0246
L_8d4eb0:
	add_s sp,sp,0x10
L_8d4eb2:
	nop_s
