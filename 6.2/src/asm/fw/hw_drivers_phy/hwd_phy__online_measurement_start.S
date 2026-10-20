/* hwd_phy__online_measurement_start @ 0x8d1e34, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__online_measurement_start
hwd_phy__online_measurement_start:
	.global L_8d1e34
L_8d1e34:
	mov_s r1,0x885000
L_8d1e3a:
	ld_s r0,[r1]
L_8d1e3c:
	bclr_s r0,r0,0x0
L_8d1e3e:
	bclr_s r0,r0,0x6
L_8d1e40:
	or r0,r0,0x41
L_8d1e44:
	st_s r0,[r1]
L_8d1e46:
	j_s [blink]
