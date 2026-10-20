/* qh_write_while_dma_open_check @ 0x926840, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   QH Write while DMA is open (qid %d, write times %d)
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, qh__write_by_flags, uc_log__emit2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global qh_write_while_dma_open_check
qh_write_while_dma_open_check:
	.global L_926840
L_926840:
	push_s blink
L_926842:
	bl L_920230
L_926846:
	ldb_s r0,[gp,-0xed]
L_926848:
	breq_s r0,0,L_92688c
L_92684a:
	mov_s r13,0x801be8
L_926850:
	ldb r0,[r13, 0x2d]
L_926854:
	mov_s r14,0x801c08
L_92685a:
	mov_s r15,0x0
L_92685c:
	ldb_s r2,[r14,0x18]
L_92685e:
	breq_s r0,0,L_92687a
L_926860:
	mov_s r0,0x80070f
L_926866:
	ldb_s r3,[r0]
L_926868:
	mov_s r1,0x1000704
L_92686e:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_926870:
	extb_s r3,r3
L_926872:
	stb_s r3,[r0]
L_926874:
	bl.d L_92d27c
L_926878:
	mov_s r0,r15
	.global L_92687a
L_92687a:
	ldb_s r0,[r14,0x18]
L_92687c:
	add r2,r13,0x3c
L_926880:
	ldb_s r1,[r14,0x19]
L_926882:
	bl.d L_92d488
L_926886:
	ldw_s r3,[r13,0x3a]
L_926888:
	stb r15,[gp, -0xed]
	.global L_92688c
L_92688c:
	b L_92029c
