/* dpal__cpl_timeout_log @ 0x8c9768, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DPAL CPL TO Event
 * Зовут его: fw_vector_15
 * Зовёт сам: dpal__mask_cpl_timeout_irq, fw_log_emit0, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dpal__cpl_timeout_log
dpal__cpl_timeout_log:
	.global L_8c9768
L_8c9768:
	push_s blink
L_8c976a:
	mov_s r1,0x1003670
L_8c9770:
	bl.d L_8dcba8
L_8c9774:
	mov_s r0,0x2f
L_8c9776:
	bl L_8f6b4c
L_8c977a:
	mov_s r0,0x96ac
L_8c9780:
	mov_s r1,0x0
L_8c9782:
	mov_s r2,r1
L_8c9784:
	bl.d L_8c3248
L_8c9788:
	mov_s r3,0x2
L_8c978a:
	pop_s blink
L_8c978c:
	j_s [blink]
L_8c978e:
	nop_s
