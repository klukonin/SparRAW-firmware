/* l2mgr__data_port_open @ 0x8ed5fc, 320 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   layer2_mgr.cpp
 *   L2MGR Data port open failed stream of CID %d is not idle!!!
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit1, fw_sysassert_fatal, l2mgr__disconnect_sta, l2mgr__send_data_port_open_evt, l2mgr__send_vring_en_evt, l2mgr__vring_drained, mac_indirect__write_entry, mac_parser__clear_rule, mac_parser__set_ba_rule, mid__conn_state_ne_1
 * Глобалы (через gp): 0x800294
 */
	.section .text.l2mgr__data_port_open,"ax",@progbits
	.global l2mgr__data_port_open
l2mgr__data_port_open:
L_8ed5fc:
	push_s blink
L_8ed5fe:
	bl L_8c02b8
L_8ed602:
	sub_s sp,sp,0x8
L_8ed604:
	bl.d L_8e7240
L_8ed608:
	mov_s r13,r0
L_8ed60a:
	cmp_s r0,0x0
L_8ed60c:
	beq_s L_8ed712
L_8ed60e:
	bl.d L_8caae0
L_8ed612:
	mov_s r0,r13
L_8ed614:
	mov_s r14,r0
L_8ed616:
	ld_s r0,[gp,0x124]
L_8ed618:
	cmp_s r0,0x0
L_8ed61a:
	bne_s L_8ed6e0
L_8ed61c:
	bl.d L_8ed820
L_8ed620:
	mov_s r0,r13
L_8ed622:
	cmp_s r0,0x0
L_8ed624:
	beq_s L_8ed6e0
L_8ed626:
	cmp_s r14,0x0
L_8ed628:
	beq_s L_8ed6fa
	.global L_8ed62a
L_8ed62a:
	ldb r16,[r14, 0x4]
L_8ed62e:
	bl.d L_8ca828
L_8ed632:
	mov_s r0,0x2
L_8ed634:
	mov_s r17,r0
	.global L_8ed636
L_8ed636:
	mov_s r0,0x886e80
L_8ed63c:
	ld_s r15,[r0,0x4c]
L_8ed63e:
	mov_s r0,0xa0
L_8ed640:
	mov lp_count,r0
L_8ed644:
	nop_s
L_8ed646:
	lp L_8ed64e
L_8ed64a:
	nop_s
L_8ed64c:
	nop_s
	.global L_8ed64e
L_8ed64e:
	bbit1 r15,0x3,L_8ed636
L_8ed652:
	ldb_s r0,[r13,0x8]
L_8ed654:
	bl.d L_8dba18
L_8ed658:
	mov_s r1,r16
L_8ed65a:
	bl.d L_8c3c14
L_8ed65e:
	mov_s r0,r17
L_8ed660:
	bl.d L_8db3cc
L_8ed664:
	mov_s r0,r17
L_8ed666:
	mov_s r15,sp
L_8ed668:
	mov_s r0,r15
L_8ed66a:
	mov_s r1,0x2
L_8ed66c:
	mov_s r2,0x1
L_8ed66e:
	mov_s r3,r1
L_8ed670:
	bl.d L_8c4768
L_8ed674:
	mov_s r4,r2
L_8ed676:
	ld_s r0,[sp,0x0]
L_8ed678:
	mov_s r1,0x2
L_8ed67a:
	bclr_s r0,r0,0x12
L_8ed67c:
	st_s r0,[sp,0x0]
L_8ed67e:
	mov_s r0,r15
L_8ed680:
	mov_s r2,0x1
L_8ed682:
	mov_s r3,r1
L_8ed684:
	mov r4,0x0
L_8ed688:
	mov r5,r4
L_8ed68c:
	mov r6,r4
L_8ed690:
	bl.d L_8c46a4
L_8ed694:
	mov_s r7,r2
L_8ed696:
	mov_s r1,0x880c00
L_8ed69c:
	ld_s r0,[r1,0x18]
L_8ed69e:
	or r0,r0,0x9
L_8ed6a2:
	st_s r0,[r1,0x18]
L_8ed6a4:
	mov r0,0x320
L_8ed6a8:
	mov lp_count,r0
L_8ed6ac:
	nop_s
L_8ed6ae:
	lp L_8ed6b6
L_8ed6b2:
	nop_s
L_8ed6b4:
	nop_s
	.global L_8ed6b6
L_8ed6b6:
	mov_s r1,0x880c00
L_8ed6bc:
	ld_s r0,[r1,0x18]
L_8ed6be:
	bic r0,r0,0x9
L_8ed6c2:
	st_s r0,[r1,0x18]
L_8ed6c4:
	mov r0,0x320
L_8ed6c8:
	mov lp_count,r0
L_8ed6cc:
	nop_s
L_8ed6ce:
	lp L_8ed6d6
L_8ed6d2:
	nop_s
L_8ed6d4:
	nop_s
	.global L_8ed6d6
L_8ed6d6:
	ldb_s r0,[r13,0x8]
L_8ed6d8:
	mov_s r1,r16
L_8ed6da:
	bl.d L_8db898
L_8ed6de:
	mov_s r2,0x2
	.global L_8ed6e0
L_8ed6e0:
	ldb_s r15,[r13,0x8]
L_8ed6e2:
	ld_s r0,[r13,0xc]
L_8ed6e4:
	ldb_s r13,[r0,0x10]
L_8ed6e6:
	breq_s r14,0,L_8ed6f0
L_8ed6e8:
	ldb_s r0,[r14,0x7]
L_8ed6ea:
	bl.d L_8f0bd4
L_8ed6ee:
	mov_s r1,r13
	.global L_8ed6f0
L_8ed6f0:
	mov_s r0,r15
L_8ed6f2:
	bl.d L_8f04b0
L_8ed6f6:
	mov_s r1,r13
L_8ed6f8:
	b_s L_8ed732
	.global L_8ed6fa
L_8ed6fa:
	mov_s r0,blink
L_8ed6fc:
	mov_s r2,0x100c474
L_8ed702:
	mov_s r1,0x147d
L_8ed708:
	bl.d L_8c82c0
L_8ed70c:
	mov r3,0x14b
L_8ed710:
	b_s L_8ed62a
	.global L_8ed712
L_8ed712:
	mov_s r2,0x100c6b4
L_8ed718:
	mov_s r0,0xb
L_8ed71a:
	mov_s r1,0x0
L_8ed71c:
	bl.d L_8edfcc
L_8ed720:
	ldb_s r3,[r13,0x8]
L_8ed722:
	ld_s r0,[r13,0xc]
L_8ed724:
	add r14,r13,0x10
L_8ed728:
	ldb_s r0,[r0,0x10]
L_8ed72a:
	mov_s r1,r14
L_8ed72c:
	bl.d L_8eb494
L_8ed730:
	mov_s r2,0x1
	.global L_8ed732
L_8ed732:
	bl.d L_8e35cc
L_8ed736:
	mov_s r0,0x6
L_8ed738:
	b.d L_8c031c
