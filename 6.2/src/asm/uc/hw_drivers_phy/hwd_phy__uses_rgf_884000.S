/* hwd_phy__uses_rgf_884000 @ 0x92999c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__set_normal_mode
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__uses_rgf_884000
hwd_phy__uses_rgf_884000:
	.global L_92999c
L_92999c:
	st.a r13,[sp,-0x8]
L_9299a0:
	mov_s r13,r0
L_9299a2:
	bclr.f r0,r0,0x0
L_9299a6:
	st_s r14,[sp,0x4]
L_9299a8:
	bne.d L_9299c8
L_9299ac:
	mov r14,blink
	.global L_9299b0
L_9299b0:
	mov_s r1,0x884000
L_9299b6:
	ld_s r0,[r1,0x8]
L_9299b8:
	mov_s blink,r14
L_9299ba:
	bclr_s r0,r0,0x0
L_9299bc:
	or_s r13,r13,r0
L_9299be:
	st_s r13,[r1,0x8]
L_9299c0:
	ld_s r14,[sp,0x4]
L_9299c2:
	j_s.d [blink]
L_9299c4:
	ld.ab r13,[sp,0x8]
	.global L_9299c8
L_9299c8:
	mov r0,blink
L_9299cc:
	bl.d L_926618
L_9299d0:
	mov r1,0xac
L_9299d4:
	b_s L_9299b0
L_9299d6:
	nop_s
