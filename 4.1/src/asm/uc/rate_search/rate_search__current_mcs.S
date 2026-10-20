/* rate_search__current_mcs @ 0x92c278, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rate_search__reset_sta, rx_funcs__rx_flow, tx_initiator_step
 */
	.section .text.rate_search__current_mcs,"ax",@progbits
	.global rate_search__current_mcs
rate_search__current_mcs:
	.global L_92c278
L_92c278:
	asl_s r1,r0,0x2
L_92c27a:
	add1_s r1,r1,r1
L_92c27c:
	mul64 r0,0x2c
L_92c280:
	mov_s r2,0x8016d8
L_92c286:
	ld_s r1,[r2,r1]
L_92c288:
	add r0,mlo,0x801738
L_92c290:
	breq_s r1,0,L_92c296
L_92c292:
	ldb_s r0,[r0,0x1a]
L_92c294:
	b_s L_92c298
	.global L_92c296
L_92c296:
	ldb_s r0,[r0,0x1d]
	.global L_92c298
L_92c298:
	j_s [blink]
L_92c29a:
	nop_s
