/* host_irq__raise_mbox_evt @ 0x8d0d04, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__mask_from_queue
 * Зовёт сам: hwd_dma__raise_host_fw_int
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_irq__raise_mbox_evt
host_irq__raise_mbox_evt:
	.global L_8d0d04
L_8d0d04:
	b.d L_8d0ad8
L_8d0d08:
	mov_s r0,0x1d
L_8d0d0a:
	nop_s
