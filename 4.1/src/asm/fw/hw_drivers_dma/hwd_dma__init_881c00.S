/* hwd_dma__init_881c00 @ 0x8cd9b4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: hwd_dma__set_881c00_8cd9cc
 */
	.section .text.hwd_dma__init_881c00,"ax",@progbits
	.global hwd_dma__init_881c00
hwd_dma__init_881c00:
	.global L_8cd9b4
L_8cd9b4:
	push_s blink
L_8cd9b6:
	bl.d L_8cd9cc
L_8cd9ba:
	mov_s r0,0x1f
L_8cd9bc:
	bl.d L_8cd9cc
L_8cd9c0:
	mov_s r0,0x1c
L_8cd9c2:
	bl.d L_8cd9cc
L_8cd9c6:
	mov_s r0,0x1b
L_8cd9c8:
	pop_s blink
L_8cd9ca:
	j_s [blink]
