/* bad_beacons_detector__configure @ 0x8c5a34, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bad_beacons_detector.cpp
 * Зовут его: bad_beacons_detector__arm, bad_beacons_detector__handle_bcons_info, bad_beacons_detector__init
 * Зовёт сам: __ld_r13_ret, detector__slot_is_free, fw_sysassert_fatal
 */
	.section .text.bad_beacons_detector__configure,"ax",@progbits
	.global bad_beacons_detector__configure
bad_beacons_detector__configure:
	.global L_8c5a34
L_8c5a34:
	push_s blink
L_8c5a36:
	push_s r13
L_8c5a38:
	bl.d L_8d7298
L_8c5a3c:
	mov_s r13,r0
L_8c5a3e:
	breq_s r0,0,L_8c5a54
L_8c5a40:
	ldb_s r0,[r13]
L_8c5a42:
	brge r0,0x8,L_8c5a58
	.global L_8c5a46
L_8c5a46:
	ld_s r0,[r13,0x4]
L_8c5a48:
	mov_s r2,0x0
L_8c5a4a:
	ldb_s r1,[r13]
L_8c5a4c:
	add r0,r0,0x1e4
L_8c5a50:
	add_s r0,r0,r1
L_8c5a52:
	stb_s r2,[r0]
	.global L_8c5a54
L_8c5a54:
	b L_8c033c
	.global L_8c5a58
L_8c5a58:
	mov_s r0,blink
L_8c5a5a:
	mov_s r2,0x10116e8
L_8c5a60:
	mov_s r1,0x147b
L_8c5a66:
	bl.d L_8c82c0
L_8c5a6a:
	mov_s r3,0x3c
L_8c5a6c:
	b_s L_8c5a46
L_8c5a6e:
	nop_s
