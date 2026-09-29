/* u_schd__hw_timer_set_compare_thunk @ 0x8c3bec, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__program_hw_timer
 * Зовёт сам: u_schd__hw_timer_set_compare
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__hw_timer_set_compare_thunk
u_schd__hw_timer_set_compare_thunk:
	.global L_8c3bec
L_8c3bec:
	b.d L_8e9160
L_8c3bf0:
	mov_s r0,r1
L_8c3bf2:
	nop_s
