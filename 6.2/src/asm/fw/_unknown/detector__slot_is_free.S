/* detector__slot_is_free @ 0x8da344, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bad_beacons__check_counter, bad_beacons_detector__is_enabled
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global detector__slot_is_free
detector__slot_is_free:
	.global L_8da344
L_8da344:
	ldb_s r2,[r0]
L_8da346:
	cmp r2,0xff
L_8da34a:
	mov_s r1,0x0
L_8da34c:
	beq_s L_8da352
L_8da34e:
	ld_s r0,[r0,0x4]
L_8da350:
	brne_s r0,0,L_8da356
	.global L_8da352
L_8da352:
	mov_s r0,r1
L_8da354:
	b_s L_8da358
	.global L_8da356
L_8da356:
	mov_s r0,0x1
	.global L_8da358
L_8da358:
	j_s.d [blink]
L_8da35a:
	extb_s r0,r0
