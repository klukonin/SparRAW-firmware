/* parse_wilocity_vs__find_tlv @ 0x8db6cc, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme__parse_wilocity_vs, parse_wilocity_vs__get_flag3, parse_wilocity_vs_get_netowork_mode, parse_wilocity_vs_get_test_mode, parse_wilocity_vs_get_version
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.parse_wilocity_vs__find_tlv,"ax",@progbits
	.global parse_wilocity_vs__find_tlv
parse_wilocity_vs__find_tlv:
	.global L_8db6cc
L_8db6cc:
	push_s blink
L_8db6ce:
	bl.d L_8c02c0
L_8db6d2:
	mov_s r3,0x3
L_8db6d4:
	ld_s r13,[r1,0x4]
L_8db6d6:
	ldb_s r14,[r1,0x1]
L_8db6d8:
	add_s r0,r13,0x3
L_8db6da:
	b_s L_8db6ec
	.global L_8db6dc
L_8db6dc:
	ldb_s r15,[r0,0x3]
L_8db6de:
	ldb_s r1,[r0,0x2]
L_8db6e0:
	asl_s r15,r15,0x8
L_8db6e2:
	or_s r1,r1,r15
L_8db6e4:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_8db6e6:
	add_s r3,r3,r1
L_8db6e8:
	extw_s r3,r3
L_8db6ea:
	add_s r0,r3,r13
	.global L_8db6ec
L_8db6ec:
	brge r3,r14,L_8db700
L_8db6f0:
	ldb_s r1,[r0,0x1]
L_8db6f2:
	ldb_s r15,[r0]
L_8db6f4:
	asl_s r1,r1,0x8
L_8db6f6:
	or_s r15,r15,r1
L_8db6f8:
	extw_s r1,r2
L_8db6fa:
	brne r15,r1,L_8db6dc
L_8db6fe:
	b_s L_8db702
	.global L_8db700
L_8db700:
	mov_s r0,0x0
	.global L_8db702
L_8db702:
	b L_8c032c
L_8db706:
	nop_s
