/* link_stats_sm__arm_latency_timer @ 0x8e4734, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_802f58__action_8e774c, sm_802f58__on_evt_latency_timer_in_active
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, u_schd__schedule
 * Глобалы (через gp): 0x8003c0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_stats_sm__arm_latency_timer
link_stats_sm__arm_latency_timer:
	.global L_8e4734
L_8e4734:
	push_s blink
L_8e4736:
	push_s r13
L_8e4738:
	mov_s r13,r0
L_8e473a:
	ld_s r0,[r0,0x8]
L_8e473c:
	brne_s r0,0,L_8e475c
	.global L_8e473e
L_8e473e:
	mov_s r0,0x19c0c
L_8e4744:
	ld.as r4,[gp,0x8f]
L_8e4748:
	mov_s r1,r13
L_8e474a:
	mov_s r2,0x0
L_8e474c:
	mov_s r3,r2
L_8e474e:
	mov_s r5,r2
L_8e4750:
	bl.d L_8e0c0c
L_8e4754:
	mov_s r6,r2
L_8e4756:
	b.d L_8c025c
L_8e475a:
	st_s r0,[r13,0x8]
	.global L_8e475c
L_8e475c:
	mov_s r0,blink
L_8e475e:
	mov_s r1,0x1257
L_8e4764:
	bl L_8c9b28
L_8e4768:
	b_s L_8e473e
L_8e476a:
	nop_s
