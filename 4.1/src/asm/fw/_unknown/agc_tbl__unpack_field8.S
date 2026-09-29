/* agc_tbl__unpack_field8 @ 0x8e21a4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: agc_start_index
 */
	.section .text.agc_tbl__unpack_field8,"ax",@progbits
	.global agc_tbl__unpack_field8
agc_tbl__unpack_field8:
	.global L_8e21a4
L_8e21a4:
	mov_s r0,0x800494
L_8e21aa:
	ld_s r1,[r0,0x8]
L_8e21ac:
	ldw_s r2,[r0]
L_8e21ae:
	bmsk r3,r1,0x0
L_8e21b2:
	lsr_s r1,r1
L_8e21b4:
	bclr_s r2,r2,0x0
L_8e21b6:
	bmsk_s r1,r1,0x0
L_8e21b8:
	or_s r2,r2,r3
L_8e21ba:
	asl_s r1,r1
L_8e21bc:
	bclr_s r2,r2,0x1
L_8e21be:
	or_s r1,r1,r2
L_8e21c0:
	stw_s r1,[r0]
L_8e21c2:
	ldb_s r1,[r0,0x9]
L_8e21c4:
	stb_s r1,[r0,0x1]
L_8e21c6:
	ldw_s r1,[r0,0xa]
L_8e21c8:
	stw_s r1,[r0,0x2]
L_8e21ca:
	ldw_s r1,[r0,0xc]
L_8e21cc:
	j_s.d [blink]
L_8e21ce:
	stw_s r1,[r0,0x4]
