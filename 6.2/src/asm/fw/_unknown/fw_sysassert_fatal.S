/* fw_sysassert_fatal @ 0x8c9b28, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Crash TSF: curr tsf 0x%08x %08x assert 0x%04x
 *   SYSTEM FATAL CRASH0: curr_blink=0x%X, prev_blink =0x%X
 *   SYSTEM FATAL CRASH0: curr_blink=0x%X, prev_blink =0x%X, SYSASSERT_CODE_0x%x
 *   SYSTEM FATAL CRASH1: sp=%d, ilink1=0x%X, ilink2=0x%X
 *   FW SYSASSERT... Close Phy Rx/Tx
 * Зовут его: CALIB_MNGR__system_state_evt_handler, FWQ_TX_AVAILABILITY__remove_packet, IF_GAIN__GAIN, LMAC_IF__rs_started, PS_NONASSOC_SM__ps_reenter_done, SDP__hwd_sdp_is_defined_mode, SDP__hwd_sdp_is_defined_sdp, SDP__hwd_sdp_is_gpio_sdp, SDP__hwd_sdp_is_int_ctrl_sdp, SDP__sdp_drive_value
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, assert__restore_hw_for_dump, fw_log_emit0, fw_log_emit2, fw_log_emit3, fw_status__set_assert_marker, fw_status__set_state, fw_sysassert__stack_dump, hwd_phy__rx_ina_det_mode, hwd_phy__tx_enable, led_scheme__apply
 * Глобалы (через gp): 0x80024a, 0x80034c, 0x800350, 0x800354
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysassert_fatal
fw_sysassert_fatal:
	.global L_8c9b28
L_8c9b28:
	push_s blink
L_8c9b2a:
	bl L_8c01dc
L_8c9b2e:
	mov_s r13,r0
L_8c9b30:
	ld_s r0,[gp,-0x168]
L_8c9b32:
	sub_s sp,sp,0x8
L_8c9b34:
	cmp_s r0,0x0
L_8c9b36:
	mov_s r16,r1
L_8c9b38:
	bne_s L_8c9c50
L_8c9b3a:
	mov_s r0,0x1
L_8c9b3c:
	bl.d L_8e864c
L_8c9b40:
	st.as r0,[gp,-0x5a]
L_8c9b44:
	mov_s r0,0xdeaddead
L_8c9b4a:
	bl L_8e8634
L_8c9b4e:
	mov_s r0,0xdeaddead
L_8c9b54:
	bl L_8e8640
L_8c9b58:
	mov_s r0,0x857000
L_8c9b5e:
	st r16,[r0, 0xc]
L_8c9b62:
	st_s r13,[r0,0x10]
L_8c9b64:
	mov r33,0xde01
L_8c9b6c:
	mov r34,r16
L_8c9b70:
	mov r33,0xde02
L_8c9b78:
	mov_s r1,sp
L_8c9b7a:
	mov_s r0,0x0
L_8c9b7c:
	bl.d L_8e9900
L_8c9b80:
	mov_s r2,r0
L_8c9b82:
	ld_s r2,[sp,0x4]
L_8c9b84:
	mov_s r1,0x10012e8
L_8c9b8a:
	ld_s r3,[sp,0x0]
L_8c9b8c:
	mov_s r0,0x20
L_8c9b8e:
	bl.d L_8dcd00
L_8c9b92:
	mov r4,r16
L_8c9b96:
	st.as r16,[gp,0x73]
L_8c9b9a:
	ld_s r0,[gp,-0x134]
L_8c9b9c:
	st.as r13,[gp,0x72]
L_8c9ba0:
	st.as r16,[gp,0x74]
L_8c9ba4:
	mov_s r3,blink
L_8c9ba6:
	brne r0,0x1,L_8c9bba
L_8c9baa:
	mov_s r1,0x1001318
L_8c9bb0:
	mov_s r0,0x0
L_8c9bb2:
	bl.d L_8dcc80
L_8c9bb6:
	mov_s r2,r13
L_8c9bb8:
	b_s L_8c9bcc
	.global L_8c9bba
L_8c9bba:
	mov_s r1,0x1001350
L_8c9bc0:
	mov_s r0,0x0
L_8c9bc2:
	mov_s r2,r13
L_8c9bc4:
	bl.d L_8dcd00
L_8c9bc8:
	mov r4,r16
	.global L_8c9bcc
L_8c9bcc:
	mov_s r2,sp
L_8c9bce:
	mov_s r3,ilink1
L_8c9bd0:
	mov r4,ilink2
L_8c9bd4:
	mov_s r1,0x100139c
L_8c9bda:
	bl.d L_8dcd00
L_8c9bde:
	mov_s r0,0x0
L_8c9be0:
	ld_s r0,[gp,-0x134]
L_8c9be2:
	cmp_s r0,0x1
L_8c9be4:
	bl.eq L_8c9ce0
L_8c9be8:
	bl L_8c9a88
L_8c9bec:
	bl.d L_8d6e88
L_8c9bf0:
	mov_s r0,0x0
L_8c9bf2:
	ld_s r0,[gp,-0x134]
L_8c9bf4:
	brne_s r0,0,L_8c9c0e
L_8c9bf6:
	mov_s r1,0x10013d4
L_8c9bfc:
	bl.d L_8dcba8
L_8c9c00:
	mov_s r0,0x20
L_8c9c02:
	bl.d L_8d2630
L_8c9c06:
	mov_s r0,0x0
L_8c9c08:
	bl.d L_8d21d0
L_8c9c0c:
	mov_s r0,0x0
	.global L_8c9c0e
L_8c9c0e:
	ld_s r0,[gp,-0x134]
L_8c9c10:
	cmp_s r0,0x1
L_8c9c12:
	bl.eq L_8c9ad0
L_8c9c16:
	bl L_8c853c
L_8c9c1a:
	mov_s r13,0x803c00
L_8c9c20:
	ld_s r0,[r13]
L_8c9c22:
	cmp_s r0,0x0
L_8c9c24:
	bl.ne L_8e866c
L_8c9c28:
	ld_s r0,[r13,0x4]
L_8c9c2a:
	cmp_s r0,0x0
L_8c9c2c:
	bl.ne.d L_8da84c
L_8c9c30:
	mov.ne r0,0x5
L_8c9c34:
	ldb_s r0,[gp,0xc6]
L_8c9c36:
	cmp_s r0,0x0
L_8c9c38:
	bl.ne L_8c9c58
L_8c9c3c:
	nop_s
L_8c9c3e:
	nop_s
L_8c9c40:
	nop_s
L_8c9c42:
	nop_s
L_8c9c44:
	flag 0x1
L_8c9c48:
	nop_s
L_8c9c4a:
	nop_s
L_8c9c4c:
	nop_s
L_8c9c4e:
	nop_s
	.global L_8c9c50
L_8c9c50:
	b.d L_8c0244
L_8c9c54:
	add_s sp,sp,0x8
L_8c9c56:
	nop_s
