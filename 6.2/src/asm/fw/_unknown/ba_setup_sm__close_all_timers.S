/* ba_setup_sm__close_all_timers @ 0x8f1b84, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_setup_sm__action_8f0c54, ba_setup_sm__action_8f7fdc
 * Зовёт сам: __ld_r13_to_r13_ret, ba_setup_sm__close_addba_req_retry_timeout_event, ba_setup_sm__close_addba_resp_timeout, ba_setup_sm__close_ba_setup_global_timeout
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__close_all_timers
ba_setup_sm__close_all_timers:
	.global L_8f1b84
L_8f1b84:
	push_s blink
L_8f1b86:
	push_s r13
L_8f1b88:
	mov_s r13,r0
L_8f1b8a:
	ld_s r0,[r0,0xc]
L_8f1b8c:
	cmp_s r0,0x0
L_8f1b8e:
	bl.ne.d L_8f1bd8
L_8f1b92:
	mov.ne r0,r13
L_8f1b96:
	ld_s r0,[r13,0x14]
L_8f1b98:
	cmp_s r0,0x0
L_8f1b9a:
	bl.ne.d L_8f1bfc
L_8f1b9e:
	mov.ne r0,r13
L_8f1ba2:
	ld_s r0,[r13,0x10]
L_8f1ba4:
	cmp_s r0,0x0
L_8f1ba6:
	bl.ne.d L_8f1bb4
L_8f1baa:
	mov.ne r0,r13
L_8f1bae:
	b L_8c025c
L_8f1bb2:
	nop_s
