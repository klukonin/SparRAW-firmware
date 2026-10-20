/* fsched_ap__start_slot @ 0x92b3bc, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap_sm
 * Зовёт сам: __ld_r13_to_r13_ret, field_rw_0x2c__9351f8, fsched__arm_slot_timer, fsched__get_cur_idx, fsched__tx_ctrl_frame, fsched_slot__clear_f4, fsched_slot__inc_f4_reached_7, mac__rf_switch_cmd1f, rx_mode__configure, uc_read_tsf_lo
 * Глобалы (через gp): 0x80053c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched_ap__start_slot
fsched_ap__start_slot:
	.global L_92b3bc
L_92b3bc:
	push_s blink
L_92b3be:
	bl.d L_934b14
L_92b3c2:
	push_s r13
L_92b3c4:
	mov_s r13,0x801be8
L_92b3ca:
	brne_s r0,0,L_92b41a
L_92b3cc:
	bl.d L_92c5e4
L_92b3d0:
	mov_s r0,0x1
L_92b3d2:
	mov_s r0,0x81
L_92b3d4:
	asl_s r0,r0,0x12
L_92b3d6:
	mov_s r32,r0
L_92b3d8:
	st.ab r0,[r25,0x4]
L_92b3dc:
	bclr r25,r25,0xa
L_92b3e0:
	bl.d L_927d54
L_92b3e4:
	mov_s r0,r13
L_92b3e6:
	mov_s r1,r0
L_92b3e8:
	bl.d L_92f4bc
L_92b3ec:
	mov_s r0,0x2
L_92b3ee:
	ldb_s r0,[gp,-0xee]
L_92b3f0:
	mov_s r2,0x6
L_92b3f2:
	mov_s r1,0x8007d4
L_92b3f8:
	add2_s r1,r1,r0
L_92b3fa:
	stb_s r2,[r1,0x2]
L_92b3fc:
	bl.d L_92acdc
L_92b400:
	mov_s r0,r13
L_92b402:
	breq_s r0,0,L_92b412
L_92b404:
	bl.d L_927d54
L_92b408:
	mov_s r0,r13
L_92b40a:
	extb_s r1,r0
L_92b40c:
	bl.d L_9351f8
L_92b410:
	mov_s r0,r13
	.global L_92b412
L_92b412:
	bl.d L_925014
L_92b416:
	mov_s r0,0xf
L_92b418:
	b_s L_92b444
	.global L_92b41a
L_92b41a:
	mov_s r0,0x14000100
L_92b420:
	mov_s r32,r0
L_92b422:
	st.ab r0,[r25,0x4]
L_92b426:
	bclr r25,r25,0xa
L_92b42a:
	bl.d L_924fa4
L_92b42e:
	mov_s r0,r13
L_92b430:
	mov_s r1,0x6
L_92b432:
	mov_s r0,0x80064c
L_92b438:
	bl.d L_9364c8
L_92b43c:
	st_s r1,[r0]
L_92b43e:
	st.as r0,[gp,0x5]
L_92b442:
	mov_s r0,0x2
	.global L_92b444
L_92b444:
	b L_9202ac
