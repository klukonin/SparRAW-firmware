/* rgf_reg_880800 @ 0x926b60, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mac_setup_step
 */
	.section .text.rgf_reg_880800,"ax",@progbits
	.global rgf_reg_880800
rgf_reg_880800:
	.global L_926b60
L_926b60:
	mov_s r3,0xbc
L_926b62:
	mov r4,0x880800
L_926b6a:
	mov_s r1,0x43ffffff
L_926b70:
	breq.d r0,0x0,L_926b84
L_926b74:
	asl_s r3,r3,0x18
L_926b76:
	ld.as r2,[r4,0xbf]
L_926b7a:
	and_s r1,r1,r2
L_926b7c:
	or_s r1,r1,r3
L_926b7e:
	st.as r1,[r4,0xbf]
L_926b82:
	j_s [blink]
	.global L_926b84
L_926b84:
	ld.as r0,[r4,0xbf]
L_926b88:
	and_s r0,r0,r1
L_926b8a:
	st.as r0,[r4,0xbf]
L_926b8e:
	j_s [blink]
