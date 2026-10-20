/* ie__next_element @ 0x8db1c4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ies__scan_for_match
 */
	.section .text.ie__next_element,"ax",@progbits
	.global ie__next_element
ie__next_element:
	.global L_8db1c4
L_8db1c4:
	ld_s r1,[r0]
L_8db1c6:
	breq_s r1,0,L_8db1e8
L_8db1c8:
	ldb_s r3,[r1,0x1]
L_8db1ca:
	ldw_s r2,[r0,0x4]
L_8db1cc:
	/* add_s r3,0x3 */
	.byte 0x03,0xe3
L_8db1ce:
	add_s r2,r2,r3
L_8db1d0:
	extw_s r2,r2
L_8db1d2:
	ld_s r3,[r0,0x8]
L_8db1d4:
	stw_s r2,[r0,0x4]
L_8db1d6:
	ldw_s r3,[r3,0x10]
L_8db1d8:
	cmp_s r2,r3
L_8db1da:
	mov_s r2,0x0
L_8db1dc:
	bge_s L_8db1e6
L_8db1de:
	ldb_s r2,[r1,0x1]
L_8db1e0:
	add1_s r2,r2,r2
L_8db1e2:
	add_s r2,r2,r1
L_8db1e4:
	add_s r2,r2,0x9
	.global L_8db1e6
L_8db1e6:
	st_s r2,[r0]
	.global L_8db1e8
L_8db1e8:
	j_s.d [blink]
L_8db1ea:
	mov_s r0,r1
