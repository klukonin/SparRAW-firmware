/* mac_counter__program_400b @ 0x934cdc, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   /home/gatis/sdk/sparrow/fwsrc4/src/ucode/inc/sxd_utils.h
 * Зовут его: ucode_cmd__queue_delete
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, uc_sysassert
 */
	.section .text.mac_counter__program_400b,"ax",@progbits
	.global mac_counter__program_400b
mac_counter__program_400b:
	.global L_934cdc
L_934cdc:
	push_s blink
L_934cde:
	bl L_920214
L_934ce2:
	mov_s r13,r0
L_934ce4:
	ld_s r0,[gp,-0xa8]
L_934ce6:
	cmp_s r0,0x0
L_934ce8:
	mov_s r14,r1
L_934cea:
	beq_s L_934da8
L_934cec:
	mov_s r0,0x886500
L_934cf2:
	ld_s r0,[r0,0x6c]
L_934cf4:
	bmsk.f 0x0,r0,0x3
L_934cf8:
	beq_s L_934d0c
L_934cfa:
	mov_s r0,blink
L_934cfc:
	mov_s r2,0x1001714
L_934d02:
	mov_s r1,0x3
L_934d04:
	bl.d L_925548
L_934d08:
	mov r3,0x154
	.global L_934d0c
L_934d0c:
	mov_s r0,0x1c000006
L_934d12:
	mov_s r32,r0
L_934d14:
	st.ab r0,[r25,0x4]
L_934d18:
	bclr r25,r25,0xa
L_934d1c:
	asl_s r0,r13,0x4
L_934d1e:
	or r0,r0,0x4600400b
L_934d26:
	mov_s r32,r0
L_934d28:
	st.ab r0,[r25,0x4]
L_934d2c:
	bclr r25,r25,0xa
L_934d30:
	mov_s r1,0x801458
L_934d36:
	ld_s r0,[r1,0x14]
L_934d38:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_934d3a:
	st_s r0,[r1,0x14]
	.global L_934d3c
L_934d3c:
	mov_s r0,r53
L_934d3e:
	bbit0 r0,0x2,L_934d3c
L_934d42:
	ld_s r0,[gp,-0x44]
L_934d44:
	and r0,r0,0xfff0ffff
L_934d4c:
	bset r1,r0,0x10
L_934d50:
	or r0,r0,0x1d010000
L_934d58:
	st.as r1,[gp,-0x11]
L_934d5c:
	mov_s r32,r0
L_934d5e:
	st.ab r0,[r25,0x4]
L_934d62:
	bclr r25,r25,0xa
L_934d66:
	nop_s
L_934d68:
	nop_s
L_934d6a:
	nop_s
	.global L_934d6c
L_934d6c:
	mov_s r0,r47
L_934d6e:
	bbit1 r0,0x0,L_934d6c
L_934d72:
	asl_s r14,r14,0x8
L_934d74:
	bset_s r14,r14,0x1a
L_934d76:
	bset_s r14,r14,0x1e
L_934d78:
	or_s r13,r13,r14
L_934d7a:
	bset_s r13,r13,0x13
L_934d7c:
	bset_s r13,r13,0x15
L_934d7e:
	mov_s r32,r13
L_934d80:
	st.ab r13,[r25,0x4]
L_934d84:
	bclr r25,r25,0xa
L_934d88:
	mov_s r0,0x45000001
L_934d8e:
	mov_s r32,r0
L_934d90:
	st.ab r0,[r25,0x4]
L_934d94:
	bclr r25,r25,0xa
L_934d98:
	mov_s r0,0x460001f1
L_934d9e:
	mov_s r32,r0
L_934da0:
	st.ab r0,[r25,0x4]
L_934da4:
	bclr r25,r25,0xa
	.global L_934da8
L_934da8:
	b L_920284
