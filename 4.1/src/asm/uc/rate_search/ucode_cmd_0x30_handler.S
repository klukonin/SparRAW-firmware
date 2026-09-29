/* ucode_cmd_0x30_handler @ 0x92c188, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r13_ret_uc, bf_b_s0_w7_uc, rate_search__reset_sta, rate_search__start_for_sta
 */
	.section .text.ucode_cmd_0x30_handler,"ax",@progbits
	.global ucode_cmd_0x30_handler
ucode_cmd_0x30_handler:
	.global L_92c188
L_92c188:
	push_s blink
L_92c18a:
	push_s r13
L_92c18c:
	mov_s r13,r0
L_92c18e:
	bl.d L_92bd80
L_92c192:
	ldb_s r0,[r0]
L_92c194:
	ldb_s r1,[r13,0x1]
L_92c196:
	ldb_s r0,[r13]
L_92c198:
	bmsk_s r1,r1,0x0
L_92c19a:
	mov_s r3,0x800658
L_92c1a0:
	asl_s r2,r1,0x7
L_92c1a2:
	add_s r0,r0,r3
L_92c1a4:
	ldb_s r1,[r0]
L_92c1a6:
	bclr_s r1,r1,0x7
L_92c1a8:
	or_s r1,r1,r2
L_92c1aa:
	stb_s r1,[r0]
L_92c1ac:
	ldb_s r1,[r13,0x2]
L_92c1ae:
	ldb_s r2,[r13]
L_92c1b0:
	bmsk_s r1,r1,0x6
L_92c1b2:
	add_s r2,r2,r3
L_92c1b4:
	mov_s r0,r2
L_92c1b6:
	bl L_937964
L_92c1ba:
	ldb_s r0,[r13]
L_92c1bc:
	bl.d L_92c34c
L_92c1c0:
	mov_s r1,0x0
L_92c1c2:
	b L_92028c
L_92c1c6:
	nop_s
