/* sta_psc_sm__max_retry_handler @ 0x8d9dec, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::max_retry_handler
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, sta_psc_sm__psc_done_sm
 */
	.section .text.sta_psc_sm__max_retry_handler,"ax",@progbits
	.global sta_psc_sm__max_retry_handler
sta_psc_sm__max_retry_handler:
L_8d9dec:
	push_s blink
L_8d9dee:
	push_s r13
L_8d9df0:
	mov_s r13,r0
L_8d9df2:
	mov_s r2,0x1003028
L_8d9df8:
	mov_s r0,0xe
L_8d9dfa:
	bl.d L_8edfb0
L_8d9dfe:
	mov_s r1,0x1
L_8d9e00:
	mov_s r0,r13
L_8d9e02:
	bl.d L_8dd7c8
L_8d9e06:
	mov_s r1,0x0
L_8d9e08:
	b L_8c033c
