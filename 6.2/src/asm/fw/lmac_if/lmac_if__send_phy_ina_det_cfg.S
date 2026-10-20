/* lmac_if__send_phy_ina_det_cfg @ 0x8dbb24, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending CMD_PHY_INA_DET_CFG [ad_out_of_txop_en=%d, ad_in_txop_en=%d]
 * Зовут его: lmac_if__lmac_ready_evt, wmi_cfg_rx_chain
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, lmac_cmd_pool__alloc, lmac_if__post_cmd, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__send_phy_ina_det_cfg
lmac_if__send_phy_ina_det_cfg:
	.global L_8dbb24
L_8dbb24:
	push_s blink
L_8dbb26:
	bl L_8c01e4
L_8dbb2a:
	bl.d L_8c3284
L_8dbb2e:
	mov_s r14,r0
L_8dbb30:
	mov_s r13,r0
L_8dbb32:
	mov_s r1,r14
L_8dbb34:
	bl.d L_8c0380
L_8dbb38:
	mov_s r2,0x24
L_8dbb3a:
	ld_s r3,[r13,0x20]
L_8dbb3c:
	mov_s r1,0x1003a90
L_8dbb42:
	lsr_s r2,r3
L_8dbb44:
	mov_s r0,0x2b
L_8dbb46:
	bmsk_s r2,r2,0x0
L_8dbb48:
	bl.d L_8dcc80
L_8dbb4c:
	bmsk_s r3,r3,0x0
L_8dbb4e:
	mov_s r0,r13
L_8dbb50:
	mov_s r1,0x20
L_8dbb52:
	mov_s r2,0x24
L_8dbb54:
	bl.d L_8e5204
L_8dbb58:
	mov_s r3,0x0
L_8dbb5a:
	b L_8c0254
L_8dbb5e:
	nop_s
