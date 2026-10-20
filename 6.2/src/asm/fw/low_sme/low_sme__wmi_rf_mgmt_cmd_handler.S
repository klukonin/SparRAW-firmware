/* low_sme__wmi_rf_mgmt_cmd_handler @ 0x8ec9e8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   low_sme::wmi_rf_mgmt_cmd_handler (cmd->rf_mgmt_type=%d)
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit1, fw_sysassert_fatal, low_sme__send_rf_mgmt_status
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global low_sme__wmi_rf_mgmt_cmd_handler
low_sme__wmi_rf_mgmt_cmd_handler:
	.global L_8ec9e8
L_8ec9e8:
	push_s blink
L_8ec9ea:
	push_s r13
L_8ec9ec:
	mov_s r13,r0
L_8ec9ee:
	mov_s r1,0x100b79c
L_8ec9f4:
	mov_s r0,0x20
L_8ec9f6:
	bl.d L_8dcc10
L_8ec9fa:
	ld_s r2,[r13]
L_8ec9fc:
	ld_s r0,[r13]
L_8ec9fe:
	breq_s r0,0,L_8eca14
L_8eca00:
	breq r0,0x1,L_8eca28
L_8eca04:
	breq r0,0x2,L_8eca34
L_8eca08:
	mov_s r0,blink
L_8eca0a:
	mov_s r1,0x7c
L_8eca0c:
	bl.d L_8c9b28
L_8eca10:
	bset_s r1,r1,0xc
L_8eca12:
	b_s L_8eca38
	.global L_8eca14
L_8eca14:
	mov_s r0,0x804c34
L_8eca1a:
	mov_s r1,0x1
L_8eca1c:
	mov_s r2,r1
	.global L_8eca1e
L_8eca1e:
	mov_s r3,0x0
L_8eca20:
	bl.d L_8d9b6c
L_8eca24:
	mov_s r4,r3
L_8eca26:
	b_s L_8eca38
	.global L_8eca28
L_8eca28:
	mov_s r0,0x804c34
L_8eca2e:
	mov_s r1,0x0
L_8eca30:
	mov_s r2,0x1
L_8eca32:
	b_s L_8eca1e
	.global L_8eca34
L_8eca34:
	bl L_8e5ce0
	.global L_8eca38
L_8eca38:
	b L_8c025c
