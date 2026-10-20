/* hwd_phy__uses_rgf_881000_9296e0 @ 0x9296e0, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__bring_up_phy_dma
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__uses_rgf_881000_9296e0
hwd_phy__uses_rgf_881000_9296e0:
	.global L_9296e0
L_9296e0:
	mov r6,0x881000
L_9296e8:
	breq_s r0,0,L_92970c
L_9296ea:
	ld.as r5,[r6,-0xe2]
L_9296ee:
	bclr r5,r5,0x3
L_9296f2:
	st.as r5,[r6,-0xe2]
L_9296f6:
	ld.as r3,[r6,-0xe2]
L_9296fa:
	bclr_s r3,r3,0x4
L_9296fc:
	st.as r3,[r6,-0xe2]
L_929700:
	ld.as r0,[r6,-0xe2]
L_929704:
	bclr_s r0,r0,0x5
L_929706:
	st.as r0,[r6,-0xe2]
L_92970a:
	j_s [blink]
	.global L_92970c
L_92970c:
	ld.as r2,[r6,-0xe2]
L_929710:
	bset_s r2,r2,0x3
L_929712:
	st.as r2,[r6,-0xe2]
L_929716:
	ld.as r1,[r6,-0xe2]
L_92971a:
	bset_s r1,r1,0x4
L_92971c:
	st.as r1,[r6,-0xe2]
L_929720:
	ld.as r4,[r6,-0xe2]
L_929724:
	bset r4,r4,0x5
L_929728:
	st.as r4,[r6,-0xe2]
L_92972c:
	j_s [blink]
L_92972e:
	nop_s
