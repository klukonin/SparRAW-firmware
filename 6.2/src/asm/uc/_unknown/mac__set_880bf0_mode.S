/* mac__set_880bf0_mode @ 0x928d78, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__bring_up_phy_dma
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__set_880bf0_mode
mac__set_880bf0_mode:
	.global L_928d78
L_928d78:
	st.a r13,[sp,-0x8]
L_928d7c:
	st_s r14,[sp,0x4]
L_928d7e:
	mov_s r14,blink
L_928d80:
	mov.f r13,r0
L_928d84:
	cmp.ne r13,0x1
L_928d88:
	cmp.ne r13,0x2
L_928d8c:
	beq L_928d98
L_928d90:
	breq r13,0x3,L_928dbc
L_928d94:
	brne r13,0x4,L_928dbc
	.global L_928d98
L_928d98:
	asl_s r1,r13,0x4
L_928d9a:
	mov_s r2,0x880800
L_928da0:
	ld.as r0,[r2,0xfc]
L_928da4:
	or_s r13,r13,r1
L_928da6:
	bic r0,r0,0xff
L_928daa:
	extb_s r13,r13
L_928dac:
	or_s r0,r0,r13
L_928dae:
	st.as r0,[r2,0xfc]
L_928db2:
	mov_s blink,r14
L_928db4:
	ld_s r14,[sp,0x4]
L_928db6:
	j_s.d [blink]
L_928db8:
	ld.ab r13,[sp,0x8]
	.global L_928dbc
L_928dbc:
	mov_s r0,blink
L_928dbe:
	mov_s r1,0x12d7
L_928dc4:
	bl L_926618
L_928dc8:
	b_s L_928d98
L_928dca:
	nop_s
