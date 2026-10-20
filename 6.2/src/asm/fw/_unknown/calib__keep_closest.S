/* calib__keep_closest @ 0x8d52d0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_bb_gain_create_table
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib__keep_closest
calib__keep_closest:
	.global L_8d52d0
L_8d52d0:
	sub_s sp,sp,0x8
L_8d52d2:
	push_s r13
L_8d52d4:
	st_s r2,[sp,0x8]
L_8d52d6:
	sub r2,r1,r3
L_8d52da:
	abs_s r13,r2
L_8d52dc:
	ld_s r2,[r0]
L_8d52de:
	sub_s r2,r2,r3
L_8d52e0:
	abs_s r2,r2
L_8d52e2:
	cmp_s r13,r2
L_8d52e4:
	rlc r2,0x0
L_8d52e8:
	brne r2,0x1,L_8d5304
L_8d52ec:
	st_s r1,[r0]
L_8d52ee:
	ldb_s r1,[sp,0x8]
L_8d52f0:
	stb_s r1,[r0,0x4]
L_8d52f2:
	ldb r1,[sp, 0x9]
L_8d52f6:
	stb_s r1,[r0,0x5]
L_8d52f8:
	ldb r1,[sp, 0xa]
L_8d52fc:
	stb_s r1,[r0,0x6]
L_8d52fe:
	ldb r1,[sp, 0xb]
L_8d5302:
	stb_s r1,[r0,0x7]
	.global L_8d5304
L_8d5304:
	pop_s r13
L_8d5306:
	j_s.d [blink]
L_8d5308:
	add_s sp,sp,0x8
L_8d530a:
	nop_s
