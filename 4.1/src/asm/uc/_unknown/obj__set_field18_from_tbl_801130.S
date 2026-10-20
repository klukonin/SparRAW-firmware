/* obj__set_field18_from_tbl_801130 @ 0x937598, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow, tx_initiator_step
 */
	.section .text.obj__set_field18_from_tbl_801130,"ax",@progbits
	.global obj__set_field18_from_tbl_801130
obj__set_field18_from_tbl_801130:
	.global L_937598
L_937598:
	mov_s r1,0x5
L_93759a:
	st_s r1,[r0,0x18]
L_93759c:
	ld_s r1,[r0,0x4]
L_93759e:
	mov_s r2,0x801130
L_9375a4:
	add1_s r1,r1,r1
L_9375a6:
	ldb_s r1,[r2,r1]
L_9375a8:
	breq_s r1,0,L_9375ae
L_9375aa:
	mov_s r1,0xf
L_9375ac:
	st_s r1,[r0,0x18]
	.global L_9375ae
L_9375ae:
	j_s [blink]
