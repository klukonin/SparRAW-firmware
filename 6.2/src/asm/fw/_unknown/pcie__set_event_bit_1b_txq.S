/* pcie__set_event_bit_1b_txq @ 0x8d1af0, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__mask_from_queue
 * Зовёт сам: pcie__set_event_bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__set_event_bit_1b_txq
pcie__set_event_bit_1b_txq:
	.global L_8d1af0
L_8d1af0:
	b.d L_8d1a98
L_8d1af4:
	mov_s r0,0x1b
L_8d1af6:
	nop_s
