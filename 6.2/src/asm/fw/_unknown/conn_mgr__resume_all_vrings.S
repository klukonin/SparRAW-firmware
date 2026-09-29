/* conn_mgr__resume_all_vrings @ 0x8e2c2c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__system_state_evt_handler
 * Зовёт сам: __ld_r13_to_r13_ret, conn__arm_retry_timer, conn_mgr__by_cid, vring_schd__resume_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__resume_all_vrings
conn_mgr__resume_all_vrings:
	.global L_8e2c2c
L_8e2c2c:
	push_s blink
L_8e2c2e:
	push_s r13
L_8e2c30:
	mov_s r13,0x0
L_8e2c32:
	b_s L_8e2c5c
	.global L_8e2c34
L_8e2c34:
	bl.d L_8cbffc
L_8e2c38:
	mov_s r0,r13
L_8e2c3a:
	breq_s r0,0,L_8e2c5a
L_8e2c3c:
	ldb r1,[r0, 0xf0]
L_8e2c40:
	brne r1,0x2,L_8e2c5a
L_8e2c44:
	bl.d L_8e2cbc
L_8e2c48:
	add_s r0,r0,0x70
L_8e2c4a:
	mov_s r0,0x854080
L_8e2c50:
	add3_s r0,r0,r13
L_8e2c52:
	ld_s r0,[r0,0x4]
L_8e2c54:
	bl.d L_8e48d0
L_8e2c58:
	mov_s r1,0x1
	.global L_8e2c5a
L_8e2c5a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8e2c5c
L_8e2c5c:
	brlo r13,0x8,L_8e2c34
L_8e2c60:
	b L_8c025c
