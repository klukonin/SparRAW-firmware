/* frag_8e4758 @ 0x8e4758, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: tail_hwd_dma__kick_channel_8cdfa4, tail_pcie__set_event_bit_8cee60
 */
	.section .text.frag_8e4758,"ax",@progbits
	.global frag_8e4758
frag_8e4758:
L_8e4758:
	push_s blink
L_8e475a:
	bl L_8cdfa4
L_8e475e:
	bl L_8cee60
L_8e4762:
	pop_s blink
