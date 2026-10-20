/* hwd_phy_dbg_clk_enable @ 0x8ceed4, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Not Understood BUG_5661_WA: hwd_phy_dbg_clk_enable(%d)
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_lo_power_step, calib_mngr_step_a, calib_mngr_step_b, hwd_phy__reconfig_with_delay, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST, hwf_calib__release_hw, ut_hw_flows_cmd_0x407
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_sysassert_fatal
 * Глобалы (через gp): 0x8002ec
 */
	.section .text.hwd_phy_dbg_clk_enable,"ax",@progbits
	.global hwd_phy_dbg_clk_enable
hwd_phy_dbg_clk_enable:
	.global L_8ceed4
L_8ceed4:
	push_s blink
L_8ceed6:
	bl L_8c02c4
L_8ceeda:
	cmp_s r0,0x0
L_8ceedc:
	mov_s r13,0x1
L_8ceede:
	sub_s.ne r13,r13,r13
L_8ceee0:
	mov_s r12,r13
L_8ceee2:
	bic.f r12,r12,-0xff
L_8ceee6:
	mov_s r14,r0
L_8ceee8:
	bne_s L_8cef2a
	.global L_8ceeea
L_8ceeea:
	mov_s r1,0x883d00
L_8ceef0:
	ld_s r0,[r1,0x60]
L_8ceef2:
	bclr_s r0,r0,0x0
L_8ceef4:
	or_s r13,r13,r0
L_8ceef6:
	st_s r13,[r1,0x60]
L_8ceef8:
	ld_s r0,[gp,0x17c]
L_8ceefa:
	breq_s r0,0,L_8cef26
L_8ceefc:
	mov_s r2,0x10186a4
L_8cef02:
	mov_s r0,0x1
L_8cef04:
	mov_s r1,0x2
L_8cef06:
	bl.d L_8edfcc
L_8cef0a:
	mov_s r3,r14
L_8cef0c:
	ld_s r0,[gp,0x17c]
L_8cef0e:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8cef10:
	add2_s r0,r0,r0
L_8cef12:
	mov lp_count,r0
L_8cef16:
	nop_s
L_8cef18:
	lp L_8cef20
L_8cef1c:
	nop_s
L_8cef1e:
	nop_s
	.global L_8cef20
L_8cef20:
	mov_s r0,0x0
L_8cef22:
	st.as r0,[gp,0x5f]
	.global L_8cef26
L_8cef26:
	b L_8c0334
	.global L_8cef2a
L_8cef2a:
	mov_s r0,blink
L_8cef2c:
	mov_s r2,0x1018690
L_8cef32:
	mov_s r1,0xac
L_8cef34:
	bl.d L_8c82c0
L_8cef38:
	mov_s r3,0xc8
L_8cef3a:
	b_s L_8ceeea
