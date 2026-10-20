/* itx__wait_cts_b @ 0x93dfb0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm2
 * Зовёт сам: rx__ppdu_is_cts_b, uc_wait_event1_or_event4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global itx__wait_cts_b
itx__wait_cts_b:
	.global L_93dfb0
L_93dfb0:
	push_s blink
L_93dfb2:
	mov_s r0,0x2011000
L_93dfb8:
	mov_s r32,r0
L_93dfba:
	st.ab r0,[r25,0x4]
L_93dfbe:
	bclr r25,r25,0xa
	.global L_93dfc2
L_93dfc2:
	mov_s r0,0x0
L_93dfc4:
	bset_s r0,r0,0xc
L_93dfc6:
	mov_s r1,0x40
L_93dfc8:
	bl.d L_9367e4
L_93dfcc:
	mov_s r2,0x0
L_93dfce:
	mov_s r0,r42
L_93dfd0:
	bbit0 r0,0xc,L_93dfde
L_93dfd4:
	bl L_92e388
L_93dfd8:
	breq_s r0,0,L_93dfc2
L_93dfda:
	mov_s r0,0x1
L_93dfdc:
	b_s L_93dfe6
	.global L_93dfde
L_93dfde:
	mov_s r0,r54
L_93dfe0:
	bbit0 r0,0x6,L_93dfc2
L_93dfe4:
	mov_s r0,0x0
	.global L_93dfe6
L_93dfe6:
	pop_s blink
L_93dfe8:
	j_s [blink]
L_93dfea:
	nop_s
