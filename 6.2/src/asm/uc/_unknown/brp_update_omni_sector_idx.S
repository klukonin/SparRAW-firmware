/* brp_update_omni_sector_idx @ 0x923970, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brp_update_omni_sector_idx sta:%u directed_omni rx sect idx:%u
 * Зовут его: brp_init__flow, brp_responder_flow_enter
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__uc_set32_s8_w15, rng__rand_below, uc_log__emit2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp_update_omni_sector_idx
brp_update_omni_sector_idx:
	.global L_923970
L_923970:
	push_s blink
L_923972:
	bl L_920230
L_923976:
	mov_s r15,r0
L_923978:
	mov_s r0,0x8014a4
L_92397e:
	ld_s r0,[r0,0x1c]
L_923980:
	breq_s r0,0,L_92398e
L_923982:
	mov_s r0,0x8577a0
L_923988:
	ldb_s r0,[r0,0x14]
L_92398a:
	brge r0,0x2,L_9239d6
	.global L_92398e
L_92398e:
	asl_s r14,r15,0x4
L_923990:
	add2_s r14,r14,r14
L_923992:
	add_s r14,r14,0x801104
L_923998:
	brne_s r1,0,L_9239ac
L_92399a:
	bl.d L_936de0
L_92399e:
	mov_s r0,0x0
L_9239a0:
	btst_s r0,0x0
L_9239a2:
	mov.ne r13,0x7fff
L_9239aa:
	bne_s L_9239b0
	.global L_9239ac
L_9239ac:
	add3 r13,r15,0xc
	.global L_9239b0
L_9239b0:
	ld_s r0,[r14,0xc]
L_9239b2:
	lsr_s r0,r0,0x8
L_9239b4:
	bmsk_s r0,r0,0xe
L_9239b6:
	breq r13,r0,L_9239d6
L_9239ba:
	mov_s r1,0x1000958
L_9239c0:
	mov_s r0,0x0
L_9239c2:
	mov_s r2,r15
L_9239c4:
	bl.d L_92d27c
L_9239c8:
	mov_s r3,r13
L_9239ca:
	bmsk r1,r13,0xe
L_9239ce:
	add r0,r14,0xc
L_9239d2:
	bl L_93e414
	.global L_9239d6
L_9239d6:
	b L_92029c
L_9239da:
	nop_s
