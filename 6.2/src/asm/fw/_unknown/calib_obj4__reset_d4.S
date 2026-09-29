/* calib_obj4__reset_d4 @ 0x8cbb90, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_exit, hwf_calib_all, if_gain, link_lost_diag__dump_all, lmac_if__send_cmd_0x16_calib_b4, phy_stats__dump, rf__restore_if_needed, silent_rssi__report_agc_tables, wmi_set_active_silent_rssi_table
 * Зовёт сам: calib_engine__get_by_index
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_obj4__reset_d4
calib_obj4__reset_d4:
	.global L_8cbb90
L_8cbb90:
	push_s blink
L_8cbb92:
	bl.d L_8cbb84
L_8cbb96:
	mov_s r0,0x4
L_8cbb98:
	mov_s r1,0x0
L_8cbb9a:
	st r1,[r0, 0xd4]
L_8cbb9e:
	mov_s r1,0x8042c8
L_8cbba4:
	ld r1,[r1,0x468]
L_8cbbac:
	brne r1,0x3,L_8cbbb6
L_8cbbb0:
	mov_s r1,0x3f
L_8cbbb2:
	st r1,[r0, 0xd4]
	.global L_8cbbb6
L_8cbbb6:
	pop_s blink
L_8cbbb8:
	j_s [blink]
L_8cbbba:
	nop_s
