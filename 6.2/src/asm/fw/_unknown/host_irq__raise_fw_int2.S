/* host_irq__raise_fw_int2 @ 0x8d0cec, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__mask_from_queue
 * Зовёт сам: hwd_dma__raise_host_fw_int
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_irq__raise_fw_int2
host_irq__raise_fw_int2:
	.global L_8d0cec
L_8d0cec:
	b.d L_8d0ad8
L_8d0cf0:
	mov_s r0,0x1e
L_8d0cf2:
	nop_s
