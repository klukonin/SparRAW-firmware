/* fwq_tx__handle_completion @ 0x8ca540, 428 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx.cpp
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/rx_api.h
 *   FW RX PAYLOADS SHORTAGE - RING PENDED (%d) dma_handled %d.
 * Зовут его: TX_API__handle_completed_packets, tail_fwq_tx__handle_completion
 * Зовёт сам: __ld_r16_to_r13_ret, __ld_r21_to_r13_ret, __st_r16_to_r13, __st_r21_to_r13, bitmap__alloc_bit, bitmap__any_free, bitmap__init, fw_log__emit2, fw_sysassert_fatal, fwq_tx__long_retry_failures, fwq_tx__on_flush_done, fwq_tx__on_queue_empty
 */
	.section .text.fwq_tx__handle_completion,"ax",@progbits
	.global fwq_tx__handle_completion
fwq_tx__handle_completion:
	.global L_8ca540
L_8ca540:
	push_s blink
L_8ca542:
	bl L_8c02bc
L_8ca546:
	mov_s r13,r0
L_8ca548:
	ld_s r0,[r0,0x4c]
L_8ca54a:
	mov_s r16,r1
L_8ca54c:
	ld_s r2,[r0,0x4]
L_8ca54e:
	sub_s sp,sp,0x4
L_8ca550:
	jl_s.d [r2]
L_8ca552:
	mov_s r0,r13
L_8ca554:
	mov_s r0,r13
L_8ca556:
	bl.d L_8c5938
L_8ca55a:
	mov_s r1,r16
L_8ca55c:
	mov_s r14,sp
L_8ca55e:
	mov_s r0,r14
L_8ca560:
	bl.d L_8e1140
L_8ca564:
	ld_s r1,[r13,0x14]
L_8ca566:
	b_s L_8ca578
	.global L_8ca568
L_8ca568:
	bl.d L_8db194
L_8ca56c:
	mov_s r0,r14
L_8ca56e:
	mov_s r1,r0
L_8ca570:
	mov_s r0,r13
L_8ca572:
	bl.d L_8e4778
L_8ca576:
	mov_s r2,r16
	.global L_8ca578
L_8ca578:
	bl.d L_8cb680
L_8ca57c:
	mov_s r0,r14
L_8ca57e:
	brne_s r0,0,L_8ca568
L_8ca580:
	ld_s r0,[r13,0x8]
L_8ca582:
	breq_s r0,0,L_8ca5c0
L_8ca584:
	breq r0,0x1,L_8ca5a4
L_8ca588:
	breq r0,0x2,L_8ca5ac
L_8ca58c:
	mov_s r0,blink
L_8ca58e:
	mov_s r2,0x1015730
L_8ca594:
	mov_s r1,0x1211
L_8ca59a:
	bl.d L_8c82c0
L_8ca59e:
	mov r3,0x16a
L_8ca5a2:
	b_s L_8ca5c0
	.global L_8ca5a4
L_8ca5a4:
	bl.d L_8e0a28
L_8ca5a8:
	mov_s r0,r13
L_8ca5aa:
	b_s L_8ca5c0
	.global L_8ca5ac
L_8ca5ac:
	ld_s r0,[r13,0x34]
L_8ca5ae:
	cmp_s r0,0x0
L_8ca5b0:
	mov_s r0,0x1
L_8ca5b2:
	sub_s.ne r0,r0,r0
L_8ca5b4:
	extb.f 0x0,r0
L_8ca5b8:
	bl.ne.d L_8db240
L_8ca5bc:
	mov.ne r0,r13
	.global L_8ca5c0
L_8ca5c0:
	b.d L_8c0324
L_8ca5c4:
	add_s sp,sp,0x4
L_8ca5c6:
	nop_s
	.global L_8ca5c8
L_8ca5c8:
	push_s blink
L_8ca5ca:
	bl L_8c02a8
L_8ca5ce:
	sub_s sp,sp,0xc
L_8ca5d0:
	mov_s r14,r0
L_8ca5d2:
	mov_s r21,r1
L_8ca5d4:
	mov r16,0x0
L_8ca5d8:
	mov r20,0x1
L_8ca5dc:
	ld_s r0,[r0,0x10]
L_8ca5de:
	mov_s r12,0x1
L_8ca5e0:
	asl r0,r12,r0
L_8ca5e4:
	bl.d L_8cd64c
L_8ca5e8:
	mov_s r1,r16
L_8ca5ea:
	mov_s r0,r14
L_8ca5ec:
	bl.d L_8c9ff8
L_8ca5f0:
	ld_s r1,[r14,0x8]
L_8ca5f2:
	mov_s r13,r0
L_8ca5f4:
	mov r17,r16
L_8ca5f8:
	b_s L_8ca6ae
	.global L_8ca5fa
L_8ca5fa:
	st r16,[r14, 0x14]
L_8ca5fe:
	ld_s r0,[r13,0x14]
L_8ca600:
	bset r19,r0,0x12
L_8ca604:
	bset.f r19,r19,0x17
L_8ca608:
	mov_s r15,sp
L_8ca60a:
	bne_s L_8ca61e
L_8ca60c:
	mov_s r0,blink
L_8ca60e:
	mov_s r2,0x10159d8
L_8ca614:
	mov_s r1,0x2
L_8ca616:
	bset_s r1,r1,0xc
L_8ca618:
	bl.d L_8c82c0
L_8ca61c:
	mov_s r3,0x31
	.global L_8ca61e
L_8ca61e:
	st r19,[r15, 0x4]
L_8ca622:
	sub r0,r19,0x38
L_8ca626:
	st_s r0,[r15]
L_8ca628:
	sub r0,r19,0x10
L_8ca62c:
	st_s r0,[r15,0x8]
L_8ca62e:
	ldb_s r0,[r13,0x1d]
L_8ca630:
	ld_s r15,[sp,0x0]
L_8ca632:
	lsr_s r0,r0,0x2
L_8ca634:
	bmsk_s r0,r0,0x0
L_8ca636:
	stw_s r0,[r15,0x2e]
L_8ca638:
	ldw_s r0,[r13,0x1e]
L_8ca63a:
	add r18,r15,0x20
L_8ca63e:
	st_s r0,[r15,0x30]
L_8ca640:
	ld_s r1,[r13,0x4]
L_8ca642:
	lsr_s r1,r1,0x10
L_8ca644:
	bmsk_s r1,r1,0x4
L_8ca646:
	bl.d L_8c9fb4
L_8ca64a:
	stb r1,[r18, 0x14]
L_8ca64e:
	stb r0,[r18, 0x15]
L_8ca652:
	ld_s r0,[r13]
L_8ca654:
	lsr_s r0,r0,0x4
L_8ca656:
	bmsk_s r0,r0,0x2
L_8ca658:
	stb r0,[r18, 0x16]
L_8ca65c:
	ld_s r0,[r13,0x4]
L_8ca65e:
	st r16,[r15, 0x10]
L_8ca662:
	lsr_s r0,r0,0x15
L_8ca664:
	bmsk_s r0,r0,0x3
L_8ca666:
	stb r0,[r18, 0x8]
L_8ca66a:
	st r19,[r15, 0x14]
L_8ca66e:
	mov_s r0,r21
L_8ca670:
	bl.d L_8c1fc4
L_8ca674:
	mov_s r1,r15
L_8ca676:
	bl.d L_8c2bf4
L_8ca67a:
	add r17,r17,0x1
L_8ca67e:
	bmsk_s r0,r0,0x11
L_8ca680:
	st_s r0,[r13,0x14]
L_8ca682:
	ldb_s r0,[r13,0x1d]
L_8ca684:
	add r1,r14,0x8
L_8ca688:
	bclr_s r0,r0,0x0
L_8ca68a:
	stb_s r0,[r13,0x1d]
L_8ca68c:
	bl.d L_8c6d20
L_8ca690:
	mov_s r0,r14
L_8ca692:
	add r1,r14,0xc
L_8ca696:
	bl.d L_8c6d20
L_8ca69a:
	mov_s r0,r14
L_8ca69c:
	ld_s r0,[r14,0x10]
L_8ca69e:
	bl.d L_8cdeac
L_8ca6a2:
	ld_s r1,[r14,0xc]
L_8ca6a4:
	mov_s r0,r14
L_8ca6a6:
	bl.d L_8c9ff8
L_8ca6aa:
	ld_s r1,[r14,0x8]
L_8ca6ac:
	mov_s r13,r0
	.global L_8ca6ae
L_8ca6ae:
	ldb_s r0,[r13,0x1d]
L_8ca6b0:
	bbit0 r0,0x0,L_8ca6d8
L_8ca6b4:
	bl L_8df0f4
L_8ca6b8:
	brne r0,0x0,L_8ca5fa
L_8ca6bc:
	bl L_8df110
L_8ca6c0:
	mov_s r2,0x1015a0c
L_8ca6c6:
	mov_s r3,r0
L_8ca6c8:
	mov_s r0,0x7
L_8ca6ca:
	mov_s r1,0x2
L_8ca6cc:
	bl.d L_8edff8
L_8ca6d0:
	mov r4,r17
L_8ca6d4:
	st r20,[r14, 0x14]
	.global L_8ca6d8
L_8ca6d8:
	ld_s r0,[r14,0x10]
L_8ca6da:
	mov_s r12,0x1
L_8ca6dc:
	asl r0,r12,r0
L_8ca6e0:
	bl.d L_8cd67c
L_8ca6e4:
	mov_s r1,0x0
L_8ca6e6:
	b.d L_8c02fc
L_8ca6ea:
	add_s sp,sp,0xc
