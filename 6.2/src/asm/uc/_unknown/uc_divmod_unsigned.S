/* uc_divmod_unsigned @ 0x9203e0, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_tbtt__count_intervals, power_manager__scale_counters_ms, rf__update_active_antenna, tx_slot__pick_queue
 * Зовёт сам: uc_divmod_signed
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_divmod_unsigned
uc_divmod_unsigned:
	.global L_9203e0
L_9203e0:
	b.d L_9203fc
L_9203e4:
	mov r8,0x0
