/* hwd_pcie_l1_enter_isr @ 0x8d15d0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_pcie_l1_enter_isr: PCIE LTSSM State != LTSSM_S_L1_IDLE
 * Зовут его: fw_vector_18
 * Зовёт сам: fw_log_emit0, hwd_pcie_ltssm_is_l1_idle, pcie__mask_l1_enter_irq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie_l1_enter_isr
hwd_pcie_l1_enter_isr:
	.global L_8d15d0
L_8d15d0:
	push_s blink
L_8d15d2:
	bl L_8d1070
L_8d15d6:
	brne_s r0,0,L_8d15e4
L_8d15d8:
	mov_s r1,0x101dcd4
L_8d15de:
	bl.d L_8dcba8
L_8d15e2:
	mov_s r0,0x1
	.global L_8d15e4
L_8d15e4:
	bl L_8d15a4
L_8d15e8:
	pop_s blink
L_8d15ea:
	j_s [blink]
