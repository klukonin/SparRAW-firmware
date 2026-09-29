/* mid__state_is_2_or_3 @ 0x8da488, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__bi_evt_all_conns, conn_mgr__system_state_evt_handler, disconnect_by_peer, ese__peer_cid_by_aid, evt_fixed_scheduling_enabled, fixed_sched__start, info_flow__run, l2_mgr__lmac_new_link_evt_handler, l2_mgr__pcp_stop, l2_mgr__validate_scan
 * Зовёт сам: mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__state_is_2_or_3
mid__state_is_2_or_3:
	.global L_8da488
L_8da488:
	push_s blink
L_8da48a:
	bl L_8cc3dc
L_8da48e:
	ld_s r0,[r0,0x50]
L_8da490:
	mov_s r1,0x0
L_8da492:
	cmp_s r0,0x2
L_8da494:
	cmp.ne r0,0x3
L_8da498:
	mov.ne r0,r1
L_8da49c:
	bne_s L_8da4a0
L_8da49e:
	mov_s r0,0x1
	.global L_8da4a0
L_8da4a0:
	extb_s r0,r0
L_8da4a2:
	pop_s blink
L_8da4a4:
	j_s [blink]
L_8da4a6:
	nop_s
