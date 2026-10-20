/* calib_engine__on_frag_done @ 0x8c5f78, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, radio_mgr__call_method_10, sm__defer_call, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__on_frag_done
calib_engine__on_frag_done:
	.global L_8c5f78
L_8c5f78:
	push_s blink
L_8c5f7a:
	push_s r13
L_8c5f7c:
	mov_s r13,r0
L_8c5f7e:
	ld_s r0,[r0,0x24]
L_8c5f80:
	breq_s r0,0,L_8c5f8a
L_8c5f82:
	bl L_8ea800
L_8c5f86:
	mov_s r0,0x0
L_8c5f88:
	st_s r0,[r13,0x24]
	.global L_8c5f8a
L_8c5f8a:
	ld_s r1,[r13,0x18]
L_8c5f8c:
	ld_s r0,[r13,0x1c]
L_8c5f8e:
	brne r1,r0,L_8c5fb6
L_8c5f92:
	ld_s r1,[r13,0xc]
L_8c5f94:
	mov_s r2,0x0
L_8c5f96:
	add_s r1,r1,r1
L_8c5f98:
	add2_s r1,r1,r1
L_8c5f9a:
	add_s r1,r1,0x8538c0
L_8c5fa0:
	ldw_s r0,[r1,0x16]
L_8c5fa2:
	mov_s r3,r2
L_8c5fa4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c5fa6:
	extw_s r0,r0
L_8c5fa8:
	stw_s r0,[r1,0x16]
L_8c5faa:
	mov_s r0,r13
L_8c5fac:
	mov_s r1,0x4
L_8c5fae:
	bl.d L_8e7044
L_8c5fb2:
	mov_s r4,r2
L_8c5fb4:
	b_s L_8c600c
	.global L_8c5fb6
L_8c5fb6:
	ld_s r0,[r13,0x38]
L_8c5fb8:
	brne r0,0x3,L_8c6000
L_8c5fbc:
	breq_s r1,0,L_8c5fe4
	.global L_8c5fbe
L_8c5fbe:
	ld_s r0,[r13,0x28]
L_8c5fc0:
	brne_s r0,0,L_8c5ff2
	.global L_8c5fc2
L_8c5fc2:
	ldw_s r1,[r13,0x20]
L_8c5fc4:
	mov_s r0,0x19c1c
L_8c5fca:
	mul64 r1,0x3e8
L_8c5fce:
	mov_s r2,0x0
L_8c5fd0:
	mov_s r1,r13
L_8c5fd2:
	mov_s r3,r2
L_8c5fd4:
	mov r4,mlo
L_8c5fd8:
	mov_s r5,r2
L_8c5fda:
	bl.d L_8e0c0c
L_8c5fde:
	mov_s r6,r2
L_8c5fe0:
	st_s r0,[r13,0x28]
L_8c5fe2:
	b_s L_8c600c
	.global L_8c5fe4
L_8c5fe4:
	mov_s r0,blink
L_8c5fe6:
	mov_s r1,0x1206
L_8c5fec:
	bl L_8c9b28
L_8c5ff0:
	b_s L_8c5fbe
	.global L_8c5ff2
L_8c5ff2:
	mov_s r0,blink
L_8c5ff4:
	mov_s r1,0x1209
L_8c5ffa:
	bl L_8c9b28
L_8c5ffe:
	b_s L_8c5fc2
	.global L_8c6000
L_8c6000:
	mov_s r0,blink
L_8c6002:
	mov_s r1,0x12e5
L_8c6008:
	bl L_8c9b28
	.global L_8c600c
L_8c600c:
	b L_8c025c
