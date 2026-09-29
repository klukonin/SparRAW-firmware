/* lmac_if__send_bcon_mgt @ 0x8d80dc, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Send CMD_BCON_MGT: flags.pcp_assoc_ready = %x, discovery_mode = %d
 * Зовут его: add_discovery_bcon, tx_bcon__update_bcon
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, basic_if__alloc_mbox_slot, fw_log__emit2, lmac_if__build_bcon_cfg, memcpy_fw, send_cmd2_lmac
 */
	.section .text.lmac_if__send_bcon_mgt,"ax",@progbits
	.global lmac_if__send_bcon_mgt
lmac_if__send_bcon_mgt:
	.global L_8d80dc
L_8d80dc:
	sub_s sp,sp,0x8
L_8d80de:
	push_s blink
L_8d80e0:
	bl L_8c02b4
L_8d80e4:
	mov_s r17,r2
L_8d80e6:
	mov_s r16,r3
L_8d80e8:
	mov_s r18,r0
L_8d80ea:
	mov_s r15,r1
L_8d80ec:
	mov_s r0,0x803e3c
L_8d80f2:
	bl.d L_8c2c38
L_8d80f6:
	mov_s r13,r4
L_8d80f8:
	mov.f r14,r0
L_8d80fc:
	beq_s L_8d814e
L_8d80fe:
	cmp_s r13,0x0
L_8d8100:
	mov.ne r0,r14
L_8d8104:
	mov_s r12,0x7f
L_8d8106:
	add.ne r0,r0,r12
L_8d810a:
	mov.ne r1,r13
L_8d810e:
	bl.ne.d L_8c0460
L_8d8112:
	mov.ne r2,0x6
L_8d8116:
	st_s r15,[r14,0x74]
L_8d8118:
	mov_s r0,r14
L_8d811a:
	mov_s r1,r18
L_8d811c:
	mov_s r2,r17
L_8d811e:
	bl.d L_8d80b4
L_8d8122:
	mov_s r3,r16
L_8d8124:
	ld r13,[r14, 0x88]
L_8d8128:
	mov_s r2,0x1004e90
L_8d812e:
	lsr r3,r13,0x3
L_8d8132:
	lsr_s r13,r13
L_8d8134:
	mov_s r0,0x5
L_8d8136:
	mov_s r1,0x2
L_8d8138:
	bmsk_s r3,r3,0x0
L_8d813a:
	bl.d L_8edff8
L_8d813e:
	bmsk r4,r13,0x0
L_8d8142:
	mov_s r0,r14
L_8d8144:
	mov_s r1,0xb
L_8d8146:
	mov_s r2,0x94
L_8d8148:
	bl.d L_8e0694
L_8d814c:
	mov_s r3,0x0
	.global L_8d814e
L_8d814e:
	mov_s r12,0xc
L_8d8150:
	b L_8c0316
