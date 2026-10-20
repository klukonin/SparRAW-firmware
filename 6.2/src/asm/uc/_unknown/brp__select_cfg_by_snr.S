/* brp__select_cfg_by_snr @ 0x922d2c, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: config_brp_rf
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, memcpy_uc, memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__select_cfg_by_snr
brp__select_cfg_by_snr:
	.global L_922d2c
L_922d2c:
	push_s blink
L_922d2e:
	bl L_920228
L_922d32:
	st.a r0,[sp,-0x10]
L_922d36:
	mov_s r13,r3
L_922d38:
	mov r17,r4
L_922d3c:
	mov r16,r5
L_922d40:
	btst_s r1,0x7
L_922d42:
	mov.ne r3,0x4
L_922d46:
	mov.ne r0,0x3
L_922d4a:
	bne_s L_922d5e
L_922d4c:
	btst_s r1,0x6
L_922d4e:
	mov.ne r3,0x2
L_922d52:
	bne_s L_922d5c
L_922d54:
	btst_s r1,0x5
L_922d56:
	mov_s r3,0x1
L_922d58:
	mov.eq r3,0x0
	.global L_922d5c
L_922d5c:
	mov_s r0,r3
	.global L_922d5e
L_922d5e:
	add_s r2,r2,r3
L_922d60:
	asr_s r2,r2,r0
L_922d62:
	add_s r1,r1,r3
L_922d64:
	asr_s r1,r1,r0
L_922d66:
	extb_s r2,r2
L_922d68:
	min r0,r2,0x1f
L_922d6c:
	extb_s r1,r1
L_922d6e:
	min r1,r1,0x1f
L_922d72:
	extb_s r0,r0
L_922d74:
	mov_s r2,0x800fc0
L_922d7a:
	ldb_s r14,[r2,r0]
L_922d7c:
	extb_s r1,r1
L_922d7e:
	ldb_s r15,[r2,r1]
L_922d80:
	add_s r0,sp,0x4
L_922d82:
	bl.d L_920a84
L_922d86:
	mov_s r1,0xc
L_922d88:
	sub_s r15,r15,r14
L_922d8a:
	sexb_s r15,r15
L_922d8c:
	add r0,r15,r17
L_922d90:
	sexb_s r0,r0
L_922d92:
	max r0,r0,0x0
L_922d96:
	sexb_s r0,r0
L_922d98:
	brge r0,0x5,L_922dac
L_922d9c:
	mov_s r1,0x80088c
L_922da2:
	ldb_s r1,[r1,0x4]
L_922da4:
	bbit0 r1,0x6,L_922dac
L_922da8:
	st_s r13,[sp,0xc]
L_922daa:
	b_s L_922e00
	.global L_922dac
L_922dac:
	brge r0,0xd,L_922dc2
L_922db0:
	mov_s r1,0x80088c
L_922db6:
	ldb_s r1,[r1,0x4]
L_922db8:
	bbit0 r1,0x5,L_922dc2
L_922dbc:
	st_s r13,[sp,0xc]
L_922dbe:
	st_s r13,[sp,0x4]
L_922dc0:
	b_s L_922e02
	.global L_922dc2
L_922dc2:
	brge r0,0x15,L_922dd6
L_922dc6:
	mov_s r1,0x80088c
L_922dcc:
	ldb_s r1,[r1,0x4]
L_922dce:
	bbit0 r1,0x4,L_922dd6
L_922dd2:
	st_s r13,[sp,0xc]
L_922dd4:
	b_s L_922e02
	.global L_922dd6
L_922dd6:
	brge r0,0x1d,L_922dec
L_922dda:
	mov_s r1,0x80088c
L_922de0:
	ldb_s r1,[r1,0x4]
L_922de2:
	bbit0 r1,0x3,L_922dec
L_922de6:
	st_s r13,[sp,0x8]
L_922de8:
	st_s r13,[sp,0x4]
L_922dea:
	b_s L_922e02
	.global L_922dec
L_922dec:
	brge r0,0x25,L_922dfc
L_922df0:
	mov_s r0,0x80088c
L_922df6:
	ldb_s r0,[r0,0x4]
L_922df8:
	bbit1 r0,0x2,L_922e00
	.global L_922dfc
L_922dfc:
	breq r16,0x0,L_922e02
	.global L_922e00
L_922e00:
	st_s r13,[sp,0x8]
	.global L_922e02
L_922e02:
	ld_s r0,[sp,0x0]
L_922e04:
	add_s r1,sp,0x4
L_922e06:
	bl.d L_920330
L_922e0a:
	mov_s r2,0xc
L_922e0c:
	b.d L_92028c
L_922e10:
	add_s sp,sp,0x10
L_922e12:
	nop_s
