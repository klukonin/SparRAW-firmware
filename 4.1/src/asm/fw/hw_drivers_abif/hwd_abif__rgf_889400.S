/* hwd_abif__rgf_889400 @ 0x8cbcb8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_abif_rfc_divider_restart, hwm_analog_channel_switch
 */
	.section .text.hwd_abif__rgf_889400,"ax",@progbits
	.global hwd_abif__rgf_889400
hwd_abif__rgf_889400:
	.global L_8cbcb8
L_8cbcb8:
	mov_s r1,0x889400
L_8cbcbe:
	cmp_s r0,0x1
L_8cbcc0:
	ld_s r0,[r1,0x1c]
L_8cbcc2:
	bclr.eq r0,r0,0x3
L_8cbcc6:
	bset.ne r0,r0,0x3
L_8cbcca:
	st_s r0,[r1,0x1c]
L_8cbccc:
	j_s [blink]
L_8cbcce:
	nop_s
