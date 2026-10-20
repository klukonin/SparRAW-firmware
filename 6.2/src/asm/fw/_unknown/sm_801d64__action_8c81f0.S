/* sm_801d64__action_8c81f0 @ 0x8c81f0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ps_mode_sm:: ignored_ps_trigger
 * Зовёт сам: fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_801d64__action_8c81f0
sm_801d64__action_8c81f0:
	.global L_8c81f0
L_8c81f0:
	mov_s r1,0x1002a94
L_8c81f6:
	b.d L_8dcba8
L_8c81fa:
	mov_s r0,0x1e
