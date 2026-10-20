/* dma_mac__cfg_880c28 @ 0x926e8c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mac_setup_step
 */
	.section .text.dma_mac__cfg_880c28,"ax",@progbits
	.global dma_mac__cfg_880c28
dma_mac__cfg_880c28:
	.global L_926e8c
L_926e8c:
	mov r6,0xfffc0000
L_926e94:
	mov r7,0x880800
L_926e9c:
	mov r8,0x881000
L_926ea4:
	breq_s r0,0,L_926ed0
L_926ea6:
	ld.as r5,[r7,0xbd]
L_926eaa:
	bmsk r5,r5,0x11
L_926eae:
	or r5,r5,r6
L_926eb2:
	st.as r5,[r7,0xbd]
L_926eb6:
	ld.as r1,[r7,0xbe]
L_926eba:
	or r1,r1,0x3f
L_926ebe:
	st.as r1,[r7,0xbe]
L_926ec2:
	ld.as r0,[r8,-0xf6]
L_926ec6:
	or r0,r0,0xf
L_926eca:
	st.as r0,[r8,-0xf6]
L_926ece:
	j_s [blink]
	.global L_926ed0
L_926ed0:
	ld.as r3,[r7,0xbd]
L_926ed4:
	bmsk_s r3,r3,0x11
L_926ed6:
	st.as r3,[r7,0xbd]
L_926eda:
	ld.as r4,[r7,0xbe]
L_926ede:
	bic r4,r4,0x3f
L_926ee2:
	st.as r4,[r7,0xbe]
L_926ee6:
	ld.as r2,[r8,-0xf6]
L_926eea:
	bic r2,r2,0xf
L_926eee:
	st.as r2,[r8,-0xf6]
L_926ef2:
	j_s [blink]
