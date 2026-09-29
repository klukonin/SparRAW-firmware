/* rf__write_sector_awv @ 0x92fa6c, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__iterate_rf_mask
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rf__write_sector_awv
rf__write_sector_awv:
	.global L_92fa6c
L_92fa6c:
	st.a r13,[sp,-0xc]
L_92fa70:
	st blink,[sp, 0x4]
L_92fa74:
	st_s r14,[sp,0x8]
L_92fa76:
	mov_s r14,r0
L_92fa78:
	mov_s r13,r1
L_92fa7a:
	extw_s r2,r1
L_92fa7c:
	or r2,r2,0x42000000
L_92fa84:
	mov r32,r2
L_92fa88:
	st.ab r2,[r25,0x4]
L_92fa8c:
	bclr r25,r25,0xa
L_92fa90:
	lsr_s r13,r13,0x10
L_92fa92:
	or r13,r13,0x43000000
L_92fa9a:
	mov_s r32,r13
L_92fa9c:
	st.ab r13,[r25,0x4]
L_92faa0:
	bclr r25,r25,0xa
L_92faa4:
	ld.as r1,[gp,-0x11]
L_92faa8:
	and r1,r1,0xfff0ffff
L_92fab0:
	or r7,r1,0x30000
L_92fab8:
	or r1,r1,0x1d030000
L_92fac0:
	st.as r7,[gp,-0x11]
L_92fac4:
	mov r32,r1
L_92fac8:
	st.ab r1,[r25,0x4]
L_92facc:
	bclr r25,r25,0xa
L_92fad0:
	nop_s
L_92fad2:
	nop_s
L_92fad4:
	mov 0x0,0x0
	.global L_92fad8
L_92fad8:
	mov r6,r47
L_92fadc:
	bbit1 r6,0x11,L_92fad8
L_92fae0:
	ld.as r3,[gp,-0x3]
L_92fae4:
	asl_s r14,r14,0x8
L_92fae6:
	or r3,r3,0x41000000
L_92faee:
	or_s r14,r14,r3
L_92faf0:
	mov r32,r14
L_92faf4:
	st.ab r14,[r25,0x4]
L_92faf8:
	bclr r25,r25,0xa
L_92fafc:
	ld_s r0,[gp,-0x44]
L_92fafe:
	and r0,r0,0xfff0ffff
L_92fb06:
	or r4,r0,0x30000
L_92fb0e:
	or r0,r0,0x1d030000
L_92fb16:
	st.as r4,[gp,-0x11]
L_92fb1a:
	mov_s r32,r0
L_92fb1c:
	st.ab r0,[r25,0x4]
L_92fb20:
	bclr r25,r25,0xa
L_92fb24:
	nop_s
L_92fb26:
	nop_s
L_92fb28:
	mov 0x0,0x0
	.global L_92fb2c
L_92fb2c:
	mov r5,r47
L_92fb30:
	bbit1 r5,0x11,L_92fb2c
L_92fb34:
	ld blink,[sp, 0x4]
L_92fb38:
	ld_s r14,[sp,0x8]
L_92fb3a:
	j_s.d [blink]
L_92fb3c:
	ld.ab r13,[sp,0xc]
