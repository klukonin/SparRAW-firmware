/* sm_802f58__action_8e774c @ 0x8e774c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   link_stats_sm --> started
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, led_scheme__apply, link_stats__counter64_a_thunk, link_stats__counter64_b_thunk, link_stats_sm__arm_latency_timer, link_stats_sm__arm_report_timer, mac_tx_cnt__get_fail, mac_tx_cnt__get_ok, memset0_words, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_802f58__action_8e774c
sm_802f58__action_8e774c:
	.global L_8e774c
L_8e774c:
	push_s blink
L_8e774e:
	bl L_8c01e4
L_8e7752:
	bl.d L_8e9524
L_8e7756:
	mov_s r13,r0
L_8e7758:
	st_s r0,[r13,0x38]
L_8e775a:
	bl.d L_8ccf78
L_8e775e:
	mov_s r0,r13
L_8e7760:
	st_s r0,[r13,0x14]
L_8e7762:
	st_s r1,[r13,0x18]
L_8e7764:
	bl.d L_8ccb64
L_8e7768:
	mov_s r0,r13
L_8e776a:
	st_s r0,[r13,0x20]
L_8e776c:
	bl.d L_8dd758
L_8e7770:
	st_s r1,[r13,0x24]
L_8e7772:
	bl.d L_8dd760
L_8e7776:
	st_s r0,[r13,0x2c]
L_8e7778:
	st_s r0,[r13,0x30]
L_8e777a:
	mov_s r0,0x853900
L_8e7780:
	ld_s r0,[r0,0x24]
L_8e7782:
	mov_s r1,0x1014ee4
L_8e7788:
	st_s r0,[r13,0x34]
L_8e778a:
	bl.d L_8dcba8
L_8e778e:
	mov_s r0,0x20
L_8e7790:
	mov_s r14,0x0
L_8e7792:
	stb_s r14,[r13,0x3]
L_8e7794:
	bl.d L_8e4734
L_8e7798:
	mov_s r0,r13
L_8e779a:
	bl.d L_8e4910
L_8e779e:
	mov_s r0,r13
L_8e77a0:
	bl.d L_8da84c
L_8e77a4:
	mov_s r0,0x1
L_8e77a6:
	mov_s r0,0x805260
L_8e77ac:
	bl.d L_8c1cd8
L_8e77b0:
	mov_s r1,0x84
L_8e77b2:
	add_s r0,gp,-0x84
L_8e77b4:
	bl.d L_8c1cd8
L_8e77b8:
	mov_s r1,0x4
L_8e77ba:
	b.d L_8c0254
L_8e77be:
	stb r14,[r13, 0x3c]
L_8e77c2:
	nop_s
