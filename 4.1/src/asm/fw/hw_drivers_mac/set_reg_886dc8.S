/* set_reg_886dc8 @ 0x8ce2ac, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwm__apply_channel_config, hwm_calib__set_loopback_mode
 */
	.section .text.set_reg_886dc8,"ax",@progbits
	.global set_reg_886dc8
set_reg_886dc8:
	.global L_8ce2ac
L_8ce2ac:
	mov_s r0,0x886d80
L_8ce2b2:
	st 0x3d000200,[r0, 0x48]
L_8ce2ba:
	j_s [blink]
