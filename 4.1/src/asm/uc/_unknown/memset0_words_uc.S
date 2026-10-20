/* memset0_words_uc @ 0x92166c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_tbtt_set_step, aw_worker__collect_awake_peers, bf_metrics__reset_and_stamp, bf_sm__clear_sta, bf_sm__reset_slot_table, bf_sm__reset_sta_rate, bf_sm__trigger, bi_build_schedule_tables, bi_ctx__reset, bi_manager_step_a
 * Зовёт сам: memset0_words_uc__body, memset_uc
 */
	.section .text.memset0_words_uc,"ax",@progbits
	.global memset0_words_uc
memset0_words_uc:
	.global L_92166c
L_92166c:
	mov.f r2,r1
L_921670:
	push_s blink
L_921672:
	push_s r13
L_921674:
	/* beq_s 0x009216f6 */
	.byte 0x41,0xf2
L_921676:
	bmsk.f 0x0,r0,0x1
L_92167a:
	bne_s L_92168c
L_92167c:
	bmsk.f 0x0,r2,0x1
L_921680:
	bne_s L_92168c
L_921682:
	lsr_s r2,r2,0x2
L_921684:
	brhs r2,0x8,L_921694
L_921688:
	mov_s r1,0x0
L_92168a:
	b_s L_92169a
	.global L_92168c
L_92168c:
	bl.d L_92a264
L_921690:
	mov_s r1,0x0
L_921692:
	/* b_s 0x009216f6 */
	.byte 0x33,0xf0
	.global L_921694
L_921694:
	sub_s r1,r2,0x1
L_921696:
	lsr_s r1,r1,0x3
L_921698:
	bmsk_s r2,r2,0x2
	.global L_92169a
L_92169a:
	/* brhs r2,0x8,0x009216f6 */
	.byte 0x5f,0x0a,0x15,0x02
L_92169e:
	ldb.x r2,[0x800eec,r2]
L_9216a6:
	add r13,pcl,0xc
L_9216aa:
	add1_s r13,r13,r2
L_9216ac:
	j_s.d [r13]
L_9216ae:
	mov_s r3,0x0
