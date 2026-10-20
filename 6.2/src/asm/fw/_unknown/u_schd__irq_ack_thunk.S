/* u_schd__irq_ack_thunk @ 0x8e94f4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__arm_timer
 * Зовёт сам: irq_ack_880b00
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__irq_ack_thunk
u_schd__irq_ack_thunk:
	.global L_8e94f4
L_8e94f4:
	b L_8e9190
