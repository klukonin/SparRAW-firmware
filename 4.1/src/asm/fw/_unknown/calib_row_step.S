/* calib_row_step @ 0x8d1fb8, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_bb_gain_rows
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, calib_lo_power_measure, calib_vga_gain_step, frag_8d2744, hwd_abif__config_vga_rows, hwd_abif__get_agc_field, hwf_vga_dc__calibrate
 */
	.section .text.calib_row_step,"ax",@progbits
	.global calib_row_step
calib_row_step:
	.global L_8d1fb8
L_8d1fb8:
	sub_s sp,sp,0x18
L_8d1fba:
	push_s blink
L_8d1fbc:
	bl L_8c02bc
L_8d1fc0:
	sub_s sp,sp,0x10
L_8d1fc2:
	mov_s r14,r4
L_8d1fc4:
	mov r4,r5
L_8d1fc8:
	mov r5,r6
L_8d1fcc:
	mov r6,r7
L_8d1fd0:
	mov_s r16,r0
L_8d1fd2:
	mov_s r0,r1
L_8d1fd4:
	ld r7,[sp, 0x3c]
L_8d1fd8:
	mov_s r1,r2
L_8d1fda:
	ld_s r13,[sp,0x44]
L_8d1fdc:
	mov_s r2,r3
L_8d1fde:
	ld_s r15,[sp,0x40]
L_8d1fe0:
	st_s r15,[sp,0x0]
L_8d1fe2:
	st_s r13,[sp,0x4]
L_8d1fe4:
	add_s r13,sp,0xc
L_8d1fe6:
	st_s r13,[sp,0x8]
L_8d1fe8:
	bl.d L_8d2744
L_8d1fec:
	mov_s r3,r14
L_8d1fee:
	mov_s r0,r16
L_8d1ff0:
	bl.d L_8cc07c
L_8d1ff4:
	mov_s r1,r13
L_8d1ff6:
	ldb_s r0,[sp,0x48]
L_8d1ff8:
	brne r0,0x1,L_8d2006
L_8d1ffc:
	mov_s r0,r16
L_8d1ffe:
	bl.d L_8d3964
L_8d2002:
	mov_s r1,r16
L_8d2004:
	b_s L_8d2028
	.global L_8d2006
L_8d2006:
	ldb_s r13,[sp,0x4c]
L_8d2008:
	mov_s r0,r16
L_8d200a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d200c:
	min r13,r13,0x4
L_8d2010:
	extb r4,r13
L_8d2014:
	mov_s r1,0x0
L_8d2016:
	mov_s r2,0xd
L_8d2018:
	bl.d L_8d3a70
L_8d201c:
	mov_s r3,r1
L_8d201e:
	mov_s r0,r16
L_8d2020:
	mov_s r1,0xd
L_8d2022:
	bl.d L_8d3f40
L_8d2026:
	ld_s r2,[sp,0x50]
	.global L_8d2028
L_8d2028:
	mov_s r0,0x28
L_8d202a:
	mov_s r1,0x1
L_8d202c:
	bl.d L_8cc834
L_8d2030:
	mov_s r2,0x0
L_8d2032:
	ld_s r13,[sp,0x54]
L_8d2034:
	mov_s r1,0x2
L_8d2036:
	stb_s r0,[r13]
L_8d2038:
	mov_s r0,0x28
L_8d203a:
	bl.d L_8cc834
L_8d203e:
	mov_s r2,0x0
L_8d2040:
	stb_s r0,[r13,0x1]
L_8d2042:
	mov_s r0,0x28
L_8d2044:
	mov_s r1,0x3
L_8d2046:
	bl.d L_8cc834
L_8d204a:
	mov_s r2,0x0
L_8d204c:
	stb_s r0,[r13,0x2]
L_8d204e:
	mov_s r0,0x28
L_8d2050:
	mov_s r1,0x4
L_8d2052:
	bl.d L_8cc834
L_8d2056:
	mov_s r2,0x0
L_8d2058:
	stb_s r0,[r13,0x3]
L_8d205a:
	mov_s r12,0x1c
L_8d205c:
	b.d L_8c0326
L_8d2060:
	add_s sp,sp,0x10
L_8d2062:
	nop_s
