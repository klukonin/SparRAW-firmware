/* hwd_mac__set_power_mode_map @ 0x8d0f40, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_modes__apply_power_mode
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_mac__set_power_mode_map
hwd_mac__set_power_mode_map:
	.global L_8d0f40
L_8d0f40:
	push_s blink
L_8d0f42:
	push_s r13
L_8d0f44:
	brhs.d r0,0x5,L_8d0f5c
L_8d0f48:
	mov_s r13,r0
L_8d0f4a:
	ldb.x r10,[0x803b60,r13]
L_8d0f52:
	add r0,pcl,0xc
L_8d0f56:
	add1 r0,r0,r10
L_8d0f5a:
	j_s [r0]
	.global L_8d0f5c
L_8d0f5c:
	mov_s r0,blink
L_8d0f5e:
	mov_s r1,0x12db
L_8d0f64:
	bl L_8c9b28
L_8d0f68:
	asl_s r1,r13,0x4
L_8d0f6a:
	or_s r1,r1,r13
L_8d0f6c:
	asl r0,r13,0x8
L_8d0f70:
	or_s r0,r0,r1
L_8d0f72:
	asl r1,r13,0xc
L_8d0f76:
	or_s r1,r1,r0
L_8d0f78:
	asl r0,r13,0x10
L_8d0f7c:
	or_s r0,r0,r1
L_8d0f7e:
	asl r1,r13,0x14
L_8d0f82:
	or_s r1,r1,r0
L_8d0f84:
	asl r0,r13,0x18
L_8d0f88:
	or_s r0,r0,r1
L_8d0f8a:
	asl_s r13,r13,0x1c
L_8d0f8c:
	or_s r0,r0,r13
L_8d0f8e:
	mov_s r1,0x886000
L_8d0f94:
	st r0,[r1, 0xfc]
L_8d0f98:
	mov_s r2,0x886100
L_8d0f9e:
	st_s r0,[r2]
L_8d0fa0:
	bmsk r1,r0,0x13
L_8d0fa4:
	st_s r1,[r2,0x4]
L_8d0fa6:
	st_s r0,[r2,0x8]
L_8d0fa8:
	st_s r0,[r2,0xc]
L_8d0faa:
	bmsk_s r0,r0,0x17
L_8d0fac:
	st_s r0,[r2,0x10]
L_8d0fae:
	b L_8c025c
L_8d0fb2:
	nop_s
