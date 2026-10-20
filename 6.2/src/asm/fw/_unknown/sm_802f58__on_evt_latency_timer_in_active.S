/* sm_802f58__on_evt_latency_timer_in_active @ 0x8da73c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_802f58__action_8e0048, sm_802f58__action_8e2be4
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, link_stats_sm__arm_latency_timer, ts_ring__push_sample
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_802f58__on_evt_latency_timer_in_active
sm_802f58__on_evt_latency_timer_in_active:
	.global L_8da73c
L_8da73c:
	push_s blink
L_8da73e:
	bl L_8c01e4
L_8da742:
	mov_s r13,r0
L_8da744:
	mov_s r14,r1
L_8da746:
	bl.d L_8dd6d4
L_8da74a:
	mov_s r1,r0
L_8da74c:
	cmp_s r14,0x0
L_8da74e:
	bl.eq.d L_8e4734
L_8da752:
	mov.eq r0,r13
L_8da756:
	b L_8c0254
L_8da75a:
	nop_s
