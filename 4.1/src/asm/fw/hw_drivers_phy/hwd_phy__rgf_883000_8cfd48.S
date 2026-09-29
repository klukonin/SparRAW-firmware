/* hwd_phy__rgf_883000_8cfd48 @ 0x8cfd48, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_lo_power_step, calib_mngr_step_a, calib_mngr_step_b, calib_silent_rssi__vt18, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST, hwf_calib__prepare_hw, hwf_calib__release_hw, hwf_calib__setup_loopback
 */
	.section .text.hwd_phy__rgf_883000_8cfd48,"ax",@progbits
	.global hwd_phy__rgf_883000_8cfd48
hwd_phy__rgf_883000_8cfd48:
	.global L_8cfd48
L_8cfd48:
	mov_s r1,0x883000
L_8cfd4e:
	ld_s r0,[r1]
L_8cfd50:
	bset_s r0,r0,0x1
L_8cfd52:
	st_s r0,[r1]
L_8cfd54:
	ld_s r0,[r1]
L_8cfd56:
	bclr_s r0,r0,0x0
L_8cfd58:
	st_s r0,[r1]
L_8cfd5a:
	ld_s r0,[r1]
L_8cfd5c:
	bset_s r0,r0,0x0
L_8cfd5e:
	st_s r0,[r1]
L_8cfd60:
	ld_s r0,[r1]
L_8cfd62:
	bclr_s r0,r0,0x0
L_8cfd64:
	st_s r0,[r1]
L_8cfd66:
	ld_s r0,[r1]
L_8cfd68:
	bset_s r0,r0,0x3
L_8cfd6a:
	st_s r0,[r1]
L_8cfd6c:
	ld_s r0,[r1]
L_8cfd6e:
	bclr_s r0,r0,0x2
L_8cfd70:
	st_s r0,[r1]
L_8cfd72:
	ld_s r0,[r1]
L_8cfd74:
	bset_s r0,r0,0x2
L_8cfd76:
	st_s r0,[r1]
L_8cfd78:
	ld_s r0,[r1]
L_8cfd7a:
	bclr_s r0,r0,0x2
L_8cfd7c:
	st_s r0,[r1]
L_8cfd7e:
	ld_s r0,[r1,0x10]
L_8cfd80:
	bset_s r0,r0,0x2
L_8cfd82:
	st_s r0,[r1,0x10]
L_8cfd84:
	j_s [blink]
L_8cfd86:
	nop_s
