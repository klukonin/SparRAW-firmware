/* conn__cancel_retry_timer @ 0x8c5b30, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__arm_retry_timer, conn__disconnect, conn__teardown_mac_rules, conn_mgr__foreach_active_link
 * Зовёт сам: __ld_r13_ret, u_schd__cancel
 */
	.section .text.conn__cancel_retry_timer,"ax",@progbits
	.global conn__cancel_retry_timer
conn__cancel_retry_timer:
	.global L_8c5b30
L_8c5b30:
	push_s blink
L_8c5b32:
	push_s r13
L_8c5b34:
	mov_s r13,r0
L_8c5b36:
	ld_s r0,[r0,0x44]
L_8c5b38:
	breq_s r0,0,L_8c5b42
L_8c5b3a:
	bl L_8c7794
L_8c5b3e:
	mov_s r0,0x0
L_8c5b40:
	st_s r0,[r13,0x44]
	.global L_8c5b42
L_8c5b42:
	b L_8c033c
L_8c5b46:
	nop_s
