/* agc_tbl__unpack_field16 @ 0x8e154c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: agc_start_index
 */
	.section .text.agc_tbl__unpack_field16,"ax",@progbits
	.global agc_tbl__unpack_field16
agc_tbl__unpack_field16:
	.global L_8e154c
L_8e154c:
	mov_s r0,0x800494
L_8e1552:
	ld_s r1,[r0,0x10]
L_8e1554:
	ldw_s r2,[r0]
L_8e1556:
	bmsk r3,r1,0x0
L_8e155a:
	lsr_s r1,r1
L_8e155c:
	bclr_s r2,r2,0x0
L_8e155e:
	bmsk_s r1,r1,0x0
L_8e1560:
	or_s r2,r2,r3
L_8e1562:
	asl_s r1,r1
L_8e1564:
	bclr_s r2,r2,0x1
L_8e1566:
	or_s r1,r1,r2
L_8e1568:
	stw_s r1,[r0]
L_8e156a:
	ldb_s r1,[r0,0x11]
L_8e156c:
	stb_s r1,[r0,0x1]
L_8e156e:
	ldw_s r1,[r0,0x12]
L_8e1570:
	stw_s r1,[r0,0x2]
L_8e1572:
	ldw_s r1,[r0,0x14]
L_8e1574:
	j_s.d [blink]
L_8e1576:
	stw_s r1,[r0,0x4]
