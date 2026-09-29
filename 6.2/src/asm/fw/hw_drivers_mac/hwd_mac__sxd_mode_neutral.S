/* hwd_mac__sxd_mode_neutral @ 0x8d0fe0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__set_loopback, hwm__apply_channel_config, hwm_calib__set_loopback_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_mac__sxd_mode_neutral
hwd_mac__sxd_mode_neutral:
	.global L_8d0fe0
L_8d0fe0:
	mov_s r0,0x886d80
L_8d0fe6:
	st 0x3e000000,[r0, 0x48]
L_8d0fee:
	st 0x3d000007,[r0, 0x48]
L_8d0ff6:
	j_s [blink]
