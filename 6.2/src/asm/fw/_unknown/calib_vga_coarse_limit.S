/* calib_vga_coarse_limit @ 0x8d8604, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *         Coarse VGA (%d) reached its limit (%d)
 * Зовут его: calib_vga_coarse
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit2, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_vga_coarse_limit
calib_vga_coarse_limit:
	.global L_8d8604
L_8d8604:
	sub_s sp,sp,0x20
L_8d8606:
	push_s blink
L_8d8608:
	bl L_8c01d8
L_8d860c:
	sub_s sp,sp,0x4
L_8d860e:
	ld_s r1,[sp,0x50]
L_8d8610:
	st_s r0,[sp,0x1c]
L_8d8612:
	cmp_s r1,0x0
L_8d8614:
	mov_s r0,0x0
L_8d8616:
	mov.ne r15,0x6
L_8d861a:
	mov.ne r2,0xffffffff
L_8d8622:
	bne_s L_8d862a
L_8d8624:
	ldb_s r0,[sp,0x1c]
L_8d8626:
	mov_s r15,0x2
L_8d8628:
	mov_s r2,0x1
	.global L_8d862a
L_8d862a:
	ld_s r13,[sp,0x44]
L_8d862c:
	mov_s r17,r2
L_8d862e:
	ld_s r2,[sp,0x48]
L_8d8630:
	ldb_s r2,[r2]
L_8d8632:
	brne r13,0x1,L_8d864e
L_8d8636:
	ld_s r14,[sp,0x40]
L_8d8638:
	ldb_s r3,[r14]
L_8d863a:
	brne r0,r3,L_8d8644
L_8d863e:
	stb_s r15,[r14]
L_8d8640:
	mov_s r13,0x0
L_8d8642:
	b_s L_8d864e
	.global L_8d8644
L_8d8644:
	add_s r3,r3,r17
L_8d8646:
	stb_s r3,[r14]
L_8d8648:
	ld_s r0,[sp,0x54]
L_8d864a:
	mov_s r3,0x1
L_8d864c:
	stb_s r3,[r0]
	.global L_8d864e
L_8d864e:
	brne_s r13,0,L_8d86b8
L_8d8650:
	ld_s r15,[sp,0x40]
L_8d8652:
	sub r15,r15,0x20
L_8d8656:
	add_s r15,r15,r2
L_8d8658:
	ldb_s r14,[r15,0x1f]
L_8d865a:
	cmp_s r14,0x0
L_8d865c:
	cmp.eq r1,0x1
L_8d8660:
	beq_s L_8d8678
L_8d8662:
	sub3 r13,sp,0x10
L_8d8666:
	add1 r16,r13,0x3f
L_8d866a:
	add_s r13,r13,r2
L_8d866c:
	ldb r0,[r13, 0x9b]
L_8d8670:
	cmp_s r14,r0
L_8d8672:
	cmp.eq r1,0x0
L_8d8676:
	bne_s L_8d868e
	.global L_8d8678
L_8d8678:
	mov_s r1,0x101ca2c
L_8d867e:
	mov_s r0,0x6
L_8d8680:
	bl.d L_8dcc80
L_8d8684:
	mov_s r3,r14
L_8d8686:
	mov_s r1,0x2
L_8d8688:
	ld_s r0,[sp,0x58]
L_8d868a:
	st_s r1,[r0]
L_8d868c:
	b_s L_8d86b8
	.global L_8d868e
L_8d868e:
	mov_s r0,sp
L_8d8690:
	mov_s r1,0x803814
L_8d8696:
	bl.d L_8c0380
L_8d869a:
	mov_s r2,0x3
L_8d869c:
	add_s r14,r14,r17
L_8d869e:
	ldb r1,[r13, 0x7e]
L_8d86a2:
	extb_s r14,r14
L_8d86a4:
	ld_s r0,[sp,0x54]
L_8d86a6:
	stb_s r14,[r15,0x1f]
L_8d86a8:
	stb_s r1,[r0]
L_8d86aa:
	ldb_s r0,[sp,0x4c]
L_8d86ac:
	brne r1,r0,L_8d86b4
L_8d86b0:
	ldb r1,[r16,r1]
	.global L_8d86b4
L_8d86b4:
	ld_s r0,[sp,0x48]
L_8d86b6:
	stb_s r1,[r0]
	.global L_8d86b8
L_8d86b8:
	mov_s r12,0x24
L_8d86ba:
	b.d L_8c023e
L_8d86be:
	add_s sp,sp,0x4
