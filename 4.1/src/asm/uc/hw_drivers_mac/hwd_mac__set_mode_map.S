/* hwd_mac__set_mode_map @ 0x926d34, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_mac.c
 * Зовут его: dma_mac_setup_step
 * Зовёт сам: uc_sysassert
 */
	.section .text.hwd_mac__set_mode_map,"ax",@progbits
	.global hwd_mac__set_mode_map
hwd_mac__set_mode_map:
	.global L_926d34
L_926d34:
	st.a r13,[sp,-0x8]
L_926d38:
	st_s r14,[sp,0x4]
L_926d3a:
	mov_s r14,blink
L_926d3c:
	mov.f r13,r0
L_926d40:
	cmp.ne r13,0x1
L_926d44:
	cmp.ne r13,0x2
L_926d48:
	beq L_926d54
L_926d4c:
	breq r13,0x3,L_926db4
L_926d50:
	brne r13,0x4,L_926db4
	.global L_926d54
L_926d54:
	asl r6,r13,0x4
L_926d58:
	or r6,r6,r13
L_926d5c:
	asl r5,r13,0x8
L_926d60:
	or r5,r5,r6
L_926d64:
	asl r4,r13,0xc
L_926d68:
	or r4,r4,r5
L_926d6c:
	asl r3,r13,0x10
L_926d70:
	or r3,r3,r4
L_926d74:
	asl r2,r13,0x14
L_926d78:
	or_s r2,r2,r3
L_926d7a:
	asl r1,r13,0x18
L_926d7e:
	or_s r1,r1,r2
L_926d80:
	asl_s r13,r13,0x1c
L_926d82:
	or_s r1,r1,r13
L_926d84:
	mov r8,0x886000
L_926d8c:
	st r1,[r8, 0xfc]
L_926d90:
	st.as r1,[r8,0x40]
L_926d94:
	bmsk r7,r1,0x13
L_926d98:
	st.as r7,[r8,0x41]
L_926d9c:
	st.as r1,[r8,0x42]
L_926da0:
	st.as r1,[r8,0x43]
L_926da4:
	bmsk_s r1,r1,0x17
L_926da6:
	st.as r1,[r8,0x44]
L_926daa:
	mov_s blink,r14
L_926dac:
	ld_s r14,[sp,0x4]
L_926dae:
	j_s.d [blink]
L_926db0:
	ld.ab r13,[sp,0x8]
	.global L_926db4
L_926db4:
	mov_s r0,blink
L_926db6:
	mov_s r2,0x10037c4
L_926dbc:
	mov r1,0x12db
L_926dc4:
	bl.d L_925548
L_926dc8:
	mov r3,0x85
L_926dcc:
	b_s L_926d54
L_926dce:
	nop_s
