/* l2mgr__send_host_event @ 0x8f86cc, 392 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID for devid %d.
 *   <<---- [HOST EVENT] WMI_CONNECT_EVENTID CID %d, resp size %d, channel %d
 *   <<---- [HOST EVENT] WMI_CONNECT_EVENTID AID %d
 * Зовут его: mlme_sm__association_done
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, conn_mgr__by_cid, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, host_if__send_pair, l2mgr__host_evt_max_len, l2mgr__pending_op_clear, low_sme__send_evt2sw, mem_pool__free_thunk, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_host_event
l2mgr__send_host_event:
	.global L_8f86cc
L_8f86cc:
	push_s blink
L_8f86ce:
	bl L_8c01c0
L_8f86d2:
	mov_s r19,r0
L_8f86d4:
	bl.d L_8cc3dc
L_8f86d8:
	mov_s r16,r1
L_8f86da:
	mov.f r17,r0
L_8f86de:
	beq_s L_8f8748
	.global L_8f86e0
L_8f86e0:
	bl.d L_8cbffc
L_8f86e4:
	mov_s r0,r16
L_8f86e6:
	mov.f r18,r0
L_8f86ea:
	beq_s L_8f8756
	.global L_8f86ec
L_8f86ec:
	add3 r21,r18,0x1e
L_8f86f0:
	bl.d L_8c32d8
L_8f86f4:
	ld r13,[r21, 0x2c]
L_8f86f8:
	mov_s r14,r0
L_8f86fa:
	ld r0,[r18, 0x18]
L_8f86fe:
	mov r20,0x1
L_8f8702:
	ld_s r0,[r0,0x50]
L_8f8704:
	mov_s r15,0x0
L_8f8706:
	cmp_s r0,0x1
L_8f8708:
	sub.ne r20,r20,r20
L_8f870c:
	mov_s r0,r14
L_8f870e:
	bl.d L_8c1cd8
L_8f8712:
	mov_s r1,0x17
L_8f8714:
	add r1,r18,0x1c
L_8f8718:
	add_s r0,r14,0x2
L_8f871a:
	bl.d L_8c0380
L_8f871e:
	mov_s r2,0x6
L_8f8720:
	mov_s r0,r15
L_8f8722:
	stb_s r0,[r14,0x8]
L_8f8724:
	lsr_s r0,r0,0x8
L_8f8726:
	stb_s r0,[r14,0x9]
L_8f8728:
	ldw r1,[r17, 0x96]
L_8f872c:
	stb_s r1,[r14,0xa]
L_8f872e:
	lsr_s r1,r1,0x8
L_8f8730:
	stb_s r1,[r14,0xb]
L_8f8732:
	ld r0,[r17, 0x14]
L_8f8736:
	stb_s r15,[r14,0x10]
L_8f8738:
	stb_s r0,[r14,0xc]
L_8f873a:
	stb r16,[r14, 0x13]
L_8f873e:
	breq r20,0x0,L_8f8764
L_8f8742:
	ldb r0,[r17, 0x8]
L_8f8746:
	b_s L_8f8768
	.global L_8f8748
L_8f8748:
	mov_s r0,blink
L_8f874a:
	mov_s r1,0x16bb
L_8f8750:
	bl L_8c9b28
L_8f8754:
	b_s L_8f86e0
	.global L_8f8756
L_8f8756:
	mov_s r0,blink
L_8f8758:
	mov_s r1,0x11e7
L_8f875e:
	bl L_8c9b28
L_8f8762:
	b_s L_8f86ec
	.global L_8f8764
L_8f8764:
	ldb r0,[r18, 0x9]
	.global L_8f8768
L_8f8768:
	stb_s r0,[r14,0x14]
L_8f876a:
	stb_s r15,[r14,0x11]
L_8f876c:
	stb_s r15,[r14,0x10]
L_8f876e:
	stb_s r15,[r14,0x12]
L_8f8770:
	mov r22,0x17
L_8f8774:
	cmp_s r13,0x0
L_8f8776:
	mov r17,0x803c20
L_8f877e:
	mov.eq r16,r22
L_8f8782:
	beq_s L_8f8806
L_8f8784:
	ldb r0,[r13, 0x37]
L_8f8788:
	stb_s r0,[r14]
L_8f878a:
	ldb r0,[r17, 0x8]
L_8f878e:
	brne_s r0,0,L_8f87f8
L_8f8790:
	ld_s r0,[r13,0x30]
L_8f8792:
	sub r18,r0,0x18
L_8f8796:
	extw r23,r18
L_8f879a:
	bl.d L_8cc3c8
L_8f879e:
	add r16,r23,0x17
L_8f87a2:
	cmp_s r0,r16
L_8f87a4:
	mov.cs r0,r22
L_8f87a8:
	blo_s L_8f87c6
L_8f87aa:
	ld_s r1,[r13,0x14]
L_8f87ac:
	add r0,r14,0x17
L_8f87b0:
	bl.d L_8c0380
L_8f87b4:
	mov_s r2,r23
L_8f87b6:
	mov_s r0,r18
L_8f87b8:
	breq r20,0x0,L_8f87c0
L_8f87bc:
	stb_s r0,[r14,0x12]
L_8f87be:
	b_s L_8f87c2
	.global L_8f87c0
L_8f87c0:
	stb_s r0,[r14,0x11]
	.global L_8f87c2
L_8f87c2:
	extw r0,r16
	.global L_8f87c6
L_8f87c6:
	mov_s r16,r0
L_8f87c8:
	mov_s r1,0x100d3f8
L_8f87ce:
	mov_s r0,0x2b
L_8f87d0:
	bl.d L_8dcc10
L_8f87d4:
	mov_s r2,r19
L_8f87d6:
	ld_s r2,[r13,0x30]
L_8f87d8:
	add r0,r13,0x28
L_8f87dc:
	add_s r2,r2,0x10
L_8f87de:
	extw_s r2,r2
L_8f87e0:
	mov_s r1,0x61
L_8f87e2:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8f87e4:
	mov_s r3,r19
L_8f87e6:
	mov r4,0x1
L_8f87ea:
	mov r5,0x0
L_8f87ee:
	bl.d L_8e5474
L_8f87f2:
	mov r6,r5
L_8f87f6:
	b_s L_8f8802
	.global L_8f87f8
L_8f87f8:
	bl.d L_8cb15c
L_8f87fc:
	mov_s r0,r13
L_8f87fe:
	mov r16,r22
	.global L_8f8802
L_8f8802:
	st r15,[r21, 0x2c]
	.global L_8f8806
L_8f8806:
	ldb r4,[r14]
L_8f880a:
	mov_s r1,0x100d438
L_8f8810:
	ldb_s r2,[r14,0x13]
L_8f8812:
	mov_s r0,0x2b
L_8f8814:
	bl.d L_8dcd00
L_8f8818:
	mov_s r3,r16
L_8f881a:
	mov_s r1,0x100d484
L_8f8820:
	mov_s r0,0x2b
L_8f8822:
	bl.d L_8dcc10
L_8f8826:
	ldb_s r2,[r14,0x14]
L_8f8828:
	mov_s r0,r14
L_8f882a:
	mov_s r1,0x2
L_8f882c:
	bset_s r1,r1,0xc
L_8f882e:
	mov_s r2,r16
L_8f8830:
	mov_s r3,r19
L_8f8832:
	mov r4,0x0
L_8f8836:
	mov r5,r4
L_8f883a:
	bl.d L_8e5474
L_8f883e:
	mov r6,r4
L_8f8842:
	ldb r0,[r17, 0x8]
L_8f8846:
	cmp_s r0,0x0
L_8f8848:
	bl.eq.d L_8c6a30
L_8f884c:
	mov.eq r0,0x1
L_8f8850:
	b L_8c020c
