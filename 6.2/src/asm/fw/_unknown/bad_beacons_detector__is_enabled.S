/* bad_beacons_detector__is_enabled @ 0x8da1cc, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bad_beacons_detector__handle_bcons_info
 * Зовёт сам: __ld_r13_to_r13_ret, detector__slot_is_free, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bad_beacons_detector__is_enabled
bad_beacons_detector__is_enabled:
	.global L_8da1cc
L_8da1cc:
	push_s blink
L_8da1ce:
	push_s r13
L_8da1d0:
	bl.d L_8da344
L_8da1d4:
	mov_s r13,r0
L_8da1d6:
	cmp_s r0,0x0
L_8da1d8:
	mov_s r0,0x0
L_8da1da:
	beq_s L_8da202
L_8da1dc:
	ldb_s r0,[r13]
L_8da1de:
	brge r0,0x8,L_8da206
	.global L_8da1e2
L_8da1e2:
	ldb_s r1,[r13]
L_8da1e4:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8da1e6:
	ld_s r2,[r13,0x4]
L_8da1e8:
	add3_s r1,r1,r1
L_8da1ea:
	ld_s r1,[r2,r1]
L_8da1ec:
	mov_s r0,0x0
L_8da1ee:
	bbit0 r1,0x2,L_8da200
L_8da1f2:
	mov_s r1,0x803c00
L_8da1f8:
	ld_s r1,[r1,0xc]
L_8da1fa:
	cmp_s r1,0x0
L_8da1fc:
	mov.eq r0,0x1
	.global L_8da200
L_8da200:
	extb_s r0,r0
	.global L_8da202
L_8da202:
	b L_8c025c
	.global L_8da206
L_8da206:
	mov_s r0,blink
L_8da208:
	mov_s r1,0x1527
L_8da20e:
	bl L_8c9b28
L_8da212:
	b_s L_8da1e2
