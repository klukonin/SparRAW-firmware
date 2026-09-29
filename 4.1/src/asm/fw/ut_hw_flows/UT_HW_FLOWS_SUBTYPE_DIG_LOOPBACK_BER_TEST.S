/* UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST @ 0x8e6514, 2376 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UT_HW_FLOWS_OPERATIONAL_cmd_handler:: ut_subtype_id=0x%x
 *   UT_HW_FLOWS_SUBTYPE_TEST_TRIAL_1 [0]=0x%x, [1]=0x%x
 *   UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST  [nFrames]=0x%x [Silence]=%d
 *   UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST  [MCS]=%d, [Length3]=%d
 *   reached UT_HW_FLOWS_SUBTYPE_CALIB_VGA_DC_ALG_FINE
 *   ut_hw_flows.c
 *   UT_HW_FLOWS_SUBTYPE_IF_LOOPBACK_BER_TEST  [nFrames]=0x%x [Silence]=%d
 *   UT_HW_FLOWS_SUBTYPE_IF_LOOPBACK_BER_TEST  [MCS]=%d, [Length3]=%d
 * Зовут его: wmi_ut_handler_dispatch
 * Зовёт сам: IF_GAIN__GAIN, __ld_r22_to_r13_ret, __st_r22_to_r13, approx_magnitude_b, basic_calib__run_step, ber_stats__snapshot, ber_test__accumulate_counters, ber_test__copy_counters, ber_test__measure, ber_test__read_lane_counters, bf_w_s20_w12, calib__delta_80161c
 */
	.section .text.UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST,"ax",@progbits
	.global UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST:
	.global L_8e6514
L_8e6514:
	push_s blink
L_8e6516:
	bl L_8c02a4
L_8e651a:
	sub_s sp,sp,0x54
L_8e651c:
	mov_s r17,r0
L_8e651e:
	mov_s r14,r1
L_8e6520:
	mov_s r1,0x9
L_8e6522:
	bl.d L_8e5b7c
L_8e6526:
	ldw_s r2,[r14,0x2]
L_8e6528:
	mov_s r16,r0
L_8e652a:
	mov_s r13,0x0
L_8e652c:
	mov_s r2,0x10171a0
L_8e6532:
	mov_s r0,r13
L_8e6534:
	mov_s r1,0x2
L_8e6536:
	bl.d L_8edfcc
L_8e653a:
	ldw_s r3,[r14,0x2]
L_8e653c:
	ldw_s r0,[r14,0x2]
L_8e653e:
	cmp r0,0x507
L_8e6542:
	beq.d L_8e6ae6
L_8e6546:
	mov_s r15,0x8
L_8e6548:
	bgt L_8e6708
L_8e654c:
	cmp r0,0x403
L_8e6550:
	beq L_8e69f0
L_8e6554:
	bgt L_8e66c4
L_8e6558:
	cmp r0,0x204
L_8e655c:
	beq L_8e68aa
L_8e6560:
	bgt L_8e65da
L_8e6564:
	cmp r0,0x201
L_8e6568:
	beq L_8e6898
L_8e656c:
	bgt L_8e65c2
L_8e6570:
	cmp_s r0,0x0
L_8e6572:
	beq L_8e681c
L_8e6576:
	cmp_s r0,0x1
L_8e6578:
	bne L_8e6e2e
L_8e657c:
	mov_s r2,0x10171dc
L_8e6582:
	ld r4,[r14, 0x8]
L_8e6586:
	mov_s r0,r13
L_8e6588:
	mov_s r1,0x2
L_8e658a:
	bl.d L_8edff8
L_8e658e:
	ld_s r3,[r14,0x4]
L_8e6590:
	bl L_8d7210
L_8e6594:
	cmp_s r0,0x0
L_8e6596:
	beq.d L_8e687a
L_8e659a:
	ld_s r1,[r14,0x4]
L_8e659c:
	bic.f r1,r1,0x7f
L_8e65a0:
	bne L_8e6866
	.global L_8e65a4
L_8e65a4:
	mov_s r0,0x886080
L_8e65aa:
	ld_s r2,[r0,0x54]
L_8e65ac:
	ld_s r1,[r14,0x4]
L_8e65ae:
	bic r2,r2,0xfe
L_8e65b2:
	asl_s r1,r1
L_8e65b4:
	or_s r1,r1,r2
L_8e65b6:
	st_s r1,[r0,0x54]
L_8e65b8:
	mov_s r13,0x12340001
L_8e65be:
	b L_8e6884
	.global L_8e65c2
L_8e65c2:
	cmp r0,0x202
L_8e65c6:
	beq L_8e68a4
L_8e65ca:
	cmp r0,0x203
L_8e65ce:
	bne L_8e6e2e
L_8e65d2:
	bl L_8d18cc
L_8e65d6:
	b L_8e689e
	.global L_8e65da
L_8e65da:
	cmp r0,0x402
L_8e65de:
	beq L_8e69dc
L_8e65e2:
	cmp r0,0x303
L_8e65e6:
	beq L_8e69b6
L_8e65ea:
	bgt L_8e669e
L_8e65ee:
	cmp r0,0x301
L_8e65f2:
	beq L_8e68b0
L_8e65f6:
	cmp r0,0x302
L_8e65fa:
	bne L_8e6e2e
L_8e65fe:
	mov_s r2,0x1017210
L_8e6604:
	ld r4,[r14, 0x8]
L_8e6608:
	mov_s r0,r13
L_8e660a:
	mov_s r1,0x2
L_8e660c:
	bl.d L_8edff8
L_8e6610:
	ld_s r3,[r14,0x4]
L_8e6612:
	mov_s r2,0x1017258
L_8e6618:
	ld r4,[r14, 0x10]
L_8e661c:
	mov_s r0,r13
L_8e661e:
	mov_s r1,0x2
L_8e6620:
	bl.d L_8edff8
L_8e6624:
	ld_s r3,[r14,0xc]
L_8e6626:
	bl L_8d7210
L_8e662a:
	cmp_s r0,0x0
L_8e662c:
	beq.d L_8e6996
L_8e6630:
	ld_s r1,[r14,0x4]
L_8e6632:
	bic.f r1,r1,0x7f
L_8e6636:
	bne L_8e6980
	.global L_8e663a
L_8e663a:
	mov_s r0,0x886080
L_8e6640:
	ld_s r1,[r0,0x54]
L_8e6642:
	ld_s r2,[r14,0x4]
L_8e6644:
	bic r1,r1,0xfe
L_8e6648:
	asl_s r2,r2
L_8e664a:
	or_s r1,r1,r2
L_8e664c:
	st_s r1,[r0,0x54]
L_8e664e:
	mov_s r13,0x12340302
L_8e6654:
	mov_s r0,0xc9
L_8e6656:
	st_s r0,[sp,0x10]
L_8e6658:
	mov_s r0,0xca
L_8e665a:
	st_s r0,[sp,0x14]
L_8e665c:
	mov_s r0,0xcb
L_8e665e:
	st_s r0,[sp,0x18]
L_8e6660:
	mov_s r0,0xcc
L_8e6662:
	st_s r0,[sp,0x1c]
L_8e6664:
	mov_s r0,0xcd
L_8e6666:
	st_s r0,[sp,0x20]
L_8e6668:
	mov_s r0,0xce
L_8e666a:
	st_s r0,[sp,0x24]
L_8e666c:
	mov_s r0,0xcf
L_8e666e:
	st_s r0,[sp,0x28]
L_8e6670:
	mov r0,0x4b1
L_8e6674:
	st_s r0,[sp,0x2c]
L_8e6676:
	mov r0,0x4b2
L_8e667a:
	st_s r0,[sp,0x30]
L_8e667c:
	mov r0,0x4b3
L_8e6680:
	st_s r0,[sp,0x34]
L_8e6682:
	mov r0,0x4b4
L_8e6686:
	st_s r0,[sp,0x38]
L_8e6688:
	mov r0,0x4b5
L_8e668c:
	st_s r0,[sp,0x3c]
L_8e668e:
	mov r0,0x4b6
L_8e6692:
	st_s r0,[sp,0x40]
L_8e6694:
	mov r0,0x4b7
L_8e6698:
	b.d L_8e69a8
L_8e669c:
	st_s r0,[sp,0x44]
	.global L_8e669e
L_8e669e:
	cmp r0,0x304
L_8e66a2:
	beq L_8e69d2
L_8e66a6:
	cmp r0,0x401
L_8e66aa:
	bne L_8e6e2e
L_8e66ae:
	mov_s r0,0x1
L_8e66b0:
	mov_s r1,0x1
L_8e66b2:
	mov_s r2,0x1
L_8e66b4:
	mov_s r3,0x1
L_8e66b6:
	bl.d L_8d3614
L_8e66ba:
	mov r4,0xd
L_8e66be:
	b.d L_8e6e46
L_8e66c2:
	mov_s r13,0x1
	.global L_8e66c4
L_8e66c4:
	cmp r0,0x40b
L_8e66c8:
	beq L_8e6a68
L_8e66cc:
	bgt_s L_8e66e8
L_8e66ce:
	sub r0,r0,0x404
L_8e66d2:
	cmp_s r0,0x6
L_8e66d4:
	bhi L_8e6e2e
L_8e66d8:
	ldw.x.as r0,[0x802d6c,r0]
L_8e66e0:
	add r1,pcl,0x8
L_8e66e4:
	add1_s r1,r1,r0
L_8e66e6:
	j_s [r1]
	.global L_8e66e8
L_8e66e8:
	sub r0,r0,0x501
L_8e66ec:
	cmp_s r0,0x5
L_8e66ee:
	bhi L_8e6e2e
L_8e66f2:
	add r2,pcl,0x18
L_8e66f6:
	ldw.x.as r0,[0x802d7c,r0]
L_8e66fe:
	mov_s r1,0x8006cc
L_8e6704:
	add1_s r2,r2,r0
L_8e6706:
	j_s [r2]
	.global L_8e6708
L_8e6708:
	cmp_s r0,0x902
L_8e670e:
	beq L_8e6bc6
L_8e6712:
	bgt L_8e67e0
L_8e6716:
	cmp r0,0x603
L_8e671a:
	beq L_8e6b78
L_8e671e:
	bgt L_8e677a
L_8e6722:
	cmp r0,0x602
L_8e6726:
	beq L_8e6b4c
L_8e672a:
	cmp r0,0x50a
L_8e672e:
	beq L_8e6b1e
L_8e6732:
	bgt_s L_8e6754
L_8e6734:
	cmp r0,0x508
L_8e6738:
	beq L_8e6b00
L_8e673c:
	cmp r0,0x509
L_8e6740:
	bne L_8e6e2e
L_8e6744:
	mov_s r0,0x84ee2c
L_8e674a:
	bl.d L_8ed5b8
L_8e674e:
	mov_s r13,0x1
L_8e6750:
	b L_8e6e46
	.global L_8e6754
L_8e6754:
	cmp r0,0x50b
L_8e6758:
	beq L_8e6b2c
L_8e675c:
	cmp r0,0x601
L_8e6760:
	bne L_8e6e2e
L_8e6764:
	mov_s r0,0x1
L_8e6766:
	mov_s r1,0x1
L_8e6768:
	mov_s r2,0x1
L_8e676a:
	mov_s r3,0x1
L_8e676c:
	bl.d L_8d3d0c
L_8e6770:
	mov r4,0xa
L_8e6774:
	b.d L_8e6e46
L_8e6778:
	mov_s r13,0x1
	.global L_8e677a
L_8e677a:
	cmp r0,0x700
L_8e677e:
	beq L_8e6b86
L_8e6782:
	bgt_s L_8e67b8
L_8e6784:
	cmp r0,0x609
L_8e6788:
	beq L_8e6b5a
L_8e678c:
	cmp r0,0x60a
L_8e6790:
	bne L_8e6e2e
L_8e6794:
	mov_s r2,0x101729c
L_8e679a:
	mov_s r0,0x6
L_8e679c:
	bl.d L_8edfb0
L_8e67a0:
	mov_s r1,0x2
L_8e67a2:
	ldb r4,[r14, 0x14]
L_8e67a6:
	ldb_s r0,[r14,0x4]
L_8e67a8:
	ld_s r1,[r14,0x8]
L_8e67aa:
	ldb_s r2,[r14,0xc]
L_8e67ac:
	bl.d L_8d3a70
L_8e67b0:
	ldb_s r3,[r14,0x10]
L_8e67b2:
	b.d L_8e6e46
L_8e67b6:
	mov_s r13,r0
	.global L_8e67b8
L_8e67b8:
	cmp r0,0x701
L_8e67bc:
	beq L_8e6b90
L_8e67c0:
	cmp_s r0,0x801
L_8e67c6:
	beq L_8e6ba0
L_8e67ca:
	cmp_s r0,0x901
L_8e67d0:
	bne L_8e6e2e
L_8e67d4:
	bl.d L_8d1ebc
L_8e67d8:
	mov_s r0,r13
L_8e67da:
	b.d L_8e6e46
L_8e67de:
	mov_s r13,0x1
	.global L_8e67e0
L_8e67e0:
	cmp_s r0,0x985
L_8e67e6:
	beq L_8e6dd4
L_8e67ea:
	cmp_s r0,0x984
L_8e67f0:
	beq L_8e6db4
L_8e67f4:
	cmp_s r0,0x983
L_8e67fa:
	beq L_8e6d94
L_8e67fe:
	sub r0,r0,0x903
L_8e6806:
	cmp_s r0,0x21
L_8e6808:
	bhi L_8e6e2e
L_8e680c:
	ldw.x.as r0,[0x802d88,r0]
L_8e6814:
	add r1,pcl,0x8
L_8e6818:
	add1_s r1,r1,r0
L_8e681a:
	j_s [r1]
	.global L_8e681c
L_8e681c:
	bl L_8d7210
L_8e6820:
	breq_s r0,0,L_8e6852
L_8e6822:
	mov_s r0,blink
L_8e6824:
	mov_s r2,0x10172d0
L_8e682a:
	mov_s r1,0xac
L_8e682c:
	bl.d L_8c82c0
L_8e6830:
	mov_s r3,0x91
L_8e6832:
	mov_s r1,0x886080
L_8e6838:
	ld_s r0,[r1,0x54]
L_8e683a:
	mov_s r13,0x12340000
L_8e6840:
	bic r0,r0,0xfe
L_8e6844:
	or r0,r0,0x22446688
L_8e684c:
	st_s r0,[r1,0x54]
L_8e684e:
	b L_8e6e46
	.global L_8e6852
L_8e6852:
	mov_s r0,0x884000
L_8e6858:
	st 0x55443311,[r0, 0x5c]
L_8e6860:
	b.d L_8e6e46
L_8e6864:
	mov_s r13,0x1
	.global L_8e6866
L_8e6866:
	mov_s r0,blink
L_8e6868:
	mov_s r2,0x10172d0
L_8e686e:
	mov_s r1,0xac
L_8e6870:
	bl.d L_8c82c0
L_8e6874:
	mov_s r3,0x9e
L_8e6876:
	b L_8e65a4
	.global L_8e687a
L_8e687a:
	mov_s r0,0x884000
L_8e6880:
	st_s r1,[r0,0x5c]
L_8e6882:
	mov_s r13,0x1
	.global L_8e6884
L_8e6884:
	ld_s r1,[r14,0x4]
L_8e6886:
	st r1,[r16, 0x8]
L_8e688a:
	ld_s r0,[r14,0x8]
L_8e688c:
	/* add_s r0,0x3 */
	.byte 0x03,0xe0
L_8e688e:
	st r0,[r16, 0xc]
L_8e6892:
	b.d L_8e6e46
L_8e6896:
	mov_s r15,0x10
	.global L_8e6898
L_8e6898:
	bl.d L_8d1898
L_8e689c:
	ld_s r0,[r14,0x4]
	.global L_8e689e
L_8e689e:
	st r0,[r16, 0x8]
L_8e68a2:
	b_s L_8e6a4a
	.global L_8e68a4
L_8e68a4:
	bl L_8d190c
L_8e68a8:
	b_s L_8e689e
	.global L_8e68aa
L_8e68aa:
	bl L_8d1894
L_8e68ae:
	b_s L_8e689e
	.global L_8e68b0
L_8e68b0:
	mov_s r2,0x10172e0
L_8e68b6:
	ld r4,[r14, 0x8]
L_8e68ba:
	mov_s r0,r13
L_8e68bc:
	mov_s r1,0x2
L_8e68be:
	bl.d L_8edff8
L_8e68c2:
	ld_s r3,[r14,0x4]
L_8e68c4:
	mov_s r2,0x1017328
L_8e68ca:
	ld r4,[r14, 0x10]
L_8e68ce:
	mov_s r0,r13
L_8e68d0:
	mov_s r1,0x2
L_8e68d2:
	bl.d L_8edff8
L_8e68d6:
	ld_s r3,[r14,0xc]
L_8e68d8:
	bl L_8d7210
L_8e68dc:
	ld_s r1,[r14,0x4]
L_8e68de:
	breq r0,0x0,L_8e695c
L_8e68e2:
	bic.f r1,r1,0x7f
L_8e68e6:
	bne_s L_8e694a
	.global L_8e68e8
L_8e68e8:
	mov_s r0,0x886080
L_8e68ee:
	ld_s r1,[r0,0x54]
L_8e68f0:
	ld_s r2,[r14,0x4]
L_8e68f2:
	bic r1,r1,0xfe
L_8e68f6:
	asl_s r2,r2
L_8e68f8:
	or_s r1,r1,r2
L_8e68fa:
	st_s r1,[r0,0x54]
L_8e68fc:
	mov_s r13,0x12340301
L_8e6902:
	mov_s r0,0x65
L_8e6904:
	st_s r0,[sp,0x10]
L_8e6906:
	mov_s r0,0x66
L_8e6908:
	st_s r0,[sp,0x14]
L_8e690a:
	mov_s r0,0x67
L_8e690c:
	st_s r0,[sp,0x18]
L_8e690e:
	mov_s r0,0x68
L_8e6910:
	st_s r0,[sp,0x1c]
L_8e6912:
	mov_s r0,0x69
L_8e6914:
	st_s r0,[sp,0x20]
L_8e6916:
	mov_s r0,0x6a
L_8e6918:
	st_s r0,[sp,0x24]
L_8e691a:
	mov_s r0,0x6b
L_8e691c:
	st_s r0,[sp,0x28]
L_8e691e:
	mov r0,0x44d
L_8e6922:
	st_s r0,[sp,0x2c]
L_8e6924:
	mov r0,0x44e
L_8e6928:
	st_s r0,[sp,0x30]
L_8e692a:
	mov r0,0x44f
L_8e692e:
	st_s r0,[sp,0x34]
L_8e6930:
	mov r0,0x450
L_8e6934:
	st_s r0,[sp,0x38]
L_8e6936:
	mov r0,0x451
L_8e693a:
	st_s r0,[sp,0x3c]
L_8e693c:
	mov r0,0x452
L_8e6940:
	st_s r0,[sp,0x40]
L_8e6942:
	mov r0,0x453
L_8e6946:
	st_s r0,[sp,0x44]
L_8e6948:
	b_s L_8e696e
	.global L_8e694a
L_8e694a:
	mov_s r0,blink
L_8e694c:
	mov_s r2,0x10172d0
L_8e6952:
	mov_s r1,0xac
L_8e6954:
	bl.d L_8c82c0
L_8e6958:
	mov_s r3,0xdf
L_8e695a:
	b_s L_8e68e8
	.global L_8e695c
L_8e695c:
	extw_s r0,r1
L_8e695e:
	ld_s r1,[r14,0x8]
L_8e6960:
	add r4,sp,0x10
L_8e6964:
	ldb_s r2,[r14,0xc]
L_8e6966:
	bl.d L_8d4204
L_8e696a:
	ld_s r3,[r14,0x10]
L_8e696c:
	mov_s r13,r0
	.global L_8e696e
L_8e696e:
	add r0,r16,0x8
L_8e6972:
	add_s r1,sp,0x10
L_8e6974:
	bl.d L_8c0460
L_8e6978:
	mov_s r2,0x38
	.global L_8e697a
L_8e697a:
	b.d L_8e6e46
L_8e697e:
	mov_s r15,0x40
	.global L_8e6980
L_8e6980:
	mov_s r0,blink
L_8e6982:
	mov_s r2,0x10172d0
L_8e6988:
	mov_s r1,0xac
L_8e698a:
	bl.d L_8c82c0
L_8e698e:
	mov r3,0x109
L_8e6992:
	b L_8e663a
	.global L_8e6996
L_8e6996:
	extw_s r0,r1
L_8e6998:
	ld_s r1,[r14,0x8]
L_8e699a:
	add r4,sp,0x10
L_8e699e:
	ldb_s r2,[r14,0xc]
L_8e69a0:
	bl.d L_8d4124
L_8e69a4:
	ld_s r3,[r14,0x10]
L_8e69a6:
	mov_s r13,r0
	.global L_8e69a8
L_8e69a8:
	add r0,r16,0x8
L_8e69ac:
	add_s r1,sp,0x10
L_8e69ae:
	bl.d L_8c0460
L_8e69b2:
	mov_s r2,0x38
L_8e69b4:
	b_s L_8e697a
	.global L_8e69b6
L_8e69b6:
	add_s r13,sp,0x10
L_8e69b8:
	bl.d L_8d4678
L_8e69bc:
	mov_s r0,r13
L_8e69be:
	add r0,r16,0x8
L_8e69c2:
	mov_s r1,r13
L_8e69c4:
	bl.d L_8c0460
L_8e69c8:
	mov_s r2,0x20
L_8e69ca:
	mov_s r15,0x28
L_8e69cc:
	b.d L_8e6e46
L_8e69d0:
	mov_s r13,0x1
	.global L_8e69d2
L_8e69d2:
	ld_s r0,[r14,0x4]
L_8e69d4:
	bl.d L_8d4330
L_8e69d8:
	ld_s r1,[r14,0x8]
L_8e69da:
	b_s L_8e689e
	.global L_8e69dc
L_8e69dc:
	ldb_s r0,[r14,0x4]
L_8e69de:
	ldb.x r1,[r14, 0x8]
L_8e69e2:
	ld_s r2,[r14,0xc]
L_8e69e4:
	bl.d L_8d327c
L_8e69e8:
	mov_s r3,0x1
L_8e69ea:
	b.d L_8e6e46
L_8e69ee:
	mov_s r13,r0
	.global L_8e69f0
L_8e69f0:
	bl.d L_8d36e4
L_8e69f4:
	ldb_s r0,[r14,0x4]
L_8e69f6:
	b.d L_8e6e46
L_8e69fa:
	mov_s r13,r0
L_8e69fc:
	bl.d L_8d35c4
L_8e6a00:
	ldb_s r0,[r14,0x4]
L_8e6a02:
	b.d L_8e6e46
L_8e6a06:
	mov_s r13,0x1
L_8e6a08:
	mov_s r2,0x8004e8
L_8e6a0e:
	ldb_s r0,[r2,0x2]
L_8e6a10:
	ldb_s r1,[r2,0x1]
L_8e6a12:
	bl.d L_8d31ac
L_8e6a16:
	ldb_s r2,[r2]
L_8e6a18:
	b.d L_8e6e46
L_8e6a1c:
	mov_s r13,0x1
L_8e6a1e:
	mov_s r0,0x1
L_8e6a20:
	bl.d L_8d36b4
L_8e6a24:
	mov_s r1,0x1
L_8e6a26:
	b.d L_8e6e46
L_8e6a2a:
	mov_s r13,0x1
L_8e6a2c:
	ldb_s r0,[r14,0x4]
L_8e6a2e:
	bl.d L_8d359c
L_8e6a32:
	mov_s r1,r13
L_8e6a34:
	b.d L_8e6e46
L_8e6a38:
	mov_s r13,0x1
L_8e6a3a:
	ld_s r0,[r14,0x4]
L_8e6a3c:
	st_s r0,[sp,0x10]
L_8e6a3e:
	bl.d L_8d34f8
L_8e6a42:
	add_s r0,sp,0x10
L_8e6a44:
	ld_s r1,[sp,0x10]
	.global L_8e6a46
L_8e6a46:
	st r1,[r16, 0x8]
	.global L_8e6a4a
L_8e6a4a:
	mov_s r15,0xc
L_8e6a4c:
	b.d L_8e6e46
L_8e6a50:
	mov_s r13,0x1
L_8e6a52:
	ld_s r0,[r14,0x4]
L_8e6a54:
	mov_s r3,0x1
L_8e6a56:
	ldb_s r1,[r14,0x8]
L_8e6a58:
	ldb_s r2,[r14,0xc]
L_8e6a5a:
	bl.d L_8d3228
L_8e6a5e:
	mov r4,0xd
L_8e6a62:
	b.d L_8e6e46
L_8e6a66:
	mov_s r13,0x1
	.global L_8e6a68
L_8e6a68:
	bl.d L_8d1734
L_8e6a6c:
	ldb_s r0,[r14,0x4]
L_8e6a6e:
	b.d L_8e6e46
L_8e6a72:
	mov_s r13,0x1
L_8e6a74:
	add_s r0,sp,0x10
L_8e6a76:
	st_s r1,[sp,0x18]
L_8e6a78:
	bl.d L_8c6abc
L_8e6a7c:
	mov_s r1,r13
L_8e6a7e:
	b.d L_8e6e46
L_8e6a82:
	mov_s r13,0x1
L_8e6a84:
	add_s r0,sp,0x10
L_8e6a86:
	st_s r1,[sp,0x18]
L_8e6a88:
	mov_s r1,r13
L_8e6a8a:
	mov_s r2,0x1
L_8e6a8c:
	bl.d L_8c6794
L_8e6a90:
	mov_s r3,0x1
L_8e6a92:
	b.d L_8e6e46
L_8e6a96:
	mov_s r13,0x1
L_8e6a98:
	add_s r0,sp,0x10
L_8e6a9a:
	st_s r1,[sp,0x18]
L_8e6a9c:
	bl.d L_8c6be0
L_8e6aa0:
	mov_s r1,r13
L_8e6aa2:
	b.d L_8e6e46
L_8e6aa6:
	mov_s r13,0x1
L_8e6aa8:
	add_s r0,sp,0x10
L_8e6aaa:
	st_s r1,[sp,0x18]
L_8e6aac:
	ld_s r1,[r14,0x4]
L_8e6aae:
	bl.d L_8e1940
L_8e6ab2:
	ld_s r2,[r14,0x8]
L_8e6ab4:
	b.d L_8e6e46
L_8e6ab8:
	mov_s r13,0x1
L_8e6aba:
	add_s r0,sp,0x10
L_8e6abc:
	st_s r1,[sp,0x18]
L_8e6abe:
	mov_s r2,0x84ee64
L_8e6ac4:
	add_s r3,sp,0x1c
L_8e6ac6:
	bl.d L_8e325c
L_8e6aca:
	sub r1,r2,0x38
L_8e6ace:
	ld_s r1,[sp,0x1c]
L_8e6ad0:
	st r1,[r16, 0x8]
L_8e6ad4:
	b_s L_8e6b44
L_8e6ad6:
	add_s r0,sp,0x10
L_8e6ad8:
	st_s r1,[sp,0x18]
L_8e6ada:
	ld_s r1,[r14,0x4]
L_8e6adc:
	bl.d L_8d8f50
L_8e6ae0:
	ld_s r2,[r14,0x8]
L_8e6ae2:
	b L_8e689e
	.global L_8e6ae6
L_8e6ae6:
	ld r4,[r14, 0x10]
L_8e6aea:
	mov_s r0,0x84ee2c
L_8e6af0:
	ld_s r1,[r14,0x4]
L_8e6af2:
	ld_s r2,[r14,0x8]
L_8e6af4:
	bl.d L_8ea598
L_8e6af8:
	ld_s r3,[r14,0xc]
L_8e6afa:
	b.d L_8e6e46
L_8e6afe:
	mov_s r13,0x1
	.global L_8e6b00
L_8e6b00:
	ld r4,[r14, 0x10]
L_8e6b04:
	mov_s r0,0x84ee2c
L_8e6b0a:
	ld r5,[r14, 0x14]
L_8e6b0e:
	ld_s r1,[r14,0x4]
L_8e6b10:
	ld_s r2,[r14,0x8]
L_8e6b12:
	bl.d L_8f0c40
L_8e6b16:
	ld_s r3,[r14,0xc]
L_8e6b18:
	b.d L_8e6e46
L_8e6b1c:
	mov_s r13,0x1
	.global L_8e6b1e
L_8e6b1e:
	mov_s r0,0x84ee2c
L_8e6b24:
	bl L_8ed83c
L_8e6b28:
	b L_8e689e
	.global L_8e6b2c
L_8e6b2c:
	mov_s r1,0x84ee2c
L_8e6b32:
	bl.d L_8ed830
L_8e6b36:
	add_s r0,sp,0x10
L_8e6b38:
	ld_s r2,[sp,0x10]
L_8e6b3a:
	ld_s r1,[sp,0x14]
	.global L_8e6b3c
L_8e6b3c:
	st r2,[r16, 0x8]
L_8e6b40:
	st r1,[r16, 0xc]
	.global L_8e6b44
L_8e6b44:
	mov_s r15,0x10
L_8e6b46:
	b.d L_8e6e46
L_8e6b4a:
	mov_s r13,0x1
	.global L_8e6b4c
L_8e6b4c:
	mov_s r0,0x1
L_8e6b4e:
	bl.d L_8d3964
L_8e6b52:
	mov_s r1,0x3f
L_8e6b54:
	b.d L_8e6e46
L_8e6b58:
	mov_s r13,0x1
	.global L_8e6b5a
L_8e6b5a:
	mov_s r2,0x101736c
L_8e6b60:
	mov_s r0,0x6
L_8e6b62:
	bl.d L_8edfb0
L_8e6b66:
	mov_s r1,0x2
L_8e6b68:
	ld_s r0,[r14,0x4]
L_8e6b6a:
	ld_s r1,[r14,0x8]
L_8e6b6c:
	bl.d L_8d3bec
L_8e6b70:
	ld_s r2,[r14,0xc]
L_8e6b72:
	b.d L_8e6e46
L_8e6b76:
	mov_s r13,0x1
	.global L_8e6b78
L_8e6b78:
	mov_s r0,0x1
L_8e6b7a:
	bl.d L_8d3dc0
L_8e6b7e:
	mov_s r1,0x1
L_8e6b80:
	b.d L_8e6e46
L_8e6b84:
	mov_s r13,0x1
	.global L_8e6b86
L_8e6b86:
	bl.d L_8d19b0
L_8e6b8a:
	mov_s r13,0x1
L_8e6b8c:
	b L_8e6e46
	.global L_8e6b90
L_8e6b90:
	ldb_s r0,[r14,0x4]
L_8e6b92:
	add_s r2,sp,0x10
L_8e6b94:
	bl.d L_8d3f40
L_8e6b98:
	ldb_s r1,[r14,0x8]
L_8e6b9a:
	ld_s r2,[sp,0x10]
L_8e6b9c:
	ld_s r1,[sp,0x14]
L_8e6b9e:
	b_s L_8e6b3c
	.global L_8e6ba0
L_8e6ba0:
	add_s r2,sp,0x10
L_8e6ba2:
	mov_s r0,0x8005d4
L_8e6ba8:
	st_s r0,[sp,0x18]
L_8e6baa:
	add_s r0,sp,0x1c
L_8e6bac:
	mov_s r1,0x1
L_8e6bae:
	bl.d L_8e8408
L_8e6bb2:
	st_s r13,[sp,0x1c]
L_8e6bb4:
	mov_s r0,r2
L_8e6bb6:
	ld_s r1,[sp,0x1c]
L_8e6bb8:
	mov_s r2,0x1
L_8e6bba:
	bl.d L_8c66a4
L_8e6bbe:
	mov_s r3,0x1
L_8e6bc0:
	b.d L_8e6e46
L_8e6bc4:
	mov_s r13,0x1
	.global L_8e6bc6
L_8e6bc6:
	bl.d L_8d1f28
L_8e6bca:
	mov_s r0,r13
L_8e6bcc:
	b.d L_8e6e46
L_8e6bd0:
	mov_s r13,0x1
L_8e6bd2:
	mov_s r2,0x10173ac
L_8e6bd8:
	mov_s r0,0x6
L_8e6bda:
	bl.d L_8edfb0
L_8e6bde:
	mov_s r1,0x2
L_8e6be0:
	bl.d L_8d1b58
L_8e6be4:
	mov_s r0,r13
L_8e6be6:
	b.d L_8e6e46
L_8e6bea:
	mov_s r13,0x1
L_8e6bec:
	ld_s r0,[r14,0x4]
L_8e6bee:
	ld_s r1,[r14,0x8]
L_8e6bf0:
	bl.d L_8d3f1c
L_8e6bf4:
	ldb_s r2,[r14,0xc]
L_8e6bf6:
	b L_8e689e
L_8e6bfa:
	mov_s r13,0x801728
L_8e6c00:
	add_s r0,sp,0x10
L_8e6c02:
	mov_s r1,r13
L_8e6c04:
	bl.d L_8c0460
L_8e6c08:
	mov_s r2,0x20
L_8e6c0a:
	mov_s r0,sp
L_8e6c0c:
	add r1,r13,0x20
L_8e6c10:
	ld r21,[sp, 0x20]
L_8e6c14:
	ld r20,[sp, 0x24]
L_8e6c18:
	ld r19,[sp, 0x28]
L_8e6c1c:
	ld r18,[sp, 0x2c]
L_8e6c20:
	bl.d L_8c0460
L_8e6c24:
	mov_s r2,0x4
L_8e6c26:
	mov_s r0,0x84ee6c
L_8e6c2c:
	st_s r0,[sp,0x4]
L_8e6c2e:
	mov_s r0,0x8426a0
L_8e6c34:
	st_s r0,[sp,0x8]
L_8e6c36:
	ld_s r0,[sp,0x10]
L_8e6c38:
	mov r4,r21
L_8e6c3c:
	ld_s r1,[sp,0x14]
L_8e6c3e:
	mov r5,r20
L_8e6c42:
	ld_s r2,[sp,0x18]
L_8e6c44:
	mov r6,r19
L_8e6c48:
	ld_s r3,[sp,0x1c]
L_8e6c4a:
	bl.d L_8d2064
L_8e6c4e:
	mov r7,r18
L_8e6c52:
	b.d L_8e6e46
L_8e6c56:
	mov_s r13,0x1
L_8e6c58:
	ld_s r0,[r14,0x4]
L_8e6c5a:
	bl.d L_8d406c
L_8e6c5e:
	ldb_s r1,[r14,0x8]
L_8e6c60:
	b L_8e689e
L_8e6c64:
	ld_s r0,[r14,0x8]
L_8e6c66:
	mov_s r13,0x84ee2c
L_8e6c6c:
	stb_s r0,[sp,0x14]
L_8e6c6e:
	ld_s r0,[r14,0xc]
L_8e6c70:
	ld_s r1,[r14,0x4]
L_8e6c72:
	stb r0,[sp, 0x15]
L_8e6c76:
	ld_s r0,[r14,0x10]
L_8e6c78:
	stb r0,[sp, 0x16]
L_8e6c7c:
	ld_s r0,[r14,0x14]
L_8e6c7e:
	stb r0,[sp, 0x17]
L_8e6c82:
	ld_s r2,[sp,0x14]
L_8e6c84:
	add3 r0,r13,0x9
L_8e6c88:
	bl.d L_8d2484
L_8e6c8c:
	ld_s r3,[r14,0x18]
L_8e6c8e:
	ld_s r2,[r13,0x48]
L_8e6c90:
	ld_s r1,[r13,0x4c]
L_8e6c92:
	b_s L_8e6b3c
L_8e6c94:
	mov r18,0x8426a0
L_8e6c9c:
	mov_s r14,0x84ee2c
L_8e6ca2:
	mov_s r13,0x801728
L_8e6ca8:
	add_s r0,sp,0x10
L_8e6caa:
	mov_s r1,r13
L_8e6cac:
	bl.d L_8c0460
L_8e6cb0:
	mov_s r2,0x14
L_8e6cb2:
	mov_s r0,sp
L_8e6cb4:
	add r1,r13,0x14
L_8e6cb8:
	ld r22,[sp, 0x14]
L_8e6cbc:
	ld r21,[sp, 0x18]
L_8e6cc0:
	ld r20,[sp, 0x1c]
L_8e6cc4:
	ld r19,[sp, 0x20]
L_8e6cc8:
	bl.d L_8c0460
L_8e6ccc:
	mov_s r2,0x10
L_8e6cce:
	ld_s r1,[r14,0x40]
L_8e6cd0:
	mov_s r0,r18
L_8e6cd2:
	ld_s r2,[r14,0x44]
L_8e6cd4:
	mov r4,r22
L_8e6cd8:
	ld_s r3,[sp,0x10]
L_8e6cda:
	mov r5,r21
L_8e6cde:
	mov r6,r20
L_8e6ce2:
	bl.d L_8d1c1c
L_8e6ce6:
	mov r7,r19
L_8e6cea:
	mov_s r13,0x1
L_8e6cec:
	b_s L_8e6e46
L_8e6cee:
	ld_s r13,[r14,0x4]
L_8e6cf0:
	mov_s r2,0x10173dc
L_8e6cf6:
	mov_s r0,0x6
L_8e6cf8:
	mov_s r1,0x2
L_8e6cfa:
	bl.d L_8edfcc
L_8e6cfe:
	mov_s r3,r13
L_8e6d00:
	bl.d L_8d2f38
L_8e6d04:
	mov_s r0,r13
L_8e6d06:
	mov_s r13,0x1
L_8e6d08:
	b_s L_8e6e46
L_8e6d0a:
	mov_s r2,0x1017418
L_8e6d10:
	mov_s r0,0x6
L_8e6d12:
	bl.d L_8edfb0
L_8e6d16:
	mov_s r1,0x2
L_8e6d18:
	bl.d L_8d3084
L_8e6d1c:
	mov_s r0,r13
L_8e6d1e:
	mov_s r13,0x1
L_8e6d20:
	b_s L_8e6e46
L_8e6d22:
	ld_s r13,[r14,0x4]
L_8e6d24:
	mov_s r2,0x1017448
L_8e6d2a:
	mov_s r0,0x6
L_8e6d2c:
	mov_s r1,0x2
L_8e6d2e:
	bl.d L_8edfcc
L_8e6d32:
	mov_s r3,r13
L_8e6d34:
	bl.d L_8d2d78
L_8e6d38:
	mov_s r0,r13
L_8e6d3a:
	mov_s r13,0x1
L_8e6d3c:
	b_s L_8e6e46
L_8e6d3e:
	mov_s r2,0x1017484
L_8e6d44:
	mov_s r0,0x6
L_8e6d46:
	bl.d L_8edfb0
L_8e6d4a:
	mov_s r1,0x2
L_8e6d4c:
	ld_s r0,[r14,0x10]
L_8e6d4e:
	add_s r3,sp,0x10
L_8e6d50:
	stb_s r0,[sp,0x10]
L_8e6d52:
	ld_s r0,[r14,0x14]
L_8e6d54:
	ld_s r1,[r14,0x8]
L_8e6d56:
	stb r0,[sp, 0x11]
L_8e6d5a:
	ld_s r0,[r14,0x18]
L_8e6d5c:
	stb r0,[sp, 0x12]
L_8e6d60:
	ld_s r0,[r14,0x1c]
L_8e6d62:
	stb r0,[sp, 0x13]
L_8e6d66:
	ld_s r0,[r14,0x20]
L_8e6d68:
	stb_s r0,[sp,0x14]
L_8e6d6a:
	ld_s r0,[r14,0x24]
L_8e6d6c:
	stb r0,[sp, 0x15]
L_8e6d70:
	ld_s r0,[r14,0x28]
L_8e6d72:
	stb r0,[sp, 0x16]
L_8e6d76:
	ld_s r0,[r14,0x2c]
L_8e6d78:
	stb r0,[sp, 0x17]
L_8e6d7c:
	ld_s r0,[r14,0x30]
L_8e6d7e:
	stb r0,[sp, 0x1e]
L_8e6d82:
	ld_s r0,[r14,0x34]
L_8e6d84:
	stb r0,[sp, 0x1f]
L_8e6d88:
	ld_s r0,[r14,0x4]
L_8e6d8a:
	bl.d L_8d2828
L_8e6d8e:
	ld_s r2,[r14,0xc]
L_8e6d90:
	mov_s r13,0x1
L_8e6d92:
	b_s L_8e6e46
	.global L_8e6d94
L_8e6d94:
	ldb r4,[r14, 0x14]
L_8e6d98:
	ldb r5,[r14, 0x18]
L_8e6d9c:
	ldb r6,[r14, 0x1c]
L_8e6da0:
	ldb r7,[r14, 0x20]
L_8e6da4:
	ldb_s r0,[r14,0x4]
L_8e6da6:
	ldb_s r1,[r14,0x8]
L_8e6da8:
	ldb_s r2,[r14,0xc]
L_8e6daa:
	bl.d L_8d47f0
L_8e6dae:
	ldb_s r3,[r14,0x10]
L_8e6db0:
	mov_s r13,0x1
L_8e6db2:
	b_s L_8e6e46
	.global L_8e6db4
L_8e6db4:
	mov_s r0,0x802d24
L_8e6dba:
	ld_s r0,[r0]
L_8e6dbc:
	add r4,sp,0x10
L_8e6dc0:
	st_s r0,[sp,0x10]
L_8e6dc2:
	ldb_s r0,[r14,0x4]
L_8e6dc4:
	ldb_s r1,[r14,0x8]
L_8e6dc6:
	ldb_s r2,[r14,0xc]
L_8e6dc8:
	bl.d L_8d4764
L_8e6dcc:
	ldb_s r3,[r14,0x10]
L_8e6dce:
	b.d L_8e6a46
L_8e6dd2:
	ld_s r1,[sp,0x10]
	.global L_8e6dd4
L_8e6dd4:
	ldb r19,[r14, 0x10]
L_8e6dd8:
	add r18,sp,0x10
L_8e6ddc:
	mov_s r0,r18
L_8e6dde:
	mov_s r1,0x802d28
L_8e6de4:
	bl.d L_8c0460
L_8e6de8:
	mov_s r2,0x42
L_8e6dea:
	add r0,r16,0x4
L_8e6dee:
	bl.d L_8c1a78
L_8e6df2:
	mov_s r1,0x60
L_8e6df4:
	ldb_s r0,[r14,0x4]
L_8e6df6:
	ldb_s r1,[r14,0x8]
L_8e6df8:
	ldb_s r2,[r14,0xc]
L_8e6dfa:
	ldb_s r3,[r14,0x10]
L_8e6dfc:
	bl.d L_8d49e8
L_8e6e00:
	mov r4,r18
L_8e6e04:
	add r0,r16,0x8
L_8e6e08:
	mov_s r1,r18
L_8e6e0a:
	bl.d L_8c0460
L_8e6e0e:
	mov_s r2,0x42
L_8e6e10:
	mov_s r15,0x4a
L_8e6e12:
	mov_s r2,0x10174bc
L_8e6e18:
	mov_s r0,r13
L_8e6e1a:
	mov_s r1,0x2
L_8e6e1c:
	mov_s r3,r15
L_8e6e1e:
	mov r4,r19
L_8e6e22:
	bl.d L_8ee034
L_8e6e26:
	mov r5,0x42
L_8e6e2a:
	mov_s r13,0x1
L_8e6e2c:
	b_s L_8e6e46
	.global L_8e6e2e
L_8e6e2e:
	mov_s r0,blink
L_8e6e30:
	mov_s r2,0x10172d0
L_8e6e36:
	mov_s r1,0xe3
L_8e6e38:
	bset_s r1,r1,0xc
L_8e6e3a:
	bl.d L_8c82c0
L_8e6e3e:
	mov r3,0x2d8
L_8e6e42:
	mov_s r15,0x8
L_8e6e44:
	mov_s r13,0x0
	.global L_8e6e46
L_8e6e46:
	st r13,[r16, 0x4]
L_8e6e4a:
	mov_s r0,r17
L_8e6e4c:
	mov_s r1,r16
L_8e6e4e:
	bl.d L_8e5b94
L_8e6e52:
	mov_s r2,r15
L_8e6e54:
	b.d L_8c02f4
L_8e6e58:
	add_s sp,sp,0x54
L_8e6e5a:
	nop_s
