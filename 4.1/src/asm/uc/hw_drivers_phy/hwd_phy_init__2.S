/* hwd_phy_init__2 @ 0x926ef4, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_phy_init() The Same as RESET Value: Address = 0x%08X, Data 0x%08X
 *   hw_drivers_phy.c
 * Зовут его: dma_mac_setup_step
 * Зовёт сам: uc_sysassert
 */
	.section .text.hwd_phy_init__2,"ax",@progbits
	.global hwd_phy_init__2
hwd_phy_init__2:
	.global L_926ef4
L_926ef4:
	st.a r13,[sp,-0x10]
L_926ef8:
	st_s r14,[sp,0x8]
L_926efa:
	st_s r15,[sp,0xc]
L_926efc:
	mov_s r14,0x1004398
L_926f02:
	ld r5,[r14]
L_926f06:
	mov_s r15,0xe0d0e0d
L_926f0c:
	st blink,[sp, 0x4]
L_926f10:
	breq.d r15,r5,L_926f98
L_926f14:
	mov_s r13,0x0
L_926f16:
	mov_s r11,r14
	.global L_926f18
L_926f18:
	ld r1,[r5]
L_926f1c:
	ld r0,[r11, 0x4]
L_926f20:
	brne r1,r0,L_926f80
L_926f24:
	mov r10,0x80209c
L_926f2c:
	ldb r6,[r10, 0xd]
L_926f30:
	mov r4,0x10035f8
L_926f38:
	bbit0 r6,0x1,L_926f80
L_926f3c:
	ld r3,[r10]
L_926f40:
	mov r9,0x8020b0
L_926f48:
	add_s r2,r3,0x2
L_926f4a:
	extb_s r2,r2
L_926f4c:
	add2 r2,r9,r2
L_926f50:
	st_s r1,[r2]
L_926f52:
	add r7,r3,0x1
L_926f56:
	extb r7,r7
L_926f5a:
	add2 r7,r9,r7
L_926f5e:
	st r5,[r7]
L_926f62:
	bmsk r4,r4,0x13
L_926f66:
	or r4,r4,0xa9900000
L_926f6e:
	extb r8,r3
L_926f72:
	add2 r8,r9,r8
L_926f76:
	st r4,[r8]
L_926f7a:
	/* add_s r3,0x3 */
	.byte 0x03,0xe3
L_926f7c:
	st r3,[r10]
	.global L_926f80
L_926f80:
	st r0,[r5]
L_926f84:
	add r13,r13,0x1
L_926f88:
	brhs r13,0x1f,L_926fa8
	.global L_926f8c
L_926f8c:
	add3 r11,r14,r13
L_926f90:
	ld r5,[r11]
L_926f94:
	brne r15,r5,L_926f18
	.global L_926f98
L_926f98:
	ld blink,[sp, 0x4]
L_926f9c:
	ld_s r14,[sp,0x8]
L_926f9e:
	ld_s r15,[sp,0xc]
L_926fa0:
	j.d [blink]
L_926fa4:
	ld.ab r13,[sp,0x10]
	.global L_926fa8
L_926fa8:
	mov_s r0,blink
L_926faa:
	mov_s r2,0x1003448
L_926fb0:
	mov r1,0x133f
L_926fb8:
	bl.d L_925548
L_926fbc:
	mov r3,0x7a6
L_926fc0:
	b_s L_926f8c
L_926fc2:
	nop_s
