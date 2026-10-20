/* calib_mngr_step_b @ 0x8c6abc, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: hwd_abif__rgf_88a000_8ccfb0, hwd_abif__rgf_88a200_8cc674, hwd_abif__rgf_88af80_8cb8d8, hwd_abif__set_agc004_w2, hwd_phy__mode_flags_by_index, hwd_phy__rgf_883000_8cf4c8, hwd_phy__rgf_883000_8cf74c, hwd_phy__rgf_883000_8cfcdc, hwd_phy__rgf_883000_8cfd48, hwd_phy__rgf_883000_8cfd88, hwd_phy__rgf_884000, hwd_phy_dbg_clk_enable
 */
	.section .text.calib_mngr_step_b,"ax",@progbits
	.global calib_mngr_step_b
calib_mngr_step_b:
	.global L_8c6abc
L_8c6abc:
	sub_s sp,sp,0x4
L_8c6abe:
	push_s blink
L_8c6ac0:
	bl L_8d3870
L_8c6ac4:
	bl.d L_8cf4c8
L_8c6ac8:
	mov_s r0,0x0
L_8c6aca:
	bl.d L_8cf4fc
L_8c6ace:
	mov_s r0,0x0
L_8c6ad0:
	bl.d L_8cb8d8
L_8c6ad4:
	mov_s r0,0x0
L_8c6ad6:
	bl.d L_8d4c0c
L_8c6ada:
	mov_s r0,0x0
L_8c6adc:
	bl L_8cfcdc
L_8c6ae0:
	mov_s r0,0x1
L_8c6ae2:
	mov_s r1,0x1c
L_8c6ae4:
	bl.d L_8d4aa8
L_8c6ae8:
	mov_s r2,0x3f
L_8c6aea:
	mov_s r0,0x1c
L_8c6aec:
	mov_s r1,0x0
L_8c6aee:
	bl.d L_8cce38
L_8c6af2:
	mov_s r2,0x0
L_8c6af4:
	mov_s r0,0x1c
L_8c6af6:
	mov_s r1,0x1
L_8c6af8:
	bl.d L_8cce38
L_8c6afc:
	mov_s r2,0x0
L_8c6afe:
	bl L_8cfd88
L_8c6b02:
	bl.d L_8cf4fc
L_8c6b06:
	mov_s r0,0x1
L_8c6b08:
	mov_s r0,0x0
L_8c6b0a:
	bl.d L_8ccfb0
L_8c6b0e:
	mov_s r1,0x1c
L_8c6b10:
	mov_s r0,0x1
L_8c6b12:
	bl.d L_8ccfb0
L_8c6b16:
	mov_s r1,0x1c
L_8c6b18:
	bl L_8cfd48
L_8c6b1c:
	mov_s r0,0x0
L_8c6b1e:
	bl.d L_8cc674
L_8c6b22:
	mov_s r1,0x3f
L_8c6b24:
	mov_s r0,0x1
L_8c6b26:
	bl.d L_8cc674
L_8c6b2a:
	mov_s r1,0x3f
L_8c6b2c:
	bl.d L_8ceed4
L_8c6b30:
	mov_s r0,0x1
L_8c6b32:
	mov_s r0,0x0
L_8c6b34:
	bset_s r0,r0,0xf
L_8c6b36:
	mov_s r1,0x1
L_8c6b38:
	bl.d L_8cf74c
L_8c6b3c:
	mov_s r2,0x65
L_8c6b3e:
	mov_s r0,0x65
L_8c6b40:
	mov_s r1,0x0
L_8c6b42:
	bl.d L_8d0318
L_8c6b46:
	mov_s r2,0x6
L_8c6b48:
	bl.d L_8d0388
L_8c6b4c:
	mov_s r0,0x1
L_8c6b4e:
	bl.d L_8cfdc0
L_8c6b52:
	mov_s r0,0x4
L_8c6b54:
	pop_s blink
L_8c6b56:
	j_s.d [blink]
