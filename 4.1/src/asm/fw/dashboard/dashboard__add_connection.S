/* dashboard__add_connection @ 0x8e5868, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dashboard.cpp
 * Зовут его: l2mgr__publish_assoc_done
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bf_w_s29_w3, fw_sysassert_fatal, memcpy_fw, memset0_words
 */
	.section .text.dashboard__add_connection,"ax",@progbits
	.global dashboard__add_connection
dashboard__add_connection:
	.global L_8e5868
L_8e5868:
	push_s blink
L_8e586a:
	bl L_8c02b4
L_8e586e:
	mov.f r15,r0
L_8e5872:
	beq_s L_8e58ec
	.global L_8e5874
L_8e5874:
	ldb_s r14,[r15,0x8]
L_8e5876:
	brge r14,0x8,L_8e5902
	.global L_8e587a
L_8e587a:
	asl_s r1,r14,0x4
L_8e587c:
	add3_s r1,r1,r1
L_8e587e:
	add r13,r1,0x854980
L_8e5886:
	ld r18,[r13, 0x4]
L_8e588a:
	mov_s r0,0x854a00
L_8e5890:
	sub r0,r0,0xfc
L_8e5894:
	add_s r0,r0,r1
L_8e5896:
	ld r17,[r13, 0x8]
L_8e589a:
	bl.d L_8c1a78
L_8e589e:
	mov_s r1,0x90
L_8e58a0:
	st r18,[r13, 0x4]
L_8e58a4:
	st r17,[r13, 0x8]
L_8e58a8:
	add r1,r15,0x10
L_8e58ac:
	add r0,r13,0xc
L_8e58b0:
	bl.d L_8c0460
L_8e58b4:
	mov_s r2,0x6
L_8e58b6:
	mov_s r2,0x854880
L_8e58bc:
	ld_s r0,[r2,0x78]
L_8e58be:
	mov r16,0x854900
L_8e58c6:
	lsr_s r0,r0,0x1d
L_8e58c8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e58ca:
	bmsk r1,r0,0x2
L_8e58ce:
	add3 r0,r2,0xf
L_8e58d2:
	bl L_8e8498
L_8e58d6:
	ldb r1,[r16]
L_8e58da:
	brne_s r1,0,L_8e58e0
L_8e58dc:
	mov_s r0,0x0
L_8e58de:
	st_s r0,[r2,0x70]
	.global L_8e58e0
L_8e58e0:
	bset r1,r1,r14
L_8e58e4:
	b.d L_8c0314
L_8e58e8:
	stb r1,[r16]
	.global L_8e58ec
L_8e58ec:
	mov_s r0,blink
L_8e58ee:
	mov_s r2,0x1014c54
L_8e58f4:
	mov_s r1,0x1119
L_8e58fa:
	bl.d L_8c82c0
L_8e58fe:
	mov_s r3,0x6b
L_8e5900:
	b_s L_8e5874
	.global L_8e5902
L_8e5902:
	mov_s r0,blink
L_8e5904:
	mov_s r2,0x1014c54
L_8e590a:
	mov_s r1,0x111a
L_8e5910:
	bl.d L_8c82c0
L_8e5914:
	mov_s r3,0x6d
L_8e5916:
	b_s L_8e587a
