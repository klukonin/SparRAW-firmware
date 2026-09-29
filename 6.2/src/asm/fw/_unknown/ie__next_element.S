/* ie__next_element @ 0x8df474, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ies__scan_for_match
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie__next_element
ie__next_element:
	.global L_8df474
L_8df474:
	ld_s r1,[r0]
L_8df476:
	breq_s r1,0,L_8df498
L_8df478:
	ldb_s r3,[r1,0x1]
L_8df47a:
	ldw_s r2,[r0,0x4]
L_8df47c:
	/* add_s r3,0x3 */
	.byte 0x03,0xe3
L_8df47e:
	add_s r2,r2,r3
L_8df480:
	extw_s r2,r2
L_8df482:
	ld_s r3,[r0,0x8]
L_8df484:
	stw_s r2,[r0,0x4]
L_8df486:
	ldw_s r3,[r3,0x10]
L_8df488:
	cmp_s r2,r3
L_8df48a:
	mov_s r2,0x0
L_8df48c:
	bge_s L_8df496
L_8df48e:
	ldb_s r2,[r1,0x1]
L_8df490:
	add1_s r2,r2,r2
L_8df492:
	add_s r2,r2,r1
L_8df494:
	add_s r2,r2,0x9
	.global L_8df496
L_8df496:
	st_s r2,[r0]
	.global L_8df498
L_8df498:
	j_s.d [blink]
L_8df49a:
	mov_s r0,r1
