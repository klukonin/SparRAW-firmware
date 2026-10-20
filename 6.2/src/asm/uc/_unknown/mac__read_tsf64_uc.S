/* mac__read_tsf64_uc @ 0x9356cc, 256 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__process_request_fifo, bi__tsf_delta64, bi_timing_snapshot_b, get_selected_rf_sector_index_cmd_handler, l1__enter_fixed_sched, l1__snapshot_bi_counter, l1_fixed_sched_ap__ev4_state4, rx_get_required_response, rx_listen__set_flag_and_stamp_tsf, uc_evt__enqueue
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, brp__write_reg_pair, rfca__select_rf_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__read_tsf64_uc
mac__read_tsf64_uc:
	.global L_9356cc
L_9356cc:
	st.a r13,[sp,-0x8]
L_9356d0:
	st_s r14,[sp,0x4]
L_9356d2:
	mov_s r14,blink
L_9356d4:
	ld.as r1,[gp,-0x11]
L_9356d8:
	mov_s r13,r0
L_9356da:
	and r1,r1,0xffff0fff
L_9356e2:
	or r0,r1,0x5000
L_9356ea:
	st.as r0,[gp,-0x11]
L_9356ee:
	or r1,r1,0x1d005000
L_9356f6:
	mov_s r32,r1
L_9356f8:
	st.ab r1,[r25,0x4]
L_9356fc:
	bclr r25,r25,0xa
L_935700:
	nop_s
L_935702:
	nop_s
L_935704:
	nop_s
L_935706:
	st r40,[r13]
L_93570a:
	ld.as r3,[gp,-0x11]
L_93570e:
	and r3,r3,0xffff0fff
L_935716:
	or r2,r3,0x6000
L_93571e:
	or r3,r3,0x1d006000
L_935726:
	st.as r2,[gp,-0x11]
L_93572a:
	mov_s r32,r3
L_93572c:
	st.ab r3,[r25,0x4]
L_935730:
	bclr r25,r25,0xa
L_935734:
	nop_s
L_935736:
	nop_s
L_935738:
	nop_s
L_93573a:
	st r40,[r13, 0x4]
L_93573e:
	mov_s blink,r14
L_935740:
	ld_s r14,[sp,0x4]
L_935742:
	j_s.d [blink]
L_935744:
	ld.ab r13,[sp,0x8]
L_935748:
	push_s blink
L_93574a:
	bl L_920230
L_93574e:
	mov_s r13,r0
L_935750:
	mov_s r15,r1
L_935752:
	mov_s r0,0x0
L_935754:
	stb.a r0,[sp,-0x4]
L_935758:
	mov_s r14,0x8006b4
L_93575e:
	mov_s r1,sp
L_935760:
	bl.d L_928b8c
L_935764:
	ldb_s r0,[r14,0x2]
L_935766:
	ldb_s r1,[r14,0x3]
L_935768:
	norm r1,r1
L_93576c:
	rsub r0,r1,0x1e
L_935770:
	extb_s r0,r0
L_935772:
	add r2,r0,0x8025e8
L_93577a:
	ldb_s r1,[r2,0x4]
L_93577c:
	add r3,r0,0x801450
L_935784:
	add_s r15,r15,r1
L_935786:
	max r15,r15,0x1
L_93578a:
	min r14,r15,0xf
L_93578e:
	extb_s r1,r14
L_935790:
	add_s r0,r0,0x80141c
L_935796:
	stb_s r14,[r3]
L_935798:
	breq r13,0x7fffff,L_9357ae
L_9357a0:
	ldb_s r2,[r2,0xc]
L_9357a2:
	add_s r2,r2,r13
L_9357a4:
	max r2,r2,0x1
L_9357a8:
	min r2,r2,0xf
L_9357ac:
	stb_s r2,[r0]
	.global L_9357ae
L_9357ae:
	ldb_s r2,[r0]
L_9357b0:
	mov r0,0x504
L_9357b4:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_9357b6:
	bl.d L_92f9d8
L_9357ba:
	or_s r1,r1,r2
L_9357bc:
	ldb_s r0,[sp,0x0]
L_9357be:
	bl.d L_928b8c
L_9357c2:
	mov_s r1,0x0
L_9357c4:
	b.d L_92029c
L_9357c8:
	add_s sp,sp,0x4
L_9357ca:
	nop_s
