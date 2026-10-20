/* rx_funcs__on_rx_type_0x14 @ 0x92aa7c, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_funcs.c
 * Зовут его: rx_funcs__handle_ppdu_report, rx_funcs__identify_peer
 * Зовёт сам: uc_sysassert
 * Глобалы (через gp): 0x8005ca
 */
	.section .text.rx_funcs__on_rx_type_0x14,"ax",@progbits
	.global rx_funcs__on_rx_type_0x14
rx_funcs__on_rx_type_0x14:
	.global L_92aa7c
L_92aa7c:
	st.a r13,[sp,-0x4]
L_92aa80:
	ldw.as r4,[gp,0x51]
L_92aa84:
	mov r8,0x804010
L_92aa8c:
	add r4,r4,0x1
L_92aa90:
	stw.as r4,[gp,0x51]
L_92aa94:
	ldb r3,[r8, 0x18]
L_92aa98:
	brne.d r3,0x14,L_92aafc
L_92aa9c:
	mov_s r13,blink
L_92aa9e:
	ldb r2,[r8, 0x19]
L_92aaa2:
	brne r2,0x1,L_92aafc
L_92aaa6:
	mov r7,0x801038
L_92aaae:
	ld r9,[r7]
L_92aab2:
	bset r6,r9,0x9
L_92aab6:
	st r6,[r7]
L_92aaba:
	ldb r5,[r8, 0x1b]
L_92aabe:
	bmsk.f 0x0,r5,0x4
L_92aac2:
	beq_s L_92aad8
L_92aac4:
	bmsk r5,r5,0x4
L_92aac8:
	stb r5,[r7, 0xc]
L_92aacc:
	or r6,r9,0x600
L_92aad4:
	st r6,[r7]
	.global L_92aad8
L_92aad8:
	ldb r0,[r8, 0x21]
L_92aadc:
	ldb r1,[r8, 0x20]
L_92aae0:
	asl_s r0,r0,0x8
L_92aae2:
	or_s r1,r1,r0
L_92aae4:
	bbit0 r1,0xa,L_92aaf0
L_92aae8:
	bset r6,r6,0xb
L_92aaec:
	st r6,[r7]
	.global L_92aaf0
L_92aaf0:
	and.f 0x0,r6,0xc00
L_92aaf8:
	beq L_92ab04
	.global L_92aafc
L_92aafc:
	mov_s blink,r13
L_92aafe:
	j_s.d [blink]
L_92ab00:
	ld.ab r13,[sp,0x4]
	.global L_92ab04
L_92ab04:
	mov_s r0,blink
L_92ab06:
	mov_s r2,0x1000ecc
L_92ab0c:
	mov r1,0x3a
L_92ab10:
	bl.d L_925548
L_92ab14:
	mov r3,0x8e
L_92ab18:
	b_s L_92aafc
L_92ab1a:
	nop_s
