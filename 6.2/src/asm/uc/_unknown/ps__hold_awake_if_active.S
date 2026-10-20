/* ps__hold_awake_if_active @ 0x93da98, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1__on_event4
 * Зовёт сам: ps__hold_awake_for_sta
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ps__hold_awake_if_active
ps__hold_awake_if_active:
	.global L_93da98
L_93da98:
	st.a r13,[sp,-0x4]
L_93da9c:
	ldb r1,[0x8030e4]
L_93daa4:
	brne.d r1,0x1,L_93dab8
L_93daa8:
	mov_s r13,blink
L_93daaa:
	ld_s r2,[r0,0x20]
L_93daac:
	cmp r2,0x1
L_93dab0:
	bl.eq.d L_93d914
L_93dab4:
	mov.eq r1,0x1
	.global L_93dab8
L_93dab8:
	mov_s blink,r13
L_93daba:
	j_s.d [blink]
L_93dabc:
	pop_s r13
L_93dabe:
	nop_s
