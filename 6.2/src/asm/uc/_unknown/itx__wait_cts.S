/* itx__wait_cts @ 0x93df4c, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm6
 * Зовёт сам: rx__ppdu_is_cts, uc_wait_event1_or_event4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global itx__wait_cts
itx__wait_cts:
	.global L_93df4c
L_93df4c:
	st.a r13,[sp,-0xc]
L_93df50:
	st blink,[sp, 0x4]
L_93df54:
	st_s r14,[sp,0x8]
L_93df56:
	mov_s r13,r0
L_93df58:
	mov_s r14,0x0
L_93df5a:
	mov_s r2,0x2011000
L_93df60:
	mov r32,r2
L_93df64:
	st.ab r2,[r25,0x4]
L_93df68:
	bclr r25,r25,0xa
	.global L_93df6c
L_93df6c:
	mov_s r0,0x0
L_93df6e:
	bset_s r0,r0,0xc
L_93df70:
	mov r1,0x40
L_93df74:
	bl.d L_9367e4
L_93df78:
	mov r2,0x0
L_93df7c:
	mov r1,r42
L_93df80:
	bbit0 r1,0xc,L_93df98
L_93df84:
	bl.d L_92e318
L_93df88:
	mov r0,r13
L_93df8c:
	breq r0,0x0,L_93df6c
L_93df90:
	b.d L_93dfa0
L_93df94:
	mov r14,0x1
	.global L_93df98
L_93df98:
	mov r0,r54
L_93df9c:
	bbit0 r0,0x6,L_93df6c
	.global L_93dfa0
L_93dfa0:
	ld blink,[sp, 0x4]
L_93dfa4:
	mov_s r0,r14
L_93dfa6:
	ld_s r14,[sp,0x8]
L_93dfa8:
	j.d [blink]
L_93dfac:
	ld.ab r13,[sp,0xc]
