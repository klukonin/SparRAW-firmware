/* fw_vector_18__pair @ 0x8d162c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_18
 * Зовёт сам: hwd_pcie_ltssm_is_l1_idle, pcie__mask_l1_exit_irq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_vector_18__pair
fw_vector_18__pair:
	.global L_8d162c
L_8d162c:
	push_s blink
L_8d162e:
	bl L_8d1070
L_8d1632:
	bl L_8d15fc
L_8d1636:
	pop_s blink
L_8d1638:
	j_s [blink]
L_8d163a:
	nop_s
