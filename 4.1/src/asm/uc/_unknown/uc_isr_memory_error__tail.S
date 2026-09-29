/* uc_isr_memory_error__tail @ 0x92159c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_isr_memory_error__tail,"ax",@progbits
	.global uc_isr_memory_error__tail
uc_isr_memory_error__tail:
L_92159c:
	pop_s blink
L_92159e:
	j_s [blink]
