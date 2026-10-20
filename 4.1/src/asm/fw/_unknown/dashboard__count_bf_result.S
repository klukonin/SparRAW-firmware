/* dashboard__count_bf_result @ 0x8e55d4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dashboard__bf_results
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.dashboard__count_bf_result,"ax",@progbits
	.global dashboard__count_bf_result
dashboard__count_bf_result:
	.global L_8e55d4
L_8e55d4:
	push_s blink
L_8e55d6:
	bl.d L_8c02c0
L_8e55da:
	mov_s r4,r1
L_8e55dc:
	mov_s r14,0x854900
L_8e55e2:
	asl_s r3,r0,0x4
L_8e55e4:
	add3_s r3,r3,r3
L_8e55e6:
	add_s r3,r3,r14
L_8e55e8:
	ld_s r2,[r3,0x68]
L_8e55ea:
	mov_s r1,0x0
L_8e55ec:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8e55ee:
	st_s r2,[r3,0x68]
L_8e55f0:
	mov_s r13,r1
L_8e55f2:
	b_s L_8e560e
	.global L_8e55f4
L_8e55f4:
	mov_s r15,0x1
L_8e55f6:
	bbit0 r4,r13,L_8e560a
L_8e55fa:
	asl_s r2,r0,0x4
L_8e55fc:
	add3_s r2,r2,r2
L_8e55fe:
	add_s r2,r2,r14
L_8e5600:
	add2_s r2,r2,r13
L_8e5602:
	ld_s r1,[r2,0x4c]
L_8e5604:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e5606:
	st_s r1,[r2,0x4c]
L_8e5608:
	mov_s r1,r15
	.global L_8e560a
L_8e560a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e560c:
	extb_s r13,r13
	.global L_8e560e
L_8e560e:
	brlt r13,0x7,L_8e55f4
L_8e5612:
	brne_s r1,0,L_8e561a
L_8e5614:
	ld_s r0,[r3,0x6c]
L_8e5616:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5618:
	st_s r0,[r3,0x6c]
	.global L_8e561a
L_8e561a:
	b L_8c032c
L_8e561e:
	nop_s
