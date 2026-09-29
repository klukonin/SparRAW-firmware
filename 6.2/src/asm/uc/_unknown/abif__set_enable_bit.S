/* abif__set_enable_bit @ 0x928b4c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__set_normal_mode
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global abif__set_enable_bit
abif__set_enable_bit:
	.global L_928b4c
L_928b4c:
	st.a r13,[sp,-0x8]
L_928b50:
	mov_s r13,r0
L_928b52:
	bclr.f r0,r0,0x0
L_928b56:
	st_s r14,[sp,0x4]
L_928b58:
	bne.d L_928b7c
L_928b5c:
	mov r14,blink
	.global L_928b60
L_928b60:
	mov_s r1,0x88b000
L_928b66:
	ld.as r0,[r1,-0x7e]
L_928b6a:
	mov_s blink,r14
L_928b6c:
	bclr_s r0,r0,0x0
L_928b6e:
	or_s r13,r13,r0
L_928b70:
	st.as r13,[r1,-0x7e]
L_928b74:
	ld_s r14,[sp,0x4]
L_928b76:
	j_s.d [blink]
L_928b78:
	ld.ab r13,[sp,0x8]
	.global L_928b7c
L_928b7c:
	mov r0,blink
L_928b80:
	bl.d L_926618
L_928b84:
	mov r1,0xac
L_928b88:
	b_s L_928b60
L_928b8a:
	nop_s
