/* hwd_phy__rgf_883000_8cfcdc @ 0x8cfcdc, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_lo_power_step, calib_mngr_step_a, calib_mngr_step_b, calib_silent_rssi__vt18, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST, hwf_calib__prepare_hw, hwf_calib__release_hw, hwf_calib__setup_loopback
 */
	.section .text.hwd_phy__rgf_883000_8cfcdc,"ax",@progbits
	.global hwd_phy__rgf_883000_8cfcdc
hwd_phy__rgf_883000_8cfcdc:
	.global L_8cfcdc
L_8cfcdc:
	mov_s r1,0x883000
L_8cfce2:
	ld_s r0,[r1,0x4]
L_8cfce4:
	bset_s r0,r0,0x1
L_8cfce6:
	st_s r0,[r1,0x4]
L_8cfce8:
	ld_s r0,[r1,0x4]
L_8cfcea:
	bclr_s r0,r0,0x0
L_8cfcec:
	st_s r0,[r1,0x4]
L_8cfcee:
	ld_s r0,[r1,0x4]
L_8cfcf0:
	bset_s r0,r0,0x0
L_8cfcf2:
	st_s r0,[r1,0x4]
L_8cfcf4:
	ld_s r0,[r1,0x4]
L_8cfcf6:
	bclr_s r0,r0,0x0
L_8cfcf8:
	st_s r0,[r1,0x4]
L_8cfcfa:
	ld_s r0,[r1,0x4]
L_8cfcfc:
	bclr_s r0,r0,0x1
L_8cfcfe:
	st_s r0,[r1,0x4]
L_8cfd00:
	ld_s r0,[r1]
L_8cfd02:
	bset_s r0,r0,0x1
L_8cfd04:
	st_s r0,[r1]
L_8cfd06:
	ld_s r0,[r1]
L_8cfd08:
	bclr_s r0,r0,0x0
L_8cfd0a:
	st_s r0,[r1]
L_8cfd0c:
	ld_s r0,[r1]
L_8cfd0e:
	bset_s r0,r0,0x0
L_8cfd10:
	st_s r0,[r1]
L_8cfd12:
	ld_s r0,[r1]
L_8cfd14:
	bclr_s r0,r0,0x0
L_8cfd16:
	st_s r0,[r1]
L_8cfd18:
	ld_s r0,[r1]
L_8cfd1a:
	bclr_s r0,r0,0x1
L_8cfd1c:
	st_s r0,[r1]
L_8cfd1e:
	ld_s r0,[r1]
L_8cfd20:
	bset_s r0,r0,0x3
L_8cfd22:
	st_s r0,[r1]
L_8cfd24:
	ld_s r0,[r1]
L_8cfd26:
	bclr_s r0,r0,0x2
L_8cfd28:
	st_s r0,[r1]
L_8cfd2a:
	ld_s r0,[r1]
L_8cfd2c:
	bset_s r0,r0,0x2
L_8cfd2e:
	st_s r0,[r1]
L_8cfd30:
	ld_s r0,[r1]
L_8cfd32:
	bclr_s r0,r0,0x2
L_8cfd34:
	st_s r0,[r1]
L_8cfd36:
	ld_s r0,[r1]
L_8cfd38:
	bclr_s r0,r0,0x3
L_8cfd3a:
	st_s r0,[r1]
L_8cfd3c:
	ld_s r0,[r1,0x10]
L_8cfd3e:
	bic r0,r0,0x6
L_8cfd42:
	st_s r0,[r1,0x10]
L_8cfd44:
	j_s [blink]
L_8cfd46:
	nop_s
