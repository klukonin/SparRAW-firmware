/* bti_tx__program_bi2_regs @ 0x930774, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_transmitter_bi2_flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti_tx__program_bi2_regs
bti_tx__program_bi2_regs:
	.global L_930774
L_930774:
	push_s r13
L_930776:
	mov_s r13,blink
L_930778:
	rsub r1,r0,0x3de
L_930780:
	or r1,r1,0x50000000
L_930788:
	mov r32,r1
L_93078c:
	st.ab r1,[r25,0x4]
L_930790:
	bclr r25,r25,0xa
L_930794:
	mov_s r2,0x5300070e
L_93079a:
	mov_s r32,r2
L_93079c:
	st.ab r2,[r25,0x4]
L_9307a0:
	bclr r25,r25,0xa
L_9307a4:
	mov_s r3,0x49000080
L_9307aa:
	mov_s r32,r3
L_9307ac:
	st.ab r3,[r25,0x4]
L_9307b0:
	bclr r25,r25,0xa
L_9307b4:
	mov_s blink,r13
L_9307b6:
	j_s.d [blink]
L_9307b8:
	pop_s r13
L_9307ba:
	nop_s
