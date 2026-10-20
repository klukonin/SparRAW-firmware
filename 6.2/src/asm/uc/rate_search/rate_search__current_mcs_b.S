/* rate_search__current_mcs_b @ 0x92ff44, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_mode__configure
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rate_search__current_mcs_b
rate_search__current_mcs_b:
	.global L_92ff44
L_92ff44:
	asl_s r1,r0,0x2
L_92ff46:
	add1_s r1,r1,r1
L_92ff48:
	mul64 r0,0x2c
L_92ff4c:
	mov_s r2,0x802610
L_92ff52:
	ld_s r1,[r2,r1]
L_92ff54:
	add r0,mlo,0x802670
L_92ff5c:
	breq_s r1,0,L_92ff62
L_92ff5e:
	ldb_s r0,[r0,0x1c]
L_92ff60:
	b_s L_92ff64
	.global L_92ff62
L_92ff62:
	ldb_s r0,[r0,0x1d]
	.global L_92ff64
L_92ff64:
	j_s [blink]
L_92ff66:
	nop_s
