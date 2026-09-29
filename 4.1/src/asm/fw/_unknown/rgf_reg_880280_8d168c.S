/* rgf_reg_880280_8d168c @ 0x8d168c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_pcie__set_low_power
 */
	.section .text.rgf_reg_880280_8d168c,"ax",@progbits
	.global rgf_reg_880280_8d168c
rgf_reg_880280_8d168c:
	.global L_8d168c
L_8d168c:
	push_s r13
L_8d168e:
	mov_s r3,0x880280
L_8d1694:
	ld_s r13,[r3,0x10]
L_8d1696:
	mov_s r2,0xff
L_8d1698:
	asl_s r2,r2,r0
L_8d169a:
	bic_s r13,r13,r2
L_8d169c:
	asl_s r1,r1,r0
L_8d169e:
	or_s r1,r1,r13
L_8d16a0:
	st_s r1,[r3,0x10]
L_8d16a2:
	j_s.d [blink]
L_8d16a4:
	pop_s r13
L_8d16a6:
	nop_s
