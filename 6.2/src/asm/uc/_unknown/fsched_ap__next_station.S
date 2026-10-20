/* fsched_ap__next_station @ 0x920d04, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fsched_ap__poll_station
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched_ap__next_station
fsched_ap__next_station:
	.global L_920d04
L_920d04:
	push_s blink
L_920d06:
	bl.d L_920230
L_920d0a:
	mov_s r3,0x1
L_920d0c:
	add r2,r0,0x20
L_920d10:
	b_s L_920d14
	.global L_920d12
L_920d12:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_920d14
L_920d14:
	brhs r3,0x9,L_920d44
L_920d18:
	ldb_s r1,[r2,0x8]
L_920d1a:
	mov_s r14,0x80218c
L_920d20:
	add_s r1,r1,r3
L_920d22:
	ldb_s r14,[r14,0x8]
L_920d24:
	bmsk_s r1,r1,0x2
L_920d26:
	mov_s r13,0x1
L_920d28:
	bbit0 r14,r1,L_920d12
L_920d2c:
	asl_s r15,r1,0x4
L_920d2e:
	mov_s r14,0x80111c
L_920d34:
	add2_s r15,r15,r15
L_920d36:
	ld_s r14,[r14,r15]
L_920d38:
	breq_s r14,0,L_920d12
L_920d3a:
	bl.d L_93d1ec
L_920d3e:
	stb_s r1,[r2,0x8]
L_920d40:
	mov_s r0,r13
L_920d42:
	b_s L_920d48
	.global L_920d44
L_920d44:
	mov_s r0,0x0
L_920d46:
	stb_s r0,[r2,0x8]
	.global L_920d48
L_920d48:
	b L_92029c
