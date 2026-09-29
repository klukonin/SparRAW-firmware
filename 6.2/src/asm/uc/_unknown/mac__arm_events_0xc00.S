/* mac__arm_events_0xc00 @ 0x93e084, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched__tx_ctrl_frame
 * Зовёт сам: uc_wait_event1_or_event4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__arm_events_0xc00
mac__arm_events_0xc00:
	.global L_93e084
L_93e084:
	push_s blink
L_93e086:
	ld_s r0,[gp,-0x48]
L_93e088:
	or r0,r0,0x27000c00
L_93e090:
	mov_s r32,r0
L_93e092:
	st.ab r0,[r25,0x4]
L_93e096:
	bclr r25,r25,0xa
L_93e09a:
	mov_s r0,0x2004000
L_93e0a0:
	mov_s r32,r0
L_93e0a2:
	st.ab r0,[r25,0x4]
L_93e0a6:
	bclr r25,r25,0xa
L_93e0aa:
	mov_s r0,0x49000040
L_93e0b0:
	mov_s r32,r0
L_93e0b2:
	st.ab r0,[r25,0x4]
L_93e0b6:
	bclr r25,r25,0xa
	.global L_93e0ba
L_93e0ba:
	mov_s r0,0x0
L_93e0bc:
	bset_s r0,r0,0xe
L_93e0be:
	mov_s r1,0x40
L_93e0c0:
	bl.d L_9367e4
L_93e0c4:
	mov_s r2,0x0
L_93e0c6:
	mov_s r0,r42
L_93e0c8:
	bbit1 r0,0xe,L_93e0d6
L_93e0cc:
	mov_s r0,r54
L_93e0ce:
	bbit0 r0,0x6,L_93e0ba
L_93e0d2:
	mov_s r0,0x0
L_93e0d4:
	b_s L_93e0d8
	.global L_93e0d6
L_93e0d6:
	mov_s r0,0x1
	.global L_93e0d8
L_93e0d8:
	pop_s blink
L_93e0da:
	j_s [blink]
