/* find_mngr__session_start @ 0x8e7ca0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: Start session.
 * Зовут его: start_find_session
 * Зовёт сам: __ld_r13_to_r13_ret, discovery__rx_start, find_mng__listen, fw_log_emit0, l2mgr__send_discovery_started
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mngr__session_start
find_mngr__session_start:
	.global L_8e7ca0
L_8e7ca0:
	push_s blink
L_8e7ca2:
	push_s r13
L_8e7ca4:
	mov_s r13,r0
L_8e7ca6:
	ld_s r0,[r0,0x40]
L_8e7ca8:
	brne_s r0,0,L_8e7cc8
L_8e7caa:
	mov_s r1,0x1017a60
L_8e7cb0:
	bl.d L_8dcba8
L_8e7cb4:
	mov_s r0,0x2c
L_8e7cb6:
	mov_s r0,0x1
L_8e7cb8:
	st_s r0,[r13,0x40]
L_8e7cba:
	bl.d L_8f80b8
L_8e7cbe:
	mov_s r0,0x0
L_8e7cc0:
	ld_s r0,[r13,0x48]
L_8e7cc2:
	bl.d L_8f88d4
L_8e7cc6:
	ldb_s r0,[r0,0x10]
	.global L_8e7cc8
L_8e7cc8:
	bl.d L_8dafa8
L_8e7ccc:
	mov_s r0,r13
L_8e7cce:
	b L_8c025c
L_8e7cd2:
	nop_s
