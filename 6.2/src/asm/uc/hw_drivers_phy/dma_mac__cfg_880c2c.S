/* dma_mac__cfg_880c2c @ 0x9298f8, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__bring_up_phy_dma
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dma_mac__cfg_880c2c
dma_mac__cfg_880c2c:
	.global L_9298f8
L_9298f8:
	mov r6,0xfffc0000
L_929900:
	mov r7,0x880800
L_929908:
	mov r8,0x881000
L_929910:
	breq_s r0,0,L_92993c
L_929912:
	ld.as r4,[r7,0xc2]
L_929916:
	or r4,r4,0x3f
L_92991a:
	st.as r4,[r7,0xc2]
L_92991e:
	ld.as r5,[r7,0xc1]
L_929922:
	bmsk r5,r5,0x11
L_929926:
	or r5,r5,r6
L_92992a:
	st.as r5,[r7,0xc1]
L_92992e:
	ld.as r0,[r8,-0xf5]
L_929932:
	or r0,r0,0xf
L_929936:
	st.as r0,[r8,-0xf5]
L_92993a:
	j_s [blink]
	.global L_92993c
L_92993c:
	ld.as r3,[r7,0xc2]
L_929940:
	bic r3,r3,0x3f
L_929944:
	st.as r3,[r7,0xc2]
L_929948:
	ld.as r2,[r7,0xc1]
L_92994c:
	bmsk_s r2,r2,0x11
L_92994e:
	st.as r2,[r7,0xc1]
L_929952:
	ld.as r1,[r8,-0xf5]
L_929956:
	bic r1,r1,0xf
L_92995a:
	st.as r1,[r8,-0xf5]
L_92995e:
	j_s [blink]
