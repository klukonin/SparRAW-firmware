/* dmg_cap__build_sta_capability @ 0x8e6598, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__apply_mac_address, mid__reset_bss_defaults
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bits__set16_s6_w6, bits__set16_s7_w7, bits__set8_s4_w2, bits__set8_s6_w2, dmg_cap__bits_set16_s3_w8, dmg_cap__bits_set16_s5_w6, dmg_cap__bits_set32b_s4_w24, dmg_cap__bits_set8_s1_w3, memcpy_fw, mid__copy_bssid_8e211c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dmg_cap__build_sta_capability
dmg_cap__build_sta_capability:
	.global L_8e6598
L_8e6598:
	push_s blink
L_8e659a:
	bl.d L_8c01dc
L_8e659e:
	mov_s r2,0x6
L_8e65a0:
	sub_s sp,sp,0x4
L_8e65a2:
	mov_s r15,r0
L_8e65a4:
	mov_s r0,0x0
L_8e65a6:
	mov_s r16,r0
L_8e65a8:
	add3 r14,r15,0xc
L_8e65ac:
	stb_s r0,[r14,0x4]
L_8e65ae:
	bl.d L_8c0380
L_8e65b2:
	add1 r0,r15,0x2f
L_8e65b6:
	mov_s r0,0x803c00
L_8e65bc:
	ld_s r0,[r0,0xc]
L_8e65be:
	mov_s r1,0x1
L_8e65c0:
	cmp_s r0,0x0
L_8e65c2:
	ldb_s r0,[r14,0x5]
L_8e65c4:
	sub_s.ne r1,r1,r1
L_8e65c6:
	bclr_s r0,r0,0x0
L_8e65c8:
	or_s r0,r0,r1
L_8e65ca:
	bic r0,r0,0xe
L_8e65ce:
	stb_s r0,[r14,0x5]
L_8e65d0:
	add_s r0,r14,0x5
L_8e65d2:
	mov_s r1,0x0
L_8e65d4:
	bl.d L_8ed298
L_8e65d8:
	add3 r13,r15,0x8
L_8e65dc:
	ldb_s r0,[r14,0x5]
L_8e65de:
	bclr_s r0,r0,0x6
L_8e65e0:
	stb_s r0,[r14,0x5]
L_8e65e2:
	mov_s r0,0x8042c8
L_8e65e8:
	bl L_8cb7e8
L_8e65ec:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8e65ee:
	bmsk r1,r0,0x6
L_8e65f2:
	add r0,r13,0x25
L_8e65f6:
	bl L_8ed214
L_8e65fa:
	add r0,r13,0x26
L_8e65fe:
	mov_s r1,0x1f
L_8e6600:
	bl L_8ed1d8
L_8e6604:
	ldb_s r0,[r14,0x7]
L_8e6606:
	mov_s r1,0x35
L_8e6608:
	bset_s r0,r0,0x4
L_8e660a:
	stb_s r0,[r14,0x7]
L_8e660c:
	add r0,r13,0x27
L_8e6610:
	bl L_8ed1c0
L_8e6614:
	ldb_s r0,[r14,0x8]
L_8e6616:
	mov_s r1,sp
L_8e6618:
	bclr_s r0,r0,0x3
L_8e661a:
	stb_s r0,[r14,0x8]
L_8e661c:
	st r16,[sp]
L_8e6620:
	bl.d L_8ccea4
L_8e6624:
	mov_s r0,r15
L_8e6626:
	ld_s r1,[sp,0x0]
L_8e6628:
	add3 r0,r15,0xd
L_8e662c:
	bmsk_s r1,r1,0x17
L_8e662e:
	bl L_8ed220
L_8e6632:
	ldb_s r0,[r14,0xb]
L_8e6634:
	mov_s r1,0x0
L_8e6636:
	bic r0,r0,0x30
L_8e663a:
	bic r0,r0,0xc0
L_8e663e:
	bset_s r0,r0,0x6
L_8e6640:
	stb_s r0,[r14,0xb]
L_8e6642:
	ldb_s r0,[r14,0xc]
L_8e6644:
	bclr_s r0,r0,0x0
L_8e6646:
	stb_s r0,[r14,0xc]
L_8e6648:
	add r0,r14,0xc
L_8e664c:
	bl L_8ed25c
L_8e6650:
	ldb_s r2,[r14,0xc]
L_8e6652:
	bset_s r2,r2,0x4
L_8e6654:
	bclr_s r2,r2,0x5
L_8e6656:
	bl.d L_8ed2bc
L_8e665a:
	stb_s r2,[r14,0xc]
L_8e665c:
	ldb_s r0,[r14,0xd]
L_8e665e:
	bic r0,r0,0x7
L_8e6662:
	stb_s r0,[r14,0xd]
L_8e6664:
	ld_s r0,[r15]
L_8e6666:
	ldb_s r1,[r0,0x11]
L_8e6668:
	add r0,r13,0x2d
L_8e666c:
	bl L_8ed19c
L_8e6670:
	ldb_s r0,[r14,0xe]
L_8e6672:
	mov_s r1,0x0
L_8e6674:
	bic r0,r0,0x38
L_8e6678:
	stb_s r0,[r14,0xe]
L_8e667a:
	add r0,r14,0xe
L_8e667e:
	bl L_8ed2bc
L_8e6682:
	ldb_s r0,[r14,0x5]
L_8e6684:
	mov_s r1,0x857280
L_8e668a:
	lsr_s r0,r0,0x4
L_8e668c:
	bmsk_s r0,r0,0x1
L_8e668e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e6690:
	stb_s r0,[r1,0xc]
L_8e6692:
	ldb r2,[r13, 0x26]
L_8e6696:
	ldb r0,[r13, 0x25]
L_8e669a:
	asl_s r2,r2,0x8
L_8e669c:
	or_s r0,r0,r2
L_8e669e:
	lsr_s r0,r0,0x7
L_8e66a0:
	bmsk_s r0,r0,0x6
L_8e66a2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e66a4:
	stb_s r0,[r1,0xd]
L_8e66a6:
	b.d L_8c0244
L_8e66aa:
	add_s sp,sp,0x4
