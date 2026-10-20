/* background_bi_step @ 0x936bac, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_task__dispatch
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bi_ap_mon__window_code, uc_pm__enter_idle, uc_tsf_elapsed
 * Глобалы (через gp): 0x800580, 0x800584, 0x80058c
 */
	.section .text.background_bi_step,"ax",@progbits
	.global background_bi_step
background_bi_step:
	.global L_936bac
L_936bac:
	push_s blink
L_936bae:
	bl L_920214
L_936bb2:
	ld_s r0,[gp,0x64]
L_936bb4:
	mov_s r14,0x1
L_936bb6:
	breq r0,0x0,L_936c76
L_936bba:
	bl L_926490
L_936bbe:
	mov_s r13,0x8009cc
L_936bc4:
	brne r0,0x1,L_936bd0
L_936bc8:
	ld_s r0,[gp,-0x4c]
L_936bca:
	breq_s r0,0,L_936bd0
L_936bcc:
	ld_s r0,[r13,0x10]
L_936bce:
	brne_s r0,0,L_936bd6
	.global L_936bd0
L_936bd0:
	mov_s r14,0x0
L_936bd2:
	st_s r14,[r13,0x14]
L_936bd4:
	b_s L_936c76
	.global L_936bd6
L_936bd6:
	mov_s r0,0xf000001
L_936bdc:
	mov_s r32,r0
L_936bde:
	st.ab r0,[r25,0x4]
L_936be2:
	bclr r25,r25,0xa
L_936be6:
	ld_s r0,[gp,-0x44]
L_936be8:
	and r0,r0,0xfffff0ff
L_936bf0:
	bset r1,r0,0x8
L_936bf4:
	bset_s r1,r1,0x9
L_936bf6:
	or r0,r0,0x1d000300
L_936bfe:
	st.as r1,[gp,-0x11]
L_936c02:
	mov_s r32,r0
L_936c04:
	st.ab r0,[r25,0x4]
L_936c08:
	bclr r25,r25,0xa
L_936c0c:
	nop_s
L_936c0e:
	nop_s
L_936c10:
	nop_s
L_936c12:
	bclr.f 0x0,r41,0x1e
L_936c16:
	beq_s L_936c20
L_936c18:
	mov_s r0,0x1
	.global L_936c1a
L_936c1a:
	st_s r0,[r13,0x14]
L_936c1c:
	mov_s r14,0x0
L_936c1e:
	b_s L_936c76
	.global L_936c20
L_936c20:
	mov_s r0,r42
L_936c22:
	btst_s r0,0x13
L_936c24:
	mov_s r0,0x2
L_936c26:
	bne_s L_936c1a
L_936c28:
	ld_s r0,[r13,0x1c]
L_936c2a:
	brne_s r0,0,L_936c6c
L_936c2c:
	bl.d L_924568
L_936c30:
	ld_s r0,[r13,0x8]
L_936c32:
	ld.as r1,[gp,0x16]
L_936c36:
	cmp_s r0,r1
L_936c38:
	mov.cs r0,0x3
L_936c3c:
	blo_s L_936c1a
L_936c3e:
	mov_s r14,0x1
L_936c40:
	mov_s r1,0x0
L_936c42:
	b_s L_936c66
	.global L_936c44
L_936c44:
	asl_s r0,r1,0x2
L_936c46:
	add2_s r0,r0,r0
L_936c48:
	add_s r0,r0,0x857838
L_936c4e:
	ldb_s r2,[r0,0x4]
L_936c50:
	brne_s r2,0,L_936c56
L_936c52:
	ldb_s r2,[r0,0x5]
L_936c54:
	breq_s r2,0,L_936c64
	.global L_936c56
L_936c56:
	ldw_s r2,[r0,0x2]
L_936c58:
	ld_s r0,[gp,0x5c]
L_936c5a:
	brhs r2,r0,L_936c64
L_936c5e:
	mov_s r0,0x4
L_936c60:
	st_s r0,[r13,0x14]
L_936c62:
	mov_s r14,0x0
	.global L_936c64
L_936c64:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_936c66
L_936c66:
	brlo r1,0x8,L_936c44
L_936c6a:
	b_s L_936c6e
	.global L_936c6c
L_936c6c:
	mov_s r14,0x0
	.global L_936c6e
L_936c6e:
	cmp_s r14,0x0
L_936c70:
	bl.ne.d L_936ca8
L_936c74:
	sub_s.ne r0,r0,r0
	.global L_936c76
L_936c76:
	b.d L_920284
L_936c7a:
	mov_s r0,r14
