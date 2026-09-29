/* tx_desc_by_index @ 0x8c9ff8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion, tx_dma_if__push_desc, tx_dma_if__submit
 */
	.section .text.tx_desc_by_index,"ax",@progbits
	.global tx_desc_by_index
tx_desc_by_index:
	.global L_8c9ff8
L_8c9ff8:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8c9ffa:
	ld_s r0,[r0]
L_8c9ffc:
	j_s.d [blink]
L_8c9ffe:
	add_s r0,r0,r1
