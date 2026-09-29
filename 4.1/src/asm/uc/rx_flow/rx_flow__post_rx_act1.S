/* rx_flow__post_rx_act1 @ 0x92e7d8, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: mtp_service__dispatch, rx_flow__post_rx_tail, rx_rfc_step
 * Глобалы (через gp): 0x800610, 0x800614
 */
	.section .text.rx_flow__post_rx_act1,"ax",@progbits
	.global rx_flow__post_rx_act1
rx_flow__post_rx_act1:
L_92e7d8:
	ld_s r1,[r14]
L_92e7da:
	mov_s r0,0x0
L_92e7dc:
	ld r2,[r14, 0x8]
L_92e7e0:
	bl.d L_92a404
L_92e7e4:
	mov r3,0xff
	.global L_92e7e8
L_92e7e8:
	mov r0,r43
L_92e7ec:
	bbit0 r0,0x1f,L_92e7e8
L_92e7f0:
	mov r9,r51
L_92e7f4:
	bmsk r3,r9,0x3
L_92e7f8:
	st.as r3,[gp,0x3a]
L_92e7fc:
	lsr r9,r9,0x4
L_92e800:
	st.as r9,[gp,0x3b]
L_92e804:
	lsr r11,r43,0x10
L_92e808:
	bmsk r11,r11,0x4
L_92e80c:
	asl r11,r11,0x4
L_92e810:
	or r9,r11,0x3e000000
L_92e818:
	mov r32,r9
L_92e81c:
	st.ab r9,[r25,0x4]
L_92e820:
	bclr r25,r25,0xa
L_92e824:
	mov r6,0x37000020
L_92e82c:
	mov r32,r6
L_92e830:
	st.ab r6,[r25,0x4]
L_92e834:
	bclr r25,r25,0xa
L_92e838:
	mov r10,0x801458
L_92e840:
	ld r0,[r10, 0xc]
L_92e844:
	mov r7,0x2008000
L_92e84c:
	add r0,r0,0x1
L_92e850:
	st r0,[r10, 0xc]
L_92e854:
	mov r32,r7
L_92e858:
	st.ab r7,[r25,0x4]
L_92e85c:
	bclr r25,r25,0xa
L_92e860:
	mov r8,0x19000001
L_92e868:
	mov r32,r8
L_92e86c:
	st.ab r8,[r25,0x4]
L_92e870:
	bclr r25,r25,0xa
	.global L_92e874
L_92e874:
	mov r8,r45
L_92e878:
	bbit0 r8,0x1f,L_92e874
L_92e87c:
	mov_s r2,0x18
L_92e87e:
	asl_s r2,r2,0x18
L_92e880:
	mov r32,r2
L_92e884:
	st.ab r2,[r25,0x4]
L_92e888:
	bclr r25,r25,0xa
L_92e88c:
	mov r0,r14
L_92e890:
	bl.d L_92f12c
L_92e894:
	mov r1,0x0
L_92e898:
	b L_92ea78
