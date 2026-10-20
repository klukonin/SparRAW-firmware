/* fwq_tx__handle_completion_thunk @ 0x8cc740, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_api__drain_list
 * Зовёт сам: fwq_tx__handle_completion
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__handle_completion_thunk
fwq_tx__handle_completion_thunk:
	.global L_8cc740
L_8cc740:
	b.d L_8cc7c4
L_8cc744:
	/* _add_s r0,0x4 */
	.byte 0x04,0xe0
L_8cc746:
	nop_s
