/* ucode_cmd_0x3d_handler @ 0x924e0c, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_pending__set_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x3d_handler
ucode_cmd_0x3d_handler:
	.global L_924e0c
L_924e0c:
	push_s blink
L_924e0e:
	bl L_920230
L_924e12:
	mov_s r14,r0
L_924e14:
	mov_s r15,r1
L_924e16:
	ld_s r1,[r14]
L_924e18:
	mov_s r0,0x0
L_924e1a:
	brne r1,0x5,L_924e26
L_924e1e:
	ld_s r1,[r14,0xc]
L_924e20:
	cmp_s r1,0x2
L_924e22:
	mov.eq r0,0x1
	.global L_924e26
L_924e26:
	extb.f 0x0,r0
L_924e2a:
	beq_s L_924e98
L_924e2c:
	ld_s r0,[gp,-0x44]
L_924e2e:
	add r13,r14,0x18
L_924e32:
	and r0,r0,0xffff0fff
L_924e3a:
	bset r1,r0,0xc
L_924e3e:
	bset_s r1,r1,0xe
L_924e40:
	st.as r1,[gp,-0x11]
L_924e44:
	or r0,r0,0x1d005000
L_924e4c:
	mov_s r32,r0
L_924e4e:
	st.ab r0,[r25,0x4]
L_924e52:
	bclr r25,r25,0xa
L_924e56:
	nop_s
L_924e58:
	nop_s
L_924e5a:
	nop_s
L_924e5c:
	st r40,[r13]
L_924e60:
	ld_s r0,[gp,-0x44]
L_924e62:
	and r0,r0,0xffff0fff
L_924e6a:
	bset r1,r0,0xd
L_924e6e:
	bset_s r1,r1,0xe
L_924e70:
	or r0,r0,0x1d006000
L_924e78:
	st.as r1,[gp,-0x11]
L_924e7c:
	mov_s r32,r0
L_924e7e:
	st.ab r0,[r25,0x4]
L_924e82:
	bclr r25,r25,0xa
L_924e86:
	nop_s
L_924e88:
	nop_s
L_924e8a:
	nop_s
L_924e8c:
	st r40,[r13, 0x4]
L_924e90:
	st_s r15,[r14,0xc]
L_924e92:
	bl.d L_9216f8
L_924e96:
	mov_s r0,0x0
	.global L_924e98
L_924e98:
	b L_92029c
