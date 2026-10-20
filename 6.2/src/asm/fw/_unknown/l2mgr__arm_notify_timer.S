/* l2mgr__arm_notify_timer @ 0x8e48a4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__periodic_notif_handler, rx_mgmt_prs__alloc_ei
 * Зовёт сам: __ld_r13_to_r13_ret, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__arm_notify_timer
l2mgr__arm_notify_timer:
	.global L_8e48a4
L_8e48a4:
	push_s blink
L_8e48a6:
	push_s r13
L_8e48a8:
	mov_s r13,r0
L_8e48aa:
	ld_s r0,[r0,0x78]
L_8e48ac:
	breq_s r0,0,L_8e48cc
L_8e48ae:
	ld_s r0,[r13,0x74]
L_8e48b0:
	brne_s r0,0,L_8e48cc
L_8e48b2:
	mov_s r0,L_8e0a20-0x8c0000
L_8e48b8:
	ld r4,[r13, 0x70]
L_8e48bc:
	mov_s r1,r13
L_8e48be:
	mov_s r2,0x0
L_8e48c0:
	mov_s r3,r2
L_8e48c2:
	mov_s r5,r2
L_8e48c4:
	bl.d L_8e0c0c
L_8e48c8:
	mov_s r6,r2
L_8e48ca:
	st_s r0,[r13,0x74]
	.global L_8e48cc
L_8e48cc:
	b L_8c025c
