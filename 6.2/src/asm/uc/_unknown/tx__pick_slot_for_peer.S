/* tx__pick_slot_for_peer @ 0x925698, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__start_rx_window, internal_tx__flow_sm2, internal_tx__flow_sm4, tx_sta__run_txop, tx_sta__wait_slot_and_tx
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, sta__queue_class
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx__pick_slot_for_peer
tx__pick_slot_for_peer:
	.global L_925698
L_925698:
	push_s blink
L_92569a:
	bl L_920230
L_92569e:
	mov_s r15,r0
L_9256a0:
	mov_s r0,r1
L_9256a2:
	mov_s r13,0x8015a4
L_9256a8:
	ld_s r1,[r13,0x10]
L_9256aa:
	sub_s sp,sp,0x4
L_9256ac:
	breq r1,0x0,L_925744
L_9256b0:
	bl.d L_927a00
L_9256b4:
	mov_s r1,r2
L_9256b6:
	mov_s r14,r0
L_9256b8:
	mov_s r1,0x8022c8
L_9256be:
	add2_s r13,r13,r0
L_9256c0:
	breq_s r15,0,L_9256dc
L_9256c2:
	ldb_s r0,[r13,0x2]
L_9256c4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9256c6:
	extb_s r0,r0
L_9256c8:
	stb_s r0,[r13,0x2]
L_9256ca:
	ldb_s r2,[r13,0x1]
L_9256cc:
	min r0,r2,r0
L_9256d0:
	extb_s r2,r0
L_9256d2:
	stb_s r0,[r13,0x2]
L_9256d4:
	ld_s r0,[r1,0x34]
L_9256d6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9256d8:
	st_s r0,[r1,0x34]
L_9256da:
	b_s L_9256e6
	.global L_9256dc
L_9256dc:
	ldb_s r2,[r13]
L_9256de:
	ld_s r0,[r1,0x38]
L_9256e0:
	stb_s r2,[r13,0x2]
L_9256e2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9256e4:
	st_s r0,[r1,0x38]
	.global L_9256e6
L_9256e6:
	mov_s r1,0x0
L_9256e8:
	bset r1,r1,r2
L_9256ec:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_9256ee:
	add r0,r14,0x9
L_9256f2:
	asl_s r0,r0,0x18
L_9256f4:
	or_s r0,r0,r1
L_9256f6:
	mov_s r32,r0
L_9256f8:
	st.ab r0,[r25,0x4]
L_9256fc:
	bclr r25,r25,0xa
L_925700:
	mov_s r0,0x801aa4
L_925706:
	ld_s r0,[r0]
L_925708:
	add_s r14,r14,sp
L_92570a:
	st_s r0,[sp,0x0]
L_92570c:
	mov_s r0,0x2
L_92570e:
	stb_s r0,[r14]
L_925710:
	ldb_s r0,[sp,0x0]
L_925712:
	ldb r1,[sp, 0x1]
L_925716:
	bset_s r0,r0,0x1b
L_925718:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_92571a:
	or_s r0,r0,r1
L_92571c:
	ldb r1,[sp, 0x2]
L_925720:
	mov_s r2,0x80146c
L_925726:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_925728:
	or_s r1,r1,r0
L_92572a:
	ldb r0,[sp, 0x3]
L_92572e:
	ld_s r2,[r2,0x8]
L_925730:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_925732:
	or_s r1,r1,r0
L_925734:
	ld_s r0,[gp,-0xd4]
L_925736:
	and_s r0,r0,r2
L_925738:
	or_s r1,r1,r0
L_92573a:
	mov_s r32,r1
L_92573c:
	st.ab r1,[r25,0x4]
L_925740:
	bclr r25,r25,0xa
	.global L_925744
L_925744:
	b.d L_92029c
L_925748:
	add_s sp,sp,0x4
L_92574a:
	nop_s
