/* uc_evt__build_and_post_report @ 0x93e624, 416 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__respond_flow, mac_mode_program_c
 * Зовёт сам: uc_read_tsf_lo, uc_send_evt__bf_done, uc_send_evt__new_link
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__build_and_post_report
uc_evt__build_and_post_report:
	.global L_93e624
L_93e624:
	st.a r13,[sp,-0x1c]
L_93e628:
	st blink,[sp, 0x4]
L_93e62c:
	st_s r14,[sp,0x8]
L_93e62e:
	st_s r15,[sp,0xc]
L_93e630:
	st r16,[sp, 0x10]
L_93e634:
	st r17,[sp, 0x14]
L_93e638:
	st r18,[sp, 0x18]
L_93e63c:
	sub sp,sp,0x68
L_93e640:
	mov r4,0x1
L_93e644:
	breq.d r1,0x0,L_93e654
L_93e648:
	st r4,[sp, 0x50]
L_93e64c:
	b.d L_93e658
L_93e650:
	ldb r14,[r0]
	.global L_93e654
L_93e654:
	ldb r14,[r0, 0xd]
	.global L_93e658
L_93e658:
	stb_s r14,[sp,0x28]
L_93e65a:
	cmp_s r1,0x0
L_93e65c:
	mov r9,0x1
L_93e660:
	sub.ne r9,r9,r9
L_93e664:
	add r9,r9,0x3
L_93e668:
	stb r9,[sp, 0x5e]
L_93e66c:
	mov r2,0x0
L_93e670:
	breq.d r1,0x0,L_93e680
L_93e674:
	stb r2,[sp, 0x5f]
L_93e678:
	b.d L_93e684
L_93e67c:
	ldb r13,[r0, 0xc]
	.global L_93e680
L_93e680:
	ldb r13,[r0, 0x10]
	.global L_93e684
L_93e684:
	mov r5,0x2
L_93e688:
	breq.d r1,0x0,L_93e698
L_93e68c:
	st r5,[sp, 0x54]
L_93e690:
	b.d L_93e6a0
L_93e694:
	ldw r3,[r0, 0x12]
	.global L_93e698
L_93e698:
	ldw r3,[0x802f28]
	.global L_93e6a0
L_93e6a0:
	breq.d r1,0x0,L_93e6b0
L_93e6a4:
	stw r3,[sp, 0x58]
L_93e6a8:
	b.d L_93e6b8
L_93e6ac:
	ldw r4,[r0, 0x14]
	.global L_93e6b0
L_93e6b0:
	ldw r4,[0x802f2a]
	.global L_93e6b8
L_93e6b8:
	breq.d r1,0x0,L_93e6c8
L_93e6bc:
	stw r4,[sp, 0x5a]
L_93e6c0:
	b.d L_93e6d0
L_93e6c4:
	ldw r5,[r0, 0x16]
	.global L_93e6c8
L_93e6c8:
	ldw r5,[0x802f2c]
	.global L_93e6d0
L_93e6d0:
	breq.d r1,0x0,L_93e6e0
L_93e6d4:
	stw r5,[sp, 0x5c]
L_93e6d8:
	b.d L_93e6e4
L_93e6dc:
	ldb r2,[r0, 0xb]
	.global L_93e6e0
L_93e6e0:
	ldb r2,[r0, 0xe]
	.global L_93e6e4
L_93e6e4:
	ld r10,[0x801024]
L_93e6ec:
	stb r2,[sp, 0x2a]
L_93e6f0:
	lsr r10,r10,0x8
L_93e6f4:
	bmsk r10,r10,0xe
L_93e6f8:
	mov_s r1,0x8020f0
L_93e6fe:
	ldb.x r7,[r1, 0xc]
L_93e702:
	stw r10,[sp, 0x2e]
L_93e706:
	stb r7,[sp, 0x30]
L_93e70a:
	ldb r8,[r1, 0xe]
L_93e70e:
	ldb.x r18,[r1, 0xd]
L_93e712:
	stb r8,[sp, 0x2d]
L_93e716:
	ld_s r15,[r1,0x10]
L_93e718:
	ld r16,[r1, 0x14]
L_93e71c:
	ld r6,[r1, 0x1c]
L_93e720:
	ld r17,[r1, 0x18]
L_93e724:
	st r6,[sp, 0x44]
L_93e728:
	mov_s r3,0xff
L_93e72a:
	st_s r3,[sp,0x4c]
L_93e72c:
	st r3,[sp, 0x48]
L_93e730:
	bl.d L_9364c8
L_93e734:
	stb r3,[sp, 0x29]
L_93e738:
	ld_s r1,[sp,0x28]
L_93e73a:
	st_s r0,[sp,0x64]
L_93e73c:
	ld_s r2,[sp,0x2c]
L_93e73e:
	ld_s r3,[sp,0x30]
L_93e740:
	ld r11,[sp, 0x44]
L_93e744:
	ld r10,[sp, 0x48]
L_93e748:
	ld r9,[sp, 0x4c]
L_93e74c:
	ld r8,[sp, 0x50]
L_93e750:
	st r11,[sp]
L_93e754:
	st r10,[sp, 0x4]
L_93e758:
	st r9,[sp, 0x8]
L_93e75c:
	st r8,[sp, 0xc]
L_93e760:
	ld r11,[sp, 0x54]
L_93e764:
	ld r10,[sp, 0x58]
L_93e768:
	ld r9,[sp, 0x5c]
L_93e76c:
	ld r8,[sp, 0x60]
L_93e770:
	st r11,[sp, 0x10]
L_93e774:
	st r10,[sp, 0x14]
L_93e778:
	st r9,[sp, 0x18]
L_93e77c:
	ld r11,[sp, 0x64]
L_93e780:
	st r8,[sp, 0x1c]
L_93e784:
	st r11,[sp, 0x20]
L_93e788:
	mov_s r0,r13
L_93e78a:
	mov r4,r18
L_93e78e:
	mov_s r5,r15
L_93e790:
	mov r6,r16
L_93e794:
	breq.d r14,0x8,L_93e7a4
L_93e798:
	mov r7,r17
L_93e79c:
	bl L_9275a8
L_93e7a0:
	b L_93e7a8
	.global L_93e7a4
L_93e7a4:
	bl L_9276bc
	.global L_93e7a8
L_93e7a8:
	add_s sp,sp,0x68
L_93e7aa:
	ld blink,[sp, 0x4]
L_93e7ae:
	ld_s r14,[sp,0x8]
L_93e7b0:
	ld_s r15,[sp,0xc]
L_93e7b2:
	ld r16,[sp, 0x10]
L_93e7b6:
	ld r17,[sp, 0x14]
L_93e7ba:
	ld r18,[sp, 0x18]
L_93e7be:
	j_s.d [blink]
L_93e7c0:
	ld.ab r13,[sp,0x1c]
