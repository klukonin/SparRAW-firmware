/* mid__state_is_2_or_3 @ 0x8d73c4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: L2MGR__system_state_evt_handler, conn_mgr__foreach_on_boot_done, conn_mgr__system_state_evt_handler, disconnect_by_peer, hw_sysapi_config_short_vec, info_flow__run, info_flow__start_periodic, l2_mgr__lmac_new_link_evt_handler, l2_mgr__pcp_stop, l2_mgr__validate_scan
 * Зовёт сам: mid_list__by_mid
 */
	.section .text.mid__state_is_2_or_3,"ax",@progbits
	.global mid__state_is_2_or_3
mid__state_is_2_or_3:
	.global L_8d73c4
L_8d73c4:
	push_s blink
L_8d73c6:
	bl L_8ca1b0
L_8d73ca:
	ld_s r0,[r0,0x50]
L_8d73cc:
	mov_s r1,0x0
L_8d73ce:
	cmp_s r0,0x2
L_8d73d0:
	cmp.ne r0,0x3
L_8d73d4:
	mov.ne r0,r1
L_8d73d8:
	bne_s L_8d73dc
L_8d73da:
	mov_s r0,0x1
	.global L_8d73dc
L_8d73dc:
	extb_s r0,r0
L_8d73de:
	pop_s blink
L_8d73e0:
	j_s [blink]
L_8d73e2:
	nop_s
