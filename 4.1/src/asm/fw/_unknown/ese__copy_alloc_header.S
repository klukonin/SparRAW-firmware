/* ese__copy_alloc_header @ 0x8e56ec, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: parse_ese
 */
	.section .text.ese__copy_alloc_header,"ax",@progbits
	.global ese__copy_alloc_header
ese__copy_alloc_header:
	.global L_8e56ec
L_8e56ec:
	ldb_s r2,[r1,0x4]
L_8e56ee:
	stb_s r2,[r0,0x4]
L_8e56f0:
	ldb_s r2,[r1,0x5]
L_8e56f2:
	stb_s r2,[r0,0x5]
L_8e56f4:
	ldb_s r1,[r1]
L_8e56f6:
	bmsk_s r1,r1,0x3
L_8e56f8:
	stb_s r1,[r0,0x6]
L_8e56fa:
	mov_s r1,0x0
L_8e56fc:
	mov_s r0,0x857260
L_8e5702:
	j_s.d [blink]
L_8e5704:
	stb_s r1,[r0,0xd]
L_8e5706:
	nop_s
