/* marlon_r_if_class__rf_configure_role_power @ 0x8de988, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rf_configure_role_power - NO RF on current platform!!!
 *   marlon_r_if_class::rf_configure_role_power: Failed to load board file COMMON_RF_SECTION
 * Зовут его: WBE_DRIVER__pcie_boot_init, power_deep_sleep_exit_step
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, marlon_r_if_class__load_brd_rf_cfg_section, rf__is_present
 */
	.section .text.marlon_r_if_class__rf_configure_role_power,"ax",@progbits
	.global marlon_r_if_class__rf_configure_role_power
marlon_r_if_class__rf_configure_role_power:
	.global L_8de988
L_8de988:
	push_s blink
L_8de98a:
	push_s r13
L_8de98c:
	bl.d L_8d750c
L_8de990:
	mov_s r13,r0
L_8de992:
	brne_s r0,0,L_8de9a0
L_8de994:
	mov_s r2,0x1005988
L_8de99a:
	mov_s r0,0x0
L_8de99c:
	mov_s r1,0x1
L_8de99e:
	b_s L_8de9b6
	.global L_8de9a0
L_8de9a0:
	mov_s r0,r13
L_8de9a2:
	mov_s r1,0x1
L_8de9a4:
	bl.d L_8d90a8
L_8de9a8:
	mov_s r2,0x80
L_8de9aa:
	brne_s r0,0,L_8de9ba
L_8de9ac:
	mov_s r2,0x10059c0
L_8de9b2:
	mov_s r0,0x0
L_8de9b4:
	mov_s r1,r0
	.global L_8de9b6
L_8de9b6:
	bl L_8edfb0
	.global L_8de9ba
L_8de9ba:
	.byte 0x85,0x01
