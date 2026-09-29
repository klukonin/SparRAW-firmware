/* fsched_slot__f3_positive @ 0x92be0c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mtp__get_tx_permission, txop__await_cts_ppdu
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched_slot__f3_positive
fsched_slot__f3_positive:
	.global L_92be0c
L_92be0c:
	ldb r1,[r0, 0x28]
L_92be10:
	/* add_s r0,0x3 */
	.byte 0x03,0xe0
L_92be12:
	add2_s r1,r1,r1
L_92be14:
	ldb_s r0,[r0,r1]
L_92be16:
	cmp_s r0,0x0
L_92be18:
	mov_s r0,0x1
L_92be1a:
	j_s.d [blink]
L_92be1c:
	sub.le r0,r0,r0
