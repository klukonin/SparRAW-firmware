/* rf_utils__fill_default_patterns @ 0x8d9a54, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: marlon_r_if_class__config_channel
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, memcpy_fw, rf_utils_auto_fill, rf_utils_auto_fill_set_pattern
 * Глобалы (через gp): 0x800243
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_utils__fill_default_patterns
rf_utils__fill_default_patterns:
	.global L_8d9a54
L_8d9a54:
	push_s blink
L_8d9a56:
	bl L_8c01e0
L_8d9a5a:
	ld_s r0,[r0,0x58]
L_8d9a5c:
	mov_s r15,0x801fa4
L_8d9a62:
	ld_s r1,[r0,0x44]
L_8d9a64:
	ld_s r1,[r1,0x18]
L_8d9a66:
	jl_s.d [r1]
L_8d9a68:
	sub_s sp,sp,0x28
L_8d9a6a:
	mov_s r13,sp
L_8d9a6c:
	mov_s r0,r13
L_8d9a6e:
	add3 r1,r15,0x9
L_8d9a72:
	bl.d L_8c0380
L_8d9a76:
	mov_s r2,0x18
L_8d9a78:
	add_s r14,sp,0x18
L_8d9a7a:
	mov_s r0,r14
L_8d9a7c:
	add3 r1,r15,0xc
L_8d9a80:
	bl.d L_8c0380
L_8d9a84:
	mov_s r2,0x10
L_8d9a86:
	ldb_s r0,[gp,0xbf]
L_8d9a88:
	st_s r13,[sp,0x1c]
L_8d9a8a:
	stb_s r0,[sp,0x18]
L_8d9a8c:
	mov_s r0,r14
L_8d9a8e:
	mov_s r15,0x1
L_8d9a90:
	bl.d L_8e3060
L_8d9a94:
	mov_s r1,r15
L_8d9a96:
	stb r15,[sp, 0x19]
L_8d9a9a:
	mov_s r0,0x0
L_8d9a9c:
	stb r0,[sp, 0x1a]
L_8d9aa0:
	mov_s r0,0x7f
L_8d9aa2:
	stb r0,[sp, 0x1b]
L_8d9aa6:
	st_s r13,[sp,0x1c]
L_8d9aa8:
	mov_s r0,r14
L_8d9aaa:
	bl.d L_8e3060
L_8d9aae:
	mov_s r1,r15
L_8d9ab0:
	st_s r13,[sp,0x1c]
L_8d9ab2:
	st 0x3f000000,[sp, 0x14]
L_8d9aba:
	bl.d L_8e3268
L_8d9abe:
	mov_s r0,r14
L_8d9ac0:
	b.d L_8c024c
L_8d9ac4:
	add_s sp,sp,0x28
L_8d9ac6:
	nop_s
