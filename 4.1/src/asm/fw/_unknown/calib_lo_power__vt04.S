/* calib_lo_power__vt04 @ 0x8d5fdc, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_all
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, calib_lo__write_vt_codes, rfc__read_field_484, stub_ret_8ca168, stub_ret_8ca170
 */
	.section .text.calib_lo_power__vt04,"ax",@progbits
	.global calib_lo_power__vt04
calib_lo_power__vt04:
	.global L_8d5fdc
L_8d5fdc:
	push_s blink
L_8d5fde:
	bl L_8c02bc
L_8d5fe2:
	sub_s sp,sp,0x4
L_8d5fe4:
	mov_s r13,r0
L_8d5fe6:
	mov_s r14,0x0
L_8d5fe8:
	st_s r14,[r0,0x10]
L_8d5fea:
	st_s r14,[r0,0x14]
L_8d5fec:
	bl.d L_8ca168
L_8d5ff0:
	st_s r14,[r0,0xc]
L_8d5ff2:
	mov_s r1,r0
L_8d5ff4:
	mov_s r15,0x803e84
L_8d5ffa:
	bl.d L_8d0444
L_8d5ffe:
	ldb_s r0,[r15]
L_8d6000:
	bl L_8ca168
L_8d6004:
	bl.d L_8ca170
L_8d6008:
	mov_s r16,r0
L_8d600a:
	mov_s r2,r0
L_8d600c:
	ldb_s r0,[r15]
L_8d600e:
	bl.d L_8d0478
L_8d6012:
	mov_s r1,r16
L_8d6014:
	ld_s r0,[r13,0x8]
L_8d6016:
	ld_s r1,[sp,0x0]
L_8d6018:
	mov_s r2,r14
L_8d601a:
	ld_s r15,[r0,0x1c]
L_8d601c:
	mov_s r0,r13
L_8d601e:
	jl_s.d [r15]
L_8d6020:
	mov_s r3,r14
L_8d6022:
	b.d L_8c0324
L_8d6026:
	add_s sp,sp,0x4
