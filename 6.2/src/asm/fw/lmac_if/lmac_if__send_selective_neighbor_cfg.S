/* lmac_if__send_selective_neighbor_cfg @ 0x8dbd94, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending CMD_SELECTIVE_NEIGHBOR_CFG [selective_detection_en=%d, threshold=%d, num_rates_reduction=%d,
 *   selective_nav_en=%d, threshold=%d, short_txop_en=%d]
 * Зовут его: maintain_sm__action_8cab64, maintain_sm__reset_rate_params
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit3, lmac_cmd_pool__alloc, lmac_if__post_cmd
 * Глобалы (через gp): 0x80026c, 0x80026d
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__send_selective_neighbor_cfg
lmac_if__send_selective_neighbor_cfg:
	.global L_8dbd94
L_8dbd94:
	push_s blink
L_8dbd96:
	bl L_8c01d8
L_8dbd9a:
	mov_s r15,r0
L_8dbd9c:
	mov_s r13,r1
L_8dbd9e:
	mov_s r17,r2
L_8dbda0:
	bl.d L_8c3284
L_8dbda4:
	mov_s r16,r3
L_8dbda6:
	mov_s r14,r0
L_8dbda8:
	ld_s r0,[gp,0xe8]
L_8dbdaa:
	bbit0 r0,0x10,L_8dbdba
L_8dbdae:
	brne r15,0x1,L_8dbdba
L_8dbdb2:
	mov_s r0,0x1
L_8dbdb4:
	stb_s r0,[r14]
L_8dbdb6:
	ldb_s r0,[gp,0xe8]
L_8dbdb8:
	b_s L_8dbdc0
	.global L_8dbdba
L_8dbdba:
	mov_s r0,0x0
L_8dbdbc:
	stb_s r0,[r14]
L_8dbdbe:
	mov_s r0,0x2d
	.global L_8dbdc0
L_8dbdc0:
	stb_s r0,[r14,0x1]
L_8dbdc2:
	ld_s r0,[gp,0xe8]
L_8dbdc4:
	bbit0 r0,0x11,L_8dbdd4
L_8dbdc8:
	brne r13,0x1,L_8dbdd4
L_8dbdcc:
	mov_s r0,0x1
L_8dbdce:
	stb_s r0,[r14,0x2]
L_8dbdd0:
	ldb_s r0,[gp,0xe9]
L_8dbdd2:
	b_s L_8dbdda
	.global L_8dbdd4
L_8dbdd4:
	mov_s r0,0x0
L_8dbdd6:
	stb_s r0,[r14,0x2]
L_8dbdd8:
	mov_s r0,0x2d
	.global L_8dbdda
L_8dbdda:
	stb_s r0,[r14,0x3]
L_8dbddc:
	ld_s r0,[gp,0xe8]
L_8dbdde:
	bbit0 r0,0x12,L_8dbde8
L_8dbde2:
	mov_s r0,0x1
L_8dbde4:
	breq r17,0x1,L_8dbdea
	.global L_8dbde8
L_8dbde8:
	mov_s r0,0x0
	.global L_8dbdea
L_8dbdea:
	stb_s r0,[r14,0x4]
L_8dbdec:
	mov_s r0,0x853900
L_8dbdf2:
	stb r16,[r14, 0x5]
L_8dbdf6:
	ld_s r1,[r0,0x18]
L_8dbdf8:
	bmsk_s r15,r15,0x0
L_8dbdfa:
	bclr_s r1,r1,0x15
L_8dbdfc:
	asl r4,r15,0x15
L_8dbe00:
	bclr_s r1,r1,0x16
L_8dbe02:
	bclr r15,r4,0x16
L_8dbe06:
	bmsk_s r13,r13,0x0
L_8dbe08:
	or_s r1,r1,r15
L_8dbe0a:
	asl_s r13,r13,0x16
L_8dbe0c:
	or_s r1,r1,r13
L_8dbe0e:
	bmsk r2,r17,0x0
L_8dbe12:
	bclr_s r1,r1,0xf
L_8dbe14:
	asl_s r2,r2,0xf
L_8dbe16:
	or_s r1,r1,r2
L_8dbe18:
	st_s r1,[r0,0x18]
L_8dbe1a:
	ldb r4,[r14, 0x5]
L_8dbe1e:
	mov_s r1,0x1004b98
L_8dbe24:
	ldb_s r2,[r14]
L_8dbe26:
	mov_s r0,0x2b
L_8dbe28:
	bl.d L_8dcd00
L_8dbe2c:
	ldb_s r3,[r14,0x1]
L_8dbe2e:
	mov_s r1,0x1004c00
L_8dbe34:
	ldb r4,[r14, 0x4]
L_8dbe38:
	mov_s r0,0x2b
L_8dbe3a:
	ldb_s r2,[r14,0x2]
L_8dbe3c:
	bl.d L_8dcd00
L_8dbe40:
	ldb_s r3,[r14,0x3]
L_8dbe42:
	mov_s r0,r14
L_8dbe44:
	mov_s r1,0x1e
L_8dbe46:
	mov_s r2,0x8
L_8dbe48:
	bl.d L_8e5204
L_8dbe4c:
	mov_s r3,0x0
L_8dbe4e:
	b L_8c023c
L_8dbe52:
	nop_s
