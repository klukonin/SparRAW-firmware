/* hwf_calib__prepare_hw @ 0x8d1ebc, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_bb_gain_dc__vt18, hwf_calib_all
 * Зовёт сам: hwd_abif__rgf_88a200_8cc674, hwd_abif__rgf_88af80_8cb8d8, hwd_abif__set_88ae60_flags, hwd_phy__mode_flags_by_index, hwd_phy__rgf_883000_8cf4c8, hwd_phy__rgf_883000_8cf74c, hwd_phy__rgf_883000_8cfcdc, hwd_phy__rgf_883000_8cfd48, hwd_phy__rgf_884000, hwd_phy__set_mode, hwf_calib__acquire_hw, hwm_calib__set_loopback_mode
 */
	.section .text.hwf_calib__prepare_hw,"ax",@progbits
	.global hwf_calib__prepare_hw
hwf_calib__prepare_hw:
	.global L_8d1ebc
L_8d1ebc:
	push_s blink
L_8d1ebe:
	bl L_8d3870
L_8d1ec2:
	bl.d L_8cf4c8
L_8d1ec6:
	mov_s r0,0x0
L_8d1ec8:
	bl.d L_8cf4fc
L_8d1ecc:
	mov_s r0,0x0
L_8d1ece:
	bl.d L_8cb8d8
L_8d1ed2:
	mov_s r0,0x0
L_8d1ed4:
	bl.d L_8d4c0c
L_8d1ed8:
	mov_s r0,0x0
L_8d1eda:
	bl L_8cfcdc
L_8d1ede:
	bl.d L_8d04b0
L_8d1ee2:
	mov_s r0,0x0
L_8d1ee4:
	bl.d L_8cbd8c
L_8d1ee8:
	mov_s r0,0x7
L_8d1eea:
	mov_s r0,0x0
L_8d1eec:
	bset_s r0,r0,0xd
L_8d1eee:
	mov_s r1,0x1
L_8d1ef0:
	bl.d L_8cf74c
L_8d1ef4:
	mov_s r2,0x0
L_8d1ef6:
	bl L_8cfd48
L_8d1efa:
	bl.d L_8cf588
L_8d1efe:
	mov_s r0,0x1
L_8d1f00:
	bl.d L_8cf958
L_8d1f04:
	mov_s r0,0x0
L_8d1f06:
	bl.d L_8d4c0c
L_8d1f0a:
	mov_s r0,0x1
L_8d1f0c:
	mov_s r0,0x0
L_8d1f0e:
	bl.d L_8cc674
L_8d1f12:
	mov_s r1,r0
L_8d1f14:
	mov_s r0,0x1
L_8d1f16:
	bl.d L_8cc674
L_8d1f1a:
	mov_s r1,0x28
L_8d1f1c:
	bl.d L_8cfdc0
L_8d1f20:
	mov_s r0,0x0
L_8d1f22:
	pop_s blink
L_8d1f24:
	j_s [blink]
L_8d1f26:
	nop_s
