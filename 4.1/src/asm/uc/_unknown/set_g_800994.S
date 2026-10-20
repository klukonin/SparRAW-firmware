/* set_g_800994 @ 0x92a680, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence, txrx_api_cmd_step
 */
	.section .text.set_g_800994,"ax",@progbits
	.global set_g_800994
set_g_800994:
	.global L_92a680
L_92a680:
	mov_s r2,0x800994
L_92a686:
	ldw_s r1,[r2,0x16]
L_92a688:
	breq_s r1,0,L_92a694
L_92a68a:
	cmp_s r0,0x0
L_92a68c:
	mov.ne r0,0x1
L_92a690:
	asl_s r0,r0
L_92a692:
	b_s L_92a696
	.global L_92a694
L_92a694:
	mov_s r0,0x0
	.global L_92a696
L_92a696:
	j_s.d [blink]
L_92a698:
	st_s r0,[r2]
L_92a69a:
	nop_s
