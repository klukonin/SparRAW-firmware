/* conn_mgr__foreach_link_arm_timer @ 0x8de794, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__system_state_evt_handler
 * Зовёт сам: __ld_r13_ret, conn__arm_retry_timer, conn_mgr__by_cid, lm_if__inject_evt_b
 */
	.section .text.conn_mgr__foreach_link_arm_timer,"ax",@progbits
	.global conn_mgr__foreach_link_arm_timer
conn_mgr__foreach_link_arm_timer:
	.global L_8de794
L_8de794:
	push_s blink
L_8de796:
	push_s r13
L_8de798:
	mov_s r13,0x0
L_8de79a:
	b_s L_8de7c4
	.global L_8de79c
L_8de79c:
	bl.d L_8c9e44
L_8de7a0:
	mov_s r0,r13
L_8de7a2:
	breq_s r0,0,L_8de7c2
L_8de7a4:
	ldb r1,[r0, 0xb0]
L_8de7a8:
	brne r1,0x2,L_8de7c2
L_8de7ac:
	bl.d L_8de824
L_8de7b0:
	add_s r0,r0,0x64
L_8de7b2:
	mov_s r0,0x80469c
L_8de7b8:
	add3_s r0,r0,r13
L_8de7ba:
	ld_s r0,[r0,0x4]
L_8de7bc:
	bl.d L_8dfc14
L_8de7c0:
	mov_s r1,0x1
	.global L_8de7c2
L_8de7c2:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8de7c4
L_8de7c4:
	brlo r13,0x8,L_8de79c
L_8de7c8:
	b L_8c033c
