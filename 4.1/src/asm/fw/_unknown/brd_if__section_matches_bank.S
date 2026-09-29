/* brd_if__section_matches_bank @ 0x8c575c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__check_physical_section_validity
 */
	.section .text.brd_if__section_matches_bank,"ax",@progbits
	.global brd_if__section_matches_bank
brd_if__section_matches_bank:
	.global L_8c575c
L_8c575c:
	brne_s r2,0,L_8c576e
L_8c575e:
	cmp_s r1,0x2
L_8c5760:
	cmp.ne r1,0x4
L_8c5764:
	cmp.ne r1,0x6
L_8c5768:
	cmp.ne r1,0x8
L_8c576c:
	bne_s L_8c5790
	.global L_8c576e
L_8c576e:
	brne r2,0x1,L_8c5782
L_8c5772:
	cmp_s r1,0x3
L_8c5774:
	cmp.ne r1,0x5
L_8c5778:
	cmp.ne r1,0x7
L_8c577c:
	cmp.ne r1,0x9
L_8c5780:
	bne_s L_8c5790
	.global L_8c5782
L_8c5782:
	brne r2,0x2,L_8c578a
L_8c5786:
	brne r1,0x1,L_8c5790
	.global L_8c578a
L_8c578a:
	brne r2,0x3,L_8c5794
L_8c578e:
	breq_s r1,0,L_8c5794
	.global L_8c5790
L_8c5790:
	mov_s r0,0x0
L_8c5792:
	b_s L_8c5796
	.global L_8c5794
L_8c5794:
	mov_s r0,0x1
	.global L_8c5796
L_8c5796:
	j_s [blink]
