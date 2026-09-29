/* rfc__issue_cmd_20 @ 0x92bc40, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__program_and_measure, rfc_ctrl__switch
 */
	.section .text.rfc__issue_cmd_20,"ax",@progbits
	.global rfc__issue_cmd_20
rfc__issue_cmd_20:
	.global L_92bc40
L_92bc40:
	st.a r13,[sp,-0xc]
L_92bc44:
	st blink,[sp, 0x4]
L_92bc48:
	st_s r14,[sp,0x8]
L_92bc4a:
	mov_s r13,r0
L_92bc4c:
	ld_s r0,[gp,-0x44]
L_92bc4e:
	mov_s r14,r1
L_92bc50:
	and r0,r0,0xfff0ffff
L_92bc58:
	or r3,r0,0x30000
L_92bc60:
	st.as r3,[gp,-0x11]
L_92bc64:
	or r0,r0,0x1d030000
L_92bc6c:
	mov r32,r0
L_92bc70:
	st.ab r0,[r25,0x4]
L_92bc74:
	bclr r25,r25,0xa
L_92bc78:
	nop_s
L_92bc7a:
	nop_s
L_92bc7c:
	mov 0x0,0x0
	.global L_92bc80
L_92bc80:
	mov_s r2,r47
L_92bc82:
	bbit1 r2,0x11,L_92bc80
L_92bc86:
	or r1,r13,0x41000000
L_92bc8e:
	asl_s r14,r14,0x8
L_92bc90:
	or_s r1,r1,r14
L_92bc92:
	bset_s r1,r1,0x5
L_92bc94:
	mov r32,r1
L_92bc98:
	st.ab r1,[r25,0x4]
L_92bc9c:
	bclr r25,r25,0xa
L_92bca0:
	ld blink,[sp, 0x4]
L_92bca4:
	ld_s r14,[sp,0x8]
L_92bca6:
	j_s.d [blink]
L_92bca8:
	ld.ab r13,[sp,0xc]
