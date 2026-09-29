/* ba_setup_sm__close_addba_resp_timeout @ 0x8f1bd8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::close_addba_resp_timeout() delete addba resp pending TO.
 * Зовут его: ba_setup_sm__addba_resp_timeout_cb, ba_setup_sm__close_all_timers, mlme_sm__association_timeout_ev_handle
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__close_addba_resp_timeout
ba_setup_sm__close_addba_resp_timeout:
	.global L_8f1bd8
L_8f1bd8:
	push_s blink
L_8f1bda:
	push_s r13
L_8f1bdc:
	mov_s r13,r0
L_8f1bde:
	ld_s r0,[r0,0xc]
L_8f1be0:
	breq_s r0,0,L_8f1bf4
L_8f1be2:
	mov_s r1,0x10135e8
L_8f1be8:
	bl.d L_8dcba8
L_8f1bec:
	mov_s r0,0x27
L_8f1bee:
	bl.d L_8c8de0
L_8f1bf2:
	ld_s r0,[r13,0xc]
	.global L_8f1bf4
L_8f1bf4:
	mov_s r0,0x0
L_8f1bf6:
	b.d L_8c025c
L_8f1bfa:
	st_s r0,[r13,0xc]
