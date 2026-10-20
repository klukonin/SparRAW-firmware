/* CALIB_MNGR__system_state_evt_handler @ 0x8e3614, 256 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   CALIB_MNGR::system_state_evt_handler (sys_state_evt=%d,param=%d)
 *   CALIB_MNGR::system_state_evt_handler SYS_STATE_EVT_PAUSE_CALIBS
 *   CALIB_MNGR::system_state_evt_handler SYS_STATE_EVT_RESUME_CALIBS
 *   calib_mngr.cpp
 * Зовут его: L2MGR__system_state_evt_handler, calib_mgr_ut, l2_mgr__high_false_alarm_secondary_lock_cb, rm_ch_switch_sm__switch_on
 * Зовёт сам: CALIB_MNGR__update_pcp_ap, CALIB_MNGR__update_sys_state, __ld_r16_to_r13_ret, __st_r16_to_r13, calib_mngr__restart_scheme, calib_mngr__switch_channel, fw_log__emit0, fw_log__emit2, fw_sysassert_fatal, get_reg_880a3c_8d7540
 */
	.section .text.CALIB_MNGR__system_state_evt_handler,"ax",@progbits
	.global CALIB_MNGR__system_state_evt_handler
CALIB_MNGR__system_state_evt_handler:
	.global L_8e3614
L_8e3614:
	push_s blink
L_8e3616:
	bl L_8c02bc
L_8e361a:
	mov_s r13,r0
L_8e361c:
	bl.d L_8d7540
L_8e3620:
	mov_s r16,r1
L_8e3622:
	cmp_s r0,0x0
L_8e3624:
	beq_s L_8e370e
L_8e3626:
	bl.d L_8e5a2c
L_8e362a:
	mov_s r0,r13
L_8e362c:
	bl.d L_8e5918
L_8e3630:
	mov_s r0,r13
L_8e3632:
	cmp_s r13,0x16
L_8e3634:
	bhi L_8e36fa
L_8e3638:
	ldb.x r13,[0x801d08,r13]
L_8e3640:
	add r0,pcl,0x8
L_8e3644:
	add1_s r0,r0,r13
L_8e3646:
	j_s [r0]
L_8e3648:
	mov_s r0,0x1
L_8e364a:
	mov_s r1,r0
L_8e364c:
	bl.d L_8dfdd8
L_8e3650:
	mov_s r2,0x0
L_8e3652:
	mov_s r0,0x0
L_8e3654:
	mov_s r1,0x1
	.global L_8e3656
L_8e3656:
	bl.d L_8dfdd8
L_8e365a:
	ld.as r2,[gp,-0x2]
L_8e365e:
	b_s L_8e370e
L_8e3660:
	bl.d L_8c5034
L_8e3664:
	mov_s r0,r16
L_8e3666:
	breq_s r0,0,L_8e3686
L_8e3668:
	mov_s r2,0x10085fc
L_8e366e:
	mov_s r0,0x6
L_8e3670:
	mov_s r1,0x2
L_8e3672:
	mov_s r3,0x1
L_8e3674:
	bl.d L_8edff8
L_8e3678:
	mov r4,r16
L_8e367c:
	mov_s r0,0x0
L_8e367e:
	mov_s r1,0x1
L_8e3680:
	bl.d L_8dfdd8
L_8e3684:
	mov_s r2,0x0
	.global L_8e3686
L_8e3686:
	ld.as r2,[gp,-0x2]
L_8e368a:
	cmp_s r2,0x3
L_8e368c:
	mov.eq r0,0x0
L_8e3690:
	bl.eq.d L_8dfdd8
L_8e3694:
	mov.eq r1,0x1
L_8e3698:
	b_s L_8e370e
L_8e369a:
	mov_s r2,0x1008640
L_8e36a0:
	mov_s r0,0x6
L_8e36a2:
	bl.d L_8edfb0
L_8e36a6:
	mov_s r1,0x2
L_8e36a8:
	mov_s r0,0x1
L_8e36aa:
	mov_s r13,0x0
L_8e36ac:
	mov_s r1,0x0
L_8e36ae:
	bl.d L_8dfdd8
L_8e36b2:
	ld.as r2,[gp,-0x2]
L_8e36b6:
	stb r13,[gp, 0xc7]
L_8e36ba:
	b_s L_8e370e
L_8e36bc:
	mov_s r0,0x1
L_8e36be:
	mov_s r1,0x0
L_8e36c0:
	b_s L_8e3656
L_8e36c2:
	mov_s r2,0x1008680
L_8e36c8:
	mov_s r0,0x6
L_8e36ca:
	bl.d L_8edfb0
L_8e36ce:
	mov_s r1,0x2
L_8e36d0:
	mov_s r0,0x1
L_8e36d2:
	stb r0,[gp, 0xc7]
L_8e36d6:
	b_s L_8e36de
L_8e36d8:
	ld_s r0,[gp,-0x8]
L_8e36da:
	brne r0,0x2,L_8e36e4
	.global L_8e36de
L_8e36de:
	mov_s r0,0x1
L_8e36e0:
	mov_s r1,r0
L_8e36e2:
	b_s L_8e3656
	.global L_8e36e4
L_8e36e4:
	mov_s r0,blink
L_8e36e6:
	mov_s r2,0x10085d4
L_8e36ec:
	mov_s r1,0x133c
L_8e36f2:
	bl.d L_8c82c0
L_8e36f6:
	mov_s r3,0xc2
L_8e36f8:
	b_s L_8e36de
	.global L_8e36fa
L_8e36fa:
	mov_s r0,blink
L_8e36fc:
	mov_s r2,0x10085d4
L_8e3702:
	mov_s r1,0x12e9
L_8e3708:
	bl.d L_8c82c0
L_8e370c:
	mov_s r3,0xce
	.global L_8e370e
L_8e370e:
	b L_8c0324
L_8e3712:
	nop_s
