/* detector__slot_is_free @ 0x8d7298, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bad_beacons_detector__configure, bad_beacons_detector__is_bad
 */
	.section .text.detector__slot_is_free,"ax",@progbits
	.global detector__slot_is_free
detector__slot_is_free:
	.global L_8d7298
L_8d7298:
	ldb_s r2,[r0]
L_8d729a:
	cmp r2,0xff
L_8d729e:
	mov_s r1,0x0
L_8d72a0:
	beq_s L_8d72a6
L_8d72a2:
	ld_s r0,[r0,0x4]
L_8d72a4:
	brne_s r0,0,L_8d72aa
	.global L_8d72a6
L_8d72a6:
	mov_s r0,r1
L_8d72a8:
	b_s L_8d72ac
	.global L_8d72aa
L_8d72aa:
	mov_s r0,0x1
	.global L_8d72ac
L_8d72ac:
	j_s.d [blink]
L_8d72ae:
	extb_s r0,r0
