/* hwd_pcie_l1_exit_isr @ 0x8ce938, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pcie_ltssm_dbg
 * Зовёт сам: hwd_pcie_ltssm_is_l1_idle, set_reg_882fe0_8ce908
 */
	.section .text.hwd_pcie_l1_exit_isr,"ax",@progbits
	.global hwd_pcie_l1_exit_isr
hwd_pcie_l1_exit_isr:
	.global L_8ce938
L_8ce938:
	push_s blink
L_8ce93a:
	bl L_8ce32c
L_8ce93e:
	bl L_8ce908
L_8ce942:
	pop_s blink
L_8ce944:
	j_s [blink]
L_8ce946:
	nop_s
