/* l2mgr__mac_bringup @ 0x8f6ab8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: ftm_main_sm__radio_allocated_cb, hwd_mac__enable_multicast, l2mgr__bringup_pair, lmac_if__send_init_cfg, mac__set_886838_b0, mac_bringup__ack_and_unmask_irqs, mac_bringup__init_dma_ctrl, mac_bringup__init_rx_desc, mac_bringup__init_seq, mac_bringup__init_tx_queues, mac_bringup__prog_881000, mac_bringup__prog_881b00
 * Глобалы (через gp): 0x800314
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__mac_bringup
l2mgr__mac_bringup:
	.global L_8f6ab8
L_8f6ab8:
	push_s blink
L_8f6aba:
	bl L_8d0ebc
L_8f6abe:
	bl L_8fa6c4
L_8f6ac2:
	bl L_8f8144
L_8f6ac6:
	bl L_8f7f38
L_8f6aca:
	mov_s r0,0x0
L_8f6acc:
	bl.d L_8f6d54
L_8f6ad0:
	mov_s r1,0x1f
L_8f6ad2:
	bl L_8f3e5c
L_8f6ad6:
	bl L_8f6c4c
L_8f6ada:
	mov r0,-0x1
L_8f6ade:
	bl.d L_8d04d8
L_8f6ae2:
	mov_s r1,0x0
L_8f6ae4:
	bl L_8f3db8
L_8f6ae8:
	bl.d L_8dd8d0
L_8f6aec:
	mov_s r0,0x1
L_8f6aee:
	bl L_8fa7e8
L_8f6af2:
	bl L_8fa7a4
L_8f6af6:
	bl.d L_8f811c
L_8f6afa:
	mov_s r0,0x0
L_8f6afc:
	bl L_8f6c34
L_8f6b00:
	ld_s r0,[gp,0x190]
L_8f6b02:
	cmp_s r0,0x0
L_8f6b04:
	bl.ne L_8f6b0c
L_8f6b08:
	pop_s blink
L_8f6b0a:
	j_s [blink]
