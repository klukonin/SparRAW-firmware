/* mac__read_bi_start_tsf64_uc @ 0x9374e8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__compute_tbtt_from_hw, peer_masks__apply_op
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__read_bi_start_tsf64_uc
mac__read_bi_start_tsf64_uc:
	.global L_9374e8
L_9374e8:
	mov r5,0x887000
L_9374f0:
	breq r2,0x0,L_9374fc
	.global L_9374f4
L_9374f4:
	ld.as r4,[r5,-0x53]
L_9374f8:
	bbit0 r4,0x1f,L_9374f4
	.global L_9374fc
L_9374fc:
	ld r6,[r5, -0x3c]
L_937500:
	st r6,[r1]
L_937504:
	ld r2,[r5, -0x38]
L_937508:
	st_s r2,[r1,0x4]
L_93750a:
	ld r3,[r5, -0x3c]
L_93750e:
	cmp r6,r3
L_937512:
	jeq_s [blink]
L_937514:
	b_s L_9374fc
L_937516:
	nop_s
