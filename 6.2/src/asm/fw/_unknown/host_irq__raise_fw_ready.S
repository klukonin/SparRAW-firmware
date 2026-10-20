/* host_irq__raise_fw_ready @ 0x8d0cf4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__send_fw_ready_evt
 * Зовёт сам: hwd_dma__raise_host_fw_int
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_irq__raise_fw_ready
host_irq__raise_fw_ready:
	.global L_8d0cf4
L_8d0cf4:
	b.d L_8d0ad8
L_8d0cf8:
	mov_s r0,0x1c
L_8d0cfa:
	nop_s
