/* ba_setup_sm__close_ba_setup_global_timeout @ 0x8f1bfc, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::close_ba_setup_global_timeout() delete global flow TO.
 * Зовут его: ba__retry_flow, ba_setup_sm__addba_resp_timeout_cb, ba_setup_sm__close_all_timers
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_sysassert_fatal, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__close_ba_setup_global_timeout
ba_setup_sm__close_ba_setup_global_timeout:
	.global L_8f1bfc
L_8f1bfc:
	push_s blink
L_8f1bfe:
	push_s r13
L_8f1c00:
	mov_s r13,r0
L_8f1c02:
	mov_s r1,0x1013630
L_8f1c08:
	bl.d L_8dcba8
L_8f1c0c:
	mov_s r0,0x27
L_8f1c0e:
	ld_s r0,[r13,0x14]
L_8f1c10:
	breq_s r0,0,L_8f1c20
	.global L_8f1c12
L_8f1c12:
	bl.d L_8c8de0
L_8f1c16:
	ld_s r0,[r13,0x14]
L_8f1c18:
	mov_s r0,0x0
L_8f1c1a:
	b.d L_8c025c
L_8f1c1e:
	st_s r0,[r13,0x14]
	.global L_8f1c20
L_8f1c20:
	mov_s r0,blink
L_8f1c22:
	mov_s r1,0x12c6
L_8f1c28:
	bl L_8c9b28
L_8f1c2c:
	b_s L_8f1c12
L_8f1c2e:
	nop_s
