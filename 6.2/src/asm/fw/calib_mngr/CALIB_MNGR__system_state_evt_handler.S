/* CALIB_MNGR__system_state_evt_handler @ 0x8e8688, 236 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   CALIB_MNGR::system_state_evt_handler (sys_state_evt=%d,param=%d)
 *   CALIB_MNGR::system_state_evt_handler SYS_STATE_EVT_PAUSE_CALIBS
 *   CALIB_MNGR::system_state_evt_handler SYS_STATE_EVT_RESUME_CALIBS
 * Зовут его: calib_mgr_ut, l2_mgr__high_false_alarm_secondary_lock_cb, rm_ch_switch_sm__switch_on, sys_state__broadcast
 * Зовёт сам: CALIB_MNGR__update_pcp_ap, CALIB_MNGR__update_sys_state, __ld_r16_to_r13_ret, __st_r16_to_r13, calib_mngr__restart_scheme, channels_switch_sm__switch_to_channel, fw_log_emit0, fw_log_emit2, fw_sysassert_fatal, platform__is_asic
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global CALIB_MNGR__system_state_evt_handler
CALIB_MNGR__system_state_evt_handler:
	.global L_8e8688
L_8e8688:
	push_s blink
L_8e868a:
	bl L_8c01dc
L_8e868e:
	mov_s r13,r0
L_8e8690:
	bl.d L_8da61c
L_8e8694:
	mov_s r16,r1
L_8e8696:
	cmp_s r0,0x0
L_8e8698:
	beq_s L_8e876e
L_8e869a:
	bl.d L_8ead00
L_8e869e:
	mov_s r0,r13
L_8e86a0:
	bl.d L_8eac58
L_8e86a4:
	mov_s r0,r13
L_8e86a6:
	brhs r13,0x17,L_8e8762
L_8e86aa:
	ldb.x r13,[0x80220c,r13]
L_8e86b2:
	add r0,pcl,0xa
L_8e86b6:
	add1_s r0,r0,r13
L_8e86b8:
	j_s [r0]
L_8e86ba:
	mov_s r0,0x1
L_8e86bc:
	mov_s r1,r0
L_8e86be:
	bl.d L_8e4a94
L_8e86c2:
	mov_s r2,0x0
L_8e86c4:
	mov_s r0,0x0
L_8e86c6:
	mov_s r1,0x1
	.global L_8e86c8
L_8e86c8:
	bl.d L_8e4a94
L_8e86cc:
	ld.as r2,[gp,-0x5]
L_8e86d0:
	b_s L_8e876e
L_8e86d2:
	bl.d L_8c5e64
L_8e86d6:
	mov_s r0,r16
L_8e86d8:
	breq_s r0,0,L_8e86fa
L_8e86da:
	mov_s r1,0x100929c
L_8e86e0:
	mov_s r0,0x26
L_8e86e2:
	mov_s r2,0x1
L_8e86e4:
	bl.d L_8dcc80
L_8e86e8:
	mov_s r3,r16
L_8e86ea:
	ld_s r0,[gp,-0x14]
L_8e86ec:
	mov_s r1,0x1
L_8e86ee:
	cmp_s r0,0x2
L_8e86f0:
	mov_s r0,0x0
L_8e86f2:
	mov_s r2,0x1
L_8e86f4:
	sub_s.ne r2,r2,r2
L_8e86f6:
	bl L_8e4a94
	.global L_8e86fa
L_8e86fa:
	ld.as r2,[gp,-0x5]
L_8e86fe:
	cmp_s r2,0x4
L_8e8700:
	mov.eq r0,0x0
L_8e8704:
	bl.eq.d L_8e4a94
L_8e8708:
	mov.eq r1,0x1
L_8e870c:
	b_s L_8e876e
L_8e870e:
	mov_s r1,0x10092e0
L_8e8714:
	bl.d L_8dcba8
L_8e8718:
	mov_s r0,0x26
L_8e871a:
	mov_s r0,0x1
L_8e871c:
	mov_s r13,0x0
L_8e871e:
	mov_s r1,0x0
L_8e8720:
	bl.d L_8e4a94
L_8e8724:
	ld.as r2,[gp,-0x5]
L_8e8728:
	stb r13,[gp, 0xca]
L_8e872c:
	b_s L_8e876e
L_8e872e:
	mov_s r0,0x1
L_8e8730:
	mov_s r1,0x0
L_8e8732:
	b_s L_8e86c8
L_8e8734:
	mov_s r1,0x1009320
L_8e873a:
	bl.d L_8dcba8
L_8e873e:
	mov_s r0,0x26
L_8e8740:
	mov_s r0,0x1
L_8e8742:
	stb r0,[gp, 0xca]
L_8e8746:
	b_s L_8e874e
L_8e8748:
	ld_s r0,[gp,-0x14]
L_8e874a:
	brne r0,0x3,L_8e8754
	.global L_8e874e
L_8e874e:
	mov_s r0,0x1
L_8e8750:
	mov_s r1,r0
L_8e8752:
	b_s L_8e86c8
	.global L_8e8754
L_8e8754:
	mov_s r0,blink
L_8e8756:
	mov_s r1,0x133c
L_8e875c:
	bl L_8c9b28
L_8e8760:
	b_s L_8e874e
	.global L_8e8762
L_8e8762:
	mov_s r0,blink
L_8e8764:
	mov_s r1,0x12e9
L_8e876a:
	bl L_8c9b28
	.global L_8e876e
L_8e876e:
	b L_8c0244
L_8e8772:
	nop_s
