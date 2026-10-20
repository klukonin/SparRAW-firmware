/* hwd_pcie__rgf_882600 @ 0x8ce6d8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pcie_main
 */
	.section .text.hwd_pcie__rgf_882600,"ax",@progbits
	.global hwd_pcie__rgf_882600
hwd_pcie__rgf_882600:
	.global L_8ce6d8
L_8ce6d8:
	mov_s r1,0x882600
L_8ce6de:
	ld_s r0,[r1,0x74]
L_8ce6e0:
	st_s r0,[r1,0x70]
L_8ce6e2:
	j_s [blink]
