/* calib__setup_loopback_hw_b @ 0x8d6a64, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd__args_to_regs_default, hwd_abif__caf_lpbk_mode, hwd_abif__rx_prepare_ifrx_pwdn, hwd_phy__rx_cal_corr_config, hwd_phy__rx_enable, hwd_phy__self_mode_exit, hwd_phy__self_rx_mode_entry, hwd_phy__set_rx_swap_iq, hwd_phy__tx_enable, hwf_calib__acquire_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib__setup_loopback_hw_b
calib__setup_loopback_hw_b:
	.global L_8d6a64
L_8d6a64:
	push_s blink
L_8d6a66:
	bl L_8c01dc
L_8d6a6a:
	mov_s r14,r1
L_8d6a6c:
	mov_s r13,r2
L_8d6a6e:
	mov_s r15,r3
L_8d6a70:
	cmp_s r0,0x0
L_8d6a72:
	mov r16,r4
L_8d6a76:
	bl.ne L_8d65e8
L_8d6a7a:
	breq_s r14,0,L_8d6aa2
L_8d6a7c:
	bl.d L_8ce5e8
L_8d6a80:
	mov_s r0,0x0
L_8d6a82:
	bl.d L_8d7560
L_8d6a86:
	mov_s r0,0x0
L_8d6a88:
	mov_s r0,0x8042c8
L_8d6a8e:
	bl L_8ccb3c
L_8d6a92:
	bl L_8d3380
L_8d6a96:
	bl.d L_8cee2c
L_8d6a9a:
	mov_s r0,0x7
L_8d6a9c:
	bl.d L_8d7560
L_8d6aa0:
	mov_s r0,0x1
	.global L_8d6aa2
L_8d6aa2:
	breq_s r13,0,L_8d6abe
L_8d6aa4:
	bl.d L_8d219c
L_8d6aa8:
	mov_s r0,0x0
L_8d6aaa:
	bl.d L_8d21d0
L_8d6aae:
	mov_s r0,0x0
L_8d6ab0:
	bl L_8d2b38
L_8d6ab4:
	bl L_8d2ba4
L_8d6ab8:
	bl.d L_8d2c1c
L_8d6abc:
	mov_s r0,0x0
	.global L_8d6abe
L_8d6abe:
	cmp_s r15,0x0
L_8d6ac0:
	sub_s.ne r0,r0,r0
L_8d6ac2:
	bset.ne r0,r0,r16
L_8d6ac6:
	mov.ne r1,0x1
L_8d6aca:
	bl.ne.d L_8d2418
L_8d6ace:
	sub_s.ne r2,r2,r2
L_8d6ad0:
	b L_8c0244
