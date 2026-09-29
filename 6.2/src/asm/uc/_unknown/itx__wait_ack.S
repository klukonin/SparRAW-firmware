/* itx__wait_ack @ 0x93dbb0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm2, internal_tx__flow_sm6
 * Зовёт сам: rx__ppdu_is_ack, uc_wait_event1_or_event4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global itx__wait_ack
itx__wait_ack:
	.global L_93dbb0
L_93dbb0:
	push_s blink
L_93dbb2:
	mov_s r0,0x2011000
L_93dbb8:
	mov_s r32,r0
L_93dbba:
	st.ab r0,[r25,0x4]
L_93dbbe:
	bclr r25,r25,0xa
	.global L_93dbc2
L_93dbc2:
	mov_s r0,0x0
L_93dbc4:
	bset_s r0,r0,0xc
L_93dbc6:
	mov_s r1,0x40
L_93dbc8:
	bl.d L_9367e4
L_93dbcc:
	mov_s r2,0x0
L_93dbce:
	mov_s r0,r42
L_93dbd0:
	bbit0 r0,0xc,L_93dbde
L_93dbd4:
	bl L_92e260
L_93dbd8:
	breq_s r0,0,L_93dbc2
L_93dbda:
	mov_s r0,0x1
L_93dbdc:
	b_s L_93dbe6
	.global L_93dbde
L_93dbde:
	mov_s r0,r54
L_93dbe0:
	bbit0 r0,0x6,L_93dbc2
L_93dbe4:
	mov_s r0,0x0
	.global L_93dbe6
L_93dbe6:
	pop_s blink
L_93dbe8:
	j_s [blink]
L_93dbea:
	nop_s
