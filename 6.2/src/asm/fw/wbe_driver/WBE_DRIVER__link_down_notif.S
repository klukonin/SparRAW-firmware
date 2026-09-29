/* WBE_DRIVER__link_down_notif @ 0x8f5dd4, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WBE_DRIVER::link_down_notif: DEV2_LINK_DOWN - Disconnect
 *   l2_mgr::link_up_evt() STATUS=%d CID=%d p_conn=0x%x.
 *   WBE_DRIVER::HOST:: DRIVER is UP - ENUMRATION STARTING!!!
 * Зовут его: fw_vector_16
 * Зовёт сам: SW_TX_MGMT_API__link_up_evt, __ld_r15_to_r13_ret, __st_r15_to_r13, conn__notify_link_via_l2mgr, conn_mgr__link_up_evt, ftm__ctx_addr, fw_log_emit0, fw_log_emit3, fw_sysassert_fatal, link_up_evt, mlme_sm__disconnect_ev_handle, pcie__set_event_bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global WBE_DRIVER__link_down_notif
WBE_DRIVER__link_down_notif:
	.global L_8f5dd4
L_8f5dd4:
	push_s blink
L_8f5dd6:
	bl.d L_8f6b5c
L_8f5dda:
	mov_s r1,r0
L_8f5ddc:
	breq_s r1,0,L_8f5dea
L_8f5dde:
	mov_s r0,blink
L_8f5de0:
	mov_s r1,0x6c
L_8f5de2:
	bl.d L_8c9b28
L_8f5de6:
	bset_s r1,r1,0xc
L_8f5de8:
	b_s L_8f5e06
	.global L_8f5dea
L_8f5dea:
	mov_s r1,0x1003718
L_8f5df0:
	bl.d L_8dcba8
L_8f5df4:
	mov_s r0,0x2f
L_8f5df6:
	mov_s r0,L_8c91b8-0x8c0000
L_8f5dfc:
	mov_s r1,0x1
L_8f5dfe:
	mov_s r2,0x0
L_8f5e00:
	bl.d L_8c3248
L_8f5e04:
	mov_s r3,0x2
	.global L_8f5e06
L_8f5e06:
	pop_s blink
L_8f5e08:
	j_s [blink]
L_8f5e0a:
	nop_s
L_8f5e0c:
	push_s blink
L_8f5e0e:
	bl L_8c01e0
L_8f5e12:
	mov_s r15,r0
L_8f5e14:
	mov_s r13,r1
L_8f5e16:
	ld_s r14,[r0,0x24]
L_8f5e18:
	mov_s r1,0x100d364
L_8f5e1e:
	ldb_s r3,[r15,0x8]
L_8f5e20:
	mov_s r0,0x2b
L_8f5e22:
	mov_s r2,r13
L_8f5e24:
	bl.d L_8dcd00
L_8f5e28:
	mov_s r4,r15
L_8f5e2a:
	brne r13,0x1,L_8f5e3c
L_8f5e2e:
	breq_s r14,0,L_8f5e3c
L_8f5e30:
	mov_s r0,r15
L_8f5e32:
	mov_s r1,0x2
L_8f5e34:
	bl.d L_8f25c8
L_8f5e38:
	bset_s r1,r1,0x10
L_8f5e3a:
	b_s L_8f5e66
	.global L_8f5e3c
L_8f5e3c:
	ld_s r0,[r15,0x18]
L_8f5e3e:
	mov_s r1,r15
L_8f5e40:
	bl.d L_8dace4
L_8f5e44:
	mov_s r2,r13
L_8f5e46:
	mov_s r0,r15
L_8f5e48:
	bl.d L_8dabfc
L_8f5e4c:
	mov_s r1,r13
L_8f5e4e:
	bl L_8ccf04
L_8f5e52:
	bl.d L_8dacec
L_8f5e56:
	mov_s r1,r13
L_8f5e58:
	cmp_s r14,0x0
L_8f5e5a:
	mov.ne r0,r15
L_8f5e5e:
	bl.ne.d L_8dad1c
L_8f5e62:
	mov.ne r1,r13
	.global L_8f5e66
L_8f5e66:
	b L_8c024c
L_8f5e6a:
	nop_s
L_8f5e6c:
	push_s blink
L_8f5e6e:
	ld_s r0,[gp,-0x8c]
L_8f5e70:
	breq_s r0,0,L_8f5e7c
L_8f5e72:
	bl L_8c8de0
L_8f5e76:
	mov_s r0,0x0
L_8f5e78:
	st.as r0,[gp,-0x23]
	.global L_8f5e7c
L_8f5e7c:
	bl L_8fa83c
L_8f5e80:
	bl L_8f6b6c
L_8f5e84:
	mov_s r1,0x10037cc
L_8f5e8a:
	bl.d L_8dcba8
L_8f5e8e:
	mov_s r0,0x2f
L_8f5e90:
	bl.d L_8d1a98
L_8f5e94:
	mov_s r0,0x2
L_8f5e96:
	ld.as r3,[gp,-0x27]
L_8f5e9a:
	ld_s r0,[gp,-0xa4]
L_8f5e9c:
	ld.as r1,[gp,-0x28]
L_8f5ea0:
	jl_s.d [r3]
L_8f5ea2:
	mov_s r2,0x1
L_8f5ea4:
	pop_s blink
L_8f5ea6:
	j_s [blink]
