/* vring_schd__find_by_cid @ 0x8e72b8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schd__stop_vring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.vring_schd__find_by_cid,"ax",@progbits
	.global vring_schd__find_by_cid
vring_schd__find_by_cid:
	.global L_8e72b8
L_8e72b8:
	push_s blink
L_8e72ba:
	bl.d L_8c02c0
L_8e72be:
	mov_s r4,r1
L_8e72c0:
	mov_s r13,0x0
L_8e72c2:
	st_s r13,[r3]
L_8e72c4:
	st_s r13,[r2]
L_8e72c6:
	ld r1,[r0, 0x94]
L_8e72ca:
	brlo r1,0x1,L_8e72ec
	.global L_8e72ce
L_8e72ce:
	mul64 r13,0x38
L_8e72d2:
	add r1,r0,0x24
L_8e72d6:
	add_s r1,r1,mlo
L_8e72d8:
	ld_s r15,[r1,0x14]
L_8e72da:
	breq_s r15,0,L_8e72e2
L_8e72dc:
	ldb_s r14,[r15,0x9]
L_8e72de:
	breq r14,r4,L_8e72f0
	.global L_8e72e2
L_8e72e2:
	ld r1,[r0, 0x94]
L_8e72e6:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e72e8:
	brlo r13,r1,L_8e72ce
	.global L_8e72ec
L_8e72ec:
	mov_s r0,0x0
L_8e72ee:
	b_s L_8e72f6
	.global L_8e72f0
L_8e72f0:
	st_s r1,[r3]
L_8e72f2:
	st_s r15,[r2]
L_8e72f4:
	mov_s r0,0x1
	.global L_8e72f6
L_8e72f6:
	b L_8c032c
L_8e72fa:
	nop_s
