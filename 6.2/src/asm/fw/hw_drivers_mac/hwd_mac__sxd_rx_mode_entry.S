/* hwd_mac__sxd_rx_mode_entry @ 0x8d0ff8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwm__apply_channel_config, hwm_calib__set_loopback_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_mac__sxd_rx_mode_entry
hwd_mac__sxd_rx_mode_entry:
	.global L_8d0ff8
L_8d0ff8:
	mov_s r0,0x886d80
L_8d0ffe:
	st 0x3d000200,[r0, 0x48]
L_8d1006:
	j_s [blink]
