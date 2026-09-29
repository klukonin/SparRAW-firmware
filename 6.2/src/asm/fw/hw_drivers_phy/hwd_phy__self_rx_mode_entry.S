/* hwd_phy__self_rx_mode_entry @ 0x8d2ba4, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib__setup_loopback_hw_b, calib__setup_loopback_rx_path, calib_corr__estimate_and_apply_rx_gain, calib_silent_rssi_sparrow__correction_alg, hwf_calib__release_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__self_rx_mode_entry
hwd_phy__self_rx_mode_entry:
	.global L_8d2ba4
L_8d2ba4:
	mov_s r1,0x883000
L_8d2baa:
	ld_s r0,[r1]
L_8d2bac:
	bset_s r0,r0,0x1
L_8d2bae:
	st_s r0,[r1]
L_8d2bb0:
	ld_s r0,[r1]
L_8d2bb2:
	bclr_s r0,r0,0x0
L_8d2bb4:
	st_s r0,[r1]
L_8d2bb6:
	ld_s r0,[r1]
L_8d2bb8:
	bset_s r0,r0,0x0
L_8d2bba:
	st_s r0,[r1]
L_8d2bbc:
	ld_s r0,[r1]
L_8d2bbe:
	bclr_s r0,r0,0x0
L_8d2bc0:
	st_s r0,[r1]
L_8d2bc2:
	ld_s r0,[r1]
L_8d2bc4:
	bset_s r0,r0,0x3
L_8d2bc6:
	st_s r0,[r1]
L_8d2bc8:
	ld_s r0,[r1]
L_8d2bca:
	bclr_s r0,r0,0x2
L_8d2bcc:
	st_s r0,[r1]
L_8d2bce:
	ld_s r0,[r1]
L_8d2bd0:
	bset_s r0,r0,0x2
L_8d2bd2:
	st_s r0,[r1]
L_8d2bd4:
	ld_s r0,[r1]
L_8d2bd6:
	bclr_s r0,r0,0x2
L_8d2bd8:
	st_s r0,[r1]
L_8d2bda:
	ld_s r0,[r1,0x10]
L_8d2bdc:
	bset_s r0,r0,0x2
L_8d2bde:
	st_s r0,[r1,0x10]
L_8d2be0:
	j_s [blink]
L_8d2be2:
	nop_s
