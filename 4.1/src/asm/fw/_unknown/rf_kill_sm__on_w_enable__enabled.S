/* rf_kill_sm__on_w_enable__enabled @ 0x8efc68, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: low_sme__send_rf_mgmt_status, rf_kill__set_flag
 */
	.section .text.rf_kill_sm__on_w_enable__enabled,"ax",@progbits
	.global rf_kill_sm__on_w_enable__enabled
rf_kill_sm__on_w_enable__enabled:
L_8efc68:
	push_s blink
L_8efc6a:
	bl.d L_8f2948
L_8efc6e:
	mov_s r0,0x0
L_8efc70:
	bl L_8e1048
L_8efc74:
	pop_s blink
L_8efc76:
	j_s [blink]
