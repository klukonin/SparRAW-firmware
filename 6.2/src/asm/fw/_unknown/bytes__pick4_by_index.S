/* bytes__pick4_by_index @ 0x8d5578, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_row_step, hwf_calib_bb_gain__args
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bytes__pick4_by_index
bytes__pick4_by_index:
	.global L_8d5578
L_8d5578:
	sub_s sp,sp,0x1c
L_8d557a:
	st_s r2,[sp,0x4]
L_8d557c:
	st_s r3,[sp,0x8]
L_8d557e:
	st r4,[sp, 0xc]
L_8d5582:
	ldb_s r1,[r0]
L_8d5584:
	st r7,[sp, 0x18]
L_8d5588:
	add_s r1,r1,sp
L_8d558a:
	ldb_s r1,[r1,0x3]
L_8d558c:
	ld_s r2,[sp,0x24]
L_8d558e:
	st r6,[sp, 0x14]
L_8d5592:
	stb_s r1,[r2]
L_8d5594:
	ldb_s r1,[r0,0x1]
L_8d5596:
	st r5,[sp, 0x10]
L_8d559a:
	add_s r1,r1,sp
L_8d559c:
	ldb_s r1,[r1,0xb]
L_8d559e:
	stb_s r1,[r2,0x1]
L_8d55a0:
	ldb_s r1,[r0,0x2]
L_8d55a2:
	add_s r1,r1,sp
L_8d55a4:
	ldb_s r1,[r1,0x13]
L_8d55a6:
	stb_s r1,[r2,0x2]
L_8d55a8:
	ldb_s r0,[r0,0x3]
L_8d55aa:
	add_s r0,r0,sp
L_8d55ac:
	ldb_s r0,[r0,0x1b]
L_8d55ae:
	stb_s r0,[r2,0x3]
L_8d55b0:
	j_s.d [blink]
L_8d55b2:
	add_s sp,sp,0x1c
