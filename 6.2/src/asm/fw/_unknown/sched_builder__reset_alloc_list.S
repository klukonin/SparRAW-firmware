/* sched_builder__reset_alloc_list @ 0x8e2948, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_scheme_builder__build_allocations_8c68a0, schedule_scheme_builder__build_allocations_from_beacon
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sched_builder__reset_alloc_list
sched_builder__reset_alloc_list:
	.global L_8e2948
L_8e2948:
	mov_s r2,0x0
L_8e294a:
	ld_s r1,[r0,0x4]
L_8e294c:
	stb_s r2,[r0]
L_8e294e:
	stb_s r2,[r1]
L_8e2950:
	ld_s r0,[r0,0x4]
L_8e2952:
	j_s.d [blink]
L_8e2954:
	stb_s r2,[r0,0x1]
L_8e2956:
	nop_s
