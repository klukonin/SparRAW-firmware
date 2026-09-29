/* brp_init__reset_ctx @ 0x92afb8, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__flow
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, brp__bits_uc_set32_s4_w5, memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp_init__reset_ctx
brp_init__reset_ctx:
	.global L_92afb8
L_92afb8:
	push_s blink
L_92afba:
	bl.d L_920228
L_92afbe:
	mov_s r1,0x10
L_92afc0:
	mov_s r17,r0
L_92afc2:
	mov_s r14,0x800824
L_92afc8:
	bl.d L_920a84
L_92afcc:
	add3 r0,r14,0x9
L_92afd0:
	mov_s r0,0x8006b4
L_92afd6:
	ldb_s r1,[r0,0x3]
L_92afd8:
	stb r17,[r14, 0x48]
L_92afdc:
	stb_s r1,[r14,0x4]
L_92afde:
	ld_s r0,[r14,0x50]
L_92afe0:
	mov_s r13,0x0
L_92afe2:
	bset r16,r0,0x0
L_92afe6:
	bset r16,r16,0x10
L_92afea:
	st r16,[r14, 0x50]
L_92afee:
	st_s r1,[r14,0x4c]
L_92aff0:
	mov_s r15,0x8
	.global L_92aff2
L_92aff2:
	mov_s r1,0x0
L_92aff4:
	add3 r0,r14,r13
L_92aff8:
	st_s r1,[r0,0x8]
L_92affa:
	st_s r1,[r0,0xc]
L_92affc:
	asl_s r0,r13,0x6
L_92affe:
	add_s r0,r0,0x801c94
L_92b004:
	bl.d L_920a84
L_92b008:
	mov_s r1,0x40
L_92b00a:
	asl_s r0,r13,0x5
L_92b00c:
	add_s r0,r0,0x801ef4
L_92b012:
	bl.d L_920a84
L_92b016:
	mov_s r1,0x20
L_92b018:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_92b01a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92b01c:
	brhs.d r15,0x1,L_92aff2
L_92b020:
	extb_s r13,r13
L_92b022:
	asl r1,r17,0x2
L_92b026:
	add2_s r1,r1,r1
L_92b028:
	add_s r1,r1,0x801ffc
L_92b02e:
	ldb_s r0,[r1,0xa]
L_92b030:
	bbit1 r0,0x0,L_92b03c
L_92b034:
	bset r0,r16,0x9
L_92b038:
	st_s r0,[r14,0x50]
L_92b03a:
	b_s L_92b054
	.global L_92b03c
L_92b03c:
	ldb_s r0,[r1,0x9]
L_92b03e:
	brlt r0,0x1,L_92b054
L_92b042:
	ld_s r0,[r14,0x54]
L_92b044:
	bset_s r0,r0,0x2
L_92b046:
	ldb_s r1,[r1,0x9]
L_92b048:
	st_s r0,[r14,0x54]
L_92b04a:
	bmsk_s r1,r1,0x4
L_92b04c:
	add2 r0,r14,0x15
L_92b050:
	bl L_93e3fc
	.global L_92b054
L_92b054:
	mov_s r0,0x2011000
L_92b05a:
	mov_s r32,r0
L_92b05c:
	st.ab r0,[r25,0x4]
L_92b060:
	bclr r25,r25,0xa
L_92b064:
	b L_92028c
