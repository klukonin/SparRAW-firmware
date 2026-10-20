/* lmac_if_config_txss @ 0x8db60c, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_config_txss: total sectors %d ,cid %d
 * Зовут его: conn__config_txss_and_sta, lm_sm__action_8daed8, lmac_if__config_txss_8
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, conn_mgr__by_cid, fw_log_emit2, fw_sysassert_fatal, lmac_cmd_pool__alloc, lmac_if__post_cmd, rf_if__tx_sectors_vcall_14, sector_list__validate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_config_txss
lmac_if_config_txss:
	.global L_8db60c
L_8db60c:
	push_s blink
L_8db60e:
	bl L_8c01d8
L_8db612:
	sub_s sp,sp,0x44
L_8db614:
	bl.d L_8c3284
L_8db618:
	mov_s r15,r0
L_8db61a:
	mov_s r14,r0
L_8db61c:
	stb_s r15,[r0]
L_8db61e:
	mov r17,0x857800
L_8db626:
	ldb r0,[r17, -0xc4]
L_8db62a:
	brlt.d r0,0x2,L_8db634
L_8db62e:
	mov_s r13,0x0
L_8db630:
	brne r15,0x8,L_8db638
	.global L_8db634
L_8db634:
	mov_s r1,r13
L_8db636:
	b_s L_8db6b6
	.global L_8db638
L_8db638:
	bl.d L_8cbffc
L_8db63c:
	mov_s r0,r15
L_8db63e:
	breq_s r0,0,L_8db634
L_8db640:
	ldw_s r13,[r0,0xc]
L_8db642:
	ldb r1,[r17, -0xc4]
L_8db646:
	mov r16,0xffff
L_8db64e:
	brge r13,r1,L_8db65a
	.global L_8db652
L_8db652:
	brne r13,r16,L_8db66e
L_8db656:
	mov_s r1,0x0
L_8db658:
	b_s L_8db6b6
	.global L_8db65a
L_8db65a:
	cmp_s r13,r16
L_8db65c:
	mov.ne r0,blink
L_8db660:
	mov.ne r1,0x1575
L_8db668:
	bl.ne L_8c9b28
L_8db66c:
	b_s L_8db652
	.global L_8db66e
L_8db66e:
	ld r0,[r17, -0x50]
L_8db672:
	add1_s r0,r0,r13
L_8db674:
	ldb_s r1,[r0,0x1]
L_8db676:
	ldb_s r2,[r0]
L_8db678:
	sub r0,r1,r2
L_8db67c:
	add r17,r0,0x1
L_8db680:
	extb r17,r17
L_8db684:
	cmp r17,0x40
L_8db688:
	bgt.d L_8db6fa
L_8db68c:
	mov r16,sp
	.global L_8db690
L_8db690:
	mov_s r1,r17
L_8db692:
	mov_s r2,0x0
L_8db694:
	brlt.d r1,0x1,L_8db6ac
L_8db698:
	mov_s r0,sp
L_8db69a:
	extb lp_count,r1
L_8db69e:
	lp L_8db6ac
L_8db6a2:
	stb_s r2,[r0]
L_8db6a4:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8db6a6:
	extb_s r2,r2
L_8db6a8:
	add r0,sp,r2
	.global L_8db6ac
L_8db6ac:
	mov_s r1,0xff
L_8db6ae:
	stb_s r1,[r0]
L_8db6b0:
	stb r13,[r14, 0x4d]
L_8db6b4:
	mov_s r1,r16
	.global L_8db6b6
L_8db6b6:
	mov_s r0,0x0
L_8db6b8:
	brne_s r1,0,L_8db6ca
L_8db6ba:
	stb r0,[r14, 0x4d]
L_8db6be:
	mov_s r0,0x8042c8
L_8db6c4:
	bl L_8cb7f8
L_8db6c8:
	mov_s r1,r0
	.global L_8db6ca
L_8db6ca:
	add_s r0,r14,0x4
L_8db6cc:
	mov_s r2,0x0
L_8db6ce:
	bl.d L_8d9ac8
L_8db6d2:
	mov_s r3,r2
L_8db6d4:
	breq_s r0,0,L_8db708
	.global L_8db6d6
L_8db6d6:
	ldb r2,[r14, 0x4c]
L_8db6da:
	mov_s r1,0x1003b38
L_8db6e0:
	mov_s r0,0x20
L_8db6e2:
	bl.d L_8dcc80
L_8db6e6:
	mov_s r3,r15
L_8db6e8:
	mov_s r0,r14
L_8db6ea:
	mov_s r1,0xc
L_8db6ec:
	mov_s r2,0x50
L_8db6ee:
	bl.d L_8e5204
L_8db6f2:
	mov_s r3,0x0
L_8db6f4:
	b.d L_8c023c
L_8db6f8:
	add_s sp,sp,0x44
	.global L_8db6fa
L_8db6fa:
	mov_s r0,blink
L_8db6fc:
	mov_s r1,0x1576
L_8db702:
	bl L_8c9b28
L_8db706:
	b_s L_8db690
	.global L_8db708
L_8db708:
	mov_s r0,blink
L_8db70a:
	mov_s r1,0x136a
L_8db710:
	bl L_8c9b28
L_8db714:
	b_s L_8db6d6
L_8db716:
	nop_s
