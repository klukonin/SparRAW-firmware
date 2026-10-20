/* process_expected_bf_results @ 0x8dd084, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   process_expected_bf_results: invalid mcs:%d
 * Зовут его: MAINTAIN_SM__OPEN, maintain_sm__on_rs_results
 * Зовёт сам: fw_log__emit1
 */
	.section .text.process_expected_bf_results,"ax",@progbits
	.global process_expected_bf_results
process_expected_bf_results:
	.global L_8dd084
L_8dd084:
	mov_s r0,0x1dde
L_8dd08a:
	push_s blink
L_8dd08c:
	mov_s r3,r1
L_8dd08e:
	bbit1 r0,r1,L_8dd0a0
L_8dd092:
	mov_s r2,0x1011ea8
L_8dd098:
	mov_s r0,0x0
L_8dd09a:
	bl.d L_8edfcc
L_8dd09e:
	mov_s r1,r0
	.global L_8dd0a0
L_8dd0a0:
	pop_s blink
L_8dd0a2:
	j_s [blink]
