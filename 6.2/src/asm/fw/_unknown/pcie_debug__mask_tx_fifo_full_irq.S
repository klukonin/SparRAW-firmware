/* pcie_debug__mask_tx_fifo_full_irq @ 0x8f6b88, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wbe_driver__pcie_debug_isr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_debug__mask_tx_fifo_full_irq
pcie_debug__mask_tx_fifo_full_irq:
	.global L_8f6b88
L_8f6b88:
	mov_s r1,0x8
L_8f6b8a:
	mov_s r0,0x882680
L_8f6b90:
	st_s r1,[r0,0x1c]
L_8f6b92:
	j_s [blink]
