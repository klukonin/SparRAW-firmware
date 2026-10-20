/* ucode_cmd__rs_enable @ 0x92becc, 336 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   enable RS = %d
 *   RS is active, aborting cid =%d
 *   restarting RS=%d
 *   disable RS cid= %d
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, memcpy_uc, rate_search__reset_sta, rate_search__start_for_sta, ucode_pm__set_busy_flag
 */
	.section .text.ucode_cmd__rs_enable,"ax",@progbits
	.global ucode_cmd__rs_enable
ucode_cmd__rs_enable:
	.global L_92becc
L_92becc:
	push_s blink
L_92bece:
	bl L_920210
L_92bed2:
	ldb_s r15,[r0,0x1]
L_92bed4:
	mov_s r13,r0
L_92bed6:
	mov_s r14,0x80209c
L_92bedc:
	ldb_s r1,[r14,0x4]
L_92bede:
	breq r15,0x0,L_92bfd2
L_92bee2:
	mov r4,0x10016bc
L_92beea:
	bbit0 r1,0x2,L_92bf16
L_92beee:
	ld_s r0,[r14]
L_92bef0:
	mov_s r3,0x8020b0
L_92bef6:
	add_s r2,r0,0x1
L_92bef8:
	extb_s r2,r2
L_92befa:
	add2 r2,r3,r2
L_92befe:
	st_s r15,[r2]
L_92bf00:
	bmsk r2,r4,0x13
L_92bf04:
	or r2,r2,0xa6000000
L_92bf0c:
	extb_s r15,r0
L_92bf0e:
	add2_s r3,r3,r15
L_92bf10:
	st_s r2,[r3]
L_92bf12:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_92bf14:
	st_s r0,[r14]
	.global L_92bf16
L_92bf16:
	ldb_s r2,[r13]
L_92bf18:
	mov_s r3,0x8016d8
L_92bf1e:
	asl_s r0,r2,0x2
L_92bf20:
	add1_s r0,r0,r0
L_92bf22:
	ld_s r0,[r3,r0]
L_92bf24:
	sub.f r0,r0,0x0
L_92bf28:
	mov.ne r0,0x1
L_92bf2c:
	extb.f 0x0,r0
L_92bf30:
	mov.eq r15,0x0
L_92bf34:
	beq_s L_92bf70
L_92bf36:
	mov_s r3,0x10016cc
L_92bf3c:
	bbit0 r1,0x2,L_92bf68
L_92bf40:
	ld_s r0,[r14]
L_92bf42:
	mov_s r1,0x8020b0
L_92bf48:
	add_s r15,r0,0x1
L_92bf4a:
	extb_s r15,r15
L_92bf4c:
	add2 r15,r1,r15
L_92bf50:
	st_s r2,[r15]
L_92bf52:
	bmsk r2,r3,0x13
L_92bf56:
	or r2,r2,0xa6000000
L_92bf5e:
	extb_s r3,r0
L_92bf60:
	add2_s r1,r1,r3
L_92bf62:
	st_s r2,[r1]
L_92bf64:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_92bf66:
	st_s r0,[r14]
	.global L_92bf68
L_92bf68:
	bl.d L_92bd80
L_92bf6c:
	ldb_s r0,[r13]
L_92bf6e:
	mov_s r15,0x1
	.global L_92bf70
L_92bf70:
	ld_s r0,[gp,-0xc]
L_92bf72:
	ldb_s r1,[r13]
L_92bf74:
	bset r0,r0,r1
L_92bf78:
	st.as r0,[gp,-0x3]
L_92bf7c:
	ldb_s r0,[r13]
L_92bf7e:
	add_s r1,r13,0x2
L_92bf80:
	mul64 r0,0x26
L_92bf84:
	add r0,mlo,0x801898
L_92bf8c:
	bl.d L_920310
L_92bf90:
	mov_s r2,0x26
L_92bf92:
	brne r15,0x1,L_92c018
L_92bf96:
	ldb_s r0,[r14,0x4]
L_92bf98:
	mov_s r2,0x10016ec
L_92bf9e:
	bbit0 r0,0x2,L_92bfc8
L_92bfa2:
	ld_s r0,[r14]
L_92bfa4:
	mov_s r1,0x8020b0
L_92bfaa:
	add_s r3,r0,0x1
L_92bfac:
	extb_s r3,r3
L_92bfae:
	add2 r3,r1,r3
L_92bfb2:
	st_s r15,[r3]
L_92bfb4:
	bmsk_s r2,r2,0x13
L_92bfb6:
	or r2,r2,0xa6000000
L_92bfbe:
	extb_s r3,r0
L_92bfc0:
	add2_s r1,r1,r3
L_92bfc2:
	st_s r2,[r1]
L_92bfc4:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_92bfc6:
	st_s r0,[r14]
	.global L_92bfc8
L_92bfc8:
	ldb_s r0,[r13]
L_92bfca:
	bl.d L_92c34c
L_92bfce:
	mov_s r1,0x0
L_92bfd0:
	b_s L_92c018
	.global L_92bfd2
L_92bfd2:
	mov_s r2,0x1001700
L_92bfd8:
	ldb_s r15,[r13]
L_92bfda:
	bbit0 r1,0x2,L_92c006
L_92bfde:
	ld_s r0,[r14]
L_92bfe0:
	mov_s r3,0x8020b0
L_92bfe6:
	add_s r1,r0,0x1
L_92bfe8:
	extb_s r1,r1
L_92bfea:
	add2 r1,r3,r1
L_92bfee:
	st_s r15,[r1]
L_92bff0:
	bmsk r1,r2,0x13
L_92bff4:
	or r1,r1,0xa6000000
L_92bffc:
	extb_s r2,r0
L_92bffe:
	add2_s r3,r3,r2
L_92c000:
	st_s r1,[r3]
L_92c002:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_92c004:
	st_s r0,[r14]
	.global L_92c006
L_92c006:
	ld_s r0,[gp,-0xc]
L_92c008:
	ldb_s r1,[r13]
L_92c00a:
	bclr r0,r0,r1
L_92c00e:
	st.as r0,[gp,-0x3]
L_92c012:
	bl.d L_936d50
L_92c016:
	mov_s r0,0x0
	.global L_92c018
L_92c018:
	b L_92027c
