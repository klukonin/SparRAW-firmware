/* pcie_ltssm__code_to_index @ 0x8ce894, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pcie_ltssm_dbg
 */
	.section .text.pcie_ltssm__code_to_index,"ax",@progbits
	.global pcie_ltssm__code_to_index
pcie_ltssm__code_to_index:
	.global L_8ce894
L_8ce894:
	mov_s r2,0x0
L_8ce896:
	breq_s r1,0,L_8ce8a0
L_8ce898:
	breq r1,0x1,L_8ce8a4
L_8ce89c:
	mov_s r0,r2
L_8ce89e:
	b_s L_8ce8a8
	.global L_8ce8a0
L_8ce8a0:
	lsr_s r0,r0,0xe
L_8ce8a2:
	b_s L_8ce8a6
	.global L_8ce8a4
L_8ce8a4:
	lsr_s r0,r0,0x13
	.global L_8ce8a6
L_8ce8a6:
	bmsk_s r0,r0,0x0
	.global L_8ce8a8
L_8ce8a8:
	j_s [blink]
L_8ce8aa:
	nop_s
