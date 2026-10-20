/* host_irq__raise_fw_error @ 0x8d0cfc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sysassert__log_1003a68
 * Зовёт сам: hwd_dma__raise_host_fw_int
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_irq__raise_fw_error
host_irq__raise_fw_error:
	.global L_8d0cfc
L_8d0cfc:
	b.d L_8d0ad8
L_8d0d00:
	mov_s r0,0x1f
L_8d0d02:
	nop_s
