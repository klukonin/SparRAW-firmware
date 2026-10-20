/* hwd_phy__rgf_881000 @ 0x926fc4, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mac_setup_step
 */
	.section .text.hwd_phy__rgf_881000,"ax",@progbits
	.global hwd_phy__rgf_881000
hwd_phy__rgf_881000:
	.global L_926fc4
L_926fc4:
	mov r6,0x881000
L_926fcc:
	breq_s r0,0,L_926ff0
L_926fce:
	ld.as r5,[r6,-0xe2]
L_926fd2:
	bclr r5,r5,0x3
L_926fd6:
	st.as r5,[r6,-0xe2]
L_926fda:
	ld.as r3,[r6,-0xe2]
L_926fde:
	bclr_s r3,r3,0x4
L_926fe0:
	st.as r3,[r6,-0xe2]
L_926fe4:
	ld.as r0,[r6,-0xe2]
L_926fe8:
	bclr_s r0,r0,0x5
L_926fea:
	st.as r0,[r6,-0xe2]
L_926fee:
	j_s [blink]
	.global L_926ff0
L_926ff0:
	ld.as r2,[r6,-0xe2]
L_926ff4:
	bset_s r2,r2,0x3
L_926ff6:
	st.as r2,[r6,-0xe2]
L_926ffa:
	ld.as r1,[r6,-0xe2]
L_926ffe:
	bset_s r1,r1,0x4
L_927000:
	st.as r1,[r6,-0xe2]
L_927004:
	ld.as r4,[r6,-0xe2]
L_927008:
	bset r4,r4,0x5
L_92700c:
	st.as r4,[r6,-0xe2]
L_927010:
	j_s [blink]
L_927012:
	nop_s
