/* txrx_api_cmd_step @ 0x931ce8, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_cfg__apply, ucode_cmd__rx_on
 * Зовёт сам: __ld_r19_to_r13_ret_uc, __st_r19_to_r13_uc, mac__program_deadline_slack, set_g_800994
 */
	.section .text.txrx_api_cmd_step,"ax",@progbits
	.global txrx_api_cmd_step
txrx_api_cmd_step:
	.global L_931ce8
L_931ce8:
	push_s blink
L_931cea:
	bl L_920200
L_931cee:
	ld_s r15,[r0]
L_931cf0:
	ld_s r1,[r0,0x4]
L_931cf2:
	st.a r15,[sp,-0x8]
L_931cf6:
	mov_s r16,r1
L_931cf8:
	st_s r1,[sp,0x4]
L_931cfa:
	ld_s r1,[r0,0x1c]
L_931cfc:
	ld_s r13,[r0,0x18]
L_931cfe:
	bmsk r19,r1,0x0
L_931d02:
	lsr r2,r1,0x2
L_931d06:
	ld_s r0,[r0,0x10]
L_931d08:
	lsr_s r1,r1
L_931d0a:
	bmsk r18,r2,0x0
L_931d0e:
	bmsk r17,r1,0x0
L_931d12:
	bbit0 r0,0x0,L_931d9e
L_931d16:
	bl.d L_92a680
L_931d1a:
	mov_s r0,0x0
L_931d1c:
	mov_s r14,0x80142c
L_931d22:
	mov_s r2,r16
L_931d24:
	mov_s r1,0x0
L_931d26:
	cmp_s r2,r1
L_931d28:
	cmp.eq r15,r13
L_931d2c:
	st_s r13,[r14,0x8]
L_931d2e:
	mov_s r0,r13
L_931d30:
	bhs_s L_931d3e
L_931d32:
	add.f r0,r0,r15
L_931d36:
	adc r1,r1,r2
L_931d3a:
	st_s r0,[sp,0x0]
L_931d3c:
	st_s r1,[sp,0x4]
	.global L_931d3e
L_931d3e:
	mov_s r1,0x887000
L_931d44:
	lsr_s r13,r13,0xa
L_931d46:
	st.as r13,[r1,-0xa7]
L_931d4a:
	ld_s r0,[sp,0x0]
L_931d4c:
	st.as r0,[r1,-0x90]
L_931d50:
	ld_s r0,[sp,0x4]
L_931d52:
	st.as r0,[r1,-0x8f]
L_931d56:
	sync
L_931d5a:
	mov_s r0,0xd000006
L_931d60:
	mov_s r32,r0
L_931d62:
	st.ab r0,[r25,0x4]
L_931d66:
	bclr r25,r25,0xa
L_931d6a:
	asl r0,r19,0x9
L_931d6e:
	or r0,r0,0xd000053
L_931d76:
	asl r1,r17,0xa
L_931d7a:
	or_s r0,r0,r1
L_931d7c:
	asl r1,r18,0xb
L_931d80:
	or_s r0,r0,r1
L_931d82:
	bset_s r0,r0,0xc
L_931d84:
	bset_s r0,r0,0x11
L_931d86:
	bset_s r0,r0,0x13
L_931d88:
	mov_s r32,r0
L_931d8a:
	st.ab r0,[r25,0x4]
L_931d8e:
	bclr r25,r25,0xa
L_931d92:
	ld_s r0,[r14,0x8]
L_931d94:
	mov_s r1,0x7
L_931d96:
	bl.d L_930494
L_931d9a:
	mov_s r2,0x50
L_931d9c:
	b_s L_931dc6
	.global L_931d9e
L_931d9e:
	asl r0,r19,0x9
L_931da2:
	or r0,r0,0xd000053
L_931daa:
	asl r1,r17,0xa
L_931dae:
	or_s r1,r1,r0
L_931db0:
	asl r0,r18,0xb
L_931db4:
	or_s r0,r0,r1
L_931db6:
	bset_s r0,r0,0xc
L_931db8:
	bset_s r0,r0,0x11
L_931dba:
	bset_s r0,r0,0x13
L_931dbc:
	mov_s r32,r0
L_931dbe:
	st.ab r0,[r25,0x4]
L_931dc2:
	bclr r25,r25,0xa
	.global L_931dc6
L_931dc6:
	b.d L_92025c
L_931dca:
	add_s sp,sp,0x8
