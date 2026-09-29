/* host_irq__mask_awake_tsf @ 0x8da810, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_880b50__dispatch_causes
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_irq__mask_awake_tsf
host_irq__mask_awake_tsf:
	.global L_8da810
L_8da810:
	mov_s r1,0x10
L_8da812:
	mov_s r0,0x880b00
L_8da818:
	st_s r1,[r0,0x60]
L_8da81a:
	j_s [blink]
