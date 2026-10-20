/* fsched_slot__inc_f4_reached_7 @ 0x92acdc, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched_ap__start_slot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched_slot__inc_f4_reached_7
fsched_slot__inc_f4_reached_7:
	.global L_92acdc
L_92acdc:
	ldb r1,[r0, 0x28]
L_92ace0:
	add2_s r1,r1,r1
L_92ace2:
	add_s r0,r0,r1
L_92ace4:
	ldb_s r1,[r0,0x4]
L_92ace6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92ace8:
	extb_s r1,r1
L_92acea:
	stb_s r1,[r0,0x4]
L_92acec:
	cmp_s r1,0x7
L_92acee:
	mov_s r0,0x1
L_92acf0:
	j_s.d [blink]
L_92acf2:
	sub.lt r0,r0,r0
L_92acf6:
	nop_s
