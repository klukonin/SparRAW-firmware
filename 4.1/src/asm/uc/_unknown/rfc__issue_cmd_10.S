/* rfc__issue_cmd_10 @ 0x92bbe0, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode__enter_idle_seq
 */
	.section .text.rfc__issue_cmd_10,"ax",@progbits
	.global rfc__issue_cmd_10
rfc__issue_cmd_10:
	.global L_92bbe0
L_92bbe0:
	st.a r13,[sp,-0x8]
L_92bbe4:
	st_s r14,[sp,0x4]
L_92bbe6:
	mov_s r13,r0
L_92bbe8:
	ld_s r0,[gp,-0x44]
L_92bbea:
	mov_s r14,blink
L_92bbec:
	and r0,r0,0xfff0ffff
L_92bbf4:
	or r2,r0,0x30000
L_92bbfc:
	st.as r2,[gp,-0x11]
L_92bc00:
	or r0,r0,0x1d030000
L_92bc08:
	mov r32,r0
L_92bc0c:
	st.ab r0,[r25,0x4]
L_92bc10:
	bclr r25,r25,0xa
L_92bc14:
	nop_s
L_92bc16:
	nop_s
L_92bc18:
	mov 0x0,0x0
	.global L_92bc1c
L_92bc1c:
	mov_s r1,r47
L_92bc1e:
	bbit1 r1,0x11,L_92bc1c
L_92bc22:
	or r13,r13,0x41000010
L_92bc2a:
	mov_s r32,r13
L_92bc2c:
	st.ab r13,[r25,0x4]
L_92bc30:
	bclr r25,r25,0xa
L_92bc34:
	mov_s blink,r14
L_92bc36:
	ld_s r14,[sp,0x4]
L_92bc38:
	j.d [blink]
L_92bc3c:
	ld.ab r13,[sp,0x8]
