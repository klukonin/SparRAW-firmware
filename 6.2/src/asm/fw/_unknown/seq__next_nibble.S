/* seq__next_nibble @ 0x8cb818, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_scheme_builder__build_allocations
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global seq__next_nibble
seq__next_nibble:
	.global L_8cb818
L_8cb818:
	mov_s r2,0x803c00
L_8cb81e:
	ld_s r2,[r2,0x10]
L_8cb820:
	brne_s r2,0,L_8cb838
L_8cb822:
	ldb_s r2,[r1,0x5]
L_8cb824:
	brne r2,0x1,L_8cb838
L_8cb828:
	ldb_s r3,[r1,0xf]
L_8cb82a:
	mov_s r2,0xff
L_8cb82c:
	brne r3,r2,L_8cb838
L_8cb830:
	ldb_s r1,[r1,0xe]
L_8cb832:
	cmp_s r1,r2
L_8cb834:
	mov_s r2,0x0
L_8cb836:
	beq_s L_8cb840
	.global L_8cb838
L_8cb838:
	ldb_s r2,[r0,0x4]
L_8cb83a:
	add_s r1,r2,0x1
L_8cb83c:
	bmsk_s r1,r1,0x3
L_8cb83e:
	stb_s r1,[r0,0x4]
	.global L_8cb840
L_8cb840:
	j_s.d [blink]
L_8cb842:
	mov_s r0,r2
