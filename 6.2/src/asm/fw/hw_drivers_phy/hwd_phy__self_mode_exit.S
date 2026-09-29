/* hwd_phy__self_mode_exit @ 0x8d2b38, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib__setup_loopback_hw_b, calib__setup_loopback_rx_path, calib_corr__estimate_and_apply_rx_gain, calib_silent_rssi_sparrow__correction_alg, hwf_calib__release_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__self_mode_exit
hwd_phy__self_mode_exit:
	.global L_8d2b38
L_8d2b38:
	mov_s r1,0x883000
L_8d2b3e:
	ld_s r0,[r1,0x4]
L_8d2b40:
	bset_s r0,r0,0x1
L_8d2b42:
	st_s r0,[r1,0x4]
L_8d2b44:
	ld_s r0,[r1,0x4]
L_8d2b46:
	bclr_s r0,r0,0x0
L_8d2b48:
	st_s r0,[r1,0x4]
L_8d2b4a:
	ld_s r0,[r1,0x4]
L_8d2b4c:
	bset_s r0,r0,0x0
L_8d2b4e:
	st_s r0,[r1,0x4]
L_8d2b50:
	ld_s r0,[r1,0x4]
L_8d2b52:
	bclr_s r0,r0,0x0
L_8d2b54:
	st_s r0,[r1,0x4]
L_8d2b56:
	ld_s r0,[r1,0x4]
L_8d2b58:
	bclr_s r0,r0,0x1
L_8d2b5a:
	st_s r0,[r1,0x4]
L_8d2b5c:
	ld_s r0,[r1]
L_8d2b5e:
	bset_s r0,r0,0x1
L_8d2b60:
	st_s r0,[r1]
L_8d2b62:
	ld_s r0,[r1]
L_8d2b64:
	bclr_s r0,r0,0x0
L_8d2b66:
	st_s r0,[r1]
L_8d2b68:
	ld_s r0,[r1]
L_8d2b6a:
	bset_s r0,r0,0x0
L_8d2b6c:
	st_s r0,[r1]
L_8d2b6e:
	ld_s r0,[r1]
L_8d2b70:
	bclr_s r0,r0,0x0
L_8d2b72:
	st_s r0,[r1]
L_8d2b74:
	ld_s r0,[r1]
L_8d2b76:
	bclr_s r0,r0,0x1
L_8d2b78:
	st_s r0,[r1]
L_8d2b7a:
	ld_s r0,[r1]
L_8d2b7c:
	bset_s r0,r0,0x3
L_8d2b7e:
	st_s r0,[r1]
L_8d2b80:
	ld_s r0,[r1]
L_8d2b82:
	bclr_s r0,r0,0x2
L_8d2b84:
	st_s r0,[r1]
L_8d2b86:
	ld_s r0,[r1]
L_8d2b88:
	bset_s r0,r0,0x2
L_8d2b8a:
	st_s r0,[r1]
L_8d2b8c:
	ld_s r0,[r1]
L_8d2b8e:
	bclr_s r0,r0,0x2
L_8d2b90:
	st_s r0,[r1]
L_8d2b92:
	ld_s r0,[r1]
L_8d2b94:
	bclr_s r0,r0,0x3
L_8d2b96:
	st_s r0,[r1]
L_8d2b98:
	ld_s r0,[r1,0x10]
L_8d2b9a:
	bic r0,r0,0x6
L_8d2b9e:
	st_s r0,[r1,0x10]
L_8d2ba0:
	j_s [blink]
L_8d2ba2:
	nop_s
