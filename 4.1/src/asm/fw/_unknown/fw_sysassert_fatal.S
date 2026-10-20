/* fw_sysassert_fatal @ 0x8c82c0, 352 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Crash TSF: curr tsf 0x%08x %08x
 *   SYSTEM FATAL CRASH0: curr_blink=0x%X, prev_blink =0x%X
 *   SYSTEM FATAL CRASH0: curr_blink=0x%X, prev_blink =0x%X, SYSASSERT_CODE_0x%x
 *   SYSTEM FATAL CRASH1: sp=%d, ilink1=0x%X, ilink2=0x%X
 *   Assert in file: %s ,
 *   [NNL]  line: %d
 *   FW SYSASSERT... Close Phy Rx/Tx
 * Зовут его: CALIB_MNGR__system_state_evt_handler, FWQ_TX_AVAILABILITY__add_packet, FWQ_TX_AVAILABILITY__remove_packet, IF_GAIN__GAIN, LMAC_IF__rs_started, POWER_MNGR__system_state_evt_handler, PS_CONNECTION__psc_complete, SDP__hwd_sdp_is_defined_mode, SDP__hwd_sdp_is_defined_sdp, SDP__hwd_sdp_is_gpio_sdp
 * Зовёт сам: WBE_DRIVER__link_down, __ld_r15_to_r13_ret, __st_r15_to_r13, assert__dump_dma_and_mac, assert__restore_hw_for_dump, fw_log__emit0, fw_log__emit1, fw_log__emit1_nonl, fw_log__emit2, fw_log__emit3, hwd_phy__reconfig_with_delay, hwd_phy__rgf_884000
 * Глобалы (через gp): 0x800231, 0x800233, 0x800338, 0x80033c, 0x800340
 */
	.section .text.fw_sysassert_fatal,"ax",@progbits
	.global fw_sysassert_fatal
fw_sysassert_fatal:
	.global L_8c82c0
L_8c82c0:
	push_s blink
L_8c82c2:
	bl L_8c02c0
L_8c82c6:
	mov_s r14,r0
L_8c82c8:
	ld_s r0,[gp,-0x148]
L_8c82ca:
	mov_s r15,r2
L_8c82cc:
	cmp_s r0,0x0
L_8c82ce:
	mov_s r13,r1
L_8c82d0:
	st.a r3,[sp,-0xc]
L_8c82d4:
	bne_s L_8c841a
L_8c82d6:
	mov_s r0,0x1
L_8c82d8:
	bl.d L_8e35e4
L_8c82dc:
	st.as r0,[gp,-0x52]
L_8c82e0:
	ldb_s r0,[gp,0xc1]
L_8c82e2:
	cmp_s r0,0x0
L_8c82e4:
	bl.gt L_8d45b4
L_8c82e8:
	mov_s r0,0xdeaddead
L_8c82ee:
	bl L_8e35cc
L_8c82f2:
	mov_s r0,0xdeaddead
L_8c82f8:
	bl L_8e35d8
L_8c82fc:
	mov_s r0,0x857000
L_8c8302:
	st_s r13,[r0,0x20]
L_8c8304:
	st_s r14,[r0,0x24]
L_8c8306:
	mov r33,0xde01
L_8c830e:
	mov_s r34,r13
L_8c8310:
	mov r33,0xde02
L_8c8318:
	add_s r1,sp,0x4
L_8c831a:
	mov_s r0,0x0
L_8c831c:
	bl.d L_8e4840
L_8c8320:
	mov_s r2,r0
L_8c8322:
	mov_s r2,0x10012dc
L_8c8328:
	ld r4,[sp, 0x4]
L_8c832c:
	mov_s r0,0x0
L_8c832e:
	mov_s r1,0x2
L_8c8330:
	bl.d L_8edff8
L_8c8334:
	ld_s r3,[sp,0x8]
L_8c8336:
	st.as r13,[gp,0x73]
L_8c833a:
	ld_s r0,[gp,-0x11c]
L_8c833c:
	st.as r14,[gp,0x72]
L_8c8340:
	st.as r13,[gp,0x74]
L_8c8344:
	mov r4,blink
L_8c8348:
	brne r0,0x1,L_8c835e
L_8c834c:
	mov_s r2,0x10012fc
L_8c8352:
	mov_s r0,0x0
L_8c8354:
	mov_s r1,r0
L_8c8356:
	bl.d L_8edff8
L_8c835a:
	mov_s r3,r14
L_8c835c:
	b_s L_8c8370
	.global L_8c835e
L_8c835e:
	mov_s r2,0x1001334
L_8c8364:
	mov_s r0,0x0
L_8c8366:
	mov_s r1,r0
L_8c8368:
	mov_s r3,r14
L_8c836a:
	bl.d L_8ee034
L_8c836e:
	mov_s r5,r13
	.global L_8c8370
L_8c8370:
	mov_s r3,sp
L_8c8372:
	mov r4,ilink1
L_8c8376:
	mov r5,ilink2
L_8c837a:
	mov_s r2,0x1001380
L_8c8380:
	mov_s r0,0x0
L_8c8382:
	bl.d L_8ee034
L_8c8386:
	mov_s r1,r0
L_8c8388:
	mov_s r2,0x10013b8
L_8c838e:
	mov_s r0,0x0
L_8c8390:
	mov_s r1,0x2
L_8c8392:
	bl.d L_8ee080
L_8c8396:
	mov_s r3,r15
L_8c8398:
	mov_s r2,0x10013d0
L_8c839e:
	mov_s r0,0x0
L_8c83a0:
	mov_s r1,0x2
L_8c83a2:
	bl.d L_8edfcc
L_8c83a6:
	ld_s r3,[sp,0x0]
L_8c83a8:
	ld_s r0,[gp,-0x11c]
L_8c83aa:
	cmp_s r0,0x1
L_8c83ac:
	bl.eq L_8c84ac
L_8c83b0:
	bl L_8c8220
L_8c83b4:
	ld_s r0,[gp,-0x11c]
L_8c83b6:
	brne_s r0,0,L_8c83d2
L_8c83b8:
	mov_s r2,0x10013e0
L_8c83be:
	mov_s r0,0x0
L_8c83c0:
	bl.d L_8edfb0
L_8c83c4:
	mov_s r1,0x2
L_8c83c6:
	bl.d L_8cf958
L_8c83ca:
	mov_s r0,0x0
L_8c83cc:
	bl.d L_8cf4fc
L_8c83d0:
	mov_s r0,0x0
	.global L_8c83d2
L_8c83d2:
	ld_s r0,[gp,-0x11c]
L_8c83d4:
	cmp_s r0,0x1
L_8c83d6:
	bl.eq L_8c8264
L_8c83da:
	bl L_8eac24
L_8c83de:
	bl.d L_8ed8d8
L_8c83e2:
	mov_s r0,0x1
L_8c83e4:
	mov_s r13,0x80345c
L_8c83ea:
	ld_s r0,[r13]
L_8c83ec:
	cmp_s r0,0x0
L_8c83ee:
	bl.ne L_8e3604
L_8c83f2:
	ld_s r0,[r13,0x4]
L_8c83f4:
	cmp_s r0,0x0
L_8c83f6:
	bl.ne.d L_8d775c
L_8c83fa:
	mov.ne r0,0x5
L_8c83fe:
	ldb_s r0,[gp,0xc3]
L_8c8400:
	cmp_s r0,0x0
L_8c8402:
	bl.ne L_8c8420
L_8c8406:
	nop_s
L_8c8408:
	nop_s
L_8c840a:
	nop_s
L_8c840c:
	nop_s
L_8c840e:
	flag 0x1
L_8c8412:
	nop_s
L_8c8414:
	nop_s
L_8c8416:
	nop_s
L_8c8418:
	nop_s
	.global L_8c841a
L_8c841a:
	b.d L_8c032c
L_8c841e:
	add_s sp,sp,0xc
