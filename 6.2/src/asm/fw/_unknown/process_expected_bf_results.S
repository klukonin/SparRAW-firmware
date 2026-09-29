/* process_expected_bf_results @ 0x8e11f8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   process_expected_bf_results: invalid mcs:%d
 * Зовут его: maintain_sm__action_8cdbd8, maintain_sm__action_8f2f0c
 * Зовёт сам: fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global process_expected_bf_results
process_expected_bf_results:
	.global L_8e11f8
L_8e11f8:
	mov_s r0,0x1dde
L_8e11fe:
	push_s blink
L_8e1200:
	mov_s r2,r1
L_8e1202:
	bbit1 r0,r1,L_8e1212
L_8e1206:
	mov_s r1,0x1014608
L_8e120c:
	bl.d L_8dcc10
L_8e1210:
	mov_s r0,0x0
	.global L_8e1212
L_8e1212:
	pop_s blink
L_8e1214:
	j_s [blink]
L_8e1216:
	nop_s
