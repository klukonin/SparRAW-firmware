/* hwd_abif__sar_dc_config_rgf_mode_get @ 0x8cf948, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__acquire_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__sar_dc_config_rgf_mode_get
hwd_abif__sar_dc_config_rgf_mode_get:
	.global L_8cf948
L_8cf948:
	mov_s r0,0x88a200
L_8cf94e:
	ld_s r0,[r0,0x4]
L_8cf950:
	lsr_s r0,r0,0x19
L_8cf952:
	j_s.d [blink]
L_8cf954:
	bmsk_s r0,r0,0x0
L_8cf956:
	nop_s
