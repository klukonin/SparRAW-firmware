/* sta_psc_sm__max_retry_handler @ 0x8ddd30, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::max_retry_handler
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, sta_psc_sm__psc_done_sm
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_psc_sm__max_retry_handler
sta_psc_sm__max_retry_handler:
	.global L_8ddd30
L_8ddd30:
	push_s blink
L_8ddd32:
	push_s r13
L_8ddd34:
	mov_s r13,r0
L_8ddd36:
	mov_s r1,0x1002d44
L_8ddd3c:
	bl.d L_8dcba8
L_8ddd40:
	mov_s r0,0x1e
L_8ddd42:
	mov_s r0,r13
L_8ddd44:
	bl.d L_8e194c
L_8ddd48:
	mov_s r1,0x0
L_8ddd4a:
	b L_8c025c
L_8ddd4e:
	nop_s
