/* itx__tx_frame_3ies @ 0x938a88, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm4
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, direct_tx__program_cmd34, mac__program_tx_with_rate, tx_fifo__push_frame_3ies
 * Глобалы (через gp): 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global itx__tx_frame_3ies
itx__tx_frame_3ies:
	.global L_938a88
L_938a88:
	push_s blink
L_938a8a:
	bl L_920230
L_938a8e:
	st.a r0,[sp,-0x14]
L_938a92:
	st_s r1,[sp,0x4]
L_938a94:
	st_s r2,[sp,0x8]
L_938a96:
	st_s r3,[sp,0xc]
L_938a98:
	mov_s r13,r4
L_938a9a:
	mov_s r14,r5
L_938a9c:
	st r6,[sp, 0x10]
L_938aa0:
	mov_s r15,r7
L_938aa2:
	ld_s r1,[sp,0x10]
L_938aa4:
	add_s r0,r14,r13
L_938aa6:
	add_s r1,r1,r0
L_938aa8:
	add_s r1,r1,r15
L_938aaa:
	add_s r1,r1,0x18
L_938aac:
	bl.d L_9257a8
L_938ab0:
	mov_s r0,0x16
L_938ab2:
	bl.d L_92d8e8
L_938ab6:
	ld_s r0,[sp,0x4]
	.global L_938ab8
L_938ab8:
	mov_s r0,r43
L_938aba:
	bbit0 r0,0x1f,L_938ab8
L_938abe:
	mov_s r0,r51
L_938ac0:
	bmsk r1,r0,0x3
L_938ac4:
	st.as r1,[gp,0x38]
L_938ac8:
	lsr_s r0,r0,0x4
L_938aca:
	st.as r0,[gp,0x39]
L_938ace:
	mov_s r0,0x2008000
L_938ad4:
	mov_s r32,r0
L_938ad6:
	st.ab r0,[r25,0x4]
L_938ada:
	bclr r25,r25,0xa
L_938ade:
	mov_s r0,0x19000001
L_938ae4:
	mov_s r32,r0
L_938ae6:
	st.ab r0,[r25,0x4]
L_938aea:
	bclr r25,r25,0xa
	.global L_938aee
L_938aee:
	mov_s r0,r45
L_938af0:
	bbit0 r0,0x1f,L_938aee
L_938af4:
	mov_s r0,0x37000005
L_938afa:
	mov_s r32,r0
L_938afc:
	st.ab r0,[r25,0x4]
L_938b00:
	bclr r25,r25,0xa
L_938b04:
	mov_s r0,0x37000002
L_938b0a:
	mov_s r32,r0
L_938b0c:
	st.ab r0,[r25,0x4]
L_938b10:
	bclr r25,r25,0xa
L_938b14:
	ld_s r0,[sp,0x8]
L_938b16:
	or r0,r0,0x3f000000
L_938b1e:
	mov_s r32,r0
L_938b20:
	st.ab r0,[r25,0x4]
L_938b24:
	bclr r25,r25,0xa
L_938b28:
	ld_s r0,[sp,0x4]
L_938b2a:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_938b2c:
	or r0,r0,0x3e000000
L_938b34:
	mov_s r32,r0
L_938b36:
	st.ab r0,[r25,0x4]
L_938b3a:
	bclr r25,r25,0xa
L_938b3e:
	mov_s r0,0x37000020
L_938b44:
	mov_s r32,r0
L_938b46:
	st.ab r0,[r25,0x4]
L_938b4a:
	bclr r25,r25,0xa
L_938b4e:
	mov_s r1,0x8022c8
L_938b54:
	ld_s r0,[r1,0xc]
L_938b56:
	mov_s r2,r13
L_938b58:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_938b5a:
	st_s r0,[r1,0xc]
L_938b5c:
	ld_s r0,[gp,0x178]
L_938b5e:
	mov_s r1,0x802940
L_938b64:
	bclr_s r0,r0,0x18
L_938b66:
	ld_s r1,[r1]
L_938b68:
	bclr_s r0,r0,0x19
L_938b6a:
	asl_s r1,r1,0x18
L_938b6c:
	or_s r0,r0,r1
L_938b6e:
	st.as r0,[gp,0x5e]
L_938b72:
	mov_s r1,0x889480
L_938b78:
	st_s r0,[r1,0x8]
L_938b7a:
	ld_s r0,[sp,0x0]
L_938b7c:
	mov_s r3,r14
L_938b7e:
	ld_s r1,[sp,0xc]
L_938b80:
	ld r4,[sp, 0x10]
L_938b84:
	bl.d L_938358
L_938b88:
	mov_s r5,r15
L_938b8a:
	b.d L_92029c
L_938b8e:
	add_s sp,sp,0x14
