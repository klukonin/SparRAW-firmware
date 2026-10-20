/* fsched__get_cur_idx @ 0x927d54, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched__run_tx_slot_twice, fsched__tx_ctrl_frame, fsched_ap__start_slot, l1_fixed_sched_ap__ev4_state2, l1_fixed_sched_ap__ev4_state4, tx_ctx__alloc_next
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__get_cur_idx
fsched__get_cur_idx:
	.global L_927d54
L_927d54:
	j_s.d [blink]
L_927d56:
	ldb r0,[r0, 0x28]
L_927d5a:
	nop_s
