/* edmg__channel_matches_mode @ 0x8c6430, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global edmg__channel_matches_mode
edmg__channel_matches_mode:
	.global L_8c6430
L_8c6430:
	brne_s r2,0,L_8c6442
L_8c6432:
	cmp_s r1,0x2
L_8c6434:
	cmp.ne r1,0x4
L_8c6438:
	cmp.ne r1,0x6
L_8c643c:
	cmp.ne r1,0x8
L_8c6440:
	bne_s L_8c6464
	.global L_8c6442
L_8c6442:
	brne r2,0x1,L_8c6456
L_8c6446:
	cmp_s r1,0x3
L_8c6448:
	cmp.ne r1,0x5
L_8c644c:
	cmp.ne r1,0x7
L_8c6450:
	cmp.ne r1,0x9
L_8c6454:
	bne_s L_8c6464
	.global L_8c6456
L_8c6456:
	brne r2,0x2,L_8c645e
L_8c645a:
	brne r1,0x1,L_8c6464
	.global L_8c645e
L_8c645e:
	brne r2,0x3,L_8c6468
L_8c6462:
	breq_s r1,0,L_8c6468
	.global L_8c6464
L_8c6464:
	mov_s r0,0x0
L_8c6466:
	b_s L_8c646a
	.global L_8c6468
L_8c6468:
	mov_s r0,0x1
	.global L_8c646a
L_8c646a:
	j_s [blink]
L_8c646c:
	ld_s r0,[r3]
L_8c646e:
	sub_s r2,r2,r0
L_8c6470:
	abs_s r2,r2
L_8c6472:
	brhs r2,r1,L_8c647c
L_8c6476:
	cmp r0,-0x1
L_8c647a:
	bne_s L_8c6480
	.global L_8c647c
L_8c647c:
	mov_s r0,0x1
L_8c647e:
	b_s L_8c6482
	.global L_8c6480
L_8c6480:
	mov_s r0,0x0
	.global L_8c6482
L_8c6482:
	j_s [blink]
