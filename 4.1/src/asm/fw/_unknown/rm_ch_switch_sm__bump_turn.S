/* rm_ch_switch_sm__bump_turn @ 0x8c6d20, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion, tx_dma_if__push_desc, tx_dma_if__submit
 * Зовёт сам: rm_ch_switch_sm__turn_step
 */
	.section .text.rm_ch_switch_sm__bump_turn,"ax",@progbits
	.global rm_ch_switch_sm__bump_turn
rm_ch_switch_sm__bump_turn:
	.global L_8c6d20
L_8c6d20:
	ld_s r2,[r1]
L_8c6d22:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8c6d24:
	st_s r2,[r1]
L_8c6d26:
	ld_s r0,[r0,0x4]
L_8c6d28:
	/* brne r2,r0,0x008c6d30 */
	.byte 0x09,0x0a,0x01,0x00
L_8c6d2c:
	mov_s r0,0x0
L_8c6d2e:
	st_s r0,[r1]
