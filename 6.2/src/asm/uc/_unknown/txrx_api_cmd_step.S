/* txrx_api_cmd_step @ 0x936be4, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x01_handler
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, mac__program_deadline_slack, rx_nav__set_flag_b1_if_enabled
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txrx_api_cmd_step
txrx_api_cmd_step:
	.global L_936be4
L_936be4:
	push_s blink
L_936be6:
	bl L_920220
L_936bea:
	ld_s r15,[r0]
L_936bec:
	ld_s r1,[r0,0x4]
L_936bee:
	st.a r15,[sp,-0x8]
L_936bf2:
	mov_s r16,r1
L_936bf4:
	st_s r1,[sp,0x4]
L_936bf6:
	ld_s r1,[r0,0x1c]
L_936bf8:
	ld_s r13,[r0,0x18]
L_936bfa:
	bmsk r19,r1,0x0
L_936bfe:
	lsr r2,r1,0x2
L_936c02:
	ld_s r0,[r0,0x10]
L_936c04:
	lsr_s r1,r1
L_936c06:
	bmsk r18,r2,0x0
L_936c0a:
	bmsk r17,r1,0x0
L_936c0e:
	bbit0 r0,0x0,L_936c9a
L_936c12:
	bl.d L_92dcbc
L_936c16:
	mov_s r0,0x0
L_936c18:
	mov_s r14,0x80229c
L_936c1e:
	mov_s r2,r16
L_936c20:
	mov_s r1,0x0
L_936c22:
	cmp_s r2,r1
L_936c24:
	cmp.eq r15,r13
L_936c28:
	st_s r13,[r14,0x8]
L_936c2a:
	mov_s r0,r13
L_936c2c:
	bhs_s L_936c3a
L_936c2e:
	add.f r0,r0,r15
L_936c32:
	adc r1,r1,r2
L_936c36:
	st_s r0,[sp,0x0]
L_936c38:
	st_s r1,[sp,0x4]
	.global L_936c3a
L_936c3a:
	mov_s r1,0x887000
L_936c40:
	lsr_s r13,r13,0xa
L_936c42:
	st.as r13,[r1,-0xa7]
L_936c46:
	ld_s r0,[sp,0x0]
L_936c48:
	st.as r0,[r1,-0x90]
L_936c4c:
	ld_s r0,[sp,0x4]
L_936c4e:
	st.as r0,[r1,-0x8f]
L_936c52:
	sync
L_936c56:
	mov_s r0,0xd000006
L_936c5c:
	mov_s r32,r0
L_936c5e:
	st.ab r0,[r25,0x4]
L_936c62:
	bclr r25,r25,0xa
L_936c66:
	asl r0,r19,0x9
L_936c6a:
	or r0,r0,0xd000053
L_936c72:
	asl r1,r17,0xa
L_936c76:
	or_s r0,r0,r1
L_936c78:
	asl r1,r18,0xb
L_936c7c:
	or_s r0,r0,r1
L_936c7e:
	bset_s r0,r0,0xc
L_936c80:
	bset_s r0,r0,0x11
L_936c82:
	bset_s r0,r0,0x13
L_936c84:
	mov_s r32,r0
L_936c86:
	st.ab r0,[r25,0x4]
L_936c8a:
	bclr r25,r25,0xa
L_936c8e:
	ld_s r0,[r14,0x8]
L_936c90:
	mov_s r1,0x7
L_936c92:
	bl.d L_934de4
L_936c96:
	mov_s r2,0x50
L_936c98:
	b_s L_936cc2
	.global L_936c9a
L_936c9a:
	asl r0,r19,0x9
L_936c9e:
	or r0,r0,0xd000053
L_936ca6:
	asl r1,r17,0xa
L_936caa:
	or_s r1,r1,r0
L_936cac:
	asl r0,r18,0xb
L_936cb0:
	or_s r0,r0,r1
L_936cb2:
	bset_s r0,r0,0xc
L_936cb4:
	bset_s r0,r0,0x11
L_936cb6:
	bset_s r0,r0,0x13
L_936cb8:
	mov_s r32,r0
L_936cba:
	st.ab r0,[r25,0x4]
L_936cbe:
	bclr r25,r25,0xa
	.global L_936cc2
L_936cc2:
	b.d L_92027c
L_936cc6:
	add_s sp,sp,0x8
