/* hwd_mac__sxd_tx_phy_frame_start @ 0x8d1044, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_mac__sxd_tx_phy_frame_start
hwd_mac__sxd_tx_phy_frame_start:
	.global L_8d1044
L_8d1044:
	mov_s r0,0x886d80
L_8d104a:
	st 0x3d002000,[r0, 0x48]
L_8d1052:
	j_s [blink]
