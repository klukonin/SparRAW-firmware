/* pcie_ltssm__code_to_index @ 0x8d158c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_18
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_ltssm__code_to_index
pcie_ltssm__code_to_index:
	.global L_8d158c
L_8d158c:
	mov_s r2,0x0
L_8d158e:
	breq_s r1,0,L_8d1598
L_8d1590:
	breq r1,0x1,L_8d159c
L_8d1594:
	mov_s r0,r2
L_8d1596:
	b_s L_8d15a0
	.global L_8d1598
L_8d1598:
	lsr_s r0,r0,0xe
L_8d159a:
	b_s L_8d159e
	.global L_8d159c
L_8d159c:
	lsr_s r0,r0,0x13
	.global L_8d159e
L_8d159e:
	bmsk_s r0,r0,0x0
	.global L_8d15a0
L_8d15a0:
	j_s [blink]
L_8d15a2:
	nop_s
