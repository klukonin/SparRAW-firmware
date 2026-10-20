/* bf_sm__clear_slot_diag @ 0x9218f4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__run_sta
 * Глобалы (через gp): 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__clear_slot_diag
bf_sm__clear_slot_diag:
	.global L_9218f4
L_9218f4:
	mov_s r0,0x0
L_9218f6:
	st.as r0,[gp,0x33]
L_9218fa:
	j_s.d [blink]
L_9218fc:
	st.as r0,[gp,0x34]
