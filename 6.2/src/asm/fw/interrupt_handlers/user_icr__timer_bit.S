/* user_icr__timer_bit @ 0x8da00c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__timer_irq_pending
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global user_icr__timer_bit
user_icr__timer_bit:
	.global L_8da00c
L_8da00c:
	lsr r0,r1,0x2
L_8da010:
	j_s.d [blink]
L_8da012:
	bmsk_s r0,r0,0x0
