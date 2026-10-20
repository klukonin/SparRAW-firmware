/* pcie__set_event_bit_1a_txq @ 0x8d1b08, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__mask_from_queue
 * Зовёт сам: pcie__set_event_bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__set_event_bit_1a_txq
pcie__set_event_bit_1a_txq:
	.global L_8d1b08
L_8d1b08:
	b.d L_8d1a98
L_8d1b0c:
	mov_s r0,0x1a
L_8d1b0e:
	nop_s
