/* pcie__mask_interrupts @ 0x8d1a78, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Clear and mask PCIe interrupts
 * Зовут его: fw_main
 * Зовёт сам: fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__mask_interrupts
pcie__mask_interrupts:
	.global L_8d1a78
L_8d1a78:
	push_s blink
L_8d1a7a:
	mov_s r1,0x101dd10
L_8d1a80:
	bl.d L_8dcba8
L_8d1a84:
	mov_s r0,0x20
L_8d1a86:
	mov r1,-0x1
L_8d1a8a:
	mov_s r0,0x882f80
L_8d1a90:
	st_s r1,[r0,0x5c]
L_8d1a92:
	st_s r1,[r0,0x50]
L_8d1a94:
	pop_s blink
L_8d1a96:
	j_s [blink]
