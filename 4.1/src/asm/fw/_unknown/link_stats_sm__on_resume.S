/* link_stats_sm__on_resume @ 0x8de74c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, link_stats__report, link_stats_sm__on_latency_timer
 */
	.section .text.link_stats_sm__on_resume,"ax",@progbits
	.global link_stats_sm__on_resume
link_stats_sm__on_resume:
L_8de74c:
	push_s blink
L_8de74e:
	push_s r13
L_8de750:
	mov_s r13,r0
L_8de752:
	bl.d L_8d7638
L_8de756:
	mov_s r1,0x0
L_8de758:
	mov_s r0,r13
L_8de75a:
	bl.d L_8e2ae8
L_8de75e:
	mov_s r1,0x0
L_8de760:
	b L_8c033c
