/* hwd_phy_dbg_clk_enable @ 0x8d1bc0, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Not Understood BUG_5661_WA: hwd_phy_dbg_clk_enable(%d)
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib_corr__estimate_and_apply_rx_gain, calib_silent_rssi_sparrow__correction_alg, channel_estimation_cmd_start, fw_sysapi_mgr__phy_rx_statistics_cmd_start, hwd_phy_rx_read_and_parse_brp_ram, hwd_phy_rx_sar_rssi_measure, hwf_calib__release_hw
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_sysassert_fatal
 * Глобалы (через gp): 0x800300
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy_dbg_clk_enable
hwd_phy_dbg_clk_enable:
	.global L_8d1bc0
L_8d1bc0:
	push_s blink
L_8d1bc2:
	bl L_8c01e4
L_8d1bc6:
	cmp_s r0,0x0
L_8d1bc8:
	mov_s r14,0x1
L_8d1bca:
	sub_s.ne r14,r14,r14
L_8d1bcc:
	mov_s r12,r14
L_8d1bce:
	bic.f r12,r12,-0xff
L_8d1bd2:
	mov_s r13,r0
L_8d1bd4:
	bne_s L_8d1c14
	.global L_8d1bd6
L_8d1bd6:
	mov_s r1,0x883d00
L_8d1bdc:
	ld_s r0,[r1,0x60]
L_8d1bde:
	bclr_s r0,r0,0x0
L_8d1be0:
	or_s r14,r14,r0
L_8d1be2:
	st_s r14,[r1,0x60]
L_8d1be4:
	ld_s r0,[gp,0x17c]
L_8d1be6:
	breq_s r0,0,L_8d1c10
L_8d1be8:
	mov_s r1,0x101d6e4
L_8d1bee:
	mov_s r0,0x21
L_8d1bf0:
	bl.d L_8dcc10
L_8d1bf4:
	mov_s r2,r13
L_8d1bf6:
	ld_s r0,[gp,0x17c]
L_8d1bf8:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8d1bfa:
	add2_s r0,r0,r0
L_8d1bfc:
	mov lp_count,r0
L_8d1c00:
	nop_s
L_8d1c02:
	lp L_8d1c0a
L_8d1c06:
	nop_s
L_8d1c08:
	nop_s
	.global L_8d1c0a
L_8d1c0a:
	mov_s r0,0x0
L_8d1c0c:
	st.as r0,[gp,0x5f]
	.global L_8d1c10
L_8d1c10:
	b L_8c0254
	.global L_8d1c14
L_8d1c14:
	mov_s r0,blink
L_8d1c16:
	bl.d L_8c9b28
L_8d1c1a:
	mov_s r1,0xac
L_8d1c1c:
	b_s L_8d1bd6
L_8d1c1e:
	nop_s
