/* rf__select_sector_cmd41 @ 0x92f934, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__program_and_measure
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rf__select_sector_cmd41
rf__select_sector_cmd41:
	.global L_92f934
L_92f934:
	st.a r13,[sp,-0xc]
L_92f938:
	st blink,[sp, 0x4]
L_92f93c:
	st_s r14,[sp,0x8]
L_92f93e:
	mov_s r14,r1
L_92f940:
	ld.as r1,[gp,-0x11]
L_92f944:
	mov_s r13,r0
L_92f946:
	and r1,r1,0xfff0ffff
L_92f94e:
	or r6,r1,0x30000
L_92f956:
	st.as r6,[gp,-0x11]
L_92f95a:
	or r1,r1,0x1d030000
L_92f962:
	mov_s r32,r1
L_92f964:
	st.ab r1,[r25,0x4]
L_92f968:
	bclr r25,r25,0xa
L_92f96c:
	nop_s
L_92f96e:
	nop_s
L_92f970:
	mov 0x0,0x0
	.global L_92f974
L_92f974:
	mov r5,r47
L_92f978:
	bbit1 r5,0x11,L_92f974
L_92f97c:
	or r2,r13,0x41000000
L_92f984:
	asl_s r14,r14,0x8
L_92f986:
	or_s r2,r2,r14
L_92f988:
	bset_s r2,r2,0x5
L_92f98a:
	mov_s r32,r2
L_92f98c:
	st.ab r2,[r25,0x4]
L_92f990:
	bclr r25,r25,0xa
L_92f994:
	ld_s r0,[gp,-0x44]
L_92f996:
	and r0,r0,0xfff0ffff
L_92f99e:
	or r3,r0,0x30000
L_92f9a6:
	or r0,r0,0x1d030000
L_92f9ae:
	st.as r3,[gp,-0x11]
L_92f9b2:
	mov_s r32,r0
L_92f9b4:
	st.ab r0,[r25,0x4]
L_92f9b8:
	bclr r25,r25,0xa
L_92f9bc:
	nop_s
L_92f9be:
	nop_s
L_92f9c0:
	mov 0x0,0x0
	.global L_92f9c4
L_92f9c4:
	mov r4,r47
L_92f9c8:
	bbit1 r4,0x11,L_92f9c4
L_92f9cc:
	ld blink,[sp, 0x4]
L_92f9d0:
	ld_s r14,[sp,0x8]
L_92f9d2:
	j_s.d [blink]
L_92f9d4:
	ld.ab r13,[sp,0xc]
