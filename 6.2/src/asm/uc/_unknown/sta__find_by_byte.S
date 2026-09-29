/* sta__find_by_byte @ 0x9267ac, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: peer__lookup_or_ff, peer_masks__or_into_8571c4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sta__find_by_byte
sta__find_by_byte:
	.global L_9267ac
L_9267ac:
	mov_s r2,0x0
L_9267ae:
	b_s L_9267b2
	.global L_9267b0
L_9267b0:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_9267b2
L_9267b2:
	brhs r2,0x8,L_9267ce
L_9267b6:
	mov_s r3,0x80218c
L_9267bc:
	ldb_s r3,[r3,0x8]
L_9267be:
	bbit0 r3,r2,L_9267b0
L_9267c2:
	add2 r3,r2,r2
L_9267c6:
	ldb_s r3,[r0,r3]
L_9267c8:
	brne r1,r3,L_9267b0
L_9267cc:
	b_s L_9267d0
	.global L_9267ce
L_9267ce:
	mov_s r2,0xff
	.global L_9267d0
L_9267d0:
	j_s.d [blink]
L_9267d2:
	mov_s r0,r2
