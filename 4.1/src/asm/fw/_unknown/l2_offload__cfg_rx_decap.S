/* l2_offload__cfg_rx_decap @ 0x8ea660, 248 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   L2 Offload Rx Decap_trans_type=%d
 *   L2 Offload Rx SNAP_keep=%d
 *   L2 Offload Rx vlan_insertion=%d
 *   L3 Offloads: ipv4_checksum_en=%d  tcpip_checksum_en=%d
 * Зовут его: wmi_handler_cfg_rx_chain
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, dma_offload__pack_decap_cfg, dma_offload__set_rx_decap, fw_log__emit1, fw_log__emit2, offload__parse_ese_with_flag, set_reg_881b30, vring_ctx_by_index
 */
	.section .text.l2_offload__cfg_rx_decap,"ax",@progbits
	.global l2_offload__cfg_rx_decap
l2_offload__cfg_rx_decap:
	.global L_8ea660
L_8ea660:
	push_s blink
L_8ea662:
	bl.d L_8c02b4
L_8ea666:
	mov_s r1,0x2
L_8ea668:
	mov_s r15,r0
L_8ea66a:
	ldb_s r0,[r0,0x12]
L_8ea66c:
	mov_s r13,0x0
L_8ea66e:
	stb.a r0,[sp,-0x4]
L_8ea672:
	ldb_s r0,[r15,0x13]
L_8ea674:
	mov_s r2,0x100c780
L_8ea67a:
	mov_s r16,r0
L_8ea67c:
	stb r0,[sp, 0x1]
L_8ea680:
	ldb_s r0,[r15,0x16]
L_8ea682:
	mov_s r18,r1
L_8ea684:
	stb r0,[sp, 0x2]
L_8ea688:
	mov_s r0,0xb
L_8ea68a:
	bl.d L_8edfcc
L_8ea68e:
	ldb_s r3,[r15,0x11]
L_8ea690:
	ldb_s r0,[r15,0x11]
L_8ea692:
	mov_s r14,0x1
L_8ea694:
	breq_s r0,0,L_8ea6aa
L_8ea696:
	breq r0,0x1,L_8ea6fe
L_8ea69a:
	mov_s r0,r13
L_8ea69c:
	mov_s r3,r13
L_8ea69e:
	mov_s r4,r14
L_8ea6a0:
	mov_s r15,r13
L_8ea6a2:
	mov_s r17,r14
L_8ea6a4:
	mov_s r5,r14
L_8ea6a6:
	mov_s r2,r13
L_8ea6a8:
	b_s L_8ea718
	.global L_8ea6aa
L_8ea6aa:
	ld r16,[sp]
L_8ea6ae:
	mov_s r2,0x100c7a4
L_8ea6b4:
	lsr r0,r16
L_8ea6b8:
	bmsk r17,r0,0x0
L_8ea6bc:
	mov_s r0,0xb
L_8ea6be:
	mov_s r1,r18
L_8ea6c0:
	bl.d L_8edfcc
L_8ea6c4:
	mov_s r3,r17
L_8ea6c6:
	mov_s r2,0x100c7c0
L_8ea6cc:
	mov_s r0,0xb
L_8ea6ce:
	mov_s r1,r18
L_8ea6d0:
	bl.d L_8edfcc
L_8ea6d4:
	bmsk r3,r16,0x0
L_8ea6d8:
	bxor r17,r17,0x0
L_8ea6dc:
	bbit0 r16,0x0,L_8ea6f4
L_8ea6e0:
	bl.d L_8db318
L_8ea6e4:
	ldb_s r0,[r15,0x14]
L_8ea6e6:
	mov_s r0,r14
L_8ea6e8:
	mov_s r3,r14
L_8ea6ea:
	mov_s r4,r14
L_8ea6ec:
	mov_s r15,r18
	.global L_8ea6ee
L_8ea6ee:
	mov_s r5,r13
L_8ea6f0:
	mov_s r2,r13
L_8ea6f2:
	b_s L_8ea718
	.global L_8ea6f4
L_8ea6f4:
	mov_s r0,r14
L_8ea6f6:
	mov_s r3,r13
L_8ea6f8:
	mov_s r4,r14
L_8ea6fa:
	mov_s r15,r14
L_8ea6fc:
	b_s L_8ea6ee
	.global L_8ea6fe
L_8ea6fe:
	mov_s r1,0x3
L_8ea700:
	ldb_s r2,[r15,0x15]
L_8ea702:
	mov_s r0,r16
L_8ea704:
	btst_s r0,0x0
L_8ea706:
	mov_s r0,r18
L_8ea708:
	mov_s r3,r13
L_8ea70a:
	mov.ne r4,r14
L_8ea70e:
	mov.eq r4,r13
L_8ea712:
	mov_s r15,r1
L_8ea714:
	mov_s r17,r13
L_8ea716:
	mov_s r5,r13
	.global L_8ea718
L_8ea718:
	bl.d L_8db290
L_8ea71c:
	mov_s r1,r17
L_8ea71e:
	bl.d L_8ca828
L_8ea722:
	mov_s r0,0x2
L_8ea724:
	bl.d L_8de08c
L_8ea728:
	mov_s r1,r15
L_8ea72a:
	ldw r14,[sp, 0x2]
L_8ea72e:
	mov_s r2,0x100c7e0
L_8ea734:
	lsr_s r13,r14
L_8ea736:
	mov_s r0,0xb
L_8ea738:
	mov_s r1,0x2
L_8ea73a:
	bmsk r3,r14,0x0
L_8ea73e:
	bl.d L_8edff8
L_8ea742:
	bmsk r4,r13,0x0
L_8ea746:
	bmsk r0,r14,0x0
L_8ea74a:
	bl.d L_8db2c0
L_8ea74e:
	bmsk r1,r13,0x0
L_8ea752:
	b.d L_8c0314
L_8ea756:
	add_s sp,sp,0x4
