/* conn__check_field_50 @ 0x8c68d4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__arm_retry_timer, conn__disconnect, conn__teardown_mac_rules, conn_mgr__rearm_all_detectors
 * Зовёт сам: __ld_r13_to_r13_ret, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__check_field_50
conn__check_field_50:
	.global L_8c68d4
L_8c68d4:
	push_s blink
L_8c68d6:
	push_s r13
L_8c68d8:
	mov_s r13,r0
L_8c68da:
	ld_s r0,[r0,0x50]
L_8c68dc:
	breq_s r0,0,L_8c68e6
L_8c68de:
	bl L_8c8de0
L_8c68e2:
	mov_s r0,0x0
L_8c68e4:
	st_s r0,[r13,0x50]
	.global L_8c68e6
L_8c68e6:
	b L_8c025c
L_8c68ea:
	nop_s
