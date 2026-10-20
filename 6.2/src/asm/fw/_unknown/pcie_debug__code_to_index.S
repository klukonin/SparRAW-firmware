/* pcie_debug__code_to_index @ 0x8d11c4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_15
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_debug__code_to_index
pcie_debug__code_to_index:
	.global L_8d11c4
L_8d11c4:
	mov_s r2,0x0
L_8d11c6:
	breq_s r1,0,L_8d11d8
L_8d11c8:
	breq r1,0x1,L_8d11dc
L_8d11cc:
	breq r1,0x2,L_8d11e0
L_8d11d0:
	breq r1,0x3,L_8d11e2
L_8d11d4:
	mov_s r0,r2
L_8d11d6:
	b_s L_8d11e4
	.global L_8d11d8
L_8d11d8:
	lsr_s r0,r0,0x3
L_8d11da:
	b_s L_8d11e2
	.global L_8d11dc
L_8d11dc:
	lsr_s r0,r0,0xc
L_8d11de:
	b_s L_8d11e2
	.global L_8d11e0
L_8d11e0:
	lsr_s r0,r0,0x9
	.global L_8d11e2
L_8d11e2:
	bmsk_s r0,r0,0x0
	.global L_8d11e4
L_8d11e4:
	j_s [blink]
L_8d11e6:
	nop_s
