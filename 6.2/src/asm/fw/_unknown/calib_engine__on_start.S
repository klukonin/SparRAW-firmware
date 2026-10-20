/* calib_engine__on_start @ 0x8c9d2c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, basic_calib_sparrow__estimation_alg, fw_sysassert_fatal, sm__defer_call, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__on_start
calib_engine__on_start:
	.global L_8c9d2c
L_8c9d2c:
	push_s blink
L_8c9d2e:
	push_s r13
L_8c9d30:
	bl.d L_8e9524
L_8c9d34:
	mov_s r13,r0
L_8c9d36:
	ld_s r0,[r13,0x8]
L_8c9d38:
	add r2,r13,0x38
L_8c9d3c:
	bl.d L_8c9da0
L_8c9d40:
	ld_s r1,[r13,0x10]
L_8c9d42:
	breq_s r0,0,L_8c9d4e
L_8c9d44:
	ld_s r0,[r13,0x40]
L_8c9d46:
	cmp r0,-0x1
L_8c9d4a:
	beq_s L_8c9d4e
L_8c9d4c:
	st_s r0,[r13,0x1c]
	.global L_8c9d4e
L_8c9d4e:
	ld_s r1,[r13,0xc]
L_8c9d50:
	add_s r1,r1,r1
L_8c9d52:
	add2_s r1,r1,r1
L_8c9d54:
	add_s r1,r1,0x8538c0
L_8c9d5a:
	ldw_s r0,[r1,0x14]
L_8c9d5c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c9d5e:
	extw_s r0,r0
L_8c9d60:
	stw_s r0,[r1,0x14]
L_8c9d62:
	ld_s r1,[r13,0x38]
L_8c9d64:
	brne r1,0x1,L_8c9d78
L_8c9d68:
	mov_s r0,r13
L_8c9d6a:
	mov_s r1,0x4
	.global L_8c9d6c
L_8c9d6c:
	mov_s r2,0x0
L_8c9d6e:
	mov_s r3,r2
L_8c9d70:
	bl.d L_8e7044
L_8c9d74:
	mov_s r4,r2
L_8c9d76:
	b_s L_8c9d9c
	.global L_8c9d78
L_8c9d78:
	breq r1,0x2,L_8c9d80
L_8c9d7c:
	ld_s r0,[r13,0x14]
L_8c9d7e:
	brne_s r0,0,L_8c9d86
	.global L_8c9d80
L_8c9d80:
	mov_s r0,r13
L_8c9d82:
	mov_s r1,0x1
L_8c9d84:
	b_s L_8c9d6c
	.global L_8c9d86
L_8c9d86:
	cmp_s r1,0x3
L_8c9d88:
	mov.eq r0,r13
L_8c9d8c:
	mov_s r1,0x2
L_8c9d8e:
	beq_s L_8c9d6c
L_8c9d90:
	mov_s r0,blink
L_8c9d92:
	mov_s r1,0x12e6
L_8c9d98:
	bl L_8c9b28
	.global L_8c9d9c
L_8c9d9c:
	b L_8c025c
