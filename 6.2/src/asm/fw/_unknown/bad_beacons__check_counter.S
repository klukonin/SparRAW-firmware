/* bad_beacons__check_counter @ 0x8c67bc, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bad_beacons_detector__arm, bad_beacons_detector__handle_bcons_info, bad_beacons_detector__init
 * Зовёт сам: __ld_r13_to_r13_ret, detector__slot_is_free, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bad_beacons__check_counter
bad_beacons__check_counter:
	.global L_8c67bc
L_8c67bc:
	push_s blink
L_8c67be:
	push_s r13
L_8c67c0:
	bl.d L_8da344
L_8c67c4:
	mov_s r13,r0
L_8c67c6:
	breq_s r0,0,L_8c67dc
L_8c67c8:
	ldb_s r0,[r13]
L_8c67ca:
	brge r0,0x8,L_8c67e0
	.global L_8c67ce
L_8c67ce:
	ld_s r0,[r13,0x4]
L_8c67d0:
	mov_s r2,0x0
L_8c67d2:
	ldb_s r1,[r13]
L_8c67d4:
	add r0,r0,0x1ec
L_8c67d8:
	add1_s r0,r0,r1
L_8c67da:
	stw_s r2,[r0]
	.global L_8c67dc
L_8c67dc:
	b L_8c025c
	.global L_8c67e0
L_8c67e0:
	mov_s r0,blink
L_8c67e2:
	mov_s r1,0x1526
L_8c67e8:
	bl L_8c9b28
L_8c67ec:
	b_s L_8c67ce
L_8c67ee:
	nop_s
