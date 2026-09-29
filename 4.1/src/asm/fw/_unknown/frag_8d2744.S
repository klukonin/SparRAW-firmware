/* frag_8d2744 @ 0x8d2744, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_row_step, frag_8d93cc
 */
	.section .text.frag_8d2744,"ax",@progbits
	.global frag_8d2744
frag_8d2744:
	.global L_8d2744
L_8d2744:
	sub_s sp,sp,0x1c
L_8d2746:
	st_s r2,[sp,0x4]
L_8d2748:
	st_s r3,[sp,0x8]
L_8d274a:
	st r4,[sp, 0xc]
L_8d274e:
	ldb_s r1,[r0]
L_8d2750:
	st r7,[sp, 0x18]
L_8d2754:
	add_s r1,r1,sp
L_8d2756:
	ldb_s r1,[r1,0x3]
L_8d2758:
	ld_s r2,[sp,0x24]
L_8d275a:
	st r6,[sp, 0x14]
L_8d275e:
	stb_s r1,[r2]
L_8d2760:
	ldb_s r1,[r0,0x1]
L_8d2762:
	st r5,[sp, 0x10]
L_8d2766:
	add_s r1,r1,sp
L_8d2768:
	ldb_s r1,[r1,0xb]
L_8d276a:
	stb_s r1,[r2,0x1]
L_8d276c:
	ldb_s r1,[r0,0x2]
L_8d276e:
	add_s r1,r1,sp
L_8d2770:
	ldb_s r1,[r1,0x13]
L_8d2772:
	stb_s r1,[r2,0x2]
L_8d2774:
	ldb_s r0,[r0,0x3]
L_8d2776:
	add_s r0,r0,sp
L_8d2778:
	ldb_s r0,[r0,0x1b]
L_8d277a:
	stb_s r0,[r2,0x3]
L_8d277c:
	j_s.d [blink]
L_8d277e:
	add_s sp,sp,0x1c
