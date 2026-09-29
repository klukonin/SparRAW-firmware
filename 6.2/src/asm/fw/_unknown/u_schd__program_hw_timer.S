/* u_schd__program_hw_timer @ 0x8e9500, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__arm_timer
 * Зовёт сам: u_schd__hw_timer_set_compare_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__program_hw_timer
u_schd__program_hw_timer:
	.global L_8e9500
L_8e9500:
	mov_s r1,r0
L_8e9502:
	b.d L_8c3bec
L_8e9506:
	add_s r0,gp,0x74
