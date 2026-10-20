/* dma__write_881c28 @ 0x928dfc, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mask__bit_from_index_plus8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dma__write_881c28
dma__write_881c28:
	.global L_928dfc
L_928dfc:
	st.a r13,[sp,-0x8]
L_928e00:
	st_s r14,[sp,0x4]
L_928e02:
	mov_s r14,blink
L_928e04:
	lr r13,[0xa]
L_928e08:
	bclr r2,r13,0x1
L_928e0c:
	flag r2
L_928e10:
	st r0,[0x881c28]
L_928e18:
	breq r1,0x0,L_928e20
L_928e1c:
	sync
	.global L_928e20
L_928e20:
	lr r1,[0xa]
L_928e24:
	bic r13,r13,-0x3
L_928e28:
	or_s r13,r13,r1
L_928e2a:
	flag r13
L_928e2e:
	mov_s blink,r14
L_928e30:
	ld_s r14,[sp,0x4]
L_928e32:
	j_s.d [blink]
L_928e34:
	ld.ab r13,[sp,0x8]
