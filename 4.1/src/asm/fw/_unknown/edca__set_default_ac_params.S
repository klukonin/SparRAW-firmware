/* edca__set_default_ac_params @ 0x8e1684, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__set_edca_defaults
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf_b_s0_w4, bf_b_s4_w4, bf_h_s0_w4, bf_h_s5_w2
 */
	.section .text.edca__set_default_ac_params,"ax",@progbits
	.global edca__set_default_ac_params
edca__set_default_ac_params:
	.global L_8e1684
L_8e1684:
	push_s blink
L_8e1686:
	bl L_8c02c4
L_8e168a:
	mov_s r13,r0
L_8e168c:
	mov_s r14,0x0
L_8e168e:
	b_s L_8e16b0
	.global L_8e1690
L_8e1690:
	mov_s r1,0x3
L_8e1692:
	bl.d L_8e82b8
L_8e1696:
	mov_s r14,r3
L_8e1698:
	mov_s r1,0x4
L_8e169a:
	add r0,r2,0x17
L_8e169e:
	bl L_8e8204
L_8e16a2:
	mov_s r1,0xa
L_8e16a4:
	bl L_8e8270
L_8e16a8:
	mov_s r0,0x28
L_8e16aa:
	stw_s r0,[r2,0x18]
	.global L_8e16ac
L_8e16ac:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e16ae:
	extb_s r14,r14
	.global L_8e16b0
L_8e16b0:
	brhs r14,0x4,L_8e1736
L_8e16b4:
	add2 r2,r13,r14
L_8e16b8:
	ldw_s r0,[r2,0x16]
L_8e16ba:
	bmsk r1,r14,0x1
L_8e16be:
	bclr_s r0,r0,0x4
L_8e16c0:
	stw_s r0,[r2,0x16]
L_8e16c2:
	add r0,r2,0x16
L_8e16c6:
	bl.d L_8e82f4
L_8e16ca:
	mov_s r3,0x0
L_8e16cc:
	ldw_s r1,[r2,0x16]
L_8e16ce:
	bclr_s r1,r1,0x7
L_8e16d0:
	stw_s r1,[r2,0x16]
L_8e16d2:
	breq_s r14,0,L_8e1690
L_8e16d4:
	breq r14,0x1,L_8e16fc
L_8e16d8:
	breq r14,0x2,L_8e1718
L_8e16dc:
	brne r14,0x3,L_8e16ac
L_8e16e0:
	mov_s r1,0x2
L_8e16e2:
	bl L_8e82b8
L_8e16e6:
	add r0,r2,0x17
L_8e16ea:
	bl L_8e8204
L_8e16ee:
	mov_s r1,0x3
L_8e16f0:
	bl L_8e8270
L_8e16f4:
	mov_s r0,0x10
L_8e16f6:
	stw_s r0,[r2,0x18]
L_8e16f8:
	mov_s r14,r1
L_8e16fa:
	b_s L_8e16ac
	.global L_8e16fc
L_8e16fc:
	mov_s r1,0x7
L_8e16fe:
	bl.d L_8e82b8
L_8e1702:
	mov_s r14,0x1
L_8e1704:
	add r0,r2,0x17
L_8e1708:
	mov_s r1,0x4
L_8e170a:
	bl L_8e8204
L_8e170e:
	mov_s r1,0xa
L_8e1710:
	bl L_8e8270
L_8e1714:
	stw_s r3,[r2,0x18]
L_8e1716:
	b_s L_8e16ac
	.global L_8e1718
L_8e1718:
	mov_s r14,0x2
L_8e171a:
	mov_s r1,r14
L_8e171c:
	bl L_8e82b8
L_8e1720:
	add r0,r2,0x17
L_8e1724:
	mov_s r1,0x3
L_8e1726:
	bl L_8e8204
L_8e172a:
	mov_s r1,0x4
L_8e172c:
	bl L_8e8270
L_8e1730:
	mov_s r0,0x40
L_8e1732:
	stw_s r0,[r2,0x18]
L_8e1734:
	b_s L_8e16ac
	.global L_8e1736
L_8e1736:
	b L_8c0334
L_8e173a:
	nop_s
