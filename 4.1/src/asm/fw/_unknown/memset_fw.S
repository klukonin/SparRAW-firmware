/* memset_fw @ 0x8da04c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: memset0_words
 */
	.section .text.memset_fw,"ax",@progbits
	.global memset_fw
memset_fw:
	.global L_8da04c
L_8da04c:
	push_s r13
L_8da04e:
	extb_s r1,r1
L_8da050:
	asl r3,r1,0x8
L_8da054:
	or_s r3,r3,r1
L_8da056:
	asl r1,r3,0x10
L_8da05a:
	or_s r1,r1,r3
L_8da05c:
	brlo.d r2,0x8,L_8da080
L_8da060:
	mov_s r3,r0
L_8da062:
	b_s L_8da06a
	.global L_8da064
L_8da064:
	stb.ab r1,[r3,0x1]
L_8da068:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
	.global L_8da06a
L_8da06a:
	bmsk.f 0x0,r3,0x1
L_8da06e:
	bne_s L_8da064
L_8da070:
	lsr r13,r2,0x2
L_8da074:
	bmsk_s r2,r2,0x1
	.global L_8da076
L_8da076:
	sub.f r13,r13,0x1
L_8da07a:
	st.ab r1,[r3,0x4]
L_8da07e:
	bne_s L_8da076
	.global L_8da080
L_8da080:
	cmp_s r2,0x0
L_8da082:
	mov.ne lp_count,r2
L_8da086:
	nop_s
L_8da088:
	lpne L_8da092
L_8da08c:
	stb.ab r1,[r3,0x1]
L_8da090:
	nop_s
	.global L_8da092
L_8da092:
	j_s.d [blink]
L_8da094:
	pop_s r13
L_8da096:
	nop_s
