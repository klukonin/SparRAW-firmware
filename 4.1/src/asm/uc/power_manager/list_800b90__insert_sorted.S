/* list_800b90__insert_sorted @ 0x92b294, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_list__insert_by_prio
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc
 */
	.section .text.list_800b90__insert_sorted,"ax",@progbits
	.global list_800b90__insert_sorted
list_800b90__insert_sorted:
	.global L_92b294
L_92b294:
	push_s blink
L_92b296:
	bl.d L_920210
L_92b29a:
	mov_s r3,0x0
L_92b29c:
	mov_s r14,0x800b90
L_92b2a2:
	add2_s r14,r14,r1
L_92b2a4:
	ld_s r1,[r14]
L_92b2a6:
	ld_s r13,[r0]
L_92b2a8:
	breq_s r1,0,L_92b2c2
	.global L_92b2aa
L_92b2aa:
	ld_s r15,[r1]
L_92b2ac:
	breq_s r2,0,L_92b2b4
L_92b2ae:
	brlo r15,r13,L_92b2b8
L_92b2b2:
	b_s L_92b2c2
	.global L_92b2b4
L_92b2b4:
	brhs r13,r15,L_92b2c2
	.global L_92b2b8
L_92b2b8:
	ld_s r15,[r1,0x8]
L_92b2ba:
	breq_s r15,0,L_92b2c6
L_92b2bc:
	mov_s r3,r1
L_92b2be:
	mov_s r1,r15
L_92b2c0:
	b_s L_92b2aa
	.global L_92b2c2
L_92b2c2:
	mov_s r15,r1
L_92b2c4:
	mov_s r1,r3
	.global L_92b2c6
L_92b2c6:
	st_s r15,[r0,0x8]
L_92b2c8:
	brne_s r1,0,L_92b2ce
L_92b2ca:
	st_s r0,[r14]
L_92b2cc:
	b_s L_92b2d0
	.global L_92b2ce
L_92b2ce:
	st_s r0,[r1,0x8]
	.global L_92b2d0
L_92b2d0:
	b L_92027c
