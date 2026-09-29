/* edca__fill_ac_table_by_mode @ 0x8dc28c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_send_cmd_0x04
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global edca__fill_ac_table_by_mode
edca__fill_ac_table_by_mode:
	.global L_8dc28c
L_8dc28c:
	push_s blink
L_8dc28e:
	bl L_8c01e4
L_8dc292:
	mov_s r14,r0
L_8dc294:
	mov_s r13,0x0
L_8dc296:
	breq_s r1,0,L_8dc2ac
L_8dc298:
	breq r1,0x1,L_8dc2b4
L_8dc29c:
	breq r1,0x2,L_8dc2bc
L_8dc2a0:
	mov_s r0,blink
L_8dc2a2:
	mov_s r1,0xcd
L_8dc2a4:
	bl.d L_8c9b28
L_8dc2a8:
	bset_s r1,r1,0xc
L_8dc2aa:
	b_s L_8dc2c2
	.global L_8dc2ac
L_8dc2ac:
	mov_s r13,0x800c00
L_8dc2b2:
	b_s L_8dc2c2
	.global L_8dc2b4
L_8dc2b4:
	mov_s r13,0x800c04
L_8dc2ba:
	b_s L_8dc2c2
	.global L_8dc2bc
L_8dc2bc:
	mov_s r13,0x800c08
	.global L_8dc2c2
L_8dc2c2:
	mov_s r1,0x0
L_8dc2c4:
	b_s L_8dc2ee
	.global L_8dc2c6
L_8dc2c6:
	asl_s r2,r1,0x2
L_8dc2c8:
	add1_s r2,r2,r2
L_8dc2ca:
	add_s r2,r2,r14
L_8dc2cc:
	st_s r1,[r2]
L_8dc2ce:
	ldw_s r0,[r13]
L_8dc2d0:
	brne_s r1,0,L_8dc2d8
L_8dc2d2:
	min r0,r0,0x4
L_8dc2d6:
	extw_s r0,r0
	.global L_8dc2d8
L_8dc2d8:
	stw_s r0,[r2,0x4]
L_8dc2da:
	ld_s r3,[r2]
L_8dc2dc:
	ldw_s r0,[r13,0x2]
L_8dc2de:
	brne_s r3,0,L_8dc2e6
L_8dc2e0:
	min r0,r0,0x4
L_8dc2e4:
	extw_s r0,r0
	.global L_8dc2e6
L_8dc2e6:
	stw_s r0,[r2,0x6]
L_8dc2e8:
	mov_s r0,0x3
L_8dc2ea:
	stw_s r0,[r2,0x8]
L_8dc2ec:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8dc2ee
L_8dc2ee:
	brlt r1,0x4,L_8dc2c6
L_8dc2f2:
	b L_8c0254
L_8dc2f6:
	nop_s
