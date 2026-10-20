/* ps_mode_sm__ignored_ps_trigger_ @ 0x8c6fb4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ps_mode_sm:: ignored_ps_trigger
 * Зовёт сам: fw_log__emit0
 */
	.section .text.ps_mode_sm__ignored_ps_trigger_,"ax",@progbits
	.global ps_mode_sm__ignored_ps_trigger_
ps_mode_sm__ignored_ps_trigger_:
L_8c6fb4:
	mov_s r1,0x1
	.global fwlog_ps_mode_sm_ignored_ps_trigger
fwlog_ps_mode_sm_ignored_ps_trigger:
L_8c6fb6:
	nop_s
L_8c6fb8:
	mov_s r2,0x1002e28
L_8c6fbe:
	mov_s r0,0xe
L_8c6fc0:
	b.d L_8edfb0
