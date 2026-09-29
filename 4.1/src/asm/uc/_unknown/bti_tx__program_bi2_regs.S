/* bti_tx__program_bi2_regs @ 0x92c968, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_transmitter_bi2_flow
 */
	.section .text.bti_tx__program_bi2_regs,"ax",@progbits
	.global bti_tx__program_bi2_regs
bti_tx__program_bi2_regs:
	.global L_92c968
L_92c968:
	push_s r13
L_92c96a:
	mov_s r13,blink
L_92c96c:
	rsub r1,r0,0x3de
L_92c974:
	or r1,r1,0x50000000
L_92c97c:
	mov r32,r1
L_92c980:
	st.ab r1,[r25,0x4]
L_92c984:
	bclr r25,r25,0xa
L_92c988:
	mov_s r2,0x5300070e
L_92c98e:
	mov_s r32,r2
L_92c990:
	st.ab r2,[r25,0x4]
L_92c994:
	bclr r25,r25,0xa
L_92c998:
	mov_s r3,0x49000080
L_92c99e:
	mov_s r32,r3
L_92c9a0:
	st.ab r3,[r25,0x4]
L_92c9a4:
	bclr r25,r25,0xa
L_92c9a8:
	mov_s blink,r13
L_92c9aa:
	j_s.d [blink]
L_92c9ac:
	pop_s r13
L_92c9ae:
	nop_s
