/* phy__get_rx_ina_det_mode @ 0x8d263c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__acquire_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy__get_rx_ina_det_mode
phy__get_rx_ina_det_mode:
	.global L_8d263c
L_8d263c:
	mov_s r0,0x883100
L_8d2642:
	ld_s r0,[r0,0x50]
L_8d2644:
	j_s [blink]
L_8d2646:
	nop_s
