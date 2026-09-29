/* lt_bf__reset_trigger_period @ 0x8e2958, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_long_term_trigger
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lt_bf__reset_trigger_period
lt_bf__reset_trigger_period:
	.global L_8e2958
L_8e2958:
	mov_s r0,0x0
L_8e295a:
	j_s.d [blink]
L_8e295c:
	st.as r0,[gp,-0x21]
