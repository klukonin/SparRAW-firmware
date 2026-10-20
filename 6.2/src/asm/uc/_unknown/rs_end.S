/* rs_end @ 0x92fdb4, 336 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rs_end cid:%u mcs:%u
 * Зовут его: background_task__dispatch, rs_start
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, memcpy_uc, memset0_words_uc, rate_search__apply_mcs, uc_log__emit2, uc_send_evt__rs_done, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rs_end
rs_end:
	.global L_92fdb4
L_92fdb4:
	push_s blink
L_92fdb6:
	bl L_92021c
L_92fdba:
	ld_s r0,[gp,-0x4]
L_92fdbc:
	sub_s sp,sp,0x30
L_92fdbe:
	breq_s r0,0,L_92fdf6
	.global L_92fdc0
L_92fdc0:
	mov r16,0x802670
L_92fdc8:
	add r20,r16,0x1e
	.global L_92fdcc
L_92fdcc:
	ld_s r0,[gp,-0x4]
L_92fdce:
	norm r0,r0
L_92fdd2:
	rsub r14,r0,0x1e
L_92fdd6:
	extb_s r15,r14
L_92fdd8:
	mul64 r15,0x2c
L_92fddc:
	add r0,r16,mlo
L_92fde0:
	ldb_s r13,[r0,0x1a]
L_92fde2:
	brne_s r13,0,L_92fde6
L_92fde4:
	ldb_s r13,[r0,0x1c]
	.global L_92fde6
L_92fde6:
	mov_s r0,0x801498
L_92fdec:
	ld_s r0,[r0,0x8]
L_92fdee:
	bbit1 r0,0x8,L_92fe04
L_92fdf2:
	mov_s r0,0x0
L_92fdf4:
	b_s L_92fe0c
	.global L_92fdf6
L_92fdf6:
	mov_s r0,blink
L_92fdf8:
	mov_s r1,0x131b
L_92fdfe:
	bl L_926618
L_92fe02:
	b_s L_92fdc0
	.global L_92fe04
L_92fe04:
	mov_s r0,0x80148c
L_92fe0a:
	ldb_s r0,[r0,0x8]
	.global L_92fe0c
L_92fe0c:
	breq_s r0,0,L_92fe2c
L_92fe0e:
	sub r1,r13,r0
L_92fe12:
	cmp_s r1,0x5
L_92fe14:
	cmp.ne r1,0x9
L_92fe18:
	bne_s L_92fe22
L_92fe1a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92fe1c:
	sub_s r13,r13,r0
L_92fe1e:
	extb_s r13,r13
L_92fe20:
	b_s L_92fe2c
	.global L_92fe22
L_92fe22:
	brlt r1,0x1,L_92fe2a
L_92fe26:
	extb_s r13,r1
L_92fe28:
	b_s L_92fe2c
	.global L_92fe2a
L_92fe2a:
	mov_s r13,0x1
	.global L_92fe2c
L_92fe2c:
	mov_s r0,0x8006ac
L_92fe32:
	ldb_s r0,[r0,r15]
L_92fe34:
	bbit0 r0,0x7,L_92fe3c
L_92fe38:
	bmsk r13,r0,0x6
	.global L_92fe3c
L_92fe3c:
	brhs r14,0x8,L_92fee8
	.global L_92fe40
L_92fe40:
	brhs r13,0xd,L_92fef6
	.global L_92fe44
L_92fe44:
	mov r17,0x0
L_92fe48:
	asl_s r0,r14,0x2
L_92fe4a:
	add1_s r0,r0,r0
L_92fe4c:
	add r1,r0,0x802610
L_92fe54:
	st r17,[r1]
L_92fe58:
	mov_s r1,0x10013a0
L_92fe5e:
	mov_s r0,0x0
L_92fe60:
	mov_s r2,r14
L_92fe62:
	bl.d L_92d27c
L_92fe66:
	mov_s r3,r13
L_92fe68:
	mul64 r14,0x2c
L_92fe6c:
	extb_s r0,r13
L_92fe6e:
	mov_s r18,r0
L_92fe70:
	add r12,r20,mlo
L_92fe74:
	stb_s r13,[r12]
L_92fe76:
	bl.d L_9300d0
L_92fe7a:
	mov_s r1,r14
L_92fe7c:
	mov_s r1,0x802910
L_92fe82:
	add2_s r1,r1,r14
L_92fe84:
	ld_s r0,[r1,0x10]
L_92fe86:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92fe88:
	st_s r0,[r1,0x10]
L_92fe8a:
	mov_s r0,sp
L_92fe8c:
	bl.d L_920a84
L_92fe90:
	mov_s r1,0x30
L_92fe92:
	mul64 r15,0x2c
L_92fe96:
	mov_s r0,sp
L_92fe98:
	add r19,r16,mlo
L_92fe9c:
	mov_s r15,mlo
L_92fe9e:
	mov_s r1,r19
L_92fea0:
	bl.d L_920330
L_92fea4:
	mov_s r2,0xd
L_92fea6:
	add r0,sp,0xd
L_92feaa:
	add r1,r19,0xd
L_92feae:
	bl.d L_920330
L_92feb2:
	mov_s r2,0xd
L_92feb4:
	stb r13,[sp, 0x1e]
L_92feb8:
	stb_s r14,[sp,0x2c]
L_92feba:
	add r0,r18,r16
L_92febe:
	add_s r1,r0,r15
L_92fec0:
	ldb_s r1,[r1,0xd]
L_92fec2:
	stb r13,[sp, 0x2d]
L_92fec6:
	ldb_s r0,[r0,r15]
L_92fec8:
	st_s r1,[sp,0x24]
L_92feca:
	st_s r0,[sp,0x20]
L_92fecc:
	st r17,[sp, 0x28]
L_92fed0:
	bl.d L_927738
L_92fed4:
	mov_s r0,sp
L_92fed6:
	ld_s r0,[gp,-0x4]
L_92fed8:
	bclr.f r0,r0,r14
L_92fedc:
	st.as r0,[gp,-0x1]
L_92fee0:
	bne_s L_92fdcc
L_92fee2:
	b.d L_920274
L_92fee6:
	add_s sp,sp,0x30
	.global L_92fee8
L_92fee8:
	mov_s r0,blink
L_92feea:
	mov_s r1,0x1472
L_92fef0:
	bl L_926618
L_92fef4:
	b_s L_92fe40
	.global L_92fef6
L_92fef6:
	mov_s r0,blink
L_92fef8:
	mov_s r1,0x1473
L_92fefe:
	bl L_926618
L_92ff02:
	b_s L_92fe44
