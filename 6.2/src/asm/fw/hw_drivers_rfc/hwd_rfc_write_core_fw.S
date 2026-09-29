/* hwd_rfc_write_core_fw @ 0x8d415c, 388 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   hwd_rfc_write_core busy set before write! (rfc_opcode=%d, rfc_addr=0x%x, rfc_data=0x%x)
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hwd_rfc_write_core busy set - go again!! (rfc_opcode=%d, rfc_addr=0x%x, rfc_data=0x%x)
 *   [NNL] mac_go_when_busy_err_cnt=%d
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd__args_to_regs, hwd__setup_pair, hwd_rfc_read_rgf, hwd_rfc_write_core_fw_mode1, marlon_r_if_class__rf_write_with_block_retries, rf_sector_commit_rx, rf_sector_commit_tx, rfc__read_core_result_fw, rfc__write_core_c_flag
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_write_core_fw
hwd_rfc_write_core_fw:
	.global L_8d415c
L_8d415c:
	push_s blink
L_8d415e:
	bl L_8c01d0
L_8d4162:
	mov_s r16,r0
L_8d4164:
	mov_s r14,r1
L_8d4166:
	mov_s r15,r2
L_8d4168:
	brge.d r0,0x10,L_8d4204
L_8d416c:
	mov_s r19,r3
	.global L_8d416e
L_8d416e:
	brge r14,0x10,L_8d4212
	.global L_8d4172
L_8d4172:
	brlo 0x7fff,r15,L_8d421e
	.global L_8d417a
L_8d417a:
	bmsk r0,r14,0x3
L_8d417e:
	asl r17,r0,0x4
L_8d4182:
	mov_s r13,0x889080
L_8d4188:
	ld_s r0,[r13,0x4c]
L_8d418a:
	mov r18,0x889000
L_8d4192:
	bbit1 r0,0x1d,L_8d422c
	.global L_8d4196
L_8d4196:
	and.f 0x0,r17,0xffff8000
L_8d419e:
	bne_s L_8d4276
	.global L_8d41a0
L_8d41a0:
	ld_s r1,[r13,0x50]
L_8d41a2:
	asl r0,r17,0x10
L_8d41a6:
	and r1,r1,0x8000ffff
L_8d41ae:
	or_s r0,r0,r1
L_8d41b0:
	st_s r0,[r13,0x50]
L_8d41b2:
	ld_s r0,[r13,0x54]
L_8d41b4:
	st_s r15,[r13,0x54]
L_8d41b6:
	ld_s r0,[r13,0x58]
L_8d41b8:
	st r19,[r13, 0x58]
L_8d41bc:
	ld_s r0,[r13,0x4c]
L_8d41be:
	mov lp_count,0x30d40
L_8d41c6:
	bset_s r0,r0,0x1e
L_8d41c8:
	st_s r0,[r13,0x4c]
L_8d41ca:
	lp L_8d41d6
L_8d41ce:
	ld_s r0,[r13,0x4c]
L_8d41d0:
	btst_s r0,0x1d
L_8d41d2:
	beq_s L_8d41d6
L_8d41d4:
	nop_s
	.global L_8d41d6
L_8d41d6:
	ld_s r0,[r13,0x4c]
L_8d41d8:
	bbit0 r0,0x1d,L_8d41ea
L_8d41dc:
	mov_s r2,blink
L_8d41de:
	mov_s r1,0x101e0c0
L_8d41e4:
	bl.d L_8dcc10
L_8d41e8:
	mov_s r0,0x0
	.global L_8d41ea
L_8d41ea:
	ld_s r0,[r13,0x4c]
L_8d41ec:
	bbit1 r0,0x1d,L_8d4280
	.global L_8d41f0
L_8d41f0:
	mov_s r0,0x8019cc
L_8d41f6:
	add2 r0,r0,r16
L_8d41fa:
	ld_s r1,[r0]
L_8d41fc:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8d41fe:
	b.d L_8c022c
L_8d4202:
	st_s r1,[r0]
	.global L_8d4204
L_8d4204:
	mov_s r0,blink
L_8d4206:
	mov_s r1,0x1135
L_8d420c:
	bl L_8c9b28
L_8d4210:
	b_s L_8d416e
	.global L_8d4212
L_8d4212:
	mov_s r0,blink
L_8d4214:
	mov_s r1,0x45
L_8d4216:
	/* bl.d 0x008c9b28 */
	.byte 0x16,0x09,0xef,0xfa
L_8d421a:
	/* _asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8d421c:
	b_s L_8d4172
	.global L_8d421e
L_8d421e:
	mov_s r0,blink
L_8d4220:
	mov_s r1,0x1141
L_8d4226:
	bl L_8c9b28
L_8d422a:
	b_s L_8d417a
	.global L_8d422c
L_8d422c:
	mov_s r1,0x101e0f0
L_8d4232:
	mov_s r0,0x10
L_8d4234:
	mov_s r2,r14
L_8d4236:
	mov_s r3,r15
L_8d4238:
	bl.d L_8dcd00
L_8d423c:
	mov r4,r19
L_8d4240:
	mov lp_count,0x30d40
L_8d4248:
	nop_s
L_8d424a:
	lp L_8d4256
L_8d424e:
	ld_s r0,[r13,0x4c]
L_8d4250:
	btst_s r0,0x1d
L_8d4252:
	beq_s L_8d4256
L_8d4254:
	nop_s
	.global L_8d4256
L_8d4256:
	ld_s r0,[r13,0x4c]
L_8d4258:
	bbit0 r0,0x1d,L_8d4196
L_8d425c:
	mov_s r1,0x101e148
L_8d4262:
	bl.d L_8dcba8
L_8d4266:
	mov_s r0,0x0
L_8d4268:
	mov_s r0,blink
L_8d426a:
	mov_s r1,0x134a
L_8d4270:
	bl L_8c9b28
L_8d4274:
	b_s L_8d4196
	.global L_8d4276
L_8d4276:
	mov_s r0,blink
L_8d4278:
	bl.d L_8c9b28
L_8d427c:
	mov_s r1,0xac
L_8d427e:
	b_s L_8d41a0
	.global L_8d4280
L_8d4280:
	mov_s r1,0x101e168
L_8d4286:
	mov_s r0,0x10
L_8d4288:
	mov_s r2,r14
L_8d428a:
	mov_s r3,r15
L_8d428c:
	bl.d L_8dcd00
L_8d4290:
	mov r4,r19
L_8d4294:
	ld.as r2,[r18,0x42]
L_8d4298:
	mov_s r1,0x101e1c0
L_8d429e:
	bmsk_s r2,r2,0xe
L_8d42a0:
	bl.d L_8dcc10
L_8d42a4:
	mov_s r0,0x10
L_8d42a6:
	ld_s r0,[r13,0x4c]
L_8d42a8:
	mov lp_count,0x30d40
L_8d42b0:
	bset_s r0,r0,0x1e
L_8d42b2:
	st_s r0,[r13,0x4c]
L_8d42b4:
	lp L_8d42c0
L_8d42b8:
	ld_s r0,[r13,0x4c]
L_8d42ba:
	btst_s r0,0x1d
L_8d42bc:
	beq_s L_8d42c0
L_8d42be:
	nop_s
	.global L_8d42c0
L_8d42c0:
	ld_s r0,[r13,0x4c]
L_8d42c2:
	bbit0 r0,0x1d,L_8d41f0
L_8d42c6:
	mov_s r1,0x101e148
L_8d42cc:
	bl.d L_8dcba8
L_8d42d0:
	mov_s r0,0x0
L_8d42d2:
	mov_s r0,blink
L_8d42d4:
	mov_s r1,0x133d
L_8d42da:
	bl L_8c9b28
L_8d42de:
	b_s L_8d41f0
