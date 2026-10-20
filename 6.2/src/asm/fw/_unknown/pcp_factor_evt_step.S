/* pcp_factor_evt_step @ 0x8c5594, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_get_pcp_factor
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set16_s7_w7, bits__set8_s2_w6, pcp_factor__bits_set32_s0_w7, pcp_factor__bits_set32_s7_w8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_factor_evt_step
pcp_factor_evt_step:
	.global L_8c5594
L_8c5594:
	push_s blink
L_8c5596:
	bl.d L_8c01e0
L_8c559a:
	bmsk_s r2,r2,0x0
L_8c559c:
	sub_s sp,sp,0x4
L_8c559e:
	mov_s r13,r1
L_8c55a0:
	mov_s r14,0x0
L_8c55a2:
	mov_s r0,sp
L_8c55a4:
	mov_s r1,r14
L_8c55a6:
	bl.d L_8ed394
L_8c55aa:
	asl_s r2,r2
L_8c55ac:
	ldb_s r15,[r13,0x10]
L_8c55ae:
	ldb_s r1,[r13,0xf]
L_8c55b0:
	asl_s r15,r15,0x8
L_8c55b2:
	or_s r1,r1,r15
L_8c55b4:
	lsr_s r1,r1,0x3
L_8c55b6:
	extb_s r1,r1
L_8c55b8:
	bl L_8ed55c
L_8c55bc:
	ldb_s r0,[r13,0x8]
L_8c55be:
	ldb_s r1,[r13,0x7]
L_8c55c0:
	asl_s r0,r0,0x8
L_8c55c2:
	or_s r1,r1,r0
L_8c55c4:
	lsr_s r1,r1,0x7
L_8c55c6:
	bmsk_s r1,r1,0x6
L_8c55c8:
	add r0,sp,0x1
L_8c55cc:
	bl L_8ed214
L_8c55d0:
	ldb_s r1,[r13,0xf]
L_8c55d2:
	ldb r15,[sp, 0x3]
L_8c55d6:
	lsr_s r0,r1
L_8c55d8:
	bmsk_s r0,r0,0x0
L_8c55da:
	asl r4,r0,0x6
L_8c55de:
	ldb r0,[sp, 0x2]
L_8c55e2:
	asl_s r15,r15,0x8
L_8c55e4:
	or_s r0,r0,r15
L_8c55e6:
	bmsk_s r1,r1,0x0
L_8c55e8:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8c55ea:
	bic r0,r0,0xc0
L_8c55ee:
	bclr r15,r4,0x7
L_8c55f2:
	or_s r0,r0,r15
L_8c55f4:
	or_s r1,r1,r0
L_8c55f6:
	stb r1,[sp, 0x2]
L_8c55fa:
	lsr_s r1,r1,0x8
L_8c55fc:
	ldb_s r0,[r13,0x10]
L_8c55fe:
	stb r1,[sp, 0x3]
L_8c5602:
	lsr_s r0,r0,0x4
L_8c5604:
	bmsk r1,r0,0x0
L_8c5608:
	ldb r0,[sp, 0x3]
L_8c560c:
	bclr_s r0,r0,0x0
L_8c560e:
	or_s r0,r0,r1
L_8c5610:
	bclr_s r0,r0,0x1
L_8c5612:
	or_s r0,r0,r2
L_8c5614:
	stb r0,[sp, 0x3]
L_8c5618:
	add r0,sp,0x3
L_8c561c:
	mov_s r1,r14
L_8c561e:
	bl L_8ed280
L_8c5622:
	ld_s r0,[sp,0x0]
L_8c5624:
	st_s r0,[r3]
L_8c5626:
	b.d L_8c024c
L_8c562a:
	add_s sp,sp,0x4
