/* stop_find_session @ 0x8f9b48, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stop_find_session()
 * Зовут его: l2_mgr__scan_abort, l2mgr__stop_discovery
 * Зовёт сам: __ld_r13_to_r13_ret, find_mngr__stop, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stop_find_session
stop_find_session:
	.global L_8f9b48
L_8f9b48:
	push_s blink
L_8f9b4a:
	push_s r13
L_8f9b4c:
	mov_s r13,r0
L_8f9b4e:
	mov_s r1,0x1017004
L_8f9b54:
	bl.d L_8dcba8
L_8f9b58:
	mov_s r0,0x2c
L_8f9b5a:
	bl.d L_8e7efc
L_8f9b5e:
	add r0,r13,0xc
L_8f9b62:
	b L_8c025c
L_8f9b66:
	nop_s
