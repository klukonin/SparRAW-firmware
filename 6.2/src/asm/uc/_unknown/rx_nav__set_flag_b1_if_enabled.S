/* rx_nav__set_flag_b1_if_enabled @ 0x92dcbc, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence, txrx_api_cmd_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_nav__set_flag_b1_if_enabled
rx_nav__set_flag_b1_if_enabled:
	.global L_92dcbc
L_92dcbc:
	mov_s r2,0x80146c
L_92dcc2:
	ldw_s r1,[r2,0x16]
L_92dcc4:
	breq_s r1,0,L_92dcd0
L_92dcc6:
	cmp_s r0,0x0
L_92dcc8:
	mov.ne r0,0x1
L_92dccc:
	asl_s r0,r0
L_92dcce:
	b_s L_92dcd2
	.global L_92dcd0
L_92dcd0:
	mov_s r0,0x0
	.global L_92dcd2
L_92dcd2:
	j_s.d [blink]
L_92dcd4:
	st_s r0,[r2]
L_92dcd6:
	nop_s
