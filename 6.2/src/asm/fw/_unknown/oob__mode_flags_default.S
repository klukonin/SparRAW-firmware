/* oob__mode_flags_default @ 0x8ccaf0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__get_status_hal, host_if__hw_ready_for_wmi, low_sme__send_rf_mgmt_status
 * Зовёт сам: oob__mode_flags
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global oob__mode_flags_default
oob__mode_flags_default:
	.global L_8ccaf0
L_8ccaf0:
	mov_s r0,0x804c34
L_8ccaf6:
	b L_8ccac8
L_8ccafa:
	nop_s
