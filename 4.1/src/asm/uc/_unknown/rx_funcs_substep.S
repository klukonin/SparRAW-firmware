/* rx_funcs_substep @ 0x935814, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs_step
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_b_s0_w5_uc, bf_w_s2_w2_uc, bf_w_s4_w4_uc, bf_w_s8_w4_uc
 */
	.section .text.rx_funcs_substep,"ax",@progbits
	.global rx_funcs_substep
rx_funcs_substep:
	.global L_935814
L_935814:
	push_s blink
L_935816:
	bl.d L_920214
L_93581a:
	mov_s r3,r0
L_93581c:
	mov_s r13,r1
L_93581e:
	mov_s r14,0x0
L_935820:
	mov_s r1,0x1
L_935822:
	bl.d L_9379ac
L_935826:
	stw_s r14,[r0]
L_935828:
	mov_s r1,0x6
L_93582a:
	bl.d L_9379d0
L_93582e:
	cmp_s r2,0x1
L_935830:
	mov_s r1,0xa
L_935832:
	bl L_937a00
L_935836:
	bne_s L_935848
L_935838:
	mov_s r0,0x85761c
L_93583e:
	mul64 r13,0x3c
L_935842:
	ld r1,[r0,mlo]
L_935846:
	b_s L_935850
	.global L_935848
L_935848:
	mov_s r0,0x800fcc
L_93584e:
	ld_s r1,[r0]
	.global L_935850
L_935850:
	bmsk r0,r1,0x5
L_935854:
	lsr_s r1,r1,0x6
L_935856:
	bmsk_s r1,r1,0x1
L_935858:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_93585a:
	or_s r0,r0,r1
L_93585c:
	stb_s r0,[r3,0x10]
L_93585e:
	mov_s r0,0x800fcc
L_935864:
	ld_s r1,[r0,0x8]
L_935866:
	stb_s r14,[r3,0x12]
L_935868:
	sub_s r1,r1,0x13
L_93586a:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93586c:
	stb_s r1,[r3,0x11]
L_93586e:
	mov_s r1,r14
L_935870:
	stb_s r1,[r3,0x13]
L_935872:
	lsr_s r1,r1,0x8
L_935874:
	stb_s r1,[r3,0x14]
L_935876:
	lsr_s r1,r1,0x8
L_935878:
	stb_s r1,[r3,0x15]
L_93587a:
	lsr_s r1,r1,0x8
L_93587c:
	stb_s r1,[r3,0x16]
L_93587e:
	ldb r0,[r0, 0x68]
L_935882:
	bbit0 r0,r13,L_935890
L_935886:
	add r0,r3,0x13
L_93588a:
	mov_s r1,0x10
L_93588c:
	bl L_937958
	.global L_935890
L_935890:
	asl_s r0,r13,0x3
L_935892:
	add3_s r0,r0,r0
L_935894:
	stb_s r14,[r3,0x17]
L_935896:
	add_s r0,r0,0x801190
L_93589c:
	ldw_s r1,[r0,0x2c]
L_93589e:
	stw_s r1,[r3,0x4]
L_9358a0:
	ldw_s r1,[r0,0x2e]
L_9358a2:
	stw_s r1,[r3,0x6]
L_9358a4:
	ldw_s r0,[r0,0x30]
L_9358a6:
	b.d L_920284
L_9358aa:
	stw_s r0,[r3,0x8]
