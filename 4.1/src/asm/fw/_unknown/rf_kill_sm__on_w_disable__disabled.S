/* rf_kill_sm__on_w_disable__disabled @ 0x8efc58, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: low_sme__send_rf_mgmt_status, rf_kill__set_flag
 */
	.section .text.rf_kill_sm__on_w_disable__disabled,"ax",@progbits
	.global rf_kill_sm__on_w_disable__disabled
rf_kill_sm__on_w_disable__disabled:
L_8efc58:
	push_s blink
L_8efc5a:
	bl.d L_8f2948
L_8efc5e:
	mov_s r0,0x1
L_8efc60:
	bl L_8e1048
L_8efc64:
	pop_s blink
L_8efc66:
	j_s [blink]
