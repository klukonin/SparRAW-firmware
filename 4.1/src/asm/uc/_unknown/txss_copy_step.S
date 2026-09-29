/* txss_copy_step @ 0x930f44, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss__flow_body, txss__prepare_frames, txss_flow_step_b, txss_rx_step
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, memcpy_uc
 */
	.section .text.txss_copy_step,"ax",@progbits
	.global txss_copy_step
txss_copy_step:
	.global L_930f44
L_930f44:
	push_s blink
L_930f46:
	bl L_92020c
L_930f4a:
	mov_s r13,0x800fcc
L_930f50:
	ld_s r0,[r13,0x48]
L_930f52:
	mov_s r2,0x8010d0
L_930f58:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_930f5a:
	add1_s r0,r0,r0
L_930f5c:
	add_s r0,r0,r13
L_930f5e:
	ld_s r3,[r0,0x10]
L_930f60:
	ld_s r1,[r2,0x4]
L_930f62:
	brlo.d r1,r3,L_930fc0
L_930f66:
	add r16,r13,0x10
L_930f6a:
	add_s r0,r0,0xc
L_930f6c:
	mov_s r1,r2
L_930f6e:
	bl.d L_920310
L_930f72:
	mov_s r2,0xc
L_930f74:
	mov_s r0,0x1
L_930f76:
	mov_s r3,0x0
L_930f78:
	b_s L_930f7e
	.global L_930f7a
L_930f7a:
	mov_s r0,r4
	.global L_930f7c
L_930f7c:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_930f7e
L_930f7e:
	brge r3,0x4,L_930fae
L_930f82:
	brne r0,0x1,L_930fae
L_930f86:
	add2 r2,r13,r3
L_930f8a:
	ld_s r14,[r2,0x48]
L_930f8c:
	ld_s r1,[r2,0x4c]
L_930f8e:
	asl_s r0,r14,0x2
L_930f90:
	asl_s r15,r1,0x2
L_930f92:
	add1_s r0,r0,r0
L_930f94:
	add1_s r15,r15,r15
L_930f96:
	ld r0,[r16,r0]
L_930f9a:
	ld r15,[r16,r15]
L_930f9e:
	brlo.d r0,r15,L_930f7a
L_930fa2:
	mov r4,0x0
L_930fa6:
	st_s r1,[r2,0x48]
L_930fa8:
	st_s r14,[r2,0x4c]
L_930faa:
	mov_s r0,0x1
L_930fac:
	b_s L_930f7c
	.global L_930fae
L_930fae:
	ld_s r0,[r13,0x58]
L_930fb0:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_930fb2:
	add1_s r0,r0,r0
L_930fb4:
	add_s r1,r13,r0
L_930fb6:
	mov_s r0,r13
L_930fb8:
	add_s r1,r1,0xc
L_930fba:
	bl.d L_920310
L_930fbe:
	mov_s r2,0xc
	.global L_930fc0
L_930fc0:
	b L_920274
