/* hwf_calib_all @ 0x8f448c, 500 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ======  Welcome Sparrow D0 ==============
 *   =========  HWF_CALIB_ALL ================
 *   =========  HWF_CALIB_ALL === LO_POWER ===
 *   =========  HWF_CALIB_ALL === VGA-DC (LastDAC) ===
 *   =========  HWF_CALIB_ALL === SAR-DC =============
 *   =========  HWF_CALIB_ALL === BB-GAIN ============
 *   =========  HWF_CALIB_ALL === VGA-DC =============
 *    =========  HWF_CALIB_ALL === IF-GAIN ============
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler
 * Зовёт сам: Calib__Measure_VGA_Gains, __ld_r17_to_r13_ret, __st_r17_to_r13, calib__bits_set32_s20_w12, calib__log_if_nonzero, calib__release_hw_thunk, calib__setup_loopback_hw, calib__setup_loopback_hw_b, calib__setup_loopback_rx_path, calib_corr__estimate_and_apply_rx_gain, calib_lo_power_measure, calib_obj4__reset_d4
 * Глобалы (через gp): 0x80021f, 0x800220, 0x800221
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_calib_all
hwf_calib_all:
	.global L_8f448c
L_8f448c:
	push_s blink
L_8f448e:
	bl L_8c01d8
L_8f4492:
	sub_s sp,sp,0x2c
L_8f4494:
	bl.d L_8e9524
L_8f4498:
	mov_s r14,0x0
L_8f449a:
	mov_s r17,r0
L_8f449c:
	mov_s r1,0x101c5bc
L_8f44a2:
	bl.d L_8dcba8
L_8f44a6:
	mov_s r0,0x26
L_8f44a8:
	mov_s r1,0x101c5e8
L_8f44ae:
	bl.d L_8dcba8
L_8f44b2:
	mov_s r0,0x26
L_8f44b4:
	mov_s r0,r14
L_8f44b6:
	bl.d L_8dddc0
L_8f44ba:
	mov_s r1,r14
L_8f44bc:
	ldb_s r0,[gp,0x9b]
L_8f44be:
	mov_s r13,0x1
L_8f44c0:
	breq_s r0,0,L_8f44fc
L_8f44c2:
	mov_s r1,0x101c614
L_8f44c8:
	bl.d L_8dcba8
L_8f44cc:
	mov_s r0,0x26
L_8f44ce:
	ldb_s r0,[gp,0x9c]
L_8f44d0:
	mov_s r2,0x80676c
L_8f44d6:
	brne_s r0,0,L_8f44e4
L_8f44d8:
	bl.d L_8f5438
L_8f44dc:
	mov_s r0,r2
L_8f44de:
	stb r13,[gp, 0x9c]
L_8f44e2:
	b_s L_8f44fc
	.global L_8f44e4
L_8f44e4:
	mov_s r0,sp
L_8f44e6:
	mov_s r1,r14
L_8f44e8:
	bl.d L_8ed430
L_8f44ec:
	st_s r14,[sp,0x0]
L_8f44ee:
	mov_s r0,r2
L_8f44f0:
	ld_s r1,[sp,0x0]
L_8f44f2:
	mov_s r2,r13
L_8f44f4:
	mov_s r3,r13
L_8f44f6:
	bl.d L_8c766c
L_8f44fa:
	mov_s r4,r14
	.global L_8f44fc
L_8f44fc:
	mov_s r1,0x101c640
L_8f4502:
	bl.d L_8dcba8
L_8f4506:
	mov_s r0,0x26
L_8f4508:
	mov_s r0,0x1
L_8f450a:
	mov_s r1,r0
L_8f450c:
	mov_s r2,r0
L_8f450e:
	mov_s r3,r0
L_8f4510:
	bl.d L_8d6a64
L_8f4514:
	mov r4,0xa
L_8f4518:
	mov_s r0,0x3f
L_8f451a:
	mov_s r1,r0
L_8f451c:
	bl.d L_8d6948
L_8f4520:
	mov_s r2,0x1
L_8f4522:
	mov_s r0,0x1
L_8f4524:
	bl.d L_8d6b20
L_8f4528:
	mov_s r1,r0
L_8f452a:
	mov_s r1,0x101c674
L_8f4530:
	bl.d L_8dcba8
L_8f4534:
	mov_s r0,0x26
L_8f4536:
	mov_s r0,0x1
L_8f4538:
	mov_s r1,r0
L_8f453a:
	mov_s r2,r0
L_8f453c:
	mov_s r3,r0
L_8f453e:
	bl.d L_8d63b0
L_8f4542:
	mov r4,0xd
L_8f4546:
	mov_s r2,0x800518
L_8f454c:
	ldb_s r0,[r2,0x2]
L_8f454e:
	ldb_s r1,[r2,0x1]
L_8f4550:
	bl.d L_8d60bc
L_8f4554:
	ldb_s r2,[r2]
L_8f4556:
	mov_s r0,0x1
L_8f4558:
	bl.d L_8d6460
L_8f455c:
	mov_s r1,r0
L_8f455e:
	mov_s r1,0x101c6a8
L_8f4564:
	bl.d L_8dcba8
L_8f4568:
	mov_s r0,0x26
L_8f456a:
	bl.d L_8d4d90
L_8f456e:
	mov_s r0,0x0
L_8f4570:
	bl.d L_8d4a08
L_8f4574:
	mov_s r0,0x0
L_8f4576:
	bl.d L_8d4e04
L_8f457a:
	mov_s r0,0x0
L_8f457c:
	mov_s r1,0x101c6dc
L_8f4582:
	bl.d L_8dcba8
L_8f4586:
	mov_s r0,0x26
L_8f4588:
	mov_s r0,0x1
L_8f458a:
	mov_s r1,r0
L_8f458c:
	mov_s r2,r0
L_8f458e:
	mov_s r3,r0
L_8f4590:
	bl.d L_8d6a64
L_8f4594:
	mov r4,0xa
L_8f4598:
	mov_s r0,0x1
L_8f459a:
	bl.d L_8d66cc
L_8f459e:
	mov_s r1,0x3f
L_8f45a0:
	mov_s r15,0x1e
L_8f45a2:
	mov_s r13,0xb
	.global L_8f45a4
L_8f45a4:
	mov_s r0,0x0
L_8f45a6:
	bl.d L_8cf5a8
L_8f45aa:
	mov_s r1,r0
L_8f45ac:
	mov_s r0,0x1
L_8f45ae:
	bl.d L_8cf5a8
L_8f45b2:
	mov_s r1,r15
L_8f45b4:
	mov_s r2,sp
L_8f45b6:
	mov_s r0,0xff
L_8f45b8:
	bl.d L_8d6ca0
L_8f45bc:
	mov_s r1,0xd
L_8f45be:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8f45c0:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8f45c2:
	brhs.d r13,0x1,L_8f45a4
L_8f45c6:
	extb_s r15,r15
L_8f45c8:
	mov_s r0,0x1
L_8f45ca:
	bl.d L_8d6b20
L_8f45ce:
	mov_s r1,r0
L_8f45d0:
	mov_s r1,0x101c710
L_8f45d6:
	bl.d L_8dcba8
L_8f45da:
	mov_s r0,0x26
L_8f45dc:
	bl.d L_8d5d98
L_8f45e0:
	mov_s r0,0x0
L_8f45e2:
	bl.d L_8d5b64
L_8f45e6:
	mov_s r0,0x0
L_8f45e8:
	bl.d L_8d5eec
L_8f45ec:
	mov_s r0,0x0
L_8f45ee:
	ldb_s r0,[gp,0x9d]
L_8f45f0:
	brne r0,0x1,L_8f4656
L_8f45f4:
	mov_s r1,0x101c744
L_8f45fa:
	bl.d L_8dcba8
L_8f45fe:
	mov_s r0,0x26
L_8f4600:
	mov_s r0,sp
L_8f4602:
	mov_s r1,r14
L_8f4604:
	bl.d L_8ed430
L_8f4608:
	st_s r14,[sp,0x0]
L_8f460a:
	mov_s r15,0x8042c8
L_8f4610:
	bl.d L_8ccb3c
L_8f4614:
	mov_s r0,r15
L_8f4616:
	mov_s r13,r0
L_8f4618:
	add r16,sp,0x4
L_8f461c:
	mov_s r0,r16
L_8f461e:
	mov_s r1,0x0
L_8f4620:
	mov_s r2,0x3
L_8f4622:
	mov_s r3,r13
L_8f4624:
	bl.d L_8c182c
L_8f4628:
	sub r4,r2,0x4
L_8f462c:
	ld r0,[r15,0x468]
L_8f4634:
	breq_s r0,0,L_8f4662
L_8f4636:
	bl L_8cbb90
L_8f463a:
	b_s L_8f4644
	.global L_8f463c
L_8f463c:
	sub_s r1,r13,0x1
L_8f463e:
	and_s r13,r13,r1
L_8f4640:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8f4642:
	extw_s r14,r14
	.global L_8f4644
L_8f4644:
	brne_s r13,0,L_8f463c
L_8f4646:
	ld_s r1,[sp,0x0]
L_8f4648:
	mov_s r2,0x1
L_8f464a:
	mov_s r3,r14
L_8f464c:
	bl.d L_8c766c
L_8f4650:
	mov r4,r16
L_8f4654:
	b_s L_8f4662
	.global L_8f4656
L_8f4656:
	mov_s r1,0x101c780
L_8f465c:
	bl.d L_8dcba8
L_8f4660:
	mov_s r0,0x16
	.global L_8f4662
L_8f4662:
	bl L_8e9524
L_8f4666:
	mov_s r1,0x101c7c8
L_8f466c:
	sub r0,r0,r17
L_8f4670:
	asl_s r2,r0,0x4
L_8f4672:
	bl.d L_8dcc10
L_8f4676:
	mov_s r0,0x26
L_8f4678:
	b.d L_8c023c
L_8f467c:
	add_s sp,sp,0x2c
L_8f467e:
	nop_s
