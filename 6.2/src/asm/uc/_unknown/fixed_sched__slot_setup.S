/* fixed_sched__slot_setup @ 0x93cc24, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state4, sends_pmc_mark_aaab02
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fsched__cur_entry_byte0, mask__bit_from_index_plus8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fixed_sched__slot_setup
fixed_sched__slot_setup:
	.global L_93cc24
L_93cc24:
	push_s blink
L_93cc26:
	bl L_920234
L_93cc2a:
	bl.d L_927dbc
L_93cc2e:
	mov_s r14,r0
L_93cc30:
	mov_s r13,0x0
L_93cc32:
	bl.d L_9262a0
L_93cc36:
	mov_s r1,r13
L_93cc38:
	b.d L_9202a4
L_93cc3c:
	stb r13,[r14, 0x2d]
