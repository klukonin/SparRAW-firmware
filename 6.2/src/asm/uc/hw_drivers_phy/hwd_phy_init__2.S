/* hwd_phy_init__2 @ 0x929684, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__bring_up_phy_dma
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_phy_init__2
hwd_phy_init__2:
	.global L_929684
L_929684:
	st.a r13,[sp,-0x10]
L_929688:
	st_s r14,[sp,0x8]
L_92968a:
	st_s r15,[sp,0xc]
L_92968c:
	mov_s r14,0x1003174
L_929692:
	ld_s r0,[r14]
L_929694:
	mov r15,0xe0d0e0d
L_92969c:
	st blink,[sp, 0x4]
L_9296a0:
	breq.d r0,r15,L_9296c0
L_9296a4:
	mov_s r13,0x0
L_9296a6:
	mov_s r2,r14
	.global L_9296a8
L_9296a8:
	ld_s r3,[r0]
L_9296aa:
	ld_s r1,[r2,0x4]
L_9296ac:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_9296ae:
	st_s r1,[r0]
L_9296b0:
	brhs r13,0x28,L_9296d0
	.global L_9296b4
L_9296b4:
	add3 r2,r14,r13
L_9296b8:
	ld r0,[r2]
L_9296bc:
	brne r0,r15,L_9296a8
	.global L_9296c0
L_9296c0:
	ld blink,[sp, 0x4]
L_9296c4:
	ld_s r14,[sp,0x8]
L_9296c6:
	ld_s r15,[sp,0xc]
L_9296c8:
	j.d [blink]
L_9296cc:
	ld.ab r13,[sp,0x10]
	.global L_9296d0
L_9296d0:
	mov_s r0,blink
L_9296d2:
	mov_s r1,0x133f
L_9296d8:
	bl L_926618
L_9296dc:
	b_s L_9296b4
L_9296de:
	nop_s
