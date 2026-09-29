/* fsched_slot__clear_f4 @ 0x924fa4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched_ap__start_slot, sends_pmc_mark_aaab20
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched_slot__clear_f4
fsched_slot__clear_f4:
	.global L_924fa4
L_924fa4:
	ldb r1,[r0, 0x28]
L_924fa8:
	mov_s r2,0x0
L_924faa:
	add2_s r1,r1,r1
L_924fac:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_924fae:
	add_s r1,r1,r0
L_924fb0:
	j_s.d [blink]
L_924fb2:
	stb_s r2,[r1]
