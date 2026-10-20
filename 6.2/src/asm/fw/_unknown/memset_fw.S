/* memset_fw @ 0x8ddf84, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: memset0_words, obj_vt8005c4__ctor, rf__get_module_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global memset_fw
memset_fw:
	.global L_8ddf84
L_8ddf84:
	push_s r13
L_8ddf86:
	extb_s r1,r1
L_8ddf88:
	asl r3,r1,0x8
L_8ddf8c:
	or_s r3,r3,r1
L_8ddf8e:
	asl r1,r3,0x10
L_8ddf92:
	or_s r1,r1,r3
L_8ddf94:
	brlo.d r2,0x8,L_8ddfb8
L_8ddf98:
	mov_s r3,r0
L_8ddf9a:
	b_s L_8ddfa2
	.global L_8ddf9c
L_8ddf9c:
	stb.ab r1,[r3,0x1]
L_8ddfa0:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
	.global L_8ddfa2
L_8ddfa2:
	bmsk.f 0x0,r3,0x1
L_8ddfa6:
	bne_s L_8ddf9c
L_8ddfa8:
	lsr r13,r2,0x2
L_8ddfac:
	bmsk_s r2,r2,0x1
	.global L_8ddfae
L_8ddfae:
	sub.f r13,r13,0x1
L_8ddfb2:
	st.ab r1,[r3,0x4]
L_8ddfb6:
	bne_s L_8ddfae
	.global L_8ddfb8
L_8ddfb8:
	cmp_s r2,0x0
L_8ddfba:
	mov.ne lp_count,r2
L_8ddfbe:
	nop_s
L_8ddfc0:
	lpne L_8ddfca
L_8ddfc4:
	stb.ab r1,[r3,0x1]
L_8ddfc8:
	nop_s
	.global L_8ddfca
L_8ddfca:
	j_s.d [blink]
L_8ddfcc:
	pop_s r13
L_8ddfce:
	nop_s
