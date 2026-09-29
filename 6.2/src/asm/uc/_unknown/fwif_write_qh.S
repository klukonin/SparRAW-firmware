/* fwif_write_qh @ 0x9279c8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwif_write_qh qid %d write_blocks_mask 0x%x
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, peer__lookup_if_fixed_sched, qh__write_by_flags, sched_cfg__merge_update, uc_log__emit2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fwif_write_qh
fwif_write_qh:
	.global L_9279c8
L_9279c8:
	push_s blink
L_9279ca:
	push_s r13
L_9279cc:
	mov_s r13,r0
L_9279ce:
	ldb_s r2,[r13]
L_9279d0:
	mov_s r1,0x10011b4
L_9279d6:
	mov_s r0,0x20
L_9279d8:
	bl.d L_92d27c
L_9279dc:
	ldb_s r3,[r13,0x1]
L_9279de:
	bl.d L_926890
L_9279e2:
	ldb_s r0,[r13]
L_9279e4:
	brne_s r0,0,L_9279f4
L_9279e6:
	ldb_s r0,[r13]
L_9279e8:
	add_s r2,r13,0x4
L_9279ea:
	ldb_s r1,[r13,0x1]
L_9279ec:
	bl.d L_92d488
L_9279f0:
	ldw_s r3,[r13,0x2]
L_9279f2:
	b_s L_9279fa
	.global L_9279f4
L_9279f4:
	bl.d L_9268c0
L_9279f8:
	mov_s r0,r13
	.global L_9279fa
L_9279fa:
	b L_9202ac
L_9279fe:
	nop_s
