/* hwd_phy__self_tx_mode_entry @ 0x8d2be4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_corr__estimate_and_apply_rx_gain, calib_silent_rssi_sparrow__correction_alg, hwf_calib__release_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__self_tx_mode_entry
hwd_phy__self_tx_mode_entry:
	.global L_8d2be4
L_8d2be4:
	mov_s r1,0x883000
L_8d2bea:
	ld_s r0,[r1,0x4]
L_8d2bec:
	bset_s r0,r0,0x1
L_8d2bee:
	st_s r0,[r1,0x4]
L_8d2bf0:
	ld_s r0,[r1,0x4]
L_8d2bf2:
	bclr_s r0,r0,0x0
L_8d2bf4:
	st_s r0,[r1,0x4]
L_8d2bf6:
	ld_s r0,[r1,0x4]
L_8d2bf8:
	bset_s r0,r0,0x0
L_8d2bfa:
	st_s r0,[r1,0x4]
L_8d2bfc:
	ld_s r0,[r1,0x4]
L_8d2bfe:
	bclr_s r0,r0,0x0
L_8d2c00:
	st_s r0,[r1,0x4]
L_8d2c02:
	ld_s r0,[r1]
L_8d2c04:
	bset_s r0,r0,0x3
L_8d2c06:
	st_s r0,[r1]
L_8d2c08:
	ld_s r0,[r1]
L_8d2c0a:
	bclr_s r0,r0,0x2
L_8d2c0c:
	st_s r0,[r1]
L_8d2c0e:
	ld_s r0,[r1]
L_8d2c10:
	bset_s r0,r0,0x2
L_8d2c12:
	st_s r0,[r1]
L_8d2c14:
	ld_s r0,[r1]
L_8d2c16:
	bclr_s r0,r0,0x2
L_8d2c18:
	st_s r0,[r1]
L_8d2c1a:
	j_s [blink]
