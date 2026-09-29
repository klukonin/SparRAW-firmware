/* rf_mgmt_sm__action_8e247c @ 0x8e247c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: low_sme__send_rf_mgmt_status, rf_mgmt__set_state_flag
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_mgmt_sm__action_8e247c
rf_mgmt_sm__action_8e247c:
	.global L_8e247c
L_8e247c:
	push_s blink
L_8e247e:
	bl.d L_8eab30
L_8e2482:
	mov_s r0,0x1
L_8e2484:
	bl L_8e5ce0
L_8e2488:
	pop_s blink
L_8e248a:
	j_s [blink]
