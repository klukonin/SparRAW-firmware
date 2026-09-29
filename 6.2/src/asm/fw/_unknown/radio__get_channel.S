/* radio__get_channel @ 0x8cc13c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__deep_sleep_exit, POWER_MNGR__halt, hw_modes__program_rf_clocks, hw_sysapi__set_freq_ratio, hwm_analog_select_active_rf_module, rf__restore_if_needed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global radio__get_channel
radio__get_channel:
	.global L_8cc13c
L_8cc13c:
	ld r0,[r0,0x460]
L_8cc144:
	j_s [blink]
L_8cc146:
	nop_s
	.global L_8cc148
L_8cc148:
	j_s.d [blink]
L_8cc14a:
	ldb r0,[r0, 0x90]
L_8cc14e:
	nop_s
L_8cc150:
	b.d L_8cc148
L_8cc154:
	add_s r0,r0,0x28
L_8cc156:
	nop_s
