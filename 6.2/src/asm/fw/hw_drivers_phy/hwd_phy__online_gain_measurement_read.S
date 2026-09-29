/* hwd_phy__online_gain_measurement_read @ 0x8d1dc8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__online_gain_measurement_read
hwd_phy__online_gain_measurement_read:
	.global L_8d1dc8
L_8d1dc8:
	mov_s r2,0x885130
L_8d1dce:
	ld.as r2,[r2,r0]
L_8d1dd2:
	lsr r0,r2,0x10
L_8d1dd6:
	bmsk_s r0,r0,0xa
L_8d1dd8:
	stw_s r0,[r1]
L_8d1dda:
	bmsk_s r2,r2,0xa
L_8d1ddc:
	j_s.d [blink]
L_8d1dde:
	stw_s r2,[r1,0x2]
