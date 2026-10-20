/* itx__wait_ack_rf @ 0x93dbec, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm4
 * Зовёт сам: __ld_r13_to_r13_ret, rx__ppdu_is_ack_b, uc_wait_event1_or_event4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global itx__wait_ack_rf
itx__wait_ack_rf:
	.global L_93dbec
L_93dbec:
	push_s blink
L_93dbee:
	push_s r13
L_93dbf0:
	mov_s r0,0x2011000
L_93dbf6:
	mov_s r32,r0
L_93dbf8:
	st.ab r0,[r25,0x4]
L_93dbfc:
	bclr r25,r25,0xa
	.global L_93dc00
L_93dc00:
	mov_s r0,0x0
L_93dc02:
	bset_s r0,r0,0xc
L_93dc04:
	mov_s r1,0x40
L_93dc06:
	bl.d L_9367e4
L_93dc0a:
	mov_s r2,0x0
L_93dc0c:
	mov_s r0,r42
L_93dc0e:
	bbit0 r0,0xc,L_93dc68
L_93dc12:
	mov_s r0,0x1f006000
L_93dc18:
	mov_s r32,r0
L_93dc1a:
	st.ab r0,[r25,0x4]
L_93dc1e:
	bclr r25,r25,0xa
L_93dc22:
	mov_s r0,0x38000300
L_93dc28:
	mov_s r32,r0
L_93dc2a:
	st.ab r0,[r25,0x4]
L_93dc2e:
	bclr r25,r25,0xa
L_93dc32:
	mov_s r0,0x3600003f
L_93dc38:
	mov_s r32,r0
L_93dc3a:
	st.ab r0,[r25,0x4]
L_93dc3e:
	bclr r25,r25,0xa
L_93dc42:
	mov_s r0,0x6000101
L_93dc48:
	mov_s r32,r0
L_93dc4a:
	st.ab r0,[r25,0x4]
L_93dc4e:
	bclr r25,r25,0xa
L_93dc52:
	mov_s r13,0x1
L_93dc54:
	mov_s r0,0x802aa0
L_93dc5a:
	bl.d L_92e2bc
L_93dc5e:
	st_s r13,[r0,0x4]
L_93dc60:
	breq r0,0x0,L_93dc00
L_93dc64:
	mov_s r0,r13
L_93dc66:
	b_s L_93dc7c
	.global L_93dc68
L_93dc68:
	mov_s r0,r54
L_93dc6a:
	bbit0 r0,0x6,L_93dc00
L_93dc6e:
	mov_s r1,0x802aa0
L_93dc74:
	ld_s r0,[r1,0x8]
L_93dc76:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93dc78:
	st_s r0,[r1,0x8]
L_93dc7a:
	mov_s r0,0x0
	.global L_93dc7c
L_93dc7c:
	b L_9202ac
