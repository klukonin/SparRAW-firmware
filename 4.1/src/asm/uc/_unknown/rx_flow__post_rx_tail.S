/* rx_flow__post_rx_tail @ 0x92ea78, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame, rx_flow__post_rx_act1, rx_flow__post_rx_act2, rx_flow__post_rx_act3, rx_flow__post_rx_act7, rx_flow__post_rx_act8, rx_flow__post_rx_act9
 */
	.section .text.rx_flow__post_rx_tail,"ax",@progbits
	.global rx_flow__post_rx_tail
rx_flow__post_rx_tail:
	.global L_92ea78
L_92ea78:
	mov r6,0x14000000
L_92ea80:
	mov r32,r6
L_92ea84:
	st.ab r6,[r25,0x4]
L_92ea88:
	bclr r25,r25,0xa
L_92ea8c:
	ld r7,[r14, 0x20]
L_92ea90:
	brne r7,0x2,L_92eaa0
L_92ea94:
	mov r2,0x1
L_92ea98:
	b.d L_92eaac
L_92ea9c:
	stb r2,[gp, -0xfb]
	.global L_92eaa0
L_92eaa0:
	brne r7,0x1,L_92eaac
L_92eaa4:
	mov r3,0x1
L_92eaa8:
	stb r3,[gp, -0xfc]
	.global L_92eaac
L_92eaac:
	add_s sp,sp,0x8
L_92eaae:
	ld blink,[sp, 0x4]
L_92eab2:
	ld_s r14,[sp,0x8]
L_92eab4:
	ld_s r15,[sp,0xc]
L_92eab6:
	ld r16,[sp, 0x10]
L_92eaba:
	j_s.d [blink]
L_92eabc:
	ld.ab r13,[sp,0x14]
