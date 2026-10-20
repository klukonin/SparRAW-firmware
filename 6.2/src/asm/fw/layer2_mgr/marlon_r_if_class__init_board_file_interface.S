/* marlon_r_if_class__init_board_file_interface @ 0x8f5700, 484 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if_class::init_board_file_interface: Failed to initialize board file interface. Check board file
 *   marlon_r_if_class::init_board_file_interface: Perform baseband configurations from board file
 *   marlon_r_if_class::init_board_file_interface: No topology info
 *   init_board_file_interface: wrong rx_rf_modules(0x%x)!= rf_modules(0x%x)
 *   marlon_r_if_class::init_board_file_interface: connected_rfc:%x %u usage_mode:%u
 * Зовут его: init_rf_hw
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, brd_if__build_tx_sector_list, brd_if_multi_array__init, fw_divmod_signed, fw_log_emit0, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, marlon_r_if_class__load_brd_parameters_section, rf_if__num_tx_sectors, rf_power_off
 * Глобалы (через gp): 0x800243
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global marlon_r_if_class__init_board_file_interface
marlon_r_if_class__init_board_file_interface:
	.global L_8f5700
L_8f5700:
	push_s blink
L_8f5702:
	bl.d L_8c01cc
L_8f5706:
	mov_s r2,0x9
L_8f5708:
	mov_s r16,r0
L_8f570a:
	add_s r14,r0,0x4
L_8f570c:
	mov_s r0,r14
L_8f570e:
	mov_s r1,0x84f800
L_8f5714:
	bl.d L_8d8fe4
L_8f5718:
	asl_s r2,r2,0xa
L_8f571a:
	mov_s r13,0x0
L_8f571c:
	brne_s r0,0,L_8f572e
L_8f571e:
	mov_s r1,0x1005a78
L_8f5724:
	bl.d L_8dcba8
L_8f5728:
	mov_s r0,r13
L_8f572a:
	mov_s r0,r13
L_8f572c:
	b_s L_8f58e0
	.global L_8f572e
L_8f572e:
	st r14,[r16, 0x58]
L_8f5732:
	mov_s r1,0x1005ae4
L_8f5738:
	bl.d L_8dcba8
L_8f573c:
	mov_s r0,0x20
L_8f573e:
	mov_s r2,r16
L_8f5740:
	ld_s r0,[r14,0x44]
L_8f5742:
	add r2,r2,0x45c
L_8f5746:
	ld_s r3,[r0,0x4]
L_8f5748:
	mov_s r0,r14
L_8f574a:
	jl_s.d [r3]
L_8f574c:
	mov_s r1,r13
L_8f574e:
	brne_s r0,0,L_8f5764
L_8f5750:
	mov_s r1,0x1005b44
L_8f5756:
	bl.d L_8dcba8
L_8f575a:
	mov_s r0,r13
L_8f575c:
	st r13,[r16, 0x58]
L_8f5760:
	mov_s r0,r13
L_8f5762:
	b_s L_8f58e0
	.global L_8f5764
L_8f5764:
	mov_s r0,r16
L_8f5766:
	bl.d L_8dc690
L_8f576a:
	mov_s r1,0x80
L_8f576c:
	brne_s r0,0,L_8f5784
L_8f576e:
	mov_s r0,0x8042c8
L_8f5774:
	bl L_8e2fa8
L_8f5778:
	mov_s r0,blink
L_8f577a:
	mov_s r1,0x1185
L_8f5780:
	bl L_8c9b28
	.global L_8f5784
L_8f5784:
	bl.d L_8ddbbc
L_8f5788:
	mov_s r0,r14
L_8f578a:
	mov r19,0x857800
L_8f5792:
	ld r1,[r19, -0x74]
L_8f5796:
	ld r0,[r19, -0x70]
L_8f579a:
	mov r17,0x857780
L_8f57a2:
	or.f 0x0,r1,r0
L_8f57a6:
	bne_s L_8f58b6
L_8f57a8:
	bl.d L_8cb7e8
L_8f57ac:
	mov_s r0,r16
L_8f57ae:
	mov r20,r16
L_8f57b2:
	add r20,r20,0x440
L_8f57b6:
	ldb r3,[r20, 0x1c]
L_8f57ba:
	mov_s r15,r0
L_8f57bc:
	mov_s r1,0x1
L_8f57be:
	brne_s r3,0,L_8f57d8
L_8f57c0:
	ldb_s r0,[gp,0xbf]
L_8f57c2:
	mov_s r14,r1
L_8f57c4:
	sub_s r3,r0,0x1
L_8f57c6:
	bic r2,r0,r3
L_8f57ca:
	stb r2,[r20, 0x1c]
L_8f57ce:
	stb r2,[r20, 0x1d]
L_8f57d2:
	mov_s r3,r2
L_8f57d4:
	mov_s r18,r1
L_8f57d6:
	b_s L_8f5800
	.global L_8f57d8
L_8f57d8:
	mov_s r14,0x0
L_8f57da:
	mov_s r1,r3
L_8f57dc:
	b_s L_8f57e6
	.global L_8f57de
L_8f57de:
	sub_s r0,r1,0x1
L_8f57e0:
	and_s r1,r1,r0
L_8f57e2:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8f57e4:
	extw_s r14,r14
	.global L_8f57e6
L_8f57e6:
	brne_s r1,0,L_8f57de
L_8f57e8:
	ldb r2,[r20, 0x1d]
L_8f57ec:
	mov_s r1,r2
L_8f57ee:
	mov_s r0,0x0
L_8f57f0:
	b_s L_8f57fc
	.global L_8f57f2
L_8f57f2:
	sub_s r0,r1,0x1
L_8f57f4:
	and_s r1,r1,r0
L_8f57f6:
	add r0,r18,0x1
L_8f57fa:
	extw_s r0,r0
	.global L_8f57fc
L_8f57fc:
	mov_s r18,r0
L_8f57fe:
	brne_s r1,0,L_8f57f2
	.global L_8f5800
L_8f5800:
	brlt r18,0x2,L_8f5896
L_8f5804:
	breq r3,r2,L_8f5820
L_8f5808:
	mov_s r1,0x1005b84
L_8f580e:
	bl.d L_8dcc80
L_8f5812:
	mov_s r0,0x0
L_8f5814:
	mov_s r0,blink
L_8f5816:
	mov_s r1,0x1573
L_8f581c:
	bl L_8c9b28
	.global L_8f5820
L_8f5820:
	mov_s r0,r15
L_8f5822:
	bl.d L_8c02dc
L_8f5826:
	mov_s r1,r14
L_8f5828:
	extw r4,r0
L_8f582c:
	mov_s r3,0x0
L_8f582e:
	b_s L_8f5866
	.global L_8f5830
L_8f5830:
	bic_s r15,r15,r2
L_8f5832:
	mul64_s r3,r0
L_8f5834:
	add r1,r17,r3
L_8f5838:
	stb_s r15,[r1,0xc]
L_8f583a:
	add r2,r19,r3
L_8f583e:
	mov_s r15,0x1
L_8f5840:
	stb mlo,[r1, 0x14]
L_8f5844:
	stb r4,[r2, -0xcc]
L_8f5848:
	stb r15,[r2, -0xc4]
L_8f584c:
	stb_s r13,[r1,0x1c]
L_8f584e:
	sub_s r1,r0,0x1
L_8f5850:
	/* asl_s r3,r3,0x6 */
	.byte 0x06,0xbb
L_8f5852:
	add r15,r3,0x84783d
L_8f585a:
	stb_s r1,[r15]
L_8f585c:
	ldb r1,[r20, 0x1c]
L_8f5860:
	mov_s r3,r14
L_8f5862:
	stb r1,[r2, -0x5c]
	.global L_8f5866
L_8f5866:
	brge r3,r18,L_8f588a
L_8f586a:
	add_s r14,r3,0x1
L_8f586c:
	extw_s r14,r14
L_8f586e:
	ldb r15,[r20, 0x1c]
L_8f5872:
	brlt.d r14,0x2,L_8f5830
L_8f5876:
	sub_s r2,r15,0x1
L_8f5878:
	sub_s r1,r14,0x1
L_8f587a:
	extw lp_count,r1
L_8f587e:
	nop_s
L_8f5880:
	lp L_8f5888
L_8f5884:
	and_s r15,r15,r2
L_8f5886:
	sub_s r2,r15,0x1
	.global L_8f5888
L_8f5888:
	b_s L_8f5830
	.global L_8f588a
L_8f588a:
	mov_s r0,0x2
L_8f588c:
	mov_s r12,r16
L_8f588e:
	add r12,r12,0x468
L_8f5892:
	st_s r0,[r12]
L_8f5894:
	b_s L_8f58b2
	.global L_8f5896
L_8f5896:
	stb r3,[r17, 0xc]
L_8f589a:
	stb r15,[r19, -0xcc]
L_8f589e:
	stb r13,[r17, 0x14]
L_8f58a2:
	stb r13,[r17, 0x1c]
L_8f58a6:
	stb r13,[r19, -0xc4]
L_8f58aa:
	ldb r1,[r20, 0x1c]
L_8f58ae:
	stb r1,[r19, -0x5c]
	.global L_8f58b2
L_8f58b2:
	st r18,[r19, -0x98]
	.global L_8f58b6
L_8f58b6:
	ldb r2,[gp, 0xbf]
L_8f58ba:
	mov_s r1,r2
L_8f58bc:
	mov_s r3,0x0
L_8f58be:
	b_s L_8f58c8
	.global L_8f58c0
L_8f58c0:
	sub_s r0,r1,0x1
L_8f58c2:
	and_s r1,r1,r0
L_8f58c4:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8f58c6:
	extw_s r3,r3
	.global L_8f58c8
L_8f58c8:
	brne_s r1,0,L_8f58c0
L_8f58ca:
	ld r4,[r16,0x468]
L_8f58d2:
	mov_s r1,0x1005bcc
L_8f58d8:
	bl.d L_8dcd00
L_8f58dc:
	mov_s r0,0x20
L_8f58de:
	mov_s r0,0x1
	.global L_8f58e0
L_8f58e0:
	b L_8c0224
