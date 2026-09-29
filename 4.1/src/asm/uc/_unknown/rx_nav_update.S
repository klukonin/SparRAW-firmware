/* rx_nav_update @ 0x92fd3c, 432 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run
 * Зовёт сам: mac__prepare_txrx_window, nav_db__update
 * Глобалы (через gp): 0x800570, 0x800604, 0x800608
 */
	.section .text.rx_nav_update,"ax",@progbits
	.global rx_nav_update
rx_nav_update:
	.global L_92fd3c
L_92fd3c:
	push_s blink
L_92fd3e:
	mov_s r5,r0
L_92fd40:
	ld.as r11,[gp,0x38]
L_92fd44:
	ld r0,[0x801a78]
L_92fd4c:
	bmsk r4,r11,0x4
L_92fd50:
	brne r4,0x1,L_92fdbc
L_92fd54:
	mov r7,-0x20
L_92fd58:
	bic r9,r11,0x1f
L_92fd5c:
	bbit0.d r1,0x8,L_92fda4
L_92fd60:
	st.as r9,[gp,0x38]
L_92fd64:
	btst_s r3,0xc
L_92fd66:
	btst.eq r9,0x12
L_92fd6a:
	beq_s L_92fda4
	.global L_92fd6c
L_92fd6c:
	and r9,r9,r7
L_92fd70:
	st.as r9,[gp,0x38]
L_92fd74:
	ld r8,[r0, 0xc]
L_92fd78:
	mov_s r1,0x0
L_92fd7a:
	bclr r8,r8,0x1
L_92fd7e:
	st r8,[r0, 0xc]
L_92fd82:
	st_s r1,[r0,0x1c]
L_92fd84:
	ld.as r3,[gp,0x37]
L_92fd88:
	btst_s r3,0x1
L_92fd8a:
	beq_s L_92fee8
L_92fd8c:
	mov_s r0,r38
L_92fd8e:
	btst_s r0,0xf
L_92fd90:
	beq_s L_92fee8
L_92fd92:
	ld.as r9,[gp,0x38]
L_92fd96:
	pop_s blink
L_92fd98:
	bset r9,r9,0x3
L_92fd9c:
	j.d [blink]
L_92fda0:
	st.as r9,[gp,0x38]
	.global L_92fda4
L_92fda4:
	mov r5,0x801458
L_92fdac:
	ld r10,[r5, 0x10]
L_92fdb0:
	add r10,r10,0x1
L_92fdb4:
	b.d L_92fe40
L_92fdb8:
	st r10,[r5, 0x10]
	.global L_92fdbc
L_92fdbc:
	brne r4,0x10,L_92fe20
L_92fdc0:
	bbit0 r1,0x1,L_92fe14
L_92fdc4:
	bic r11,r11,0x1f
L_92fdc8:
	st.as r11,[gp,0x38]
L_92fdcc:
	ld_s r1,[r0,0xc]
L_92fdce:
	mov r6,0x0
L_92fdd2:
	bclr_s r1,r1,0x1
L_92fdd4:
	st r1,[r0, 0xc]
L_92fdd8:
	st r6,[r0, 0x1c]
L_92fddc:
	ld.as r7,[gp,0x37]
L_92fde0:
	bbit1.d r7,0x1,L_92fdf0
L_92fde4:
	mov r10,-0x20
L_92fde8:
	b.d L_92fdfc
L_92fdec:
	ld.as r11,[gp,0x38]
	.global L_92fdf0
L_92fdf0:
	mov r4,r38
L_92fdf4:
	bbit1.d r4,0xf,L_92fe08
L_92fdf8:
	ld.as r11,[gp,0x38]
	.global L_92fdfc
L_92fdfc:
	and r10,r10,r11
L_92fe00:
	pop_s blink
L_92fe02:
	j_s.d [blink]
L_92fe04:
	st.as r10,[gp,0x38]
	.global L_92fe08
L_92fe08:
	bic r10,r11,0x1f
L_92fe0c:
	pop_s blink
L_92fe0e:
	j_s.d [blink]
L_92fe10:
	st.as r10,[gp,0x38]
	.global L_92fe14
L_92fe14:
	bset r10,r11,0x7
L_92fe18:
	pop_s blink
L_92fe1a:
	j_s.d [blink]
L_92fe1c:
	st.as r10,[gp,0x38]
	.global L_92fe20
L_92fe20:
	brne r4,0x2,L_92fe68
L_92fe24:
	mov r7,-0x20
L_92fe28:
	bic r9,r11,0x1f
L_92fe2c:
	st.as r9,[gp,0x38]
L_92fe30:
	btst_s r1,0x9
L_92fe32:
	btst.ne r3,0xc
L_92fe36:
	beq_s L_92fe4c
L_92fe38:
	ld.as r5,[gp,-0x33]
L_92fe3c:
	breq r5,0x0,L_92fd6c
	.global L_92fe40
L_92fe40:
	bl.d L_92177c
L_92fe44:
	mov r1,0x2
L_92fe48:
	pop_s blink
L_92fe4a:
	j_s [blink]
	.global L_92fe4c
L_92fe4c:
	bl.d L_92177c
L_92fe50:
	mov r1,0x2
L_92fe54:
	mov_s r3,0x801118
L_92fe5a:
	ld_s r2,[r3,0xc]
L_92fe5c:
	pop_s blink
L_92fe5e:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_92fe60:
	j.d [blink]
L_92fe64:
	st r2,[r3, 0xc]
	.global L_92fe68
L_92fe68:
	brne r4,0x4,L_92fed4
L_92fe6c:
	bbit0 r2,0x1,L_92fe84
L_92fe70:
	bic r10,r11,0x1f
L_92fe74:
	st.as r10,[gp,0x38]
L_92fe78:
	mov_s r2,0x1
L_92fe7a:
	pop_s blink
L_92fe7c:
	j.d [blink]
L_92fe80:
	st.as r2,[gp,0x12]
	.global L_92fe84
L_92fe84:
	mov r4,r37
L_92fe88:
	bbit0 r4,0x2,L_92fecc
L_92fe8c:
	mov r6,0x804010
L_92fe94:
	mov_s r0,0x1
L_92fe96:
	ldw r1,[r6]
L_92fe9a:
	mov_s r3,0x80401a
L_92fea0:
	bl.d L_92a6f4
L_92fea4:
	ldw r2,[r6, 0x2]
L_92fea8:
	mov r4,0x801458
L_92feb0:
	ld r10,[r4, 0x60]
L_92feb4:
	ld.as r11,[gp,0x38]
L_92feb8:
	add r10,r10,0x1
L_92febc:
	st r10,[r4, 0x60]
L_92fec0:
	bic r11,r11,0x1f
L_92fec4:
	b.d L_92fe14
L_92fec8:
	or r11,r11,0x5
	.global L_92fecc
L_92fecc:
	b.d L_92fe14
L_92fed0:
	ld.as r11,[gp,0x38]
	.global L_92fed4
L_92fed4:
	brne r4,0x8,L_92fee8
L_92fed8:
	cmp r5,0x0
L_92fedc:
	mov.ne r10,0xffffffe0
L_92fee4:
	bne L_92fdfc
	.global L_92fee8
L_92fee8:
	pop_s blink
L_92feea:
	j_s [blink]
