/* hwd_pcie_l1_enter_isr @ 0x8ce8d8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_pcie_l1_enter_isr: PCIE LTSSM State != LTSSM_S_L1_IDLE
 * Зовут его: isr_pcie_ltssm_dbg
 * Зовёт сам: fw_log__emit0, hwd_pcie_ltssm_is_l1_idle, set_reg_882fe0
 */
	.section .text.hwd_pcie_l1_enter_isr,"ax",@progbits
	.global hwd_pcie_l1_enter_isr
hwd_pcie_l1_enter_isr:
	.global L_8ce8d8
L_8ce8d8:
	push_s blink
L_8ce8da:
	bl L_8ce32c
L_8ce8de:
	brne_s r0,0,L_8ce8ee
L_8ce8e0:
	mov_s r2,0x1018b24
L_8ce8e6:
	mov_s r0,0x1
L_8ce8e8:
	bl.d L_8edfb0
L_8ce8ec:
	mov_s r1,0x0
	.global L_8ce8ee
L_8ce8ee:
	bl L_8ce8ac
L_8ce8f2:
	pop_s blink
L_8ce8f4:
	j_s [blink]
L_8ce8f6:
	nop_s
