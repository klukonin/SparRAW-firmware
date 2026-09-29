/* calib_base__vt14 @ 0x8c5798, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.calib_base__vt14,"ax",@progbits
	.global calib_base__vt14
calib_base__vt14:
L_8c5798:
	ld_s r0,[r3]
L_8c579a:
	sub_s r2,r2,r0
L_8c579c:
	abs_s r2,r2
L_8c579e:
	brhs r2,r1,L_8c57a8
L_8c57a2:
	cmp r0,-0x1
L_8c57a6:
	bne_s L_8c57ac
	.global L_8c57a8
L_8c57a8:
	mov_s r0,0x1
L_8c57aa:
	b_s L_8c57ae
	.global L_8c57ac
L_8c57ac:
	mov_s r0,0x0
	.global L_8c57ae
L_8c57ae:
	j_s [blink]
