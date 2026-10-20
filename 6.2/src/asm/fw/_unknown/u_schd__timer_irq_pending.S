/* u_schd__timer_irq_pending @ 0x8e94f8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_880b50__dispatch_causes
 * Зовёт сам: user_icr__timer_bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__timer_irq_pending
u_schd__timer_irq_pending:
	.global L_8e94f8
L_8e94f8:
	mov_s r1,r0
L_8e94fa:
	b.d L_8da00c
L_8e94fe:
	add_s r0,gp,0x74
