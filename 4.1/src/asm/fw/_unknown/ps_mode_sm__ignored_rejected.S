/* ps_mode_sm__ignored_rejected @ 0x8c6fc4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ps_mode_sm:: ignored_rejected
 * Зовёт сам: fw_log__emit0
 */
	.section .text.ps_mode_sm__ignored_rejected,"ax",@progbits
	.global ps_mode_sm__ignored_rejected
ps_mode_sm__ignored_rejected:
L_8c6fc4:
	mov_s r1,0x1
	.global fwlog_ps_mode_sm_ignored_rejected
fwlog_ps_mode_sm_ignored_rejected:
L_8c6fc6:
	nop_s
L_8c6fc8:
	mov_s r2,0x1002e64
L_8c6fce:
	mov_s r0,0xe
L_8c6fd0:
	b.d L_8edfb0
L_8c6fd4:
	mov_s r1,0x1
L_8c6fd6:
	nop_s
