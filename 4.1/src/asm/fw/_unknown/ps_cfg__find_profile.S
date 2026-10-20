/* ps_cfg__find_profile @ 0x8d73e4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CFG_SCHEME__switch_active_ps_profile
 */
	.section .text.ps_cfg__find_profile,"ax",@progbits
	.global ps_cfg__find_profile
ps_cfg__find_profile:
	.global L_8d73e4
L_8d73e4:
	push_s r13
L_8d73e6:
	mov_s r2,0x0
L_8d73e8:
	mov_s r13,0x8035c8
L_8d73ee:
	add_s r3,r13,0x4
L_8d73f0:
	b_s L_8d73f4
	.global L_8d73f2
L_8d73f2:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_8d73f4
L_8d73f4:
	brge r2,0x1,L_8d7404
L_8d73f8:
	asl_s r1,r2,0x2
L_8d73fa:
	add3_s r1,r1,r1
L_8d73fc:
	ld_s r1,[r3,r1]
L_8d73fe:
	breq r0,r1,L_8d73f2
L_8d7402:
	b_s L_8d740a
	.global L_8d7404
L_8d7404:
	ld_s r1,[r13,0x24]
L_8d7406:
	breq r0,r1,L_8d740e
	.global L_8d740a
L_8d740a:
	mov_s r0,0x0
L_8d740c:
	b_s L_8d7410
	.global L_8d740e
L_8d740e:
	mov_s r0,0x1
	.global L_8d7410
L_8d7410:
	j_s.d [blink]
L_8d7412:
	pop_s r13
