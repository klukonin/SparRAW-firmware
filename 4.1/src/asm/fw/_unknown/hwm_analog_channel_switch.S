/* hwm_analog_channel_switch @ 0x8d4b3c, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    ====== hwm_ANALOG_CHANNEL_SWITCH  channel_num[1..4]=%d ======
 * Зовут его: UT_HW_MODES_cmd_handler, calib_mngr__switch_channel
 * Зовёт сам: __ld_r13_ret, abif__program_rf_clock_and_wait, fw_log__emit1, hwd_abif__program_rf_clk, hwd_abif__rgf_889380_8cbcd0, hwd_abif__rgf_889400, hwd_rfc__rgf_889100, marlon_r_if_class__config_channel, phy__program_channel_regs, rfc__write_core_reg6, rfc__write_field_1136
 */
	.section .text.hwm_analog_channel_switch,"ax",@progbits
	.global hwm_analog_channel_switch
hwm_analog_channel_switch:
	.global L_8d4b3c
L_8d4b3c:
	push_s blink
L_8d4b3e:
	push_s r13
L_8d4b40:
	mov_s r13,r0
L_8d4b42:
	mov_s r0,0x0
L_8d4b44:
	bl.d L_8d042c
L_8d4b48:
	mov_s r1,0x1
L_8d4b4a:
	mov_s r0,0x0
L_8d4b4c:
	bl.d L_8d04bc
L_8d4b50:
	mov_s r1,0x1
L_8d4b52:
	bl.d L_8cbcd0
L_8d4b56:
	mov_s r0,0x1
L_8d4b58:
	bl.d L_8cbcb8
L_8d4b5c:
	mov_s r0,0x0
L_8d4b5e:
	bl L_8cb9dc
L_8d4b62:
	bl.d L_8cba10
L_8d4b66:
	mov_s r0,r13
L_8d4b68:
	bl.d L_8cf83c
L_8d4b6c:
	mov_s r0,r13
L_8d4b6e:
	mov_s r0,0x7d
L_8d4b70:
	asl_s r0,r0,0x8
L_8d4b72:
	mov lp_count,r0
L_8d4b76:
	nop_s
L_8d4b78:
	lp L_8d4b80
L_8d4b7c:
	nop_s
L_8d4b7e:
	nop_s
	.global L_8d4b80
L_8d4b80:
	bl.d L_8cbcb8
L_8d4b84:
	mov_s r0,0x1
L_8d4b86:
	mov r0,0x190
L_8d4b8a:
	mov lp_count,r0
L_8d4b8e:
	nop_s
L_8d4b90:
	lp L_8d4b98
L_8d4b94:
	nop_s
L_8d4b96:
	nop_s
	.global L_8d4b98
L_8d4b98:
	bl.d L_8cbcd0
L_8d4b9c:
	mov_s r0,0x0
L_8d4b9e:
	mov_s r0,0x0
L_8d4ba0:
	bl.d L_8d04bc
L_8d4ba4:
	mov_s r1,r0
L_8d4ba6:
	mov_s r0,0x0
L_8d4ba8:
	bl.d L_8d042c
L_8d4bac:
	mov_s r1,r0
L_8d4bae:
	bl.d L_8d0e74
L_8d4bb2:
	mov_s r0,0x0
L_8d4bb4:
	mov_s r0,0x803e84
L_8d4bba:
	bl.d L_8c6048
L_8d4bbe:
	mov_s r1,r13
L_8d4bc0:
	mov_s r2,0x1018420
L_8d4bc6:
	add_s r3,r13,0x1
L_8d4bc8:
	mov_s r0,0x1
L_8d4bca:
	bl.d L_8edfcc
L_8d4bce:
	mov_s r1,0x2
L_8d4bd0:
	b L_8c033c
