/* hwd_pcie__get_882b80 @ 0x8ce72c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter, hwd_pcie_exit_l1, isr_pcie_main, pcie__ready_for_deep_sleep
 */
	.section .text.hwd_pcie__get_882b80,"ax",@progbits
	.global hwd_pcie__get_882b80
hwd_pcie__get_882b80:
	.global L_8ce72c
L_8ce72c:
	mov_s r0,0x882b80
L_8ce732:
	ld_s r0,[r0,0x8]
L_8ce734:
	j_s.d [blink]
L_8ce736:
	bmsk_s r0,r0,0x0
