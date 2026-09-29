/* bf_sm__reset_slot_table @ 0x928380, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__advance_if_slot33, bf_sm__post_slot_result, bf_substate__brp_mode_by_slot, bf_substate__txss_by_slot, bf_substate__txss_step_by_slot, bi_mode__reset_bf_state
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, memset0_words_uc
 */
	.section .text.bf_sm__reset_slot_table,"ax",@progbits
	.global bf_sm__reset_slot_table
bf_sm__reset_slot_table:
	.global L_928380
L_928380:
	push_s blink
L_928382:
	bl.d L_920214
L_928386:
	mov_s r1,0x3c
L_928388:
	mov_s r14,0x800fcc
L_92838e:
	add3 r13,r14,0x9
L_928392:
	bl.d L_92166c
L_928396:
	add r0,r14,0xc
L_92839a:
	mov_s r0,r14
L_92839c:
	bl.d L_92166c
L_9283a0:
	mov_s r1,0xc
L_9283a2:
	mov lp_count,0x5
L_9283a6:
	mov_s r1,0x4
L_9283a8:
	lp L_9283b4
L_9283ac:
	add2 r12,r13,r1
L_9283b0:
	st_s r1,[r12]
L_9283b2:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
	.global L_9283b4
L_9283b4:
	b L_920284
