/* lmac_if__send_phy_ina_det_cfg @ 0x8d8824, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending CMD_PHY_INA_DET_CFG [ad_out_of_txop_en=%d, ad_in_txop_en=%d]
 * Зовут его: lmac_if__lmac_ready_evt, wmi_handler_cfg_rx_chain
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, lmac_mbox__alloc_slot, memcpy_fw, send_cmd2_lmac
 */
	.section .text.lmac_if__send_phy_ina_det_cfg,"ax",@progbits
	.global lmac_if__send_phy_ina_det_cfg
lmac_if__send_phy_ina_det_cfg:
	.global L_8d8824
L_8d8824:
	push_s blink
L_8d8826:
	bl L_8c02c4
L_8d882a:
	bl.d L_8c2b0c
L_8d882e:
	mov_s r14,r0
L_8d8830:
	mov_s r13,r0
L_8d8832:
	mov_s r1,r14
L_8d8834:
	bl.d L_8c0460
L_8d8838:
	mov_s r2,0x24
L_8d883a:
	ld_s r14,[r13,0x20]
L_8d883c:
	mov_s r2,0x1003e8c
L_8d8842:
	lsr_s r3,r14
L_8d8844:
	mov_s r0,0xb
L_8d8846:
	mov_s r1,0x2
L_8d8848:
	bmsk_s r3,r3,0x0
L_8d884a:
	bl.d L_8edff8
L_8d884e:
	bmsk r4,r14,0x0
L_8d8852:
	mov_s r0,r13
L_8d8854:
	mov_s r1,0x20
L_8d8856:
	mov_s r2,0x24
L_8d8858:
	bl.d L_8e0694
L_8d885c:
	mov_s r3,0x0
L_8d885e:
	b L_8c0334
L_8d8862:
	nop_s
