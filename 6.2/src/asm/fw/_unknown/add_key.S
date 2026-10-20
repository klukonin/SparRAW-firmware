/* add_key @ 0x8d0edc, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   In the add_key function. KEY[0]ADDRESS: %x
 * Зовут его: key__install_by_type
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global add_key
add_key:
	.global L_8d0edc
L_8d0edc:
	push_s blink
L_8d0ede:
	bl.d L_8c01e4
L_8d0ee2:
	mov_s r2,r0
L_8d0ee4:
	sub_s sp,sp,0x10
L_8d0ee6:
	mov_s r13,r1
L_8d0ee8:
	mov_s r0,sp
L_8d0eea:
	mov_s r1,r2
L_8d0eec:
	bl.d L_8c0380
L_8d0ef0:
	mov_s r2,0x10
L_8d0ef2:
	ld_s r0,[sp,0x0]
L_8d0ef4:
	mov_s r14,0x886000
L_8d0efa:
	st_s r0,[r14,0x38]
L_8d0efc:
	ld_s r0,[sp,0x4]
L_8d0efe:
	mov_s r1,0x101f778
L_8d0f04:
	st_s r0,[r14,0x3c]
L_8d0f06:
	ld_s r0,[sp,0x8]
L_8d0f08:
	st_s r0,[r14,0x40]
L_8d0f0a:
	ld_s r0,[sp,0xc]
L_8d0f0c:
	st_s r0,[r14,0x44]
L_8d0f0e:
	st_s r13,[r14,0x34]
L_8d0f10:
	mov_s r0,0x20
L_8d0f12:
	st 0x80000000,[r14, 0x30]
L_8d0f1a:
	st 0x40000000,[r14, 0x2c]
L_8d0f22:
	bl.d L_8dcc10
L_8d0f26:
	mov_s r2,r13
L_8d0f28:
	mov_s r1,0x0
L_8d0f2a:
	ld r0,[r14, 0xd8]
L_8d0f2e:
	bset r1,r1,r13
L_8d0f32:
	bic_s r0,r0,r1
L_8d0f34:
	or_s r0,r0,r1
L_8d0f36:
	st r0,[r14, 0xd8]
L_8d0f3a:
	b.d L_8c0254
L_8d0f3e:
	add_s sp,sp,0x10
