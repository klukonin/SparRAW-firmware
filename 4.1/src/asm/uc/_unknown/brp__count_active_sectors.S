/* brp__count_active_sectors @ 0x92b3e4, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__mode_step, brp_flow_step
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc
 */
	.section .text.brp__count_active_sectors,"ax",@progbits
	.global brp__count_active_sectors
brp__count_active_sectors:
	.global L_92b3e4
L_92b3e4:
	push_s blink
L_92b3e6:
	bl L_920210
L_92b3ea:
	mov_s r2,0x857000
L_92b3f0:
	ld_s r2,[r2,0x4c]
L_92b3f2:
	bbit0 r2,r1,L_92b440
L_92b3f6:
	mov_s r3,0x0
L_92b3f8:
	b_s L_92b3fc
	.global L_92b3fa
L_92b3fa:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_92b3fc
L_92b3fc:
	mov_s r2,0x800734
L_92b402:
	ld_s r2,[r2]
L_92b404:
	lsr_s r2,r2,0xf
L_92b406:
	bmsk_s r2,r2,0x5
L_92b408:
	brhs r3,r2,L_92b440
L_92b40c:
	mov_s r14,0x801050
L_92b412:
	add1 r13,r14,r3
L_92b416:
	ldb_s r15,[r13]
L_92b418:
	brlt r0,r15,L_92b3fa
L_92b41c:
	sub_s r15,r2,0x1
L_92b41e:
	breq r3,r15,L_92b43c
L_92b422:
	sub lp_count,r15,r3
L_92b426:
	lp L_92b43c
L_92b42a:
	add1 r2,r14,r15
L_92b42e:
	ldb r3,[r2, -0x2]
L_92b432:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_92b434:
	stb_s r3,[r2]
L_92b436:
	ldb r3,[r2, -0x1]
L_92b43a:
	stb_s r3,[r2,0x1]
	.global L_92b43c
L_92b43c:
	stb_s r0,[r13]
L_92b43e:
	stb_s r1,[r13,0x1]
	.global L_92b440
L_92b440:
	b L_92027c
