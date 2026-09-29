/* lmac_if__send_bcon_mgt @ 0x8db288, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Send CMD_BCON_MGT: flags.pcp_assoc_ready = %x, discovery_mode = %d
 * Зовут его: bcn_tx_init_ss_params
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit2, lmac_if__build_bcon_cfg, lmac_if__post_cmd, mem_pool__alloc_locked, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__send_bcon_mgt
lmac_if__send_bcon_mgt:
	.global L_8db288
L_8db288:
	sub_s sp,sp,0x8
L_8db28a:
	push_s blink
L_8db28c:
	bl L_8c01d4
L_8db290:
	mov_s r17,r2
L_8db292:
	mov_s r16,r3
L_8db294:
	mov_s r18,r0
L_8db296:
	mov_s r15,r1
L_8db298:
	mov_s r0,0x804280
L_8db29e:
	bl.d L_8c33d0
L_8db2a2:
	mov_s r13,r4
L_8db2a4:
	mov.f r14,r0
L_8db2a8:
	beq_s L_8db2f4
L_8db2aa:
	cmp_s r13,0x0
L_8db2ac:
	mov.ne r0,r14
L_8db2b0:
	mov_s r12,0x5b
L_8db2b2:
	add.ne r0,r0,r12
L_8db2b6:
	mov.ne r1,r13
L_8db2ba:
	bl.ne.d L_8c0380
L_8db2be:
	mov.ne r2,0x6
L_8db2c2:
	st_s r15,[r14,0x50]
L_8db2c4:
	mov_s r0,r14
L_8db2c6:
	mov_s r1,r18
L_8db2c8:
	mov_s r2,r17
L_8db2ca:
	bl.d L_8db260
L_8db2ce:
	mov_s r3,r16
L_8db2d0:
	ld_s r3,[r14,0x64]
L_8db2d2:
	mov_s r1,0x1004b04
L_8db2d8:
	lsr r2,r3,0x3
L_8db2dc:
	lsr_s r3,r3
L_8db2de:
	mov_s r0,0x25
L_8db2e0:
	bmsk_s r2,r2,0x0
L_8db2e2:
	bl.d L_8dcc80
L_8db2e6:
	bmsk_s r3,r3,0x0
L_8db2e8:
	mov_s r0,r14
L_8db2ea:
	mov_s r1,0xb
L_8db2ec:
	mov_s r2,0x70
L_8db2ee:
	bl.d L_8e5204
L_8db2f2:
	mov_s r3,0x0
	.global L_8db2f4
L_8db2f4:
	mov_s r12,0xc
L_8db2f6:
	b L_8c0236
L_8db2fa:
	nop_s
