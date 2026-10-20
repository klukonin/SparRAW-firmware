/* wbe_driver__pcie_debug @ 0x8f7d20, 316 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCIE DEBUG %d (ring#=%d): 0x%08X
 *   PCIE.PXE.PUP.DBG.PCIE_PCIE_PXE_PUP_DBG_0 = 0x%08X
 *   PCIE.PXE.PDN.CACHE_REQ_FIFO_CONTROLLER.PCIE_PXE_PDN_CACHE_REQ_FIFO = 0x%08X
 *   PCIE.PXE.PDN.TX_DP_FIFO_CONTROLLER = 0x%08X
 *   PCIE.SW_PORT1.DEBUG.TX.PCPL.REMOTE.SW_PORT1_DEBUG_TX_PCPL_REMOTE_0 = 0x%08X
 *   PCIE.SW_PORT1.DEBUG.TX.PCPL.REMOTE.SW_PORT1_DEBUG_TX_PCPL_REMOTE_1 = 0x%08X
 *   PCIE.SW_PORT1.DEBUG.TX.PCPL.REMOTE.SW_PORT1_DEBUG_TX_PCPL_REMOTE_2 = 0x%08X
 *   PCIE.SW_PORT1.DEBUG.TX.PCPL.REMOTE.SW_PORT1_DEBUG_TX_PCPL_REMOTE_3 = 0x%08X
 * Зовут его: wbe_driver__pcie_debug_isr
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wbe_driver__pcie_debug
wbe_driver__pcie_debug:
	.global L_8f7d20
L_8f7d20:
	push_s blink
L_8f7d22:
	bl L_8c01d8
L_8f7d26:
	mov_s r14,0x882e80
L_8f7d2c:
	ld_s r0,[r14,0x5c]
L_8f7d2e:
	extb r16,r0
L_8f7d32:
	mov_s r13,0x0
L_8f7d34:
	b_s L_8f7d40
	.global L_8f7d36
L_8f7d36:
	asr r0,r16
L_8f7d3a:
	extb r16,r0
L_8f7d3e:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8f7d40
L_8f7d40:
	brhs r13,0x8,L_8f7db2
L_8f7d44:
	bbit0 r16,0x0,L_8f7d36
L_8f7d48:
	bic.f r15,r13,0x7
L_8f7d4c:
	bne_s L_8f7d62
	.global L_8f7d4e
L_8f7d4e:
	ld_s r0,[r14,0x58]
L_8f7d50:
	asl_s r1,r13,0x4
L_8f7d52:
	bic r0,r0,0x70
L_8f7d56:
	or_s r0,r0,r1
L_8f7d58:
	st_s r0,[r14,0x58]
L_8f7d5a:
	ld_s r0,[r14,0x58]
L_8f7d5c:
	brne_s r13,0,L_8f7d6c
L_8f7d5e:
	bclr_s r0,r0,0x8
L_8f7d60:
	b_s L_8f7d6e
	.global L_8f7d62
L_8f7d62:
	mov_s r0,blink
L_8f7d64:
	bl.d L_8c9b28
L_8f7d68:
	mov_s r1,0xac
L_8f7d6a:
	b_s L_8f7d4e
	.global L_8f7d6c
L_8f7d6c:
	bset_s r0,r0,0x8
	.global L_8f7d6e
L_8f7d6e:
	st_s r0,[r14,0x58]
L_8f7d70:
	brne_s r15,0,L_8f7da8
	.global L_8f7d72
L_8f7d72:
	ld_s r0,[r14,0x58]
L_8f7d74:
	mov_s r15,0x0
L_8f7d76:
	bic r0,r0,0x7
L_8f7d7a:
	or_s r0,r0,r13
L_8f7d7c:
	st_s r0,[r14,0x58]
L_8f7d7e:
	mov r17,0x10
	.global L_8f7d82
L_8f7d82:
	mov_s r1,0x10031b8
L_8f7d88:
	mov_s r0,0x882ed8
L_8f7d8e:
	ld.as r4,[r0,r15]
L_8f7d92:
	mov_s r0,0x2f
L_8f7d94:
	mov_s r2,r15
L_8f7d96:
	bl.d L_8dcd00
L_8f7d9a:
	mov_s r3,r13
L_8f7d9c:
	sub r17,r17,0x1
L_8f7da0:
	/* brhs.d r17,0x1,0x008f7d82 */
	.byte 0xe3,0x09,0x75,0xa0
L_8f7da4:
	/* _add_s r15,0x1 */
	.byte 0x01,0xe7
L_8f7da6:
	b_s L_8f7d36
	.global L_8f7da8
L_8f7da8:
	mov_s r0,blink
L_8f7daa:
	bl.d L_8c9b28
L_8f7dae:
	mov_s r1,0xac
L_8f7db0:
	b_s L_8f7d72
	.global L_8f7db2
L_8f7db2:
	ld_s r2,[r14,0xc]
L_8f7db4:
	mov_s r1,0x10031dc
L_8f7dba:
	bl.d L_8dcc10
L_8f7dbe:
	mov_s r0,0x2f
L_8f7dc0:
	ld_s r2,[r14,0x4]
L_8f7dc2:
	mov_s r1,0x1003210
L_8f7dc8:
	bl.d L_8dcc10
L_8f7dcc:
	mov_s r0,0x2f
L_8f7dce:
	ld_s r2,[r14,0x8]
L_8f7dd0:
	mov_s r1,0x100325c
L_8f7dd6:
	bl.d L_8dcc10
L_8f7dda:
	mov_s r0,0x2f
L_8f7ddc:
	mov_s r13,0x882300
L_8f7de2:
	ld_s r2,[r13,0x34]
L_8f7de4:
	mov_s r1,0x1003288
L_8f7dea:
	bl.d L_8dcc10
L_8f7dee:
	mov_s r0,0x2f
L_8f7df0:
	ld_s r2,[r13,0x38]
L_8f7df2:
	mov_s r1,0x10032d4
L_8f7df8:
	bl.d L_8dcc10
L_8f7dfc:
	mov_s r0,0x2f
L_8f7dfe:
	ld_s r2,[r13,0x3c]
L_8f7e00:
	mov_s r1,0x1003320
L_8f7e06:
	bl.d L_8dcc10
L_8f7e0a:
	mov_s r0,0x2f
L_8f7e0c:
	ld_s r2,[r13,0x40]
L_8f7e0e:
	mov_s r1,0x100336c
L_8f7e14:
	bl.d L_8dcc10
L_8f7e18:
	mov_s r0,0x2f
L_8f7e1a:
	mov_s r13,0x882280
L_8f7e20:
	ld_s r2,[r13,0x50]
L_8f7e22:
	mov_s r1,0x10033b8
L_8f7e28:
	bl.d L_8dcc10
L_8f7e2c:
	mov_s r0,0x2f
L_8f7e2e:
	ld_s r2,[r13,0x54]
L_8f7e30:
	mov_s r1,0x1003404
L_8f7e36:
	bl.d L_8dcc10
L_8f7e3a:
	mov_s r0,0x2f
L_8f7e3c:
	ld_s r2,[r13,0x58]
L_8f7e3e:
	mov_s r1,0x1003450
L_8f7e44:
	bl.d L_8dcc10
L_8f7e48:
	mov_s r0,0x2f
L_8f7e4a:
	ld_s r2,[r13,0x5c]
L_8f7e4c:
	mov_s r1,0x100349c
L_8f7e52:
	bl.d L_8dcc10
L_8f7e56:
	mov_s r0,0x2f
L_8f7e58:
	b L_8c023c
