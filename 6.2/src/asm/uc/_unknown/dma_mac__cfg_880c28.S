/* dma_mac__cfg_880c28 @ 0x92961c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__bring_up_phy_dma
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dma_mac__cfg_880c28
dma_mac__cfg_880c28:
	.global L_92961c
L_92961c:
	mov r6,0xfffc0000
L_929624:
	mov r7,0x880800
L_92962c:
	mov r8,0x881000
L_929634:
	breq_s r0,0,L_929660
L_929636:
	ld.as r5,[r7,0xbd]
L_92963a:
	bmsk r5,r5,0x11
L_92963e:
	or r5,r5,r6
L_929642:
	st.as r5,[r7,0xbd]
L_929646:
	ld.as r1,[r7,0xbe]
L_92964a:
	or r1,r1,0x3f
L_92964e:
	st.as r1,[r7,0xbe]
L_929652:
	ld.as r0,[r8,-0xf6]
L_929656:
	or r0,r0,0xf
L_92965a:
	st.as r0,[r8,-0xf6]
L_92965e:
	j_s [blink]
	.global L_929660
L_929660:
	ld.as r3,[r7,0xbd]
L_929664:
	bmsk_s r3,r3,0x11
L_929666:
	st.as r3,[r7,0xbd]
L_92966a:
	ld.as r4,[r7,0xbe]
L_92966e:
	bic r4,r4,0x3f
L_929672:
	st.as r4,[r7,0xbe]
L_929676:
	ld.as r2,[r8,-0xf6]
L_92967a:
	bic r2,r2,0xf
L_92967e:
	st.as r2,[r8,-0xf6]
L_929682:
	j_s [blink]
