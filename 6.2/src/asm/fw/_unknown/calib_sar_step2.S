/* calib_sar_step2 @ 0x8d47e4, 352 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_sar_alg
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, fw_ashr64, hwd_abif__rx_rgf_read_sar_dc, hwd_abif__rx_rgf_update_sar_dc, hwd_phy__read_sar_sample, hwd_phy__rx_sar_measurement_completed, hwd_phy__rx_sar_measurement_start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_sar_step2
calib_sar_step2:
	.global L_8d47e4
L_8d47e4:
	push_s blink
L_8d47e6:
	bl L_8c01c4
L_8d47ea:
	mov_s r2,0x803800
L_8d47f0:
	ldw_s r1,[r2,0x10]
L_8d47f2:
	sub r21,r0,0x2
L_8d47f6:
	stw.a r1,[sp,-0x14]
L_8d47fa:
	ldw_s r1,[r2,0x12]
L_8d47fc:
	mov_s r14,0x8
L_8d47fe:
	stw r1,[sp, 0x2]
L_8d4802:
	mov_s r1,0x0
L_8d4804:
	mov_s r20,r1
L_8d4806:
	mov_s r18,r1
L_8d4808:
	bl.d L_8d2958
L_8d480c:
	extb r21,r21
L_8d4810:
	bl.d L_8d2920
L_8d4814:
	mov_s r13,r20
L_8d4816:
	mov r16,r20
L_8d481a:
	mov r17,r20
	.global L_8d481e
L_8d481e:
	extb_s r0,r13
L_8d4820:
	bl.d L_8d2474
L_8d4824:
	add_s r1,sp,0x4
L_8d4826:
	ld_s r1,[sp,0x8]
L_8d4828:
	ld_s r0,[sp,0x4]
L_8d482a:
	bl.d L_8c0620
L_8d482e:
	mov_s r2,0x3
L_8d4830:
	add.f r16,r16,r0
L_8d4834:
	ld_s r0,[sp,0xc]
L_8d4836:
	adc r17,r17,r1
L_8d483a:
	ld_s r1,[sp,0x10]
L_8d483c:
	bl.d L_8c0620
L_8d4840:
	mov_s r2,0x3
L_8d4842:
	add.f r20,r20,r0
L_8d4846:
	adc r18,r18,r1
L_8d484a:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8d484c:
	brhs.d r14,0x1,L_8d481e
L_8d4850:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d4852:
	mov_s r0,0x0
L_8d4854:
	b_s L_8d485a
	.global L_8d4856
L_8d4856:
	add r0,r22,0x1
	.global L_8d485a
L_8d485a:
	brhs.d r0,0x8,L_8d48a8
L_8d485e:
	mov_s r22,r0
L_8d4860:
	mov_s r14,0x0
L_8d4862:
	mov_s r13,0x2
	.global L_8d4864
L_8d4864:
	extb r15,r22
L_8d4868:
	mov_s r0,r15
L_8d486a:
	mov_s r1,r14
L_8d486c:
	bl.d L_8cefa0
L_8d4870:
	mov_s r2,0x0
L_8d4872:
	mov_s r19,r0
L_8d4874:
	mov_s r0,r15
L_8d4876:
	mov_s r1,r14
L_8d4878:
	bl.d L_8cefa0
L_8d487c:
	mov_s r2,0x1
L_8d487e:
	sub r2,r19,r0
L_8d4882:
	add r0,sp,r14
L_8d4886:
	ldb.x r1,[r0]
L_8d488a:
	sexb_s r2,r2
L_8d488c:
	max r1,r1,r2
L_8d4890:
	stb_s r1,[r0]
L_8d4892:
	ldb.x r1,[r0, 0x2]
L_8d4896:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d4898:
	min r2,r1,r2
L_8d489c:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d489e:
	stb_s r2,[r0,0x2]
L_8d48a0:
	brhs.d r13,0x1,L_8d4864
L_8d48a4:
	extb_s r14,r14
L_8d48a6:
	b_s L_8d4856
	.global L_8d48a8
L_8d48a8:
	mov_s r0,r16
L_8d48aa:
	mov_s r1,r17
L_8d48ac:
	bl.d L_8c0620
L_8d48b0:
	mov_s r2,r21
L_8d48b2:
	rsub r13,r0,0x0
L_8d48b6:
	sexb_s r13,r13
L_8d48b8:
	mov_s r0,r20
L_8d48ba:
	mov_s r1,r18
L_8d48bc:
	bl.d L_8c0620
L_8d48c0:
	mov_s r2,r21
L_8d48c2:
	rsub r2,r0,0x0
L_8d48c6:
	ldb.x r0,[sp]
L_8d48ca:
	sexb_s r2,r2
L_8d48cc:
	rsub r3,r0,0x1f
L_8d48d0:
	ldb.x r0,[sp, 0x2]
L_8d48d4:
	sexb_s r3,r3
L_8d48d6:
	add_s r0,r0,0x1f
L_8d48d8:
	neg_s r0,r0
L_8d48da:
	ldb.x r15,[sp, 0x1]
L_8d48de:
	sexb_s r14,r0
L_8d48e0:
	rsub r0,r15,0x1f
L_8d48e4:
	ldb.x r15,[sp, 0x3]
L_8d48e8:
	sexb_s r0,r0
L_8d48ea:
	add_s r15,r15,0x1f
L_8d48ec:
	neg_s r15,r15
L_8d48ee:
	brlt.d r13,0x1,L_8d48fe
L_8d48f2:
	sexb_s r15,r15
L_8d48f4:
	min r3,r3,r13
L_8d48f8:
	sexb r16,r3
L_8d48fc:
	b_s L_8d4906
	.global L_8d48fe
L_8d48fe:
	max r13,r14,r13
L_8d4902:
	sexb r16,r13
	.global L_8d4906
L_8d4906:
	brlt r2,0x1,L_8d4914
L_8d490a:
	min r0,r0,r2
L_8d490e:
	sexb r17,r0
L_8d4912:
	b_s L_8d491c
	.global L_8d4914
L_8d4914:
	max r2,r15,r2
L_8d4918:
	sexb r17,r2
	.global L_8d491c
L_8d491c:
	mov_s r15,0x0
L_8d491e:
	mov_s r13,0x8
	.global L_8d4920
L_8d4920:
	extb_s r14,r15
L_8d4922:
	mov_s r0,r14
L_8d4924:
	mov_s r1,0x0
L_8d4926:
	bl.d L_8cefdc
L_8d492a:
	mov_s r2,r16
L_8d492c:
	mov_s r0,r14
L_8d492e:
	mov_s r1,0x1
L_8d4930:
	bl.d L_8cefdc
L_8d4934:
	mov_s r2,r17
L_8d4936:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d4938:
	/* brhs.d r13,0x1,0x008d4920 */
	.byte 0xe9,0x0d,0x75,0x90
L_8d493c:
	/* _add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d493e:
	b.d L_8c0214
L_8d4942:
	add_s sp,sp,0x14
