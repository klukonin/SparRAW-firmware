/* tx_desc__build @ 0x8c8858, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_dma_if__push_desc
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_w_s0_w10, bf_w_s0_w4, bf_w_s16_w4, bf_w_s22_w5, bf_w_s24_w7, tx_desc__set_lifetime
 * Глобалы (через gp): 0x800348
 */
	.section .text.tx_desc__build,"ax",@progbits
	.global tx_desc__build
tx_desc__build:
	.global L_8c8858
L_8c8858:
	push_s blink
L_8c885a:
	bl L_8c02bc
L_8c885e:
	mov_s r13,r1
L_8c8860:
	mov_s r14,r2
L_8c8862:
	mov_s r15,r3
L_8c8864:
	mov r16,r5
L_8c8868:
	ld_s r2,[r13,0x4]
L_8c886a:
	mov_s r1,r7
L_8c886c:
	bclr_s r2,r2,0x17
L_8c886e:
	bclr_s r2,r2,0x1f
L_8c8870:
	st_s r2,[r13,0x4]
L_8c8872:
	brne r6,0x0,L_8c8886
L_8c8876:
	bmsk_s r1,r1,0x6
L_8c8878:
	add_s r0,r13,0x4
L_8c887a:
	bl L_8e845c
L_8c887e:
	ld_s r0,[r13,0x4]
L_8c8880:
	bset_s r0,r0,0x1f
L_8c8882:
	st_s r0,[r13,0x4]
L_8c8884:
	b_s L_8c889e
	.global L_8c8886
L_8c8886:
	ld_s r1,[sp,0x14]
L_8c8888:
	breq_s r1,0,L_8c889e
L_8c888a:
	bset_s r2,r2,0x17
L_8c888c:
	st_s r2,[r13,0x4]
L_8c888e:
	bl.d L_8ca264
L_8c8892:
	ld_s r0,[gp,0x1d8]
L_8c8894:
	bmsk r1,r0,0x9
L_8c8898:
	mov_s r0,r13
L_8c889a:
	bl L_8e830c
	.global L_8c889e
L_8c889e:
	ld_s r0,[r13]
L_8c88a0:
	bmsk r1,r16,0x4
L_8c88a4:
	bset_s r0,r0,0x1b
L_8c88a6:
	st_s r0,[r13]
L_8c88a8:
	mov_s r0,r13
L_8c88aa:
	bl L_8e842c
L_8c88ae:
	ld_s r0,[r13,0x4]
L_8c88b0:
	ldb_s r1,[sp,0x18]
L_8c88b2:
	bset_s r0,r0,0x14
L_8c88b4:
	st_s r0,[r13,0x4]
L_8c88b6:
	bmsk_s r1,r1,0x3
L_8c88b8:
	add_s r0,r13,0x4
L_8c88ba:
	bl L_8e83cc
L_8c88be:
	ld_s r1,[r13,0x4]
L_8c88c0:
	bset_s r1,r1,0x4
L_8c88c2:
	st_s r1,[r13,0x4]
L_8c88c4:
	bmsk r1,r15,0x3
L_8c88c8:
	bl L_8e8348
L_8c88cc:
	b.d L_8c0324
L_8c88d0:
	st_s r14,[r13,0xc]
L_8c88d2:
	nop_s
