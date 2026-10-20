/* l2mgr__arm_notify_timer @ 0x8dfbe8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__arm_ts_sync_timer, l2mgr__send_notify_req_done
 * Зовёт сам: __ld_r13_ret, u_schd__schedule
 */
	.section .text.l2mgr__arm_notify_timer,"ax",@progbits
	.global l2mgr__arm_notify_timer
l2mgr__arm_notify_timer:
	.global L_8dfbe8
L_8dfbe8:
	push_s blink
L_8dfbea:
	push_s r13
L_8dfbec:
	mov_s r13,r0
L_8dfbee:
	ld_s r0,[r0,0x44]
L_8dfbf0:
	breq_s r0,0,L_8dfc10
L_8dfbf2:
	ld_s r0,[r13,0x40]
L_8dfbf4:
	brne_s r0,0,L_8dfc10
L_8dfbf6:
	mov_s r0,0x1c7d0
L_8dfbfc:
	ld r4,[r13, 0x3c]
L_8dfc00:
	mov_s r1,r13
L_8dfc02:
	mov_s r2,0x0
L_8dfc04:
	mov_s r3,r2
L_8dfc06:
	mov_s r5,r2
L_8dfc08:
	bl.d L_8dc92c
L_8dfc0c:
	mov_s r6,r2
L_8dfc0e:
	st_s r0,[r13,0x40]
	.global L_8dfc10
L_8dfc10:
	b L_8c033c
