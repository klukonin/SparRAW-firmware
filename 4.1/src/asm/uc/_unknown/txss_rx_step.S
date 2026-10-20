/* txss_rx_step @ 0x93648c, 240 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss_flow_step_b
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, mac__program_4f_52, mac_mode__switch_core_and_rf, rx_flow__run, sxd_hal__mac_write_indexed, txss__tx_sector_frame, txss_copy_step, uc_wait_event1_or_event4
 * Глобалы (через gp): 0x800608
 */
	.section .text.txss_rx_step,"ax",@progbits
	.global txss_rx_step
txss_rx_step:
	.global L_93648c
L_93648c:
	push_s blink
L_93648e:
	bl L_920214
L_936492:
	mov_s r14,r0
L_936494:
	mov_s r1,0x29995
L_93649a:
	bl.d L_9306ac
L_93649e:
	mov_s r0,0x1
	.global L_9364a0
L_9364a0:
	mov_s r2,r54
L_9364a2:
	mov_s r0,0x801038
L_9364a8:
	ld_s r1,[r0]
L_9364aa:
	btst_s r2,0x0
L_9364ac:
	btst.eq r1,0x1
L_9364b0:
	bne_s L_9364cc
L_9364b2:
	mov_s r0,r54
L_9364b4:
	bbit1 r0,0x7,L_936574
L_9364b8:
	mov_s r13,0x801038
L_9364be:
	ld_s r0,[r13]
L_9364c0:
	bbit0 r0,0x0,L_93654e
L_9364c4:
	bclr_s r0,r0,0x0
L_9364c6:
	st_s r0,[r13]
L_9364c8:
	mov_s r0,0x1
L_9364ca:
	b_s L_936550
	.global L_9364cc
L_9364cc:
	st.as 0x80000,[gp,0x38]
L_9364d4:
	lsr_s r0,r1
L_9364d6:
	bmsk_s r0,r0,0x0
L_9364d8:
	st.as r0,[gp,-0x1e]
L_9364dc:
	bbit1 r1,0x1,L_9364ee
L_9364e0:
	mov_s r0,0x801b3c
L_9364e6:
	bl.d L_92a9f4
L_9364ea:
	ld.as r0,[r0,r14]
	.global L_9364ee
L_9364ee:
	mov_s r0,0x800fcc
L_9364f4:
	ld_s r0,[r0]
L_9364f6:
	mov_s r2,0x801b08
L_9364fc:
	lsr r1,r0,0x6
L_936500:
	bmsk_s r0,r0,0x5
L_936502:
	stw_s r0,[r2,0x22]
L_936504:
	mov_s r0,0x800f74
L_93650a:
	bmsk_s r1,r1,0x1
L_93650c:
	ld_s r0,[r0,0x28]
L_93650e:
	stw_s r1,[r2,0x20]
L_936510:
	bl.d L_924840
L_936514:
	mov_s r1,0x4
L_936516:
	mul64 r14,0x1c
L_93651a:
	mov_s r0,0x801bc6
L_936520:
	mov_s r2,0x1
L_936522:
	mov r4,0x0
L_936526:
	ldw r13,[r0,mlo]
L_93652a:
	mov_s r0,r14
L_93652c:
	mov_s r1,0x5
L_93652e:
	mov_s r3,r2
L_936530:
	mov r5,r4
L_936534:
	bl.d L_936864
L_936538:
	mov_s r6,r13
L_93653a:
	mov_s r0,0x49000040
L_936540:
	mov_s r32,r0
L_936542:
	st.ab r0,[r25,0x4]
L_936546:
	bclr r25,r25,0xa
L_93654a:
	mov_s r0,0x1
L_93654c:
	b_s L_936576
	.global L_93654e
L_93654e:
	mov_s r0,0x0
	.global L_936550
L_936550:
	cmp_s r0,0x1
L_936552:
	bl.eq L_930f44
L_936556:
	mov_s r0,0x0
L_936558:
	bset_s r0,r0,0x13
L_93655a:
	mov_s r1,0x81
L_93655c:
	bl.d L_9318f4
L_936560:
	mov_s r2,0x0
L_936562:
	mov_s r0,r54
L_936564:
	bbit1 r0,0x0,L_9364a0
L_936568:
	bl L_92ce9c
L_93656c:
	ld_s r0,[r13]
L_93656e:
	bic.f r0,r0,-0xd
L_936572:
	beq_s L_9364a0
	.global L_936574
L_936574:
	mov_s r0,0x0
	.global L_936576
L_936576:
	b L_920284
L_93657a:
	nop_s
