/* fwq_tx__on_queue_empty @ 0x8db240, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: frag_8e2dbc, fwq_tx__handle_completion
 * Зовёт сам: rx_off__complete_when_drained
 */
	.section .text.fwq_tx__on_queue_empty,"ax",@progbits
	.global fwq_tx__on_queue_empty
fwq_tx__on_queue_empty:
	.global L_8db240
L_8db240:
	mov_s r1,0x0
L_8db242:
	st_s r1,[r0,0x8]
L_8db244:
	ld_s r1,[r0]
L_8db246:
	ld_s r0,[r1,0x1c]
L_8db248:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8db24a:
	b.d L_8c9694
L_8db24e:
	st_s r0,[r1,0x1c]
