/* fixed_sched_manager__decrement_curr_sta_rd_counter @ 0x92574c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fixed_sched_manager::decrement_curr_sta_rd_counter: tried to decrement counter when rd_counter=0
 * Зовут его: mtp__get_tx_permission, txop__await_cts_ppdu
 * Зовёт сам: uc_log__emit_snapshot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fixed_sched_manager__decrement_curr_sta_rd_counter
fixed_sched_manager__decrement_curr_sta_rd_counter:
	.global L_92574c
L_92574c:
	push_s blink
L_92574e:
	ldb r1,[r0, 0x28]
L_925752:
	add2_s r1,r1,r1
L_925754:
	add_s r0,r0,r1
L_925756:
	ldb_s r1,[r0,0x3]
L_925758:
	brlt r1,0x1,L_925762
L_92575c:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_92575e:
	stb_s r1,[r0,0x3]
L_925760:
	b_s L_92576e
	.global L_925762
L_925762:
	mov_s r1,0x1000738
L_925768:
	bl.d L_92d13c
L_92576c:
	mov_s r0,0x10
	.global L_92576e
L_92576e:
	pop_s blink
L_925770:
	j_s [blink]
L_925772:
	nop_s
