/* hwd_phy__rgf_883000_8cfd88 @ 0x8cfd88, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_lo_power_step, calib_mngr_step_b, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST, hwf_calib__release_hw
 */
	.section .text.hwd_phy__rgf_883000_8cfd88,"ax",@progbits
	.global hwd_phy__rgf_883000_8cfd88
hwd_phy__rgf_883000_8cfd88:
	.global L_8cfd88
L_8cfd88:
	mov_s r1,0x883000
L_8cfd8e:
	ld_s r0,[r1,0x4]
L_8cfd90:
	bset_s r0,r0,0x1
L_8cfd92:
	st_s r0,[r1,0x4]
L_8cfd94:
	ld_s r0,[r1,0x4]
L_8cfd96:
	bclr_s r0,r0,0x0
L_8cfd98:
	st_s r0,[r1,0x4]
L_8cfd9a:
	ld_s r0,[r1,0x4]
L_8cfd9c:
	bset_s r0,r0,0x0
L_8cfd9e:
	st_s r0,[r1,0x4]
L_8cfda0:
	ld_s r0,[r1,0x4]
L_8cfda2:
	bclr_s r0,r0,0x0
L_8cfda4:
	st_s r0,[r1,0x4]
L_8cfda6:
	ld_s r0,[r1]
L_8cfda8:
	bset_s r0,r0,0x3
L_8cfdaa:
	st_s r0,[r1]
L_8cfdac:
	ld_s r0,[r1]
L_8cfdae:
	bclr_s r0,r0,0x2
L_8cfdb0:
	st_s r0,[r1]
L_8cfdb2:
	ld_s r0,[r1]
L_8cfdb4:
	bset_s r0,r0,0x2
L_8cfdb6:
	st_s r0,[r1]
L_8cfdb8:
	ld_s r0,[r1]
L_8cfdba:
	bclr_s r0,r0,0x2
L_8cfdbc:
	st_s r0,[r1]
L_8cfdbe:
	j_s [blink]
