/* conn_mgr__system_state_evt_handler @ 0x8e394c, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::system_state_evt_handler: evt=SYS_STATE_EVT_ASSOC_DONE cid=%d
 *   conn_mgr::system_state_evt_handler: evt=SYS_STATE_EVT_UNASSOC_START cid=%d
 *   conn_mgr::system_state_evt_handler: evt=SYS_STATE_EVT_SHALLOW_SLEEP_ENTER/PAUSE
 *   conn_mgr::system_state_evt_handler: evt=SYS_STATE_EVT_SHALLOW_SLEEP_EXIT/RESUME
 *   conn_mgr::system_state_evt_handler: evt=SYS_STATE_EVT_MAC_MONITOR
 *   conn_mgr.cpp
 * Зовут его: L2MGR__system_state_evt_handler
 * Зовёт сам: conn__stop_link_loss_monitoring, conn_mgr__apply_default_link_maintain_cfg, conn_mgr__by_cid, conn_mgr__foreach_active_link, conn_mgr__foreach_link_arm_timer, conn_mgr__foreach_on_boot_done, fw_log__emit0, fw_log__emit1, fw_sysassert_fatal, lm_if__start_link_loss_monitoring, mid__state_is_2_or_3
 */
	.section .text.conn_mgr__system_state_evt_handler,"ax",@progbits
	.global conn_mgr__system_state_evt_handler
conn_mgr__system_state_evt_handler:
	.global L_8e394c
L_8e394c:
	st.a r16,[sp,-0x4]
L_8e3950:
	push_s blink
L_8e3952:
	brhs.d r0,0x17,L_8e39ea
L_8e3956:
	mov_s r16,r1
L_8e3958:
	ldw.x.as r0,[0x801e4c,r0]
L_8e3960:
	add r1,pcl,0x8
L_8e3964:
	add1_s r1,r1,r0
L_8e3966:
	j_s [r1]
L_8e3968:
	bl.d L_8d73c4
L_8e396c:
	mov_s r0,0x0
L_8e396e:
	bl.d L_8c3160
L_8e3972:
	mov_s r1,0x0
L_8e3974:
	b_s L_8e39fe
L_8e3976:
	mov_s r2,0x100aaa4
L_8e397c:
	mov_s r0,0xb
L_8e397e:
	mov_s r1,0x2
L_8e3980:
	bl.d L_8edfcc
L_8e3984:
	mov_s r3,r16
L_8e3986:
	bl.d L_8c9e44
L_8e398a:
	mov_s r0,r16
L_8e398c:
	bl L_8e2874
L_8e3990:
	b_s L_8e39fe
L_8e3992:
	mov_s r2,0x100aaec
L_8e3998:
	mov_s r0,0xb
L_8e399a:
	mov_s r1,0x2
L_8e399c:
	bl.d L_8edfcc
L_8e39a0:
	mov_s r3,r16
L_8e39a2:
	bl.d L_8c9e44
L_8e39a6:
	mov_s r0,r16
L_8e39a8:
	bl L_8e2ec8
L_8e39ac:
	b_s L_8e39fe
L_8e39ae:
	mov_s r2,0x100ab38
L_8e39b4:
	mov_s r0,0xb
L_8e39b6:
	bl.d L_8edfb0
L_8e39ba:
	mov_s r1,0x2
L_8e39bc:
	bl L_8dbf90
L_8e39c0:
	b_s L_8e39fe
L_8e39c2:
	mov_s r2,0x100ab88
L_8e39c8:
	mov_s r0,0xb
L_8e39ca:
	bl.d L_8edfb0
L_8e39ce:
	mov_s r1,0x2
L_8e39d0:
	bl L_8de794
L_8e39d4:
	b_s L_8e39fe
L_8e39d6:
	mov_s r2,0x100abd8
L_8e39dc:
	mov_s r0,0xb
L_8e39de:
	bl.d L_8edfb0
L_8e39e2:
	mov_s r1,0x2
L_8e39e4:
	bl L_8cb4c0
L_8e39e8:
	b_s L_8e39fe
	.global L_8e39ea
L_8e39ea:
	mov_s r0,blink
L_8e39ec:
	mov_s r2,0x100a878
L_8e39f2:
	mov_s r1,0x1341
L_8e39f8:
	bl.d L_8c82c0
L_8e39fc:
	mov_s r3,0xae
	.global L_8e39fe
L_8e39fe:
	pop_s blink
L_8e3a00:
	j_s.d [blink]
L_8e3a02:
	ld.ab r16,[sp,0x4]
L_8e3a06:
	nop_s
