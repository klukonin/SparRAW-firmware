/* cf_end__pulse_883150 @ 0x92b27c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: cf_end__tx_flow
 * Зовёт сам: set_reg_883150, uc_spin_until_event4
 */
	.section .text.cf_end__pulse_883150,"ax",@progbits
	.global cf_end__pulse_883150
cf_end__pulse_883150:
	.global L_92b27c
L_92b27c:
	push_s blink
L_92b27e:
	bl.d L_927480
L_92b282:
	mov_s r0,0x0
L_92b284:
	bl.d L_9317f0
L_92b288:
	mov_s r0,0x40
L_92b28a:
	bl.d L_927480
L_92b28e:
	mov_s r0,0x3
L_92b290:
	pop_s blink
L_92b292:
	j_s [blink]
