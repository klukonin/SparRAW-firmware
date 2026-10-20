/* hwd_abif__rgf_889380 @ 0x8ced8c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_abif__rfc_divider_restart, hwm_analog_channel_switch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rgf_889380
hwd_abif__rgf_889380:
	.global L_8ced8c
L_8ced8c:
	mov_s r1,0x889380
L_8ced92:
	cmp_s r0,0x1
L_8ced94:
	ld_s r0,[r1,0x14]
L_8ced96:
	bclr.eq r0,r0,0x0
L_8ced9a:
	bset.ne r0,r0,0x0
L_8ced9e:
	st_s r0,[r1,0x14]
L_8ceda0:
	j_s [blink]
L_8ceda2:
	nop_s
