/* hwf_sector_rf_chain_set @ 0x8d7154, 516 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_sector_rf_chain_set(): sector_num=%d, is_tx_sector=%d, chain_num=%d
 *   hwf_sector_rf_chain_set(): edge_gain=%d, edge_phase=%d, dist_gain=%d
 *   hwf_sector_rf_chain_set(): dist_num=%d, is_x16_on=%d, sector_gain_idx=%d
 *   hwf_sector_rf_chain_set(): sector# %d was activated (settings applied to current RF chain HW)
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, fw_log_emit1, fw_log_emit3, hwd_rfc__read_sector_chain, hwd_rfc__read_sector_reg, hwd_rfc_sector_dist_gain_set, hwd_rfc_sector_edge_gain_set, hwd_rfc_sector_edge_phase_set, hwd_rfc_sector_x16_state_set, rf_sector_commit_rx, rf_sector_commit_tx
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_sector_rf_chain_set
hwf_sector_rf_chain_set:
	.global L_8d7154
L_8d7154:
	push_s blink
L_8d7156:
	bl L_8c01c0
L_8d715a:
	mov_s r20,r0
L_8d715c:
	mov_s r19,r1
L_8d715e:
	mov_s r14,r2
L_8d7160:
	mov_s r21,r3
L_8d7162:
	st.a r4,[sp,-0x14]
L_8d7166:
	st r5,[sp, 0x4]
L_8d716a:
	st r6,[sp, 0x10]
L_8d716e:
	st r7,[sp, 0x8]
L_8d7172:
	bl.d L_8d39f8
L_8d7176:
	mov r5,0xff
L_8d717a:
	ld r4,[sp, 0x4]
L_8d717e:
	mov_s r0,r20
L_8d7180:
	mov_s r1,r19
L_8d7182:
	mov_s r2,r14
L_8d7184:
	mov_s r3,r21
L_8d7186:
	bl.d L_8d3c04
L_8d718a:
	mov r5,0xff
L_8d718e:
	asr r0,r21,0x2
L_8d7192:
	extb r18,r0
L_8d7196:
	ld_s r0,[sp,0x10]
L_8d7198:
	brne r0,0x0,L_8d721c
L_8d719c:
	mov_s r3,r21
L_8d719e:
	bic r3,r3,-0xfd
L_8d71a2:
	add_s r13,r3,0x1
L_8d71a4:
	extb_s r13,r13
L_8d71a6:
	add_s r15,r13,0x1
L_8d71a8:
	extb_s r15,r15
L_8d71aa:
	add r22,r15,0x1
L_8d71ae:
	extb r22,r22
L_8d71b2:
	mov_s r0,0x0
L_8d71b4:
	cmp_s r3,r21
L_8d71b6:
	mov.ne r0,r20
L_8d71ba:
	mov.ne r1,r19
L_8d71be:
	bl.ne.d L_8d3954
L_8d71c2:
	mov.ne r2,r14
L_8d71c6:
	cmp_s r13,r21
L_8d71c8:
	mov_s r17,r0
L_8d71ca:
	mov.eq r16,0x0
L_8d71ce:
	beq_s L_8d71de
L_8d71d0:
	mov_s r0,r20
L_8d71d2:
	mov_s r1,r19
L_8d71d4:
	mov_s r2,r14
L_8d71d6:
	bl.d L_8d3954
L_8d71da:
	mov_s r3,r13
L_8d71dc:
	mov_s r16,r0
	.global L_8d71de
L_8d71de:
	cmp_s r15,r21
L_8d71e0:
	mov.eq r13,0x0
L_8d71e4:
	beq_s L_8d71f4
L_8d71e6:
	mov_s r0,r20
L_8d71e8:
	mov_s r1,r19
L_8d71ea:
	mov_s r2,r14
L_8d71ec:
	bl.d L_8d3954
L_8d71f0:
	mov_s r3,r15
L_8d71f2:
	mov_s r13,r0
	.global L_8d71f4
L_8d71f4:
	cmp r21,r22
L_8d71f8:
	mov_s r0,0x0
L_8d71fa:
	mov.ne r0,r20
L_8d71fe:
	mov.ne r1,r19
L_8d7202:
	mov.ne r2,r14
L_8d7206:
	bl.ne.d L_8d3954
L_8d720a:
	mov.ne r3,r22
L_8d720e:
	add r1,r16,r17
L_8d7212:
	add_s r1,r1,r13
L_8d7214:
	add.f 0x0,r1,r0
L_8d7218:
	bpnz L_8d7230
	.global L_8d721c
L_8d721c:
	ld r4,[sp, 0x10]
L_8d7220:
	mov_s r0,r20
L_8d7222:
	mov_s r1,r19
L_8d7224:
	mov_s r2,r14
L_8d7226:
	mov_s r3,r18
L_8d7228:
	bl.d L_8d3888
L_8d722c:
	mov r5,0xff
	.global L_8d7230
L_8d7230:
	ld_s r0,[sp,0x10]
L_8d7232:
	cmp_s r0,0x0
L_8d7234:
	mov.ne r0,0x1
L_8d7238:
	st_s r0,[sp,0xc]
L_8d723a:
	asr r0,r18,0x2
L_8d723e:
	extb r23,r0
L_8d7242:
	ld_s r0,[sp,0x10]
L_8d7244:
	brne r0,0x0,L_8d72c8
L_8d7248:
	mov_s r3,r18
L_8d724a:
	bic r3,r3,-0xfd
L_8d724e:
	add_s r13,r3,0x1
L_8d7250:
	extb_s r13,r13
L_8d7252:
	add_s r15,r13,0x1
L_8d7254:
	extb_s r15,r15
L_8d7256:
	add r22,r15,0x1
L_8d725a:
	extb r22,r22
L_8d725e:
	mov_s r0,0x0
L_8d7260:
	cmp_s r3,r21
L_8d7262:
	mov.ne r0,r20
L_8d7266:
	mov.ne r1,r19
L_8d726a:
	bl.ne.d L_8d3850
L_8d726e:
	mov.ne r2,r14
L_8d7272:
	cmp_s r13,r21
L_8d7274:
	mov_s r16,r0
L_8d7276:
	mov.eq r17,0x0
L_8d727a:
	beq_s L_8d728a
L_8d727c:
	mov_s r0,r20
L_8d727e:
	mov_s r1,r19
L_8d7280:
	mov_s r2,r14
L_8d7282:
	bl.d L_8d3850
L_8d7286:
	mov_s r3,r13
L_8d7288:
	mov_s r17,r0
	.global L_8d728a
L_8d728a:
	cmp_s r15,r21
L_8d728c:
	mov.eq r13,0x0
L_8d7290:
	beq_s L_8d72a0
L_8d7292:
	mov_s r0,r20
L_8d7294:
	mov_s r1,r19
L_8d7296:
	mov_s r2,r14
L_8d7298:
	bl.d L_8d3850
L_8d729c:
	mov_s r3,r15
L_8d729e:
	mov_s r13,r0
	.global L_8d72a0
L_8d72a0:
	cmp r21,r22
L_8d72a4:
	mov_s r0,0x0
L_8d72a6:
	mov.ne r0,r20
L_8d72aa:
	mov.ne r1,r19
L_8d72ae:
	mov.ne r2,r14
L_8d72b2:
	bl.ne.d L_8d3850
L_8d72b6:
	mov.ne r3,r22
L_8d72ba:
	add r1,r17,r16
L_8d72be:
	add_s r1,r1,r13
L_8d72c0:
	add.f 0x0,r1,r0
L_8d72c4:
	bpnz L_8d72dc
	.global L_8d72c8
L_8d72c8:
	ld r4,[sp, 0xc]
L_8d72cc:
	mov_s r0,r20
L_8d72ce:
	mov_s r1,r19
L_8d72d0:
	mov_s r2,r14
L_8d72d2:
	mov_s r3,r23
L_8d72d4:
	bl.d L_8d3da0
L_8d72d8:
	mov r5,0xff
	.global L_8d72dc
L_8d72dc:
	mov_s r1,0x101b3e4
L_8d72e2:
	mov_s r0,0x20
L_8d72e4:
	mov_s r2,r19
L_8d72e6:
	mov_s r3,r14
L_8d72e8:
	bl.d L_8dcd00
L_8d72ec:
	mov r4,r21
L_8d72f0:
	ld_s r2,[sp,0x0]
L_8d72f2:
	mov_s r1,0x101b42c
L_8d72f8:
	ld_s r3,[sp,0x4]
L_8d72fa:
	mov_s r0,0x20
L_8d72fc:
	bl.d L_8dcd00
L_8d7300:
	ld r4,[sp, 0x10]
L_8d7304:
	mov_s r1,0x101b474
L_8d730a:
	ld_s r3,[sp,0xc]
L_8d730c:
	mov_s r0,0x20
L_8d730e:
	mov_s r2,r18
L_8d7310:
	bl.d L_8dcd00
L_8d7314:
	ld r4,[sp, 0x8]
L_8d7318:
	ld_s r0,[sp,0x8]
L_8d731a:
	brge r0,0x10,L_8d7350
L_8d731e:
	mov_s r0,r20
L_8d7320:
	mov_s r1,r19
L_8d7322:
	breq_s r14,0,L_8d7334
L_8d7324:
	bl L_8d40d8
L_8d7328:
	mov_s r0,r20
L_8d732a:
	mov_s r1,r19
L_8d732c:
	bl.d L_8d4104
L_8d7330:
	ld_s r2,[sp,0x8]
L_8d7332:
	b_s L_8d7342
	.global L_8d7334
L_8d7334:
	bl L_8d37dc
L_8d7338:
	mov_s r0,r20
L_8d733a:
	mov_s r1,r19
L_8d733c:
	bl.d L_8d3808
L_8d7340:
	ld_s r2,[sp,0x8]
	.global L_8d7342
L_8d7342:
	mov_s r1,0x101b4c0
L_8d7348:
	mov_s r0,0x20
L_8d734a:
	bl.d L_8dcc10
L_8d734e:
	mov_s r2,r19
	.global L_8d7350
L_8d7350:
	b.d L_8c020c
L_8d7354:
	add_s sp,sp,0x14
L_8d7356:
	nop_s
