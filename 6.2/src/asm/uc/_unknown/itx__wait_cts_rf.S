/* itx__wait_cts_rf @ 0x93dfec, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm4
 * Зовёт сам: __ld_r13_to_r13_ret, rx__ppdu_is_cts_c, uc_wait_event1_or_event4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global itx__wait_cts_rf
itx__wait_cts_rf:
	.global L_93dfec
L_93dfec:
	push_s blink
L_93dfee:
	push_s r13
L_93dff0:
	mov_s r0,0x2011000
L_93dff6:
	mov_s r32,r0
L_93dff8:
	st.ab r0,[r25,0x4]
L_93dffc:
	bclr r25,r25,0xa
	.global L_93e000
L_93e000:
	mov_s r0,0x0
L_93e002:
	bset_s r0,r0,0xc
L_93e004:
	mov_s r1,0x40
L_93e006:
	bl.d L_9367e4
L_93e00a:
	mov_s r2,0x0
L_93e00c:
	mov_s r0,0xa
L_93e00e:
	mov lp_count,r0
L_93e012:
	nop_s
L_93e014:
	lp L_93e01c
L_93e018:
	nop_s
L_93e01a:
	nop_s
	.global L_93e01c
L_93e01c:
	mov_s r0,r42
L_93e01e:
	bbit0 r0,0xc,L_93e078
L_93e022:
	mov_s r0,0x1f006000
L_93e028:
	mov_s r32,r0
L_93e02a:
	st.ab r0,[r25,0x4]
L_93e02e:
	bclr r25,r25,0xa
L_93e032:
	mov_s r0,0x38000300
L_93e038:
	mov_s r32,r0
L_93e03a:
	st.ab r0,[r25,0x4]
L_93e03e:
	bclr r25,r25,0xa
L_93e042:
	mov_s r0,0x3600003f
L_93e048:
	mov_s r32,r0
L_93e04a:
	st.ab r0,[r25,0x4]
L_93e04e:
	bclr r25,r25,0xa
L_93e052:
	mov_s r0,0x6000101
L_93e058:
	mov_s r32,r0
L_93e05a:
	st.ab r0,[r25,0x4]
L_93e05e:
	bclr r25,r25,0xa
L_93e062:
	mov_s r13,0x1
L_93e064:
	mov_s r0,0x802aa0
L_93e06a:
	bl.d L_92e3e0
L_93e06e:
	st_s r13,[r0,0x4]
L_93e070:
	breq r0,0x0,L_93e000
L_93e074:
	mov_s r0,r13
L_93e076:
	b_s L_93e080
	.global L_93e078
L_93e078:
	mov_s r0,r54
L_93e07a:
	bbit0 r0,0x6,L_93e000
L_93e07e:
	mov_s r0,0x0
	.global L_93e080
L_93e080:
	b L_9202ac
