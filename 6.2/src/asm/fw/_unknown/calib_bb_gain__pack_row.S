/* calib_bb_gain__pack_row @ 0x8e97bc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_bb_gain_rows
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_bb_gain__pack_row
calib_bb_gain__pack_row:
	.global L_8e97bc
L_8e97bc:
	ldb_s r2,[r0,0x3]
L_8e97be:
	breq_s r1,0,L_8e97d4
L_8e97c0:
	ldb_s r3,[r0]
L_8e97c2:
	ldb_s r1,[r0,0x1]
L_8e97c4:
	asl_s r3,r3,0xc
L_8e97c6:
	asl_s r1,r1,0x8
L_8e97c8:
	ldb_s r0,[r0,0x2]
L_8e97ca:
	add_s r1,r1,r3
L_8e97cc:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8e97ce:
	add_s r0,r0,r1
L_8e97d0:
	add_s r0,r0,r2
L_8e97d2:
	b_s L_8e97e6
	.global L_8e97d4
L_8e97d4:
	ldb_s r1,[r0]
L_8e97d6:
	ldb_s r3,[r0,0x1]
L_8e97d8:
	asl_s r1,r1,0x18
L_8e97da:
	asl_s r3,r3,0x10
L_8e97dc:
	ldb_s r0,[r0,0x2]
L_8e97de:
	add_s r1,r1,r3
L_8e97e0:
	asl_s r0,r0,0x8
L_8e97e2:
	add_s r0,r0,r1
L_8e97e4:
	add_s r0,r0,r2
	.global L_8e97e6
L_8e97e6:
	j_s [blink]
