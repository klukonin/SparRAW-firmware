/* hwf_calib__setup_loopback @ 0x8d3d0c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_bb_gain_dc__vga_dc_fine, calib_sar__vt18, hwf_calib_all
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd_abif__rgf_88af80_8cb8d8, hwd_abif__set_88ae60_flags, hwd_phy__mode_flags_by_index, hwd_phy__rgf_883000_8cf4c8, hwd_phy__rgf_883000_8cf74c, hwd_phy__rgf_883000_8cfcdc, hwd_phy__rgf_883000_8cfd48, hwd_phy__rgf_884000, hwf_calib__acquire_hw, hwm_calib__set_loopback_mode
 */
	.section .text.hwf_calib__setup_loopback,"ax",@progbits
	.global hwf_calib__setup_loopback
hwf_calib__setup_loopback:
	.global L_8d3d0c
L_8d3d0c:
	push_s blink
L_8d3d0e:
	bl L_8c02bc
L_8d3d12:
	mov_s r14,r1
L_8d3d14:
	mov_s r13,r2
L_8d3d16:
	mov_s r15,r3
L_8d3d18:
	cmp_s r0,0x0
L_8d3d1a:
	mov r16,r4
L_8d3d1e:
	bl.ne L_8d3870
L_8d3d22:
	breq_s r14,0,L_8d3d42
L_8d3d24:
	bl.d L_8cb8d8
L_8d3d28:
	mov_s r0,0x0
L_8d3d2a:
	bl.d L_8d4c0c
L_8d3d2e:
	mov_s r0,0x0
L_8d3d30:
	bl.d L_8d04b0
L_8d3d34:
	mov_s r0,0x0
L_8d3d36:
	bl.d L_8cbd8c
L_8d3d3a:
	mov_s r0,0x7
L_8d3d3c:
	bl.d L_8d4c0c
L_8d3d40:
	mov_s r0,0x1
	.global L_8d3d42
L_8d3d42:
	breq_s r13,0,L_8d3d5e
L_8d3d44:
	bl.d L_8cf4c8
L_8d3d48:
	mov_s r0,0x0
L_8d3d4a:
	bl.d L_8cf4fc
L_8d3d4e:
	mov_s r0,0x0
L_8d3d50:
	bl L_8cfcdc
L_8d3d54:
	bl L_8cfd48
L_8d3d58:
	bl.d L_8cfdc0
L_8d3d5c:
	mov_s r0,0x0
	.global L_8d3d5e
L_8d3d5e:
	cmp_s r15,0x0
L_8d3d60:
	sub_s.ne r0,r0,r0
L_8d3d62:
	bset.ne r0,r0,r16
L_8d3d66:
	mov.ne r1,0x1
L_8d3d6a:
	bl.ne.d L_8cf74c
L_8d3d6e:
	sub_s.ne r2,r2,r2
L_8d3d70:
	b L_8c0324
