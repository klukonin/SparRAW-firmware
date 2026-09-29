/* schedule_scheme_builder__build_allocations_8c68a0 @ 0x8c68a0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   schedule_scheme_builder::build_allocations. Clearing scheme
 * Зовут его: sched_builder__build_if_present, schedule_scheme_builder__build_allocations
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, add_bcon, fw_log_emit0, remove_app_ie, sched_builder__reset_alloc_list
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global schedule_scheme_builder__build_allocations_8c68a0
schedule_scheme_builder__build_allocations_8c68a0:
	.global L_8c68a0
L_8c68a0:
	push_s blink
L_8c68a2:
	bl L_8c01e4
L_8c68a6:
	mov_s r13,r0
L_8c68a8:
	mov_s r1,0x1014510
L_8c68ae:
	bl.d L_8dcba8
L_8c68b2:
	mov_s r0,0x2b
L_8c68b4:
	ld_s r0,[r13,0x10]
L_8c68b6:
	mov_s r14,0x0
L_8c68b8:
	mov_s r1,r14
L_8c68ba:
	bl.d L_8e2600
L_8c68be:
	mov_s r2,0x90
L_8c68c0:
	bl.d L_8c2778
L_8c68c4:
	ld_s r0,[r13,0x10]
L_8c68c6:
	bl.d L_8e2948
L_8c68ca:
	ld_s r0,[r13]
L_8c68cc:
	b.d L_8c0254
L_8c68d0:
	st_s r14,[r13,0xc]
L_8c68d2:
	nop_s
