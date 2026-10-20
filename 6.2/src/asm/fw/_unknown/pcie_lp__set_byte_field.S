/* pcie_lp__set_byte_field @ 0x8d473c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_pcie__set_low_power
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_lp__set_byte_field
pcie_lp__set_byte_field:
	.global L_8d473c
L_8d473c:
	push_s r13
L_8d473e:
	mov_s r3,0x880280
L_8d4744:
	ld_s r13,[r3,0x10]
L_8d4746:
	mov_s r2,0xff
L_8d4748:
	asl_s r2,r2,r0
L_8d474a:
	bic_s r13,r13,r2
L_8d474c:
	asl_s r1,r1,r0
L_8d474e:
	or_s r1,r1,r13
L_8d4750:
	st_s r1,[r3,0x10]
L_8d4752:
	j_s.d [blink]
L_8d4754:
	pop_s r13
L_8d4756:
	nop_s
