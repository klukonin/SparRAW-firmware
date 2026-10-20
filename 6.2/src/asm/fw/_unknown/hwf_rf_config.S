/* hwf_rf_config @ 0x8d6f30, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_config: channel is %d
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler, hwm_analog_select_active_rf_module
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, marlon_r_if_class__config_channel, marlon_r_if_class__rf_configure_role_power
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_config
hwf_rf_config:
	.global L_8d6f30
L_8d6f30:
	push_s blink
L_8d6f32:
	bl L_8c01e4
L_8d6f36:
	mov_s r13,r0
L_8d6f38:
	mov_s r1,0x101b3c4
L_8d6f3e:
	mov_s r0,0x21
L_8d6f40:
	bl.d L_8dcc10
L_8d6f44:
	mov_s r2,r13
L_8d6f46:
	mov_s r14,0x8042c8
L_8d6f4c:
	bl.d L_8e2e88
L_8d6f50:
	mov_s r0,r14
L_8d6f52:
	cmp_s r13,0x4
L_8d6f54:
	mov.cs r0,r14
L_8d6f58:
	mov.cs r1,r13
L_8d6f5c:
	bl.cs.d L_8c6d00
L_8d6f60:
	mov.cs r2,0x1
L_8d6f64:
	b L_8c0254
