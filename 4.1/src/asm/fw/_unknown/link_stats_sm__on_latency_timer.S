/* link_stats_sm__on_latency_timer @ 0x8d7638, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats_sm__on_pause, link_stats_sm__on_resume
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, link_stats__collect, link_stats_sm__arm_latency_timer
 */
	.section .text.link_stats_sm__on_latency_timer,"ax",@progbits
	.global link_stats_sm__on_latency_timer
link_stats_sm__on_latency_timer:
	.global L_8d7638
L_8d7638:
	push_s blink
L_8d763a:
	bl L_8c02c4
L_8d763e:
	mov_s r13,r0
L_8d7640:
	mov_s r14,r1
L_8d7642:
	bl.d L_8d98f8
L_8d7646:
	mov_s r1,r0
L_8d7648:
	cmp_s r14,0x0
L_8d764a:
	bl.eq.d L_8dfa40
L_8d764e:
	mov.eq r0,r13
L_8d7652:
	b L_8c0334
L_8d7656:
	nop_s
