/* fsched_slot__inc_f2 @ 0x92accc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched_slot__inc_f2
fsched_slot__inc_f2:
	.global L_92accc
L_92accc:
	ldb r1,[r0, 0x28]
L_92acd0:
	add2_s r1,r1,r1
L_92acd2:
	add_s r0,r0,r1
L_92acd4:
	ldb_s r1,[r0,0x2]
L_92acd6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92acd8:
	j_s.d [blink]
L_92acda:
	stb_s r1,[r0,0x2]
