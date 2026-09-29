/* conn__arm_retry_timer @ 0x8e48d0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__resume_all_vrings, connection__bf_notify_entry, lmac_if__abft_notify_evt
 * Зовёт сам: __ld_r13_to_r13_ret, conn__check_field_50, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__arm_retry_timer
conn__arm_retry_timer:
	.global L_8e48d0
L_8e48d0:
	push_s blink
L_8e48d2:
	push_s r13
L_8e48d4:
	mov_s r13,r0
L_8e48d6:
	mov_s r0,0x0
L_8e48d8:
	add3 r2,r13,0x8
L_8e48dc:
	brne r1,0x1,L_8e48e2
L_8e48e0:
	stb_s r0,[r2,0xd]
	.global L_8e48e2
L_8e48e2:
	ldb_s r0,[r2,0xd]
L_8e48e4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e48e6:
	extb_s r0,r0
L_8e48e8:
	stb_s r0,[r2,0xd]
L_8e48ea:
	bl.d L_8c68d4
L_8e48ee:
	mov_s r0,r13
L_8e48f0:
	mov_s r0,0x2754c
L_8e48f6:
	ld.as r4,[gp,-0x5e]
L_8e48fa:
	mov_s r1,r13
L_8e48fc:
	mov_s r2,0x0
L_8e48fe:
	mov_s r3,r2
L_8e4900:
	mov_s r5,r2
L_8e4902:
	bl.d L_8e0c0c
L_8e4906:
	mov_s r6,r2
L_8e4908:
	b.d L_8c025c
L_8e490c:
	st_s r0,[r13,0x50]
L_8e490e:
	nop_s
