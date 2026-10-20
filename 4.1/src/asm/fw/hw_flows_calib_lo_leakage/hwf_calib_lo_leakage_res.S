/* hwf_calib_lo_leakage_res @ 0x8c6794, 340 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_flows_calib_lo_leakage.cpp
 *   LO LEAKAGE RESULTS: I=%d Q=%d, gain = %d
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, calib_lo_leakage_run, fw_log__emit3, fw_sysassert_fatal, hwd_abif__rgf_88a000_8ccfb0, hwd_abif__rgf_88a200_8cc674, hwd_abif__set_agc004_w2, hwd_abif__set_agc004_w7
 */
	.section .text.hwf_calib_lo_leakage_res,"ax",@progbits
	.global hwf_calib_lo_leakage_res
hwf_calib_lo_leakage_res:
	.global L_8c6794
L_8c6794:
	sub_s sp,sp,0x4
L_8c6796:
	push_s blink
L_8c6798:
	bl.d L_8c02bc
L_8c679c:
	mov_s r4,r2
L_8c679e:
	mov_s r16,r0
L_8c67a0:
	mov_s r0,0x40
L_8c67a2:
	st.a r0,[sp,-0x78]
L_8c67a6:
	st_s r0,[sp,0x4]
L_8c67a8:
	mov_s r0,0x0
L_8c67aa:
	mov_s r1,0x20
L_8c67ac:
	st_s r1,[sp,0x8]
L_8c67ae:
	mov_s r1,0x1
L_8c67b0:
	st_s r1,[sp,0xc]
L_8c67b2:
	mov_s r15,0x10
L_8c67b4:
	st_s r15,[sp,0x10]
L_8c67b6:
	st_s r1,[sp,0x14]
L_8c67b8:
	mov_s r14,0x8
L_8c67ba:
	st_s r14,[sp,0x18]
L_8c67bc:
	st_s r1,[sp,0x1c]
L_8c67be:
	mov_s r13,0x4
L_8c67c0:
	st_s r13,[sp,0x20]
L_8c67c2:
	st_s r1,[sp,0x24]
L_8c67c4:
	mov_s r2,0x2
L_8c67c6:
	st_s r2,[sp,0x28]
L_8c67c8:
	st_s r1,[sp,0x2c]
L_8c67ca:
	st_s r1,[sp,0x30]
L_8c67cc:
	st_s r1,[sp,0x34]
L_8c67ce:
	st_s r0,[sp,0x38]
L_8c67d0:
	st_s r0,[sp,0x3c]
L_8c67d2:
	st_s r15,[sp,0x40]
L_8c67d4:
	st_s r1,[sp,0x44]
L_8c67d6:
	st_s r14,[sp,0x48]
L_8c67d8:
	st_s r1,[sp,0x4c]
L_8c67da:
	st_s r13,[sp,0x50]
L_8c67dc:
	st_s r1,[sp,0x54]
L_8c67de:
	st_s r2,[sp,0x58]
L_8c67e0:
	st_s r1,[sp,0x5c]
L_8c67e2:
	st_s r1,[sp,0x60]
L_8c67e4:
	st_s r1,[sp,0x64]
L_8c67e6:
	st_s r0,[sp,0x68]
L_8c67e8:
	st_s r0,[sp,0x6c]
L_8c67ea:
	st_s r0,[sp,0x70]
L_8c67ec:
	st_s r0,[sp,0x74]
L_8c67ee:
	cmp r4,0x1
L_8c67f2:
	cmp.eq r3,0x1
L_8c67f6:
	bne_s L_8c6822
	.global L_8c67f8
L_8c67f8:
	mov_s r13,sp
L_8c67fa:
	add_s r14,sp,0x4
L_8c67fc:
	add_s r3,sp,0x8
L_8c67fe:
	mov_s r0,r16
L_8c6800:
	mov_s r1,r13
L_8c6802:
	bl.d L_8e0128
L_8c6806:
	mov_s r2,r14
L_8c6808:
	ld_s r0,[sp,0x0]
L_8c680a:
	brlo r0,0x4,L_8c6838
L_8c680e:
	cmp_s r0,0x7b
L_8c6810:
	bhi_s L_8c6838
L_8c6812:
	ld_s r0,[sp,0x4]
L_8c6814:
	brlo r0,0x4,L_8c6838
L_8c6818:
	cmp_s r0,0x7b
L_8c681a:
	bhi_s L_8c6838
L_8c681c:
	mov r16,0x0
L_8c6820:
	b_s L_8c6890
	.global L_8c6822
L_8c6822:
	mov_s r0,blink
L_8c6824:
	mov_s r2,0x10178e4
L_8c682a:
	mov_s r1,0x1162
L_8c6830:
	bl.d L_8c82c0
L_8c6834:
	mov_s r3,0x85
L_8c6836:
	b_s L_8c67f8
	.global L_8c6838
L_8c6838:
	mov_s r0,0x0
L_8c683a:
	bl.d L_8cc674
L_8c683e:
	mov_s r1,r0
L_8c6840:
	mov_s r0,0x1
L_8c6842:
	bl.d L_8cc674
L_8c6846:
	mov_s r1,0x3f
L_8c6848:
	mov_s r0,0x1c
L_8c684a:
	mov_s r1,0x0
L_8c684c:
	bl.d L_8cce38
L_8c6850:
	mov_s r2,0x1
L_8c6852:
	mov_s r0,0x1c
L_8c6854:
	mov_s r1,0x1
L_8c6856:
	bl.d L_8cce38
L_8c685a:
	mov_s r2,0x1
L_8c685c:
	mov_s r0,0x1c
L_8c685e:
	mov_s r1,0x0
L_8c6860:
	bl.d L_8ccdac
L_8c6864:
	ldb_s r2,[sp,0x0]
L_8c6866:
	mov_s r0,0x1c
L_8c6868:
	mov_s r1,0x1
L_8c686a:
	bl.d L_8ccdac
L_8c686e:
	ldb_s r2,[sp,0x4]
L_8c6870:
	mov_s r0,0x0
L_8c6872:
	bl.d L_8ccfb0
L_8c6876:
	mov_s r1,r0
L_8c6878:
	mov_s r0,0x1
L_8c687a:
	bl.d L_8ccfb0
L_8c687e:
	mov_s r1,0x1c
L_8c6880:
	add_s r3,sp,0x40
L_8c6882:
	mov_s r0,r16
L_8c6884:
	mov_s r1,r13
L_8c6886:
	bl.d L_8e0128
L_8c688a:
	mov_s r2,r14
L_8c688c:
	mov r16,0x1
	.global L_8c6890
L_8c6890:
	mov_s r14,0x0
L_8c6892:
	mov_s r13,0x1e
	.global L_8c6894
L_8c6894:
	mov_s r0,r14
L_8c6896:
	mov_s r1,0x0
L_8c6898:
	bl.d L_8cce38
L_8c689c:
	mov_s r2,r16
L_8c689e:
	mov_s r0,r14
L_8c68a0:
	mov_s r1,0x1
L_8c68a2:
	bl.d L_8cce38
L_8c68a6:
	mov_s r2,r16
L_8c68a8:
	mov_s r0,r14
L_8c68aa:
	mov_s r1,0x0
L_8c68ac:
	bl.d L_8ccdac
L_8c68b0:
	ldb_s r2,[sp,0x0]
L_8c68b2:
	mov_s r0,r14
L_8c68b4:
	mov_s r1,0x1
L_8c68b6:
	bl.d L_8ccdac
L_8c68ba:
	ldb_s r2,[sp,0x4]
L_8c68bc:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8c68be:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8c68c0:
	brhs.d r13,0x1,L_8c6894
L_8c68c4:
	extb_s r14,r14
L_8c68c6:
	ld r4,[sp, 0x4]
L_8c68ca:
	mov_s r2,0x1017904
L_8c68d0:
	ld_s r3,[sp,0x0]
L_8c68d2:
	mov_s r0,0x6
L_8c68d4:
	mov_s r1,0x2
L_8c68d6:
	bl.d L_8ee034
L_8c68da:
	mov r5,r16
L_8c68de:
	mov_s r0,0x1
L_8c68e0:
	mov_s r12,0x8
L_8c68e2:
	b.d L_8c0326
L_8c68e6:
	add_s sp,sp,0x78
