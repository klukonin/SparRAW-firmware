/* parse_wilocity_vs__find_tlv @ 0x8df7ac, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme__parse_wilocity_vs, parse_wilocity_vs__get_flag3, parse_wilocity_vs_get_features_version_tracking, parse_wilocity_vs_get_netowork_mode, parse_wilocity_vs_get_test_mode, parse_wilocity_vs_get_version
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global parse_wilocity_vs__find_tlv
parse_wilocity_vs__find_tlv:
	.global L_8df7ac
L_8df7ac:
	push_s blink
L_8df7ae:
	bl.d L_8c01e0
L_8df7b2:
	mov_s r3,0x3
L_8df7b4:
	ld_s r13,[r1,0x4]
L_8df7b6:
	ldb_s r14,[r1,0x1]
L_8df7b8:
	add_s r0,r13,0x3
L_8df7ba:
	b_s L_8df7cc
	.global L_8df7bc
L_8df7bc:
	ldb_s r15,[r0,0x3]
L_8df7be:
	ldb_s r1,[r0,0x2]
L_8df7c0:
	asl_s r15,r15,0x8
L_8df7c2:
	or_s r1,r1,r15
L_8df7c4:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_8df7c6:
	add_s r3,r3,r1
L_8df7c8:
	extw_s r3,r3
L_8df7ca:
	add_s r0,r3,r13
	.global L_8df7cc
L_8df7cc:
	brge r3,r14,L_8df7e0
L_8df7d0:
	ldb_s r1,[r0,0x1]
L_8df7d2:
	ldb_s r15,[r0]
L_8df7d4:
	asl_s r1,r1,0x8
L_8df7d6:
	or_s r15,r15,r1
L_8df7d8:
	extw_s r1,r2
L_8df7da:
	brne r15,r1,L_8df7bc
L_8df7de:
	b_s L_8df7e2
	.global L_8df7e0
L_8df7e0:
	mov_s r0,0x0
	.global L_8df7e2
L_8df7e2:
	b L_8c024c
L_8df7e6:
	nop_s
