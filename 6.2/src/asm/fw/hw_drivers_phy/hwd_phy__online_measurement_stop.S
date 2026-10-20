/* hwd_phy__online_measurement_stop @ 0x8d1e48, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__online_measurement_stop
hwd_phy__online_measurement_stop:
	.global L_8d1e48
L_8d1e48:
	mov_s r1,0x885000
L_8d1e4e:
	ld_s r0,[r1]
L_8d1e50:
	bclr_s r0,r0,0x0
L_8d1e52:
	st_s r0,[r1]
L_8d1e54:
	j_s [blink]
L_8d1e56:
	nop_s
