/* lm_if__start_link_loss_monitoring @ 0x8e2874, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if::start_link_loss_monitoring: cid=%d, is_enabled=%d
 * Зовут его: conn_mgr__set_link_maintain_cfg, conn_mgr__system_state_evt_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bad_beacons_detector__arm, fw_log__emit2, ka_necessity_detector__start_monitoring, lm_if__get_cid, tx_ppdu_ageing_timeout_detector__start_monitoring
 */
	.section .text.lm_if__start_link_loss_monitoring,"ax",@progbits
	.global lm_if__start_link_loss_monitoring
lm_if__start_link_loss_monitoring:
	.global L_8e2874
L_8e2874:
	b.d L_8e287c
L_8e2878:
	add_s r0,r0,0x64
L_8e287a:
	nop_s
	.global L_8e287c
L_8e287c:
	push_s blink
L_8e287e:
	bl L_8c02c4
L_8e2882:
	bl.d L_8c9d8c
L_8e2886:
	mov_s r13,r0
L_8e2888:
	mov_s r3,r0
L_8e288a:
	ld_s r14,[r13,0x48]
L_8e288c:
	mov_s r2,0x1010f18
L_8e2892:
	sub.f r4,r14,0x0
L_8e2896:
	mov_s r0,0xb
L_8e2898:
	mov.ne r4,0x1
L_8e289c:
	bl.d L_8edff8
L_8e28a0:
	mov_s r1,0x2
L_8e28a2:
	ld_s r0,[r13,0x48]
L_8e28a4:
	cmp_s r0,0x0
L_8e28a6:
	bl.ne L_8e29d4
L_8e28aa:
	ld_s r0,[r13,0x48]
L_8e28ac:
	cmp_s r0,0x0
L_8e28ae:
	bl.ne.d L_8e28ec
L_8e28b2:
	add2.ne r0,r0,0x15
L_8e28b6:
	ld_s r0,[r13,0x48]
L_8e28b8:
	cmp_s r0,0x0
L_8e28ba:
	bl.ne.d L_8e28d8
L_8e28be:
	add3.ne r0,r0,0x13
L_8e28c2:
	.byte 0x75,0x02
