/* sched_builder__build_if_present @ 0x8ea86c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dmg_bcon__rx_handler
 * Зовёт сам: schedule_scheme_builder__build_allocations_8c68a0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sched_builder__build_if_present
sched_builder__build_if_present:
	.global L_8ea86c
L_8ea86c:
	push_s blink
L_8ea86e:
	ld_s r1,[r0,0xc]
L_8ea870:
	cmp_s r1,0x0
L_8ea872:
	bl.ne L_8c68a0
L_8ea876:
	pop_s blink
L_8ea878:
	j_s [blink]
L_8ea87a:
	nop_s
