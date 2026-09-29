/* sw_vring__ba_agreed @ 0x8c3724, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sw_vring::ba_agreed. win_size:%d, msdu_max_size: %d macq:%d
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bf_w_s0_w12, fw_log__emit3, get_g_8001f4, get_g_800230, hwd_dma__set_ring_field_99e0, l2mgr__send_ba_status_evt, mac_indirect__write_entry, mid__conn_state_ne_1, rx_chain__configure, sw_vring__program_ba_win
 * Глобалы (через gp): 0x800294
 */
	.section .text.sw_vring__ba_agreed,"ax",@progbits
	.global sw_vring__ba_agreed
sw_vring__ba_agreed:
L_8c3724:
	push_s blink
L_8c3726:
	bl L_8c02b0
L_8c372a:
	sub_s sp,sp,0x10
L_8c372c:
	mov_s r14,r0
L_8c372e:
	mov_s r16,r1
L_8c3730:
	mov_s r17,r2
L_8c3732:
	mov_s r18,r3
L_8c3734:
	bl.d L_8cacc0
L_8c3738:
	ldb_s r0,[r0,0x5]
L_8c373a:
	mov_s r15,sp
L_8c373c:
	mov_s r13,r0
L_8c373e:
	mov_s r0,r15
L_8c3740:
	ldb_s r1,[r13]
L_8c3742:
	mov_s r2,0x2
L_8c3744:
	mov_s r3,0x0
L_8c3746:
	bl.d L_8c4768
L_8c374a:
	mov r4,0x1
L_8c374e:
	ldw_s r1,[r13,0x6]
L_8c3750:
	add_s r0,sp,0x8
L_8c3752:
	add.f r1,r1,0x7
L_8c3756:
	add.mi r1,r1,0x7
L_8c375a:
	/* asr_s r1,r1,0x3 */
	.byte 0x43,0xb9
L_8c375c:
	bmsk_s r1,r1,0xb
L_8c375e:
	bl.d L_8e8318
L_8c3762:
	mov_s r2,0x2
L_8c3764:
	mov_s r0,r15
L_8c3766:
	ldb_s r1,[r13]
L_8c3768:
	mov_s r3,0x0
L_8c376a:
	mov_s r4,r3
L_8c376c:
	mov_s r5,r3
L_8c376e:
	mov_s r6,r3
L_8c3770:
	bl.d L_8c46a4
L_8c3774:
	mov r7,0x1
L_8c3778:
	ldw r4,[r13, 0x6]
L_8c377c:
	mov_s r2,0x100f048
L_8c3782:
	ldb r5,[r14, 0x5]
L_8c3786:
	mov_s r0,0x7
L_8c3788:
	mov_s r1,0x2
L_8c378a:
	bl.d L_8ee034
L_8c378e:
	mov_s r3,r16
L_8c3790:
	mov_s r0,0x0
L_8c3792:
	bl.d L_8cdd24
L_8c3796:
	asr r1,r16,0x3
L_8c379a:
	ld_s r0,[r14]
L_8c379c:
	bl.d L_8ed820
L_8c37a0:
	ldb r19,[r0, 0x8]
L_8c37a4:
	mov_s r6,r0
L_8c37a6:
	ldw r5,[r14, 0xc8]
L_8c37aa:
	mov_s r0,r13
L_8c37ac:
	mov_s r1,0x6
L_8c37ae:
	ldb_s r2,[r14,0x4]
L_8c37b0:
	mov_s r3,r16
L_8c37b2:
	bl.d L_8e5304
L_8c37b6:
	mov r4,r19
L_8c37ba:
	bl.d L_8de858
L_8c37be:
	ldb_s r0,[r14,0x7]
L_8c37c0:
	extb r5,r18
L_8c37c4:
	mov_s r0,r14
L_8c37c6:
	ldb_s r1,[r14,0x7]
L_8c37c8:
	mov_s r2,0x0
L_8c37ca:
	mov_s r3,r16
L_8c37cc:
	bl.d L_8e061c
L_8c37d0:
	mov r4,r17
L_8c37d4:
	ld_s r0,[gp,0x124]
L_8c37d6:
	brne_s r0,0,L_8c3804
L_8c37d8:
	bl.d L_8ca828
L_8c37dc:
	mov_s r0,0x2
L_8c37de:
	bl.d L_8cabdc
L_8c37e2:
	mov_s r16,r0
L_8c37e4:
	bl.d L_8cabcc
L_8c37e8:
	mov_s r15,r0
L_8c37ea:
	mov_s r13,r0
L_8c37ec:
	extw r4,r0
L_8c37f0:
	ldb_s r1,[r14,0x4]
L_8c37f2:
	extb_s r3,r15
L_8c37f4:
	mov_s r0,r16
L_8c37f6:
	bl.d L_8c3b48
L_8c37fa:
	mov_s r2,0x0
L_8c37fc:
	mov_s r0,0x2
L_8c37fe:
	bl.d L_8df4cc
L_8c3802:
	mov_s r1,r13
	.global L_8c3804
L_8c3804:
	b.d L_8c030c
