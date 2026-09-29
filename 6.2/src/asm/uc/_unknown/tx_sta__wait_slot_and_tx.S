/* tx_sta__wait_slot_and_tx @ 0x93a5fc, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_sta__run_txop
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mac__select_rf_module_cmd31, mac_q__tx_ppdu, rx_flow__run, sxd_hal__wait_slot2_busy2, tx__pick_slot_for_peer
 * Глобалы (через gp): 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_sta__wait_slot_and_tx
tx_sta__wait_slot_and_tx:
	.global L_93a5fc
L_93a5fc:
	push_s blink
L_93a5fe:
	bl L_920230
L_93a602:
	mov_s r14,r0
L_93a604:
	ld_s r0,[gp,0xd0]
L_93a606:
	mov_s r15,r1
L_93a608:
	bmsk.f 0x0,r0,0x4
L_93a60c:
	mov_s r13,0x1
L_93a60e:
	beq_s L_93a6d0
L_93a610:
	bl.d L_936cc8
L_93a614:
	ldw_s r0,[gp,-0x20]
L_93a616:
	breq r0,0x0,L_93a6bc
L_93a61a:
	bl L_930dd4
L_93a61e:
	ld_s r0,[gp,0xd0]
L_93a620:
	bbit1 r0,0x7,L_93a648
L_93a624:
	ld_s r1,[r14]
L_93a626:
	mov_s r0,0x0
L_93a628:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93a62a:
	add2_s r1,r1,r1
L_93a62c:
	add r2,r1,0x857e48
L_93a634:
	stb_s r0,[r2]
L_93a636:
	stb_s r13,[r15]
L_93a638:
	mov_s r2,0x8010b0
L_93a63e:
	ldw_s r1,[r2,0x30]
L_93a640:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_93a642:
	extw_s r1,r1
L_93a644:
	stw_s r1,[r2,0x30]
L_93a646:
	b_s L_93a6b8
	.global L_93a648
L_93a648:
	bclr r1,r0,0x8
L_93a64c:
	st.as r1,[gp,0x34]
L_93a650:
	bbit0 r1,0x2,L_93a674
	.global L_93a654
L_93a654:
	ldb_s r1,[r14]
L_93a656:
	mov_s r0,0x1
L_93a658:
	bl.d L_925698
L_93a65c:
	ldb_s r2,[r14,0x4]
L_93a65e:
	ld_s r1,[r14]
L_93a660:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93a662:
	add2_s r1,r1,r1
L_93a664:
	add_s r1,r1,0x857e38
L_93a66a:
	ldb_s r0,[r1,0x10]
L_93a66c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93a66e:
	stb_s r0,[r1,0x10]
L_93a670:
	mov_s r0,0x1
L_93a672:
	b_s L_93a6b8
	.global L_93a674
L_93a674:
	bic.f r0,r0,-0x6
L_93a678:
	beq_s L_93a6b6
L_93a67a:
	ld_s r0,[r14]
L_93a67c:
	mov_s r2,0x0
L_93a67e:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_93a680:
	add2_s r0,r0,r0
L_93a682:
	add r1,r0,0x857e48
L_93a68a:
	stb_s r2,[r1]
L_93a68c:
	ldb_s r1,[r14]
L_93a68e:
	mov_s r0,0x0
L_93a690:
	bl.d L_925698
L_93a694:
	ldb_s r2,[r14,0x4]
L_93a696:
	mov_s r1,0x8010b0
L_93a69c:
	ldw_s r0,[r1,0x32]
L_93a69e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93a6a0:
	extw_s r0,r0
L_93a6a2:
	stw_s r0,[r1,0x32]
L_93a6a4:
	b_s L_93a6b6
	.global L_93a6a6
L_93a6a6:
	mov_s r0,0x0
L_93a6a8:
	bl.d L_93cfdc
L_93a6ac:
	mov_s r1,r0
L_93a6ae:
	mov_s r0,r14
L_93a6b0:
	bl.d L_939888
L_93a6b4:
	mov_s r1,0x2
	.global L_93a6b6
L_93a6b6:
	mov_s r0,r13
	.global L_93a6b8
L_93a6b8:
	b L_92029c
	.global L_93a6bc
L_93a6bc:
	ld_s r0,[gp,0xd0]
L_93a6be:
	bclr_s r0,r0,0x8
L_93a6c0:
	st.as r0,[gp,0x34]
L_93a6c4:
	bbit1 r0,0x2,L_93a654
L_93a6c8:
	ld_s r0,[r14,0xc]
L_93a6ca:
	bbit0 r0,0x1,L_93a6b6
L_93a6ce:
	b_s L_93a6a6
	.global L_93a6d0
L_93a6d0:
	bclr_s r0,r0,0x11
L_93a6d2:
	st.as r0,[gp,0x34]
L_93a6d6:
	b_s L_93a6b6
