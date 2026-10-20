/* hwd_pcie__rgf_882f80 @ 0x8ce6e4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pcie_ltssm_dbg
 */
	.section .text.hwd_pcie__rgf_882f80,"ax",@progbits
	.global hwd_pcie__rgf_882f80
hwd_pcie__rgf_882f80:
	.global L_8ce6e4
L_8ce6e4:
	mov_s r1,0x882f80
L_8ce6ea:
	ld_s r0,[r1,0x54]
L_8ce6ec:
	st_s r0,[r1,0x50]
L_8ce6ee:
	j_s [blink]
