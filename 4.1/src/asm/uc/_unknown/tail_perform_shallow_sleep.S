/* tail_perform_shallow_sleep @ 0x925208, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_step
 * Зовёт сам: perform_shallow_sleep
 */
	.section .text.tail_perform_shallow_sleep,"ax",@progbits
	.global tail_perform_shallow_sleep
tail_perform_shallow_sleep:
	.global L_925208
L_925208:
	mov_s r1,0x1
L_92520a:
	mov_s r2,0x0
L_92520c:
	mov r3,r1
L_925210:
	b.d L_92af4c
