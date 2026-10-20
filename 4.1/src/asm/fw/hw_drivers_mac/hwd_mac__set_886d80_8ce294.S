/* hwd_mac__set_886d80_8ce294 @ 0x8ce294, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__set_loopback, hwm__apply_channel_config, hwm_calib__set_loopback_mode
 */
	.section .text.hwd_mac__set_886d80_8ce294,"ax",@progbits
	.global hwd_mac__set_886d80_8ce294
hwd_mac__set_886d80_8ce294:
	.global L_8ce294
L_8ce294:
	mov_s r0,0x886d80
L_8ce29a:
	st 0x3e000000,[r0, 0x48]
L_8ce2a2:
	st 0x3d000007,[r0, 0x48]
L_8ce2aa:
	j_s [blink]
