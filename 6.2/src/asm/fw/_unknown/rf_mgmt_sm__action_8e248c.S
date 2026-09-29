/* rf_mgmt_sm__action_8e248c @ 0x8e248c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: low_sme__send_rf_mgmt_status, rf_mgmt__set_state_flag
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_mgmt_sm__action_8e248c
rf_mgmt_sm__action_8e248c:
	.global L_8e248c
L_8e248c:
	push_s blink
L_8e248e:
	bl.d L_8eab30
L_8e2492:
	mov_s r0,0x0
L_8e2494:
	bl L_8e5ce0
L_8e2498:
	pop_s blink
L_8e249a:
	j_s [blink]
