/* conn__arm_retry_timer @ 0x8dfc14, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__arm_all_retry_timers, conn_mgr__foreach_link_arm_timer, lmac_if__abft_notify_evt
 * Зовёт сам: __ld_r13_ret, conn__cancel_retry_timer, u_schd__schedule
 */
	.section .text.conn__arm_retry_timer,"ax",@progbits
	.global conn__arm_retry_timer
conn__arm_retry_timer:
	.global L_8dfc14
L_8dfc14:
	push_s blink
L_8dfc16:
	push_s r13
L_8dfc18:
	mov_s r13,r0
L_8dfc1a:
	mov_s r0,0x0
L_8dfc1c:
	add3 r2,r13,0x8
L_8dfc20:
	brne r1,0x1,L_8dfc26
L_8dfc24:
	stb_s r0,[r2,0x1]
	.global L_8dfc26
L_8dfc26:
	ldb_s r0,[r2,0x1]
L_8dfc28:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8dfc2a:
	extb_s r0,r0
L_8dfc2c:
	stb_s r0,[r2,0x1]
L_8dfc2e:
	bl.d L_8c5b30
L_8dfc32:
	mov_s r0,r13
L_8dfc34:
	mov_s r0,0x2238c
L_8dfc3a:
	ld.as r4,[gp,-0x57]
L_8dfc3e:
	mov_s r1,r13
L_8dfc40:
	mov_s r2,0x0
L_8dfc42:
	mov_s r3,r2
L_8dfc44:
	mov_s r5,r2
L_8dfc46:
	bl.d L_8dc92c
L_8dfc4a:
	mov_s r6,r2
L_8dfc4c:
	b.d L_8c033c
L_8dfc50:
	st_s r0,[r13,0x44]
L_8dfc52:
	nop_s
