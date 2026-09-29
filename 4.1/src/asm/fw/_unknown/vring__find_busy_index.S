/* vring__find_busy_index @ 0x8cacf4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__busy_index_or_ff, vring__busy_index_or_zero
 */
	.section .text.vring__find_busy_index,"ax",@progbits
	.global vring__find_busy_index
vring__find_busy_index:
	.global L_8cacf4
L_8cacf4:
	mov_s r3,0x0
L_8cacf6:
	b_s L_8cacfc
	.global L_8cacf8
L_8cacf8:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8cacfa:
	extb_s r3,r3
	.global L_8cacfc
L_8cacfc:
	brhs r3,0x9,L_8cad16
L_8cad00:
	asl_s r1,r3,0x3
L_8cad02:
	add2_s r1,r1,r1
L_8cad04:
	add_s r1,r1,0x804404
L_8cad0a:
	ld_s r2,[r1,0x24]
L_8cad0c:
	breq_s r2,0,L_8cacf8
L_8cad0e:
	ldb_s r2,[r1,0xa]
L_8cad10:
	brne r0,r2,L_8cacf8
L_8cad14:
	b_s L_8cad18
	.global L_8cad16
L_8cad16:
	mov_s r1,0x0
	.global L_8cad18
L_8cad18:
	j_s.d [blink]
L_8cad1a:
	mov_s r0,r1
