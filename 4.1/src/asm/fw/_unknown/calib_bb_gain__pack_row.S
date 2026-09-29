/* calib_bb_gain__pack_row @ 0x8e46fc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_bb_gain_rows
 */
	.section .text.calib_bb_gain__pack_row,"ax",@progbits
	.global calib_bb_gain__pack_row
calib_bb_gain__pack_row:
	.global L_8e46fc
L_8e46fc:
	ldb_s r2,[r0,0x3]
L_8e46fe:
	breq_s r1,0,L_8e4714
L_8e4700:
	ldb_s r3,[r0]
L_8e4702:
	ldb_s r1,[r0,0x1]
L_8e4704:
	asl_s r3,r3,0xc
L_8e4706:
	asl_s r1,r1,0x8
L_8e4708:
	ldb_s r0,[r0,0x2]
L_8e470a:
	add_s r1,r1,r3
L_8e470c:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8e470e:
	add_s r0,r0,r1
L_8e4710:
	add_s r0,r0,r2
L_8e4712:
	b_s L_8e4726
	.global L_8e4714
L_8e4714:
	ldb_s r1,[r0]
L_8e4716:
	ldb_s r3,[r0,0x1]
L_8e4718:
	asl_s r1,r1,0x18
L_8e471a:
	asl_s r3,r3,0x10
L_8e471c:
	ldb_s r0,[r0,0x2]
L_8e471e:
	add_s r1,r1,r3
L_8e4720:
	asl_s r0,r0,0x8
L_8e4722:
	add_s r0,r0,r1
L_8e4724:
	add_s r0,r0,r2
	.global L_8e4726
L_8e4726:
	j_s [blink]
