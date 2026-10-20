/* uc_sysassert @ 0x926618, 348 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Crash TSF: curr tsf 0x%08x %08x assert 0x%04x
 *   SYSTEM FATAL CRASH0: curr_blink=0x%X, prev_blink =0x%X, SYSASSERT_CODE_0x%x
 *   SYSTEM FATAL CRASH1: sp=%d, ilink1=0x%X, ilink2=0x%X
 *   PRS_ICR=0x%08X
 *   mrfc_switch2tx_status_bus=0x%08X
 *   mrfc_switch2rx_status_bus=0x%08X
 * Зовут его: abft_responder__tx_ssw, abif__save_override_restore, abif__set_88a204_field, abif__set_enable_bit, arc__program_action_point, aw_worker__collect_awake_peers, background_task__dispatch, bf__reset_sta_slot, bf_gpc__program_mac_by_mode_b, bf_init_sm
 * Зовёт сам: phy_rx__set_ina_det_mode_uc, uc_log__emit1, uc_log__emit3, uc_sysassert__emit_mac_trace, uc_sysassert__idle_hist, uc_sysassert__snapshot_mac, uc_sysassert__write_code
 * Глобалы (через gp): 0x800558, 0x80055c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_sysassert
uc_sysassert:
	.global L_926618
L_926618:
	st.a r13,[sp,-0x10]
L_92661c:
	st blink,[sp, 0x4]
L_926620:
	st_s r14,[sp,0x8]
L_926622:
	st_s r15,[sp,0xc]
L_926624:
	ld.as r2,[gp,0xd]
L_926628:
	mov_s r15,r0
L_92662a:
	cmp_s r2,0x0
L_92662c:
	sub sp,sp,0x8
L_926630:
	bne.d L_926764
L_926634:
	mov_s r13,r1
L_926636:
	mov r6,0x1
L_92663a:
	st.as r6,[gp,0xd]
L_92663e:
	mov_s r1,sp
L_926640:
	mov r0,0x0
L_926644:
	bl.d L_93756c
L_926648:
	mov r2,r0
L_92664c:
	ld_s r2,[sp,0x4]
L_92664e:
	mov_s r1,0x10001e8
L_926654:
	ld_s r3,[sp,0x0]
L_926656:
	mov_s r0,0x20
L_926658:
	bl.d L_92d338
L_92665c:
	mov r4,r13
L_926660:
	mov r5,0x857000
L_926668:
	st r13,[r5, 0x14]
L_92666c:
	st r15,[r5, 0x18]
L_926670:
	mov_s r2,0x80eeeeee
L_926676:
	mov_s r32,r2
L_926678:
	st.ab r2,[r25,0x4]
L_92667c:
	bclr r25,r25,0xa
L_926680:
	bset r1,r13,0x1f
L_926684:
	mov r32,r1
L_926688:
	st.ab r1,[r25,0x4]
L_92668c:
	bclr r25,r25,0xa
L_926690:
	ror r0,0x1
L_926694:
	mov r32,r0
L_926698:
	st.ab r0,[r25,0x4]
L_92669c:
	bclr r25,r25,0xa
L_9266a0:
	mov_s r3,blink
L_9266a2:
	mov_s r1,0x1000218
L_9266a8:
	mov_s r0,0x0
L_9266aa:
	mov_s r2,r15
L_9266ac:
	bl.d L_92d338
L_9266b0:
	mov r4,r13
L_9266b4:
	mov_s r2,sp
L_9266b6:
	mov_s r3,ilink1
L_9266b8:
	mov r4,ilink2
L_9266bc:
	mov r1,0x1000264
L_9266c4:
	bl.d L_92d338
L_9266c8:
	mov r0,0x0
L_9266cc:
	ld r2,[0x886210]
L_9266d4:
	mov r1,0x100029c
L_9266dc:
	bl.d L_92d1d0
L_9266e0:
	mov r0,0x20
L_9266e4:
	mov_s r14,0x887000
L_9266ea:
	ld r2,[r14, -0xc4]
L_9266ee:
	mov_s r1,0x10002ac
L_9266f4:
	bl.d L_92d1d0
L_9266f8:
	mov r0,0x20
L_9266fc:
	ld r2,[r14, -0xc0]
L_926700:
	mov r1,0x10002d0
L_926708:
	bl.d L_92d1d0
L_92670c:
	mov r0,0x20
L_926710:
	bl L_926478
L_926714:
	ld.as r4,[gp,-0x2d]
L_926718:
	cmp r4,0x1
L_92671c:
	bl.eq.d L_929c04
L_926720:
	mov.eq r0,0x0
L_926724:
	bl.d L_92f2f0
L_926728:
	mov r0,0xd
L_92672c:
	bl.d L_929d04
L_926730:
	mov r0,0x1
L_926734:
	st.as r13,[gp,-0x1c]
L_926738:
	st.as r13,[gp,-0x1a]
L_92673c:
	st.as r15,[gp,-0x1d]
L_926740:
	st.as r25,[gp,0xc]
L_926744:
	mov_s r3,0x40
L_926746:
	st.as r3,[r14,-0x6b]
L_92674a:
	st.as r3,[r14,-0x6e]
L_92674e:
	nop_s
L_926750:
	nop_s
L_926752:
	nop_s
L_926754:
	nop_s
L_926756:
	flag 0x1
L_92675a:
	nop_s
L_92675c:
	nop_s
L_92675e:
	nop_s
L_926760:
	mov 0x0,0x0
	.global L_926764
L_926764:
	add_s sp,sp,0x8
L_926766:
	ld blink,[sp, 0x4]
L_92676a:
	ld_s r14,[sp,0x8]
L_92676c:
	ld_s r15,[sp,0xc]
L_92676e:
	j_s.d [blink]
L_926770:
	ld.ab r13,[sp,0x10]
