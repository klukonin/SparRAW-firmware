/* ba_setup_sm__close_addba_req_retry_timeout_event @ 0x8f1bb4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::close_addba_req_retry_timeout_event delete event.
 * Зовут его: ba_setup_sm__close_all_timers
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__close_addba_req_retry_timeout_event
ba_setup_sm__close_addba_req_retry_timeout_event:
	.global L_8f1bb4
L_8f1bb4:
	push_s blink
L_8f1bb6:
	push_s r13
L_8f1bb8:
	mov_s r13,r0
L_8f1bba:
	ld_s r0,[r0,0x10]
L_8f1bbc:
	breq_s r0,0,L_8f1bd0
L_8f1bbe:
	mov_s r1,0x1013674
L_8f1bc4:
	bl.d L_8dcba8
L_8f1bc8:
	mov_s r0,0x27
L_8f1bca:
	bl.d L_8c8de0
L_8f1bce:
	ld_s r0,[r13,0x10]
	.global L_8f1bd0
L_8f1bd0:
	mov_s r0,0x0
L_8f1bd2:
	b.d L_8c025c
L_8f1bd6:
	st_s r0,[r13,0x10]
