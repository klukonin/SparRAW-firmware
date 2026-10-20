/* dma_mac__cfg_880c2c @ 0x927250, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mac_setup_step
 */
	.section .text.dma_mac__cfg_880c2c,"ax",@progbits
	.global dma_mac__cfg_880c2c
dma_mac__cfg_880c2c:
	.global L_927250
L_927250:
	mov r6,0xfffc0000
L_927258:
	mov r7,0x880800
L_927260:
	mov r8,0x881000
L_927268:
	breq_s r0,0,L_927294
L_92726a:
	ld.as r4,[r7,0xc2]
L_92726e:
	or r4,r4,0x3f
L_927272:
	st.as r4,[r7,0xc2]
L_927276:
	ld.as r5,[r7,0xc1]
L_92727a:
	bmsk r5,r5,0x11
L_92727e:
	or r5,r5,r6
L_927282:
	st.as r5,[r7,0xc1]
L_927286:
	ld.as r0,[r8,-0xf5]
L_92728a:
	or r0,r0,0xf
L_92728e:
	st.as r0,[r8,-0xf5]
L_927292:
	j_s [blink]
	.global L_927294
L_927294:
	ld.as r3,[r7,0xc2]
L_927298:
	bic r3,r3,0x3f
L_92729c:
	st.as r3,[r7,0xc2]
L_9272a0:
	ld.as r2,[r7,0xc1]
L_9272a4:
	bmsk_s r2,r2,0x11
L_9272a6:
	st.as r2,[r7,0xc1]
L_9272aa:
	ld.as r1,[r8,-0xf5]
L_9272ae:
	bic r1,r1,0xf
L_9272b2:
	st.as r1,[r8,-0xf5]
L_9272b6:
	j_s [blink]
