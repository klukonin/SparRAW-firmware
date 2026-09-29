/* rate_search__current_mcs_b @ 0x92c1c8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rfc_ctrl__switch
 */
	.section .text.rate_search__current_mcs_b,"ax",@progbits
	.global rate_search__current_mcs_b
rate_search__current_mcs_b:
	.global L_92c1c8
L_92c1c8:
	asl_s r1,r0,0x2
L_92c1ca:
	add1_s r1,r1,r1
L_92c1cc:
	mul64 r0,0x2c
L_92c1d0:
	mov_s r2,0x8016d8
L_92c1d6:
	ld_s r1,[r2,r1]
L_92c1d8:
	add r0,mlo,0x801738
L_92c1e0:
	breq_s r1,0,L_92c1e6
L_92c1e2:
	ldb_s r0,[r0,0x1c]
L_92c1e4:
	b_s L_92c1e8
	.global L_92c1e6
L_92c1e6:
	ldb_s r0,[r0,0x1d]
	.global L_92c1e8
L_92c1e8:
	j_s [blink]
L_92c1ea:
	nop_s
