/* mem_pool__notify_dma @ 0x8e4728, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__put_block
 * Зовёт сам: hwd_dma__set_881c00_8cddc0
 */
	.section .text.mem_pool__notify_dma,"ax",@progbits
	.global mem_pool__notify_dma
mem_pool__notify_dma:
	.global L_8e4728
L_8e4728:
	ld_s r0,[r0,0x10]
L_8e472a:
	mov_s r12,0x1
L_8e472c:
	asl r0,r12,r0
L_8e4730:
	b.d L_8cddc0
