/* lmac_if__send_selective_neighbor_cfg @ 0x8d8a7c, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending CMD_SELECTIVE_NEIGHBOR_CFG [selective_detection_en=%d, threshold=%d, num_rates_reduction=%d,
 *   selective_nav_en=%d, threshold=%d, short_txop_en=%d]
 * Зовут его: MAINTAIN_SM__FBF_DELAYED, maintain_sm__reset_link_cfg
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit3, lmac_mbox__alloc_slot, send_cmd2_lmac
 * Глобалы (через gp): 0x800254, 0x800255
 */
	.section .text.lmac_if__send_selective_neighbor_cfg,"ax",@progbits
	.global lmac_if__send_selective_neighbor_cfg
lmac_if__send_selective_neighbor_cfg:
	.global L_8d8a7c
L_8d8a7c:
	push_s blink
L_8d8a7e:
	bl L_8c02b8
L_8d8a82:
	mov_s r15,r0
L_8d8a84:
	mov_s r13,r1
L_8d8a86:
	mov_s r17,r2
L_8d8a88:
	bl.d L_8c2b0c
L_8d8a8c:
	mov_s r16,r3
L_8d8a8e:
	ld.as r1,[gp,0x39]
L_8d8a92:
	mov_s r14,r0
L_8d8a94:
	bbit0 r1,0x10,L_8d8aa4
L_8d8a98:
	brne r15,0x1,L_8d8aa4
L_8d8a9c:
	mov_s r0,0x1
L_8d8a9e:
	stb_s r0,[r14]
L_8d8aa0:
	ldb_s r0,[gp,0xe4]
L_8d8aa2:
	b_s L_8d8aaa
	.global L_8d8aa4
L_8d8aa4:
	mov_s r0,0x0
L_8d8aa6:
	stb_s r0,[r14]
L_8d8aa8:
	mov_s r0,0x2d
	.global L_8d8aaa
L_8d8aaa:
	stb_s r0,[r14,0x1]
L_8d8aac:
	bbit0 r1,0x11,L_8d8abc
L_8d8ab0:
	brne r13,0x1,L_8d8abc
L_8d8ab4:
	mov_s r0,0x1
L_8d8ab6:
	stb_s r0,[r14,0x2]
L_8d8ab8:
	ldb_s r0,[gp,0xe5]
L_8d8aba:
	b_s L_8d8ac2
	.global L_8d8abc
L_8d8abc:
	mov_s r0,0x0
L_8d8abe:
	stb_s r0,[r14,0x2]
L_8d8ac0:
	mov_s r0,0x2d
	.global L_8d8ac2
L_8d8ac2:
	stb_s r0,[r14,0x3]
L_8d8ac4:
	bbit0 r1,0x12,L_8d8ace
L_8d8ac8:
	mov_s r0,0x1
L_8d8aca:
	breq r17,0x1,L_8d8ad0
	.global L_8d8ace
L_8d8ace:
	mov_s r0,0x0
	.global L_8d8ad0
L_8d8ad0:
	stb_s r0,[r14,0x4]
L_8d8ad2:
	mov_s r0,0x854880
L_8d8ad8:
	stb r16,[r14, 0x5]
L_8d8adc:
	ld_s r1,[r0,0x78]
L_8d8ade:
	bmsk_s r15,r15,0x0
L_8d8ae0:
	bclr_s r1,r1,0x15
L_8d8ae2:
	asl r4,r15,0x15
L_8d8ae6:
	bclr_s r1,r1,0x16
L_8d8ae8:
	bclr r15,r4,0x16
L_8d8aec:
	bmsk_s r13,r13,0x0
L_8d8aee:
	or_s r1,r1,r15
L_8d8af0:
	asl_s r13,r13,0x16
L_8d8af2:
	or_s r1,r1,r13
L_8d8af4:
	bmsk r2,r17,0x0
L_8d8af8:
	bclr_s r1,r1,0xf
L_8d8afa:
	asl_s r2,r2,0xf
L_8d8afc:
	or_s r1,r1,r2
L_8d8afe:
	st_s r1,[r0,0x78]
L_8d8b00:
	ldb r4,[r14, 0x1]
L_8d8b04:
	mov_s r2,0x1004f24
L_8d8b0a:
	ldb r5,[r14, 0x5]
L_8d8b0e:
	mov_s r0,0xb
L_8d8b10:
	mov_s r1,0x2
L_8d8b12:
	bl.d L_8ee034
L_8d8b16:
	ldb_s r3,[r14]
L_8d8b18:
	mov_s r2,0x1004f8c
L_8d8b1e:
	ldb r4,[r14, 0x3]
L_8d8b22:
	mov_s r0,0xb
L_8d8b24:
	ldb r5,[r14, 0x4]
L_8d8b28:
	mov_s r1,0x2
L_8d8b2a:
	bl.d L_8ee034
L_8d8b2e:
	ldb_s r3,[r14,0x2]
L_8d8b30:
	mov_s r0,r14
L_8d8b32:
	mov_s r1,0x1e
L_8d8b34:
	mov_s r2,0x8
L_8d8b36:
	bl.d L_8e0694
L_8d8b3a:
	mov_s r3,0x0
L_8d8b3c:
	b L_8c031c
