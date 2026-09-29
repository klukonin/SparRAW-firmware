/* bad_beacons_detector__is_bad @ 0x8d70fc, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bad_beacons_detector.cpp
 * Зовут его: bad_beacons_detector__handle_bcons_info
 * Зовёт сам: __ld_r13_ret, detector__slot_is_free, fw_sysassert_fatal
 */
	.section .text.bad_beacons_detector__is_bad,"ax",@progbits
	.global bad_beacons_detector__is_bad
bad_beacons_detector__is_bad:
	.global L_8d70fc
L_8d70fc:
	push_s blink
L_8d70fe:
	push_s r13
L_8d7100:
	bl.d L_8d7298
L_8d7104:
	mov_s r13,r0
L_8d7106:
	cmp_s r0,0x0
L_8d7108:
	mov_s r0,0x0
L_8d710a:
	beq_s L_8d7132
L_8d710c:
	ldb_s r0,[r13]
L_8d710e:
	brge r0,0x8,L_8d7136
	.global L_8d7112
L_8d7112:
	ldb_s r1,[r13]
L_8d7114:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8d7116:
	ld_s r2,[r13,0x4]
L_8d7118:
	add3_s r1,r1,r1
L_8d711a:
	ld_s r1,[r2,r1]
L_8d711c:
	mov_s r0,0x0
L_8d711e:
	bbit0 r1,0x2,L_8d7130
L_8d7122:
	mov_s r1,0x80345c
L_8d7128:
	ld_s r1,[r1,0xc]
L_8d712a:
	cmp_s r1,0x0
L_8d712c:
	mov.eq r0,0x1
	.global L_8d7130
L_8d7130:
	extb_s r0,r0
	.global L_8d7132
L_8d7132:
	b L_8c033c
	.global L_8d7136
L_8d7136:
	mov_s r0,blink
L_8d7138:
	mov_s r2,0x10116e8
L_8d713e:
	mov_s r1,0x147b
L_8d7144:
	bl.d L_8c82c0
L_8d7148:
	mov_s r3,0x31
L_8d714a:
	b_s L_8d7112
