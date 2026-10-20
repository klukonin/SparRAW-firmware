/* hwd_phy__online_measurement_completed @ 0x8d1de0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__online_measurement_completed
hwd_phy__online_measurement_completed:
	.global L_8d1de0
L_8d1de0:
	mov_s r0,0x885000
L_8d1de6:
	ld_s r0,[r0,0x4]
L_8d1de8:
	bbit0 r0,0xc,L_8d1de0
L_8d1dec:
	j_s [blink]
L_8d1dee:
	nop_s
