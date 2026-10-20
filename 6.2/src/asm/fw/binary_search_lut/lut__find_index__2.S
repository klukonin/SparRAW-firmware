/* lut__find_index__2 @ 0x8ca7f8, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lut::find_index(): x=%d out of search range [%d,%d]
 *   lut::find_index(): start_idx=%d, end_idx=%d
 *   lut::find_index(): bad middle_idx=0, end_idx=%d, start_idx=%d, x=%d
 *   lut::find_index(): Binary search hasn't converged after %d iterations. lut_size=%d
 * Зовут его: lut__find_index
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lut__find_index__2
lut__find_index__2:
	.global L_8ca7f8
L_8ca7f8:
	push_s blink
L_8ca7fa:
	bl L_8c01d0
L_8ca7fe:
	mov_s r16,r0
L_8ca800:
	mov_s r19,r1
L_8ca802:
	mov_s r13,0x0
L_8ca804:
	ld r1,[r16]
L_8ca808:
	ld_s r0,[r0,0x8]
L_8ca80a:
	ld.as r2,[r1,r13]
L_8ca80e:
	brlt.d r2,r19,L_8ca818
L_8ca812:
	sub_s r15,r0,0x1
	.global L_8ca814
L_8ca814:
	mov_s r15,r13
L_8ca816:
	b_s L_8ca8ee
	.global L_8ca818
L_8ca818:
	ld.as r2,[r1,r15]
L_8ca81c:
	brge r19,r2,L_8ca8ee
L_8ca820:
	add2 r18,r0,r0
L_8ca824:
	mov_s r17,r13
L_8ca826:
	b_s L_8ca8f4
	.global L_8ca828
L_8ca828:
	ld.as r3,[r1,r13]
L_8ca82c:
	add r17,r0,0x1
L_8ca830:
	ld.as r4,[r1,r14]
L_8ca834:
	cmp_s r3,r19
L_8ca836:
	cmp.le r19,r4
L_8ca83a:
	ble_s L_8ca866
L_8ca83c:
	mov_s r1,0x1013254
L_8ca842:
	mov_s r0,0x0
L_8ca844:
	bl.d L_8dcd00
L_8ca848:
	mov_s r2,r19
L_8ca84a:
	mov_s r1,0x1013288
L_8ca850:
	mov_s r0,0x0
L_8ca852:
	mov_s r2,r13
L_8ca854:
	bl.d L_8dcc80
L_8ca858:
	mov_s r3,r14
L_8ca85a:
	mov_s r0,blink
L_8ca85c:
	mov_s r1,0x1443
L_8ca862:
	bl L_8c9b28
	.global L_8ca866
L_8ca866:
	sub r0,r14,r13
L_8ca86a:
	brlo r0,0x2,L_8ca8d0
L_8ca86e:
	add_s r15,r14,r13
L_8ca870:
	lsr.f r15,r15
L_8ca874:
	bne_s L_8ca896
L_8ca876:
	mov_s r1,0x10132b4
L_8ca87c:
	mov_s r0,0x0
L_8ca87e:
	mov_s r2,r13
L_8ca880:
	mov_s r3,r14
L_8ca882:
	bl.d L_8dcd00
L_8ca886:
	mov r4,r19
L_8ca88a:
	mov_s r0,blink
L_8ca88c:
	mov_s r1,0x1444
L_8ca892:
	bl L_8c9b28
	.global L_8ca896
L_8ca896:
	ld r1,[r16]
L_8ca89a:
	ld.as r0,[r1,r15]
L_8ca89e:
	breq r0,r19,L_8ca8ee
L_8ca8a2:
	brlt r19,r0,L_8ca8f4
L_8ca8a6:
	brlt r0,r19,L_8ca8f8
	.global L_8ca8aa
L_8ca8aa:
	mov_s r0,r17
L_8ca8ac:
	brlo r0,r18,L_8ca828
L_8ca8b0:
	mov_s r1,0x10132f8
L_8ca8b6:
	mov_s r0,0x0
L_8ca8b8:
	mov_s r2,r17
L_8ca8ba:
	bl.d L_8dcc80
L_8ca8be:
	ld r3,[r16, 0x8]
L_8ca8c2:
	mov_s r0,blink
L_8ca8c4:
	mov_s r1,0x1446
L_8ca8ca:
	bl L_8c9b28
L_8ca8ce:
	b_s L_8ca814
	.global L_8ca8d0
L_8ca8d0:
	ld r2,[r16]
L_8ca8d4:
	ld.as r0,[r2,r13]
L_8ca8d8:
	sub r1,r19,r0
L_8ca8dc:
	ld.as r0,[r2,r14]
L_8ca8e0:
	sub r0,r0,r19
L_8ca8e4:
	cmp_s r1,r0
L_8ca8e6:
	mov.lt r15,r13
L_8ca8ea:
	mov.ge r15,r14
	.global L_8ca8ee
L_8ca8ee:
	b.d L_8c022c
L_8ca8f2:
	mov_s r0,r15
	.global L_8ca8f4
L_8ca8f4:
	mov_s r14,r15
L_8ca8f6:
	b_s L_8ca8aa
	.global L_8ca8f8
L_8ca8f8:
	mov_s r13,r15
L_8ca8fa:
	b_s L_8ca8aa
