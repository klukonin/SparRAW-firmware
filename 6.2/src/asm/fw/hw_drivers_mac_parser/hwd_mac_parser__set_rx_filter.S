/* hwd_mac_parser__set_rx_filter @ 0x8dfd14, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__rx_start, discovery__rx_stop, mac_parser__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, mac_parser__uses_rgf_886280
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_mac_parser__set_rx_filter
hwd_mac_parser__set_rx_filter:
	.global L_8dfd14
L_8dfd14:
	push_s blink
L_8dfd16:
	bl L_8c01dc
L_8dfd1a:
	sub_s sp,sp,0x8
L_8dfd1c:
	mov_s r16,r0
L_8dfd1e:
	mov_s r15,r1
L_8dfd20:
	mov_s r14,0x0
L_8dfd22:
	b_s L_8dfd4e
	.global L_8dfd24
L_8dfd24:
	mov_s r3,0x0
L_8dfd26:
	bset_s r3,r3,0xe
	.global L_8dfd28
L_8dfd28:
	or_s r2,r2,r3
L_8dfd2a:
	bset_s r2,r2,0xf
L_8dfd2c:
	stw_s r2,[r13,0x2]
L_8dfd2e:
	asl r2,r16,0x12
L_8dfd32:
	or r2,r2,0x1af7f
L_8dfd3a:
	asl_s r0,r0,0x13
L_8dfd3c:
	or_s r0,r0,r2
L_8dfd3e:
	bset_s r0,r0,0x16
L_8dfd40:
	bset_s r0,r0,0x17
L_8dfd42:
	st_s r0,[r13,0x4]
L_8dfd44:
	mov_s r0,r13
L_8dfd46:
	bl.d L_8dfbd8
L_8dfd4a:
	mov_s r2,0x3
	.global L_8dfd4c
L_8dfd4c:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8dfd4e
L_8dfd4e:
	brhs r14,0xf,L_8dfddc
L_8dfd52:
	brlo r14,0x6,L_8dfd5a
L_8dfd56:
	brlo r14,0x8,L_8dfd4c
	.global L_8dfd5a
L_8dfd5a:
	mov_s r13,sp
L_8dfd5c:
	asl_s r0,r14,0x2
L_8dfd5e:
	bset_s r0,r0,0xa
L_8dfd60:
	brhs.d r14,0xf,L_8dfd86
L_8dfd64:
	stw r0,[sp]
L_8dfd68:
	ldb.x r10,[0x803980,r14]
L_8dfd70:
	add r0,pcl,0xa
L_8dfd74:
	add1 r0,r0,r10
L_8dfd78:
	j_s [r0]
L_8dfd7a:
	add_s r1,r14,0x1
L_8dfd7c:
	b_s L_8dfd92
L_8dfd7e:
	sub_s r1,r14,0x1
L_8dfd80:
	b_s L_8dfd92
L_8dfd82:
	mov_s r1,0xf
L_8dfd84:
	b_s L_8dfd92
	.global L_8dfd86
L_8dfd86:
	mov_s r0,blink
L_8dfd88:
	mov_s r1,0xe
L_8dfd8a:
	bl.d L_8c9b28
L_8dfd8e:
	bset_s r1,r1,0xc
L_8dfd90:
	mov_s r1,0x0
	.global L_8dfd92
L_8dfd92:
	sub_s r3,r1,0x5
L_8dfd94:
	brhs.d r3,0xb,L_8dfdc0
L_8dfd98:
	mov_s r0,0x1
L_8dfd9a:
	ldb.x r3,[0x803990,r3]
L_8dfda2:
	add r2,pcl,0xa
L_8dfda6:
	add1_s r2,r2,r3
L_8dfda8:
	j_s [r2]
L_8dfdaa:
	mov_s r1,0xc
L_8dfdac:
	cmp_s r15,0x0
L_8dfdae:
	mov_s r0,0x1
L_8dfdb0:
	sub_s.ne r0,r0,r0
L_8dfdb2:
	neg_s r0,r0
L_8dfdb4:
	bmsk_s r0,r0,0x1
L_8dfdb6:
	b_s L_8dfdc0
L_8dfdb8:
	mov_s r0,0x3
L_8dfdba:
	b_s L_8dfdc0
L_8dfdbc:
	mov_s r1,0x6
L_8dfdbe:
	mov_s r0,0x0
	.global L_8dfdc0
L_8dfdc0:
	cmp_s r1,0xc
L_8dfdc2:
	mov_s r2,0x1
L_8dfdc4:
	sub_s.ne r2,r2,r2
L_8dfdc6:
	asl_s r2,r2,0x8
L_8dfdc8:
	or r2,r2,0x3007
L_8dfdd0:
	cmp_s r1,0xf
L_8dfdd2:
	cmp.ne r1,0x8
L_8dfdd6:
	bne_s L_8dfd24
L_8dfdd8:
	mov_s r3,0x0
L_8dfdda:
	b_s L_8dfd28
	.global L_8dfddc
L_8dfddc:
	b.d L_8c0244
L_8dfde0:
	add_s sp,sp,0x8
L_8dfde2:
	nop_s
