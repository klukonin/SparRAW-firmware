/* l2mgr__mac_bringup @ 0x8ee6cc, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: hwd_mac__enable_multicast, lmac_if__send_init_cfg, lmac_if_send_cmd_0x07, mac_bringup__init_rx_desc, mac_bringup__init_tx_queues, mac_bringup__phy_init, mac_bringup__prog_881000, mac_bringup__prog_881b00, mac_bringup__program_886800, mac_parser__configure, rf_chain_dist_config, rgf_reg_886800
 * Глобалы (через gp): 0x800300
 */
	.section .text.l2mgr__mac_bringup,"ax",@progbits
	.global l2mgr__mac_bringup
l2mgr__mac_bringup:
	.global L_8ee6cc
L_8ee6cc:
	push_s blink
L_8ee6ce:
	bl L_8ce15c
L_8ee6d2:
	bl L_8f2784
L_8ee6d6:
	bl L_8efe10
L_8ee6da:
	bl L_8efb90
L_8ee6de:
	mov_s r0,0x0
L_8ee6e0:
	bl.d L_8ee9cc
L_8ee6e4:
	mov_s r1,0x1f
L_8ee6e6:
	bl L_8ec114
L_8ee6ea:
	bl L_8ee8a8
L_8ee6ee:
	mov r0,-0x1
L_8ee6f2:
	bl.d L_8cd64c
L_8ee6f6:
	mov_s r1,0x0
L_8ee6f8:
	bl L_8ec070
L_8ee6fc:
	bl.d L_8d9b44
L_8ee700:
	mov_s r0,0x1
L_8ee702:
	bl L_8f28a4
L_8ee706:
	bl L_8f2860
L_8ee70a:
	bl.d L_8efddc
L_8ee70e:
	mov_s r0,0x0
L_8ee710:
	bl L_8ee890
L_8ee714:
	ld_s r0,[gp,0x190]
L_8ee716:
	cmp_s r0,0x0
L_8ee718:
	bl.ne L_8ee720
L_8ee71c:
	pop_s blink
L_8ee71e:
	j_s [blink]
