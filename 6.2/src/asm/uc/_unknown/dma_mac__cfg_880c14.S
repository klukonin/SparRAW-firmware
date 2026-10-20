/* dma_mac__cfg_880c14 @ 0x929424, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__bring_up_phy_dma
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dma_mac__cfg_880c14
dma_mac__cfg_880c14:
	.global L_929424
L_929424:
	mov r8,0x3a000
L_92942c:
	mov r4,0x3ff7ff
L_929434:
	mov r10,0x881000
L_92943c:
	mov_s r2,0xffc00800
L_929442:
	mov r9,0x880800
L_92944a:
	mov r6,0xfffc5fff
L_929452:
	breq_s r0,0,L_929474
L_929454:
	ld.as r3,[r10,-0xfb]
L_929458:
	and_s r2,r2,r3
L_92945a:
	or r2,r2,r4
L_92945e:
	st.as r2,[r10,-0xfb]
L_929462:
	ld.as r7,[r9,0xbd]
L_929466:
	and r6,r6,r7
L_92946a:
	or r6,r6,r8
L_92946e:
	st.as r6,[r9,0xbd]
L_929472:
	j_s [blink]
	.global L_929474
L_929474:
	ld.as r1,[r10,-0xfb]
L_929478:
	and_s r1,r1,r2
L_92947a:
	st.as r1,[r10,-0xfb]
L_92947e:
	ld.as r5,[r9,0xbd]
L_929482:
	and r5,r5,r6
L_929486:
	st.as r5,[r9,0xbd]
L_92948a:
	j_s [blink]
