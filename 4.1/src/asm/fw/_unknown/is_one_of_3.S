/* is_one_of_3 @ 0x8d1f2c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_bb_gain__choose_row
 */
	.section .text.is_one_of_3,"ax",@progbits
	.global is_one_of_3
is_one_of_3:
	.global L_8d1f2c
L_8d1f2c:
	ldb_s r3,[r0,0x1]
L_8d1f2e:
	mov_s r2,0x0
L_8d1f30:
	breq r1,r3,L_8d1f44
L_8d1f34:
	ldb_s r3,[r0,0x2]
L_8d1f36:
	breq r1,r3,L_8d1f44
L_8d1f3a:
	ldb_s r0,[r0,0x3]
L_8d1f3c:
	cmp_s r1,r0
L_8d1f3e:
	mov.ne r0,r2
L_8d1f42:
	bne_s L_8d1f46
	.global L_8d1f44
L_8d1f44:
	mov_s r0,0x1
	.global L_8d1f46
L_8d1f46:
	j_s [blink]
