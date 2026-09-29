/* fw_set_timer_alarm @ 0x8e4670, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__arm_timer
 * Зовёт сам: tail_set_reg_88024c
 */
	.section .text.fw_set_timer_alarm,"ax",@progbits
	.global fw_set_timer_alarm
fw_set_timer_alarm:
	.global L_8e4670
L_8e4670:
	mov_s r1,r0
L_8e4672:
	b.d L_8c320c
L_8e4676:
	add_s r0,gp,0x70
