/* ese__alloc_matches_id @ 0x8d72e8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: parse_ese
 */
	.section .text.ese__alloc_matches_id,"ax",@progbits
	.global ese__alloc_matches_id
ese__alloc_matches_id:
	.global L_8d72e8
L_8d72e8:
	push_s r13
L_8d72ea:
	ldb_s r13,[r1,0x4]
L_8d72ec:
	ldb_s r3,[r0,0x4]
L_8d72ee:
	mov_s r2,0x0
L_8d72f0:
	brne r13,r3,L_8d72fc
L_8d72f4:
	ldb_s r13,[r1,0x5]
L_8d72f6:
	ldb_s r3,[r0,0x5]
L_8d72f8:
	breq r13,r3,L_8d7300
	.global L_8d72fc
L_8d72fc:
	mov_s r0,r2
L_8d72fe:
	b_s L_8d730c
	.global L_8d7300
L_8d7300:
	ldb_s r1,[r1]
L_8d7302:
	ldb_s r0,[r0,0x6]
L_8d7304:
	bmsk_s r1,r1,0x3
L_8d7306:
	brne r1,r0,L_8d72fc
L_8d730a:
	mov_s r0,0x1
	.global L_8d730c
L_8d730c:
	extb_s r0,r0
L_8d730e:
	j_s.d [blink]
L_8d7310:
	pop_s r13
L_8d7312:
	nop_s
