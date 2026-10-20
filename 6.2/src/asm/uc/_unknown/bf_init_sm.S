/* bf_init_sm @ 0x9219f4, 324 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bf_init_sm cmd_type:%u cid:%u src:%u
 * Зовут его: bf__trigger_for_mid, ucode_cmd_trigger_bf
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bf__abort_step, bf__reset_sta_slot, bf_req__enqueue, bf_sm__set_sta_state, memset0_words_uc, uc_log__emit3, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_init_sm
bf_init_sm:
	.global L_9219f4
L_9219f4:
	push_s blink
L_9219f6:
	bl L_920228
L_9219fa:
	mov_s r14,r0
L_9219fc:
	push_s r1
L_9219fe:
	ld_s r13,[r0,0x8]
L_921a00:
	mov_s r1,0x1000d14
L_921a06:
	mov_s r0,0x20
L_921a08:
	ld_s r2,[r14]
L_921a0a:
	mov_s r3,r13
L_921a0c:
	bl.d L_92d338
L_921a10:
	ld r4,[sp]
L_921a14:
	ld_s r0,[r14]
L_921a16:
	mov_s r15,0x801ffc
L_921a1c:
	brne_s r0,0,L_921a3c
L_921a1e:
	mov_s r13,0x8020fc
L_921a24:
	add r0,r13,0x14
L_921a28:
	bl.d L_920a84
L_921a2c:
	mov_s r1,0x1c
L_921a2e:
	mov_s r0,r15
L_921a30:
	bl.d L_920a84
L_921a34:
	mov_s r1,0xc8
L_921a36:
	ld_s r0,[gp,-0x30]
L_921a38:
	st_s r0,[r13,0x20]
L_921a3a:
	b_s L_921b32
	.global L_921a3c
L_921a3c:
	mov r16,0x0
L_921a40:
	ld r0,[r15, 0xb4]
L_921a44:
	bset r16,r16,r13
L_921a48:
	tst r0,r16
L_921a4c:
	beq_s L_921a88
L_921a4e:
	asl_s r1,r13,0x2
L_921a50:
	add2_s r1,r1,r1
L_921a52:
	add_s r1,r1,0x857e38
L_921a58:
	ldb_s r0,[r1,0x11]
L_921a5a:
	mov_s r2,r0
L_921a5c:
	and r3,r0,0x10
L_921a60:
	bic r2,r2,-0xc0
L_921a64:
	breq r3,r2,L_921a70
L_921a68:
	bclr r2,r0,0x4
L_921a6c:
	extb_s r0,r2
L_921a6e:
	stb_s r2,[r1,0x11]
	.global L_921a70
L_921a70:
	bic r0,r0,-0x41
L_921a74:
	sub.f r0,r0,0x0
L_921a78:
	mov.ne r0,0x1
L_921a7c:
	extb.f 0x0,r0
L_921a80:
	beq_s L_921b32
L_921a82:
	bl.d L_92484c
L_921a86:
	mov_s r0,r13
	.global L_921a88
L_921a88:
	mov_s r0,0x80217c
L_921a8e:
	add2_s r0,r0,r13
L_921a90:
	ld_s r1,[r0,0x1c]
L_921a92:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_921a94:
	st_s r1,[r0,0x1c]
L_921a96:
	ld_s r0,[sp,0x0]
L_921a98:
	brne r0,0x1,L_921aac
L_921a9c:
	asl_s r0,r13,0x2
L_921a9e:
	add2_s r0,r0,r0
L_921aa0:
	add_s r0,r0,0x857e38
L_921aa6:
	ldb_s r1,[r0,0x11]
L_921aa8:
	bset_s r1,r1,0x4
L_921aaa:
	stb_s r1,[r0,0x11]
	.global L_921aac
L_921aac:
	ld_s r0,[r14,0x4]
L_921aae:
	mov r17,0x0
L_921ab2:
	breq_s r0,0,L_921ac4
L_921ab4:
	breq r0,0x1,L_921ac8
L_921ab8:
	mov_s r0,blink
L_921aba:
	bl.d L_926618
L_921abe:
	mov_s r1,0x16
L_921ac0:
	mov_s r1,r17
L_921ac2:
	b_s L_921ad8
	.global L_921ac4
L_921ac4:
	mov_s r1,0x2
L_921ac6:
	b_s L_921ad8
	.global L_921ac8
L_921ac8:
	mov_s r0,0x8021d8
L_921ace:
	ldb_s r0,[r0,0x5]
L_921ad0:
	mov_s r1,0x9
L_921ad2:
	cmp_s r0,0x0
L_921ad4:
	mov.eq r1,0x11
	.global L_921ad8
L_921ad8:
	lr r14,[0xa]
L_921adc:
	bclr r0,r14,0x1
L_921ae0:
	flag r0
L_921ae4:
	ld r0,[r15, 0xb4]
L_921ae8:
	tst r0,r16
L_921aec:
	bne_s L_921afc
L_921aee:
	mov_s r2,0x800fec
L_921af4:
	bl.d L_921bd4
L_921af8:
	extb_s r0,r13
L_921afa:
	b_s L_921b04
	.global L_921afc
L_921afc:
	bl.d L_92b220
L_921b00:
	mov_s r0,r13
L_921b02:
	mov_s r0,0x1
	.global L_921b04
L_921b04:
	breq_s r0,0,L_921b24
L_921b06:
	asl_s r0,r13,0x4
L_921b08:
	add2_s r0,r0,r0
L_921b0a:
	add_s r0,r0,0x801124
L_921b10:
	ld_s r2,[r0,0x10]
L_921b12:
	mov_s r1,0x80217c
L_921b18:
	ldw_s r0,[r0,0x14]
L_921b1a:
	st_s r2,[r1,0xc]
L_921b1c:
	stw_s r0,[r1,0x10]
L_921b1e:
	bl.d L_921824
L_921b22:
	mov_s r0,r13
	.global L_921b24
L_921b24:
	lr r0,[0xa]
L_921b28:
	bic r14,r14,-0x3
L_921b2c:
	or_s r14,r14,r0
L_921b2e:
	flag r14
	.global L_921b32
L_921b32:
	b.d L_92028c
L_921b36:
	add_s sp,sp,0x4
