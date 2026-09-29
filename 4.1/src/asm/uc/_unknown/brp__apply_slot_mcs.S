/* brp__apply_slot_mcs @ 0x9258d0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_substate__dispatch_by_state
 * Зовёт сам: rate_search__apply_mcs
 */
	.section .text.brp__apply_slot_mcs,"ax",@progbits
	.global brp__apply_slot_mcs
brp__apply_slot_mcs:
	.global L_9258d0
L_9258d0:
	mov_s r1,r0
L_9258d2:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_9258d4:
	add3_s r0,r0,r0
L_9258d6:
	add_s r0,r0,0x801190
L_9258dc:
	ld.as r2,[gp,-0x4]
L_9258e0:
	ldb r3,[r0, 0x46]
L_9258e4:
	bset_s r2,r2,0x5
L_9258e6:
	asl_s r3,r3,0x8
L_9258e8:
	or_s r2,r2,r3
L_9258ea:
	st_s r2,[r0,0x4]
L_9258ec:
	b.d L_92c330
L_9258f0:
	ldb r0,[r0, 0x45]
