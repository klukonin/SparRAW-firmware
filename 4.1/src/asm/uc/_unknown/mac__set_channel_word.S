/* mac__set_channel_word @ 0x9290b4, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode_kick
 * Глобалы (через gp): 0x8005d8
 */
	.section .text.mac__set_channel_word,"ax",@progbits
	.global mac__set_channel_word
mac__set_channel_word:
	.global L_9290b4
L_9290b4:
	st.a r13,[sp,-0x4]
L_9290b8:
	ldw.as r3,[gp,0x58]
L_9290bc:
	ldw r0,[0x801a08]
L_9290c4:
	breq.d r3,r0,L_9290f4
L_9290c8:
	mov r13,blink
L_9290cc:
	stw.as r0,[gp,0x58]
L_9290d0:
	or r0,r0,0x1730000
L_9290d8:
	st r0,[0x886d00]
L_9290e0:
	sync
L_9290e4:
	mov_s r1,0x38000200
L_9290ea:
	mov_s r32,r1
L_9290ec:
	st.ab r1,[r25,0x4]
L_9290f0:
	bclr r25,r25,0xa
	.global L_9290f4
L_9290f4:
	mov_s r2,0x3d000400
L_9290fa:
	mov_s r32,r2
L_9290fc:
	st.ab r2,[r25,0x4]
L_929100:
	bclr r25,r25,0xa
L_929104:
	mov_s blink,r13
L_929106:
	j_s.d [blink]
L_929108:
	pop_s r13
L_92910a:
	nop_s
