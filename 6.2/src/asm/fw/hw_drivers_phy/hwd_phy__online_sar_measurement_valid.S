/* hwd_phy__online_sar_measurement_valid @ 0x8d1e58, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__online_sar_measurement_valid
hwd_phy__online_sar_measurement_valid:
	.global L_8d1e58
L_8d1e58:
	mov_s r0,0x885000
L_8d1e5e:
	ld_s r0,[r0,0x4]
L_8d1e60:
	lsr_s r0,r0,0xc
L_8d1e62:
	j_s.d [blink]
L_8d1e64:
	bmsk_s r0,r0,0x0
L_8d1e66:
	nop_s
