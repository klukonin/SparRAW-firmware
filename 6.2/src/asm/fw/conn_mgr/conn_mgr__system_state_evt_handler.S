/* conn_mgr__system_state_evt_handler @ 0x8e8954, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::system_state_evt_handler: evt=SYS_STATE_EVT_ASSOC_DONE cid=%d
 *   conn_mgr::system_state_evt_handler: evt=SYS_STATE_EVT_UNASSOC_START cid=%d
 *   conn_mgr::system_state_evt_handler: evt=SYS_STATE_EVT_SHALLOW_SLEEP_ENTER/PAUSE
 *   conn_mgr::system_state_evt_handler: evt=SYS_STATE_EVT_SHALLOW_SLEEP_EXIT/RESUME
 * Зовут его: sys_state__broadcast
 * Зовёт сам: conn_mgr__apply_default_link_maintain_cfg, conn_mgr__bi_evt_all_conns, conn_mgr__by_cid, conn_mgr__rearm_all_detectors, conn_mgr__resume_all_vrings, conn_mgr__stop_link_loss_monitoring, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, lm_if__start_link_loss_monitoring, mid__state_is_2_or_3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__system_state_evt_handler
conn_mgr__system_state_evt_handler:
	.global L_8e8954
L_8e8954:
	st.a r16,[sp,-0x4]
L_8e8958:
	push_s blink
L_8e895a:
	brhs.d r0,0x17,L_8e89dc
L_8e895e:
	mov_s r16,r1
L_8e8960:
	ldw.x.as r0,[0x802388,r0]
L_8e8968:
	add r1,pcl,0x8
L_8e896c:
	add1_s r1,r1,r0
L_8e896e:
	j_s [r1]
L_8e8970:
	bl.d L_8da488
L_8e8974:
	mov_s r0,0x0
L_8e8976:
	bl.d L_8c3a5c
L_8e897a:
	mov_s r1,0x0
L_8e897c:
	b_s L_8e89e8
L_8e897e:
	mov_s r1,0x100bf48
L_8e8984:
	mov_s r0,0x2b
L_8e8986:
	bl.d L_8dcc10
L_8e898a:
	mov_s r2,r16
L_8e898c:
	bl.d L_8cbffc
L_8e8990:
	mov_s r0,r16
L_8e8992:
	bl L_8e7a7c
L_8e8996:
	b_s L_8e89e8
L_8e8998:
	mov_s r1,0x100bf90
L_8e899e:
	mov_s r0,0x2b
L_8e89a0:
	bl.d L_8dcc10
L_8e89a4:
	mov_s r2,r16
L_8e89a6:
	bl.d L_8cbffc
L_8e89aa:
	mov_s r0,r16
L_8e89ac:
	bl L_8e7fb4
L_8e89b0:
	b_s L_8e89e8
L_8e89b2:
	mov_s r1,0x100bfdc
L_8e89b8:
	bl.d L_8dcba8
L_8e89bc:
	mov_s r0,0x2b
L_8e89be:
	bl L_8e00a4
L_8e89c2:
	b_s L_8e89e8
L_8e89c4:
	mov_s r1,0x100c02c
L_8e89ca:
	bl.d L_8dcba8
L_8e89ce:
	mov_s r0,0x2b
L_8e89d0:
	bl L_8e2c2c
L_8e89d4:
	b_s L_8e89e8
L_8e89d6:
	bl L_8cd8f4
L_8e89da:
	b_s L_8e89e8
	.global L_8e89dc
L_8e89dc:
	mov_s r0,blink
L_8e89de:
	mov_s r1,0x1341
L_8e89e4:
	bl L_8c9b28
	.global L_8e89e8
L_8e89e8:
	pop_s blink
L_8e89ea:
	j_s.d [blink]
L_8e89ec:
	ld.ab r16,[sp,0x4]
