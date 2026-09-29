/* rfc__issue_cmd_20_uc @ 0x92f8c8, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__split_id
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rfc__issue_cmd_20_uc
rfc__issue_cmd_20_uc:
	.global L_92f8c8
L_92f8c8:
	st.a r13,[sp,-0xc]
L_92f8cc:
	st blink,[sp, 0x4]
L_92f8d0:
	st_s r14,[sp,0x8]
L_92f8d2:
	mov_s r13,r0
L_92f8d4:
	ld_s r0,[gp,-0x44]
L_92f8d6:
	mov_s r14,r1
L_92f8d8:
	and r0,r0,0xfff0ffff
L_92f8e0:
	or r3,r0,0x30000
L_92f8e8:
	st.as r3,[gp,-0x11]
L_92f8ec:
	or r0,r0,0x1d030000
L_92f8f4:
	mov r32,r0
L_92f8f8:
	st.ab r0,[r25,0x4]
L_92f8fc:
	bclr r25,r25,0xa
L_92f900:
	nop_s
L_92f902:
	nop_s
L_92f904:
	mov 0x0,0x0
	.global L_92f908
L_92f908:
	mov_s r2,r47
L_92f90a:
	bbit1 r2,0x11,L_92f908
L_92f90e:
	or r1,r13,0x41000000
L_92f916:
	asl_s r14,r14,0x8
L_92f918:
	or_s r1,r1,r14
L_92f91a:
	bset_s r1,r1,0x5
L_92f91c:
	mov r32,r1
L_92f920:
	st.ab r1,[r25,0x4]
L_92f924:
	bclr r25,r25,0xa
L_92f928:
	ld blink,[sp, 0x4]
L_92f92c:
	ld_s r14,[sp,0x8]
L_92f92e:
	j_s.d [blink]
L_92f930:
	ld.ab r13,[sp,0xc]
