/* ba_setup_sm__addba_session_success_ntf @ 0x8f0c70, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::addba_session_success_ntf() : m_wsize_actual=%d
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__addba_session_success_ntf
ba_setup_sm__addba_session_success_ntf:
	.global L_8f0c70
L_8f0c70:
	push_s blink
L_8f0c72:
	push_s r13
L_8f0c74:
	mov_s r13,r0
L_8f0c76:
	mov_s r1,0x10136f4
L_8f0c7c:
	mov_s r0,0x25
L_8f0c7e:
	bl.d L_8dcc10
L_8f0c82:
	ldb_s r2,[r13,0x19]
L_8f0c84:
	mov_s r2,0x0
L_8f0c86:
	ld_s r0,[r13,0x20]
L_8f0c88:
	mov_s r1,0x7
L_8f0c8a:
	mov_s r3,r2
L_8f0c8c:
	bl.d L_8d9b6c
L_8f0c90:
	mov_s r4,r2
L_8f0c92:
	b L_8c025c
L_8f0c96:
	nop_s
