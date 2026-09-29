/* wmi_enable_fixed_scheduling @ 0x8ec500, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fixed scheduling is already enabled
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fixed_sched__start, fw_log_emit0, mid__state_is_2_or_3, mid_list__by_mid_fw, pring__set_done_handler, vring__active_ring_table, wmi_fixed_sched__apply
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_enable_fixed_scheduling
wmi_enable_fixed_scheduling:
	.global L_8ec500
L_8ec500:
	push_s blink
L_8ec502:
	bl L_8c01e0
L_8ec506:
	mov_s r14,r0
L_8ec508:
	mov_s r0,0x847adc
L_8ec50e:
	ldb_s r0,[r0,0x5]
L_8ec510:
	mov_s r15,r2
L_8ec512:
	brne r0,0x1,L_8ec524
L_8ec516:
	mov_s r1,0x10068f0
L_8ec51c:
	bl.d L_8dcba8
L_8ec520:
	mov_s r0,0x10
L_8ec522:
	b_s L_8ec568
	.global L_8ec524
L_8ec524:
	bl.d L_8da488
L_8ec528:
	mov_s r0,0x0
L_8ec52a:
	breq_s r0,0,L_8ec562
L_8ec52c:
	bl.d L_8cc3dc
L_8ec530:
	mov_s r0,r15
L_8ec532:
	bl.d L_8cd080
L_8ec536:
	ldb r13,[r0, 0x24]
L_8ec53a:
	mov_s r0,0x9854
L_8ec540:
	bl.d L_8e7334
L_8ec544:
	mov_s r1,r14
L_8ec546:
	bl L_8cd080
L_8ec54a:
	ld_s r1,[r0]
L_8ec54c:
	ld_s r2,[r1,0x1c]
L_8ec54e:
	jl_s.d [r2]
L_8ec550:
	mov_s r1,r13
L_8ec552:
	cmp_s r0,0x0
L_8ec554:
	mov.eq r0,0x0
L_8ec558:
	bl.eq.d L_8c9854
L_8ec55c:
	mov.eq r1,r14
L_8ec560:
	b_s L_8ec568
	.global L_8ec562
L_8ec562:
	bl.d L_8c9884
L_8ec566:
	mov_s r0,r14
	.global L_8ec568
L_8ec568:
	b L_8c024c
