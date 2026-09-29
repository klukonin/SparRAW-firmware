/* field_rw_0x2c__924fb4 @ 0x924fb4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global field_rw_0x2c__924fb4
field_rw_0x2c__924fb4:
	.global L_924fb4
L_924fb4:
	ldb r2,[r0, 0x2c]
L_924fb8:
	bclr r2,r2,r1
L_924fbc:
	j_s.d [blink]
L_924fbe:
	stb r2,[r0, 0x2c]
L_924fc2:
	nop_s
