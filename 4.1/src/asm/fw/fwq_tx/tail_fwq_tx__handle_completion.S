/* tail_fwq_tx__handle_completion @ 0x8ca538, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_api__drain_list
 * Зовёт сам: fwq_tx__handle_completion
 */
	.section .text.tail_fwq_tx__handle_completion,"ax",@progbits
	.global tail_fwq_tx__handle_completion
tail_fwq_tx__handle_completion:
	.global L_8ca538
L_8ca538:
	/* b.d 0x008ca5c8 */
	.byte 0x91,0x00,0x20,0x00
L_8ca53c:
	/* _add_s r0,0x4 */
	.byte 0x04,0xe0
L_8ca53e:
	nop_s
