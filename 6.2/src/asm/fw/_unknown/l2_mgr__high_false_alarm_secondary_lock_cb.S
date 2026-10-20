/* l2_mgr__high_false_alarm_secondary_lock_cb @ 0x8f3c9c, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_PMC_STATUS_EVENTID
 *   l2_mgr::high_false_alarm_secondary_lock_cb()  unlocking radio 0x%x
 *   l2_mgr::high_false_alarm_secondary_lock_cb release secondary. Patish took %d usec
 *   l2_mgr::high_false_alarm_secondary_lock_cb posting check_high_false_alarm_aging_cb
 * Зовут его: sched__apply_entry
 * Зовёт сам: CALIB_MNGR__system_state_evt_handler, __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit1, fw_sysapi_mgr__send_evt2host, fw_sysapi_mgr__stop_sysapi_cmd, radio_mgr__call_method_10, u_schd__now, u_schd__schedule
 * Глобалы (через gp): 0x800370, 0x800374
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__high_false_alarm_secondary_lock_cb
l2_mgr__high_false_alarm_secondary_lock_cb:
	.global L_8f3c9c
L_8f3c9c:
	push_s blink
L_8f3c9e:
	push_s r13
L_8f3ca0:
	mov_s r13,r0
L_8f3ca2:
	ld_s r0,[r1]
L_8f3ca4:
	st.a r0,[sp,-0x10]
L_8f3ca8:
	ld_s r0,[r1,0x4]
L_8f3caa:
	st_s r0,[sp,0x4]
L_8f3cac:
	ld_s r0,[r1,0x8]
L_8f3cae:
	st_s r0,[sp,0x8]
L_8f3cb0:
	ld_s r0,[r1,0xc]
L_8f3cb2:
	mov_s r1,0x10131a0
L_8f3cb8:
	st_s r0,[sp,0xc]
L_8f3cba:
	bl.d L_8dcba8
L_8f3cbe:
	mov_s r0,0x2b
L_8f3cc0:
	ld_s r1,[r13,0x20]
L_8f3cc2:
	mov_s r2,sp
L_8f3cc4:
	add r4,r13,0x4
L_8f3cc8:
	mov_s r0,r13
L_8f3cca:
	bl.d L_8f8948
L_8f3cce:
	mov_s r3,0x10
L_8f3cd0:
	ld_s r0,[sp,0x0]
L_8f3cd2:
	cmp_s r0,0x1
L_8f3cd4:
	mov.eq r0,r13
L_8f3cd8:
	bl.eq.d L_8f9bd0
L_8f3cdc:
	mov.eq r1,0x8
L_8f3ce0:
	b.d L_8c025c
L_8f3ce4:
	add_s sp,sp,0x10
L_8f3ce6:
	nop_s
L_8f3ce8:
	push_s blink
L_8f3cea:
	bl.d L_8c01e4
L_8f3cee:
	mov_s r0,0x13
L_8f3cf0:
	mov_s r14,r1
L_8f3cf2:
	mov_s r13,0x0
L_8f3cf4:
	bl.d L_8e8688
L_8f3cf8:
	mov_s r1,r13
L_8f3cfa:
	mov_s r1,0x100f3fc
L_8f3d00:
	mov_s r0,0x2c
L_8f3d02:
	bl.d L_8dcc10
L_8f3d06:
	ld.as r2,[gp,-0x12]
L_8f3d0a:
	bl.d L_8ea800
L_8f3d0e:
	ld_s r0,[gp,-0x48]
L_8f3d10:
	bl L_8e9524
L_8f3d14:
	mov_s r1,0x100f440
L_8f3d1a:
	sub_s r0,r0,r14
L_8f3d1c:
	asl_s r2,r0,0x4
L_8f3d1e:
	st.as r2,[gp,0x7c]
L_8f3d22:
	bl.d L_8dcc10
L_8f3d26:
	mov_s r0,0x2b
L_8f3d28:
	ld_s r0,[gp,0x1ec]
L_8f3d2a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f3d2c:
	st.as r0,[gp,0x7b]
L_8f3d30:
	ld_s r0,[gp,-0xa8]
L_8f3d32:
	st.as r13,[gp,-0x12]
L_8f3d36:
	brne_s r0,0,L_8f3d66
L_8f3d38:
	mov_s r1,0x100f494
L_8f3d3e:
	bl.d L_8dcba8
L_8f3d42:
	mov_s r0,0x2b
L_8f3d44:
	mov_s r0,L_8f1980-0x8c0000
L_8f3d4a:
	ld.as r1,[gp,0x7b]
L_8f3d4e:
	mov_s r2,r13
L_8f3d50:
	mov_s r3,0x1
L_8f3d52:
	mov r4,0x44aa20
L_8f3d5a:
	mov_s r5,r13
L_8f3d5c:
	bl.d L_8e0c0c
L_8f3d60:
	mov_s r6,r13
L_8f3d62:
	st.as r0,[gp,-0x2a]
	.global L_8f3d66
L_8f3d66:
	b L_8c0254
L_8f3d6a:
	nop_s
