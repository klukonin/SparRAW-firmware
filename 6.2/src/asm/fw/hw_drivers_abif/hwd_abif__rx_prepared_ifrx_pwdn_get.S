/* hwd_abif__rx_prepared_ifrx_pwdn_get @ 0x8ceec0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__acquire_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_prepared_ifrx_pwdn_get
hwd_abif__rx_prepared_ifrx_pwdn_get:
	.global L_8ceec0
L_8ceec0:
	mov_s r0,0x88ae00
L_8ceec6:
	ld_s r0,[r0,0x60]
L_8ceec8:
	lsr_s r0,r0,0xb
L_8ceeca:
	j_s.d [blink]
L_8ceecc:
	bmsk_s r0,r0,0x2
L_8ceece:
	nop_s
