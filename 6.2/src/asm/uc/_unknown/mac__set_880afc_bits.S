/* mac__set_880afc_bits @ 0x928dcc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__bring_up_phy_dma
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__set_880afc_bits
mac__set_880afc_bits:
	.global L_928dcc
L_928dcc:
	mov_s r3,0xbc
L_928dce:
	mov r4,0x880800
L_928dd6:
	mov_s r1,0x43ffffff
L_928ddc:
	breq.d r0,0x0,L_928df0
L_928de0:
	asl_s r3,r3,0x18
L_928de2:
	ld.as r2,[r4,0xbf]
L_928de6:
	and_s r1,r1,r2
L_928de8:
	or_s r1,r1,r3
L_928dea:
	st.as r1,[r4,0xbf]
L_928dee:
	j_s [blink]
	.global L_928df0
L_928df0:
	ld.as r0,[r4,0xbf]
L_928df4:
	and_s r0,r0,r1
L_928df6:
	st.as r0,[r4,0xbf]
L_928dfa:
	j_s [blink]
