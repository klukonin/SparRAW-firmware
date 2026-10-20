/* dma_mac__cfg_880c14 @ 0x926c68, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mac_setup_step
 */
	.section .text.dma_mac__cfg_880c14,"ax",@progbits
	.global dma_mac__cfg_880c14
dma_mac__cfg_880c14:
	.global L_926c68
L_926c68:
	mov r8,0x3a000
L_926c70:
	mov r4,0x3ff7ff
L_926c78:
	mov r10,0x881000
L_926c80:
	mov_s r2,0xffc00800
L_926c86:
	mov r9,0x880800
L_926c8e:
	mov r6,0xfffc5fff
L_926c96:
	breq_s r0,0,L_926cb8
L_926c98:
	ld.as r3,[r10,-0xfb]
L_926c9c:
	and_s r2,r2,r3
L_926c9e:
	or r2,r2,r4
L_926ca2:
	st.as r2,[r10,-0xfb]
L_926ca6:
	ld.as r7,[r9,0xbd]
L_926caa:
	and r6,r6,r7
L_926cae:
	or r6,r6,r8
L_926cb2:
	st.as r6,[r9,0xbd]
L_926cb6:
	j_s [blink]
	.global L_926cb8
L_926cb8:
	ld.as r1,[r10,-0xfb]
L_926cbc:
	and_s r1,r1,r2
L_926cbe:
	st.as r1,[r10,-0xfb]
L_926cc2:
	ld.as r5,[r9,0xbd]
L_926cc6:
	and r5,r5,r6
L_926cca:
	st.as r5,[r9,0xbd]
L_926cce:
	j_s [blink]
