/* calib_engine__links_active @ 0x8e566c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__step
 */
	.section .text.calib_engine__links_active,"ax",@progbits
	.global calib_engine__links_active
calib_engine__links_active:
	.global L_8e566c
L_8e566c:
	mov_s r1,0x854900
L_8e5672:
	ldb_s r1,[r1]
L_8e5674:
	breq_s r1,0,L_8e5682
L_8e5676:
	mov_s r2,0x854880
L_8e567c:
	ld_s r1,[r2,0x70]
L_8e567e:
	add_s r0,r0,r1
L_8e5680:
	st_s r0,[r2,0x70]
	.global L_8e5682
L_8e5682:
	j_s [blink]
