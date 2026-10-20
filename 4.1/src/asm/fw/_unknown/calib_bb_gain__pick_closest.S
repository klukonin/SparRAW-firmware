/* calib_bb_gain__pick_closest @ 0x8d2484, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, hwf_calib_bb_gain_create_table
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, calib_bb_gain__choose_row
 */
	.section .text.calib_bb_gain__pick_closest,"ax",@progbits
	.global calib_bb_gain__pick_closest
calib_bb_gain__pick_closest:
	.global L_8d2484
L_8d2484:
	sub_s sp,sp,0x8
L_8d2486:
	push_s blink
L_8d2488:
	bl L_8c02c0
L_8d248c:
	st_s r1,[sp,0x10]
L_8d248e:
	st_s r2,[sp,0x14]
L_8d2490:
	mov_s r14,r0
L_8d2492:
	ld_s r0,[r0]
L_8d2494:
	sub_s r1,r1,r3
L_8d2496:
	sub_s r0,r0,r3
L_8d2498:
	abs_s r13,r0
L_8d249a:
	cmp_s r13,0x20000
L_8d24a0:
	abs_s r15,r1
L_8d24a2:
	bls_s L_8d24a8
L_8d24a4:
	brlo r15,r13,L_8d24be
	.global L_8d24a8
L_8d24a8:
	add_s r0,sp,0x14
L_8d24aa:
	bl.d L_8d1f48
L_8d24ae:
	add_s r1,r14,0x4
L_8d24b0:
	breq r0,0x1,L_8d24be
L_8d24b4:
	brne_s r0,0,L_8d24ba
L_8d24b6:
	brlo r15,r13,L_8d24be
	.global L_8d24ba
L_8d24ba:
	mov_s r0,0x0
L_8d24bc:
	b_s L_8d24c0
	.global L_8d24be
L_8d24be:
	mov_s r0,0x1
	.global L_8d24c0
L_8d24c0:
	brne r0,0x1,L_8d24de
L_8d24c4:
	ld_s r0,[sp,0x10]
L_8d24c6:
	st_s r0,[r14]
L_8d24c8:
	ldb_s r0,[sp,0x14]
L_8d24ca:
	stb_s r0,[r14,0x4]
L_8d24cc:
	ldb r0,[sp, 0x15]
L_8d24d0:
	stb_s r0,[r14,0x5]
L_8d24d2:
	ldb r0,[sp, 0x16]
L_8d24d6:
	stb_s r0,[r14,0x6]
L_8d24d8:
	ldb r0,[sp, 0x17]
L_8d24dc:
	stb_s r0,[r14,0x7]
	.global L_8d24de
L_8d24de:
	mov_s r12,0xc
L_8d24e0:
	b L_8c032e
