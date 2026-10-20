/* tof__get_tx_offset @ 0x8d46ac, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, wmi_tof_get_tx_rx_offset
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof__get_tx_offset
tof__get_tx_offset:
	.global L_8d46ac
L_8d46ac:
	mov_s r0,0x889500
L_8d46b2:
	ld_s r0,[r0,0x48]
L_8d46b4:
	j_s [blink]
L_8d46b6:
	nop_s
