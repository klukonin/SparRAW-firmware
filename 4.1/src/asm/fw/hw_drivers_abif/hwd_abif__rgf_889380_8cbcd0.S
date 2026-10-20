/* hwd_abif__rgf_889380_8cbcd0 @ 0x8cbcd0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_abif_rfc_divider_restart, hwm_analog_channel_switch
 */
	.section .text.hwd_abif__rgf_889380_8cbcd0,"ax",@progbits
	.global hwd_abif__rgf_889380_8cbcd0
hwd_abif__rgf_889380_8cbcd0:
	.global L_8cbcd0
L_8cbcd0:
	mov_s r1,0x889380
L_8cbcd6:
	cmp_s r0,0x1
L_8cbcd8:
	ld_s r0,[r1,0x14]
L_8cbcda:
	bclr.eq r0,r0,0x0
L_8cbcde:
	bset.ne r0,r0,0x0
L_8cbce2:
	st_s r0,[r1,0x14]
L_8cbce4:
	j_s [blink]
L_8cbce6:
	nop_s
