/* bf__clear_sta_bit_state34 @ 0x92ed2c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__set_state
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__clear_sta_bit_state34
bf__clear_sta_bit_state34:
	.global L_92ed2c
L_92ed2c:
	cmp_s r1,0x3
L_92ed2e:
	cmp.ne r1,0x4
L_92ed32:
	bne_s L_92ed4e
L_92ed34:
	mov_s r1,0x0
L_92ed36:
	bset r1,r1,r0
L_92ed3a:
	mov_s r2,0x80218c
L_92ed40:
	ldb_s r0,[r2,0x6]
L_92ed42:
	not_s r1,r1
L_92ed44:
	and_s r0,r0,r1
L_92ed46:
	stb_s r0,[r2,0x6]
L_92ed48:
	ldb_s r0,[r2,0x7]
L_92ed4a:
	and_s r0,r0,r1
L_92ed4c:
	stb_s r0,[r2,0x7]
	.global L_92ed4e
L_92ed4e:
	j_s [blink]
