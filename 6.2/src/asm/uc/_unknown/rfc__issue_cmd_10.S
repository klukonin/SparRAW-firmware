/* rfc__issue_cmd_10 @ 0x92f868, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode__enter_idle_seq
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rfc__issue_cmd_10
rfc__issue_cmd_10:
	.global L_92f868
L_92f868:
	st.a r13,[sp,-0x8]
L_92f86c:
	st_s r14,[sp,0x4]
L_92f86e:
	mov_s r13,r0
L_92f870:
	ld_s r0,[gp,-0x44]
L_92f872:
	mov_s r14,blink
L_92f874:
	and r0,r0,0xfff0ffff
L_92f87c:
	or r2,r0,0x30000
L_92f884:
	st.as r2,[gp,-0x11]
L_92f888:
	or r0,r0,0x1d030000
L_92f890:
	mov r32,r0
L_92f894:
	st.ab r0,[r25,0x4]
L_92f898:
	bclr r25,r25,0xa
L_92f89c:
	nop_s
L_92f89e:
	nop_s
L_92f8a0:
	mov 0x0,0x0
	.global L_92f8a4
L_92f8a4:
	mov_s r1,r47
L_92f8a6:
	bbit1 r1,0x11,L_92f8a4
L_92f8aa:
	or r13,r13,0x41000010
L_92f8b2:
	mov_s r32,r13
L_92f8b4:
	st.ab r13,[r25,0x4]
L_92f8b8:
	bclr r25,r25,0xa
L_92f8bc:
	mov_s blink,r14
L_92f8be:
	ld_s r14,[sp,0x4]
L_92f8c0:
	j.d [blink]
L_92f8c4:
	ld.ab r13,[sp,0x8]
