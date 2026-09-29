/* SW_TX_MGMT_API__send_packet @ 0x8e577c, 248 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SW_TX_MGMT_API::send_packet() IN
 *   SW TX MGMT: send packet %d bytes, complete cb 0x%x, metadata_p=0x%x.
 *   SW_TX_MGMT_API::send_packet() CALL SW_TX_MGMT_API::link_up_evt(p_conn=0x%x, conn::LINKUP_SUCCESS
 *   SW_TX_MGMT_API::send_packet() CALL link_obtain(p_conn=0x%x, conn::LINKUP_SUCCESS
 *   SW failed TX MGMT: NO RESOURCES AVAILABLE.
 * Зовут его: handle_packet_splitmac, send_sw_packet, wmi_sw_tx_req
 * Зовёт сам: SW_TX_MGMT_API__link_up_evt, SW_TX_MGMT_API__packet_release, __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, hexdump_words, memcpy_fw, mid_list__by_mid_fw, mid_list__find_by
 * Глобалы (через gp): 0x800184
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global SW_TX_MGMT_API__send_packet
SW_TX_MGMT_API__send_packet:
	.global L_8e577c
L_8e577c:
	push_s blink
L_8e577e:
	bl L_8c01d0
L_8e5782:
	sub_s sp,sp,0x8
L_8e5784:
	mov_s r19,r0
L_8e5786:
	mov_s r15,r1
L_8e5788:
	mov_s r13,r2
L_8e578a:
	mov_s r16,r3
L_8e578c:
	mov r17,r4
L_8e5790:
	mov_s r1,0x10186e4
L_8e5796:
	bl.d L_8dcba8
L_8e579a:
	mov_s r0,0x27
L_8e579c:
	ld_s r0,[gp,-0xc0]
L_8e579e:
	brne r0,0x0,L_8e5856
L_8e57a2:
	mov_s r0,0x842304
L_8e57a8:
	ld_s r1,[r0,0xc]
L_8e57aa:
	ld_s r0,[r0,0x10]
L_8e57ac:
	cmp_s r1,r0
L_8e57ae:
	mov_s r0,0x1
L_8e57b0:
	sub.cs r0,r0,r0
L_8e57b4:
	brne r0,0x0,L_8e5856
L_8e57b8:
	bl.d L_8cc3dc
L_8e57bc:
	mov_s r0,r15
L_8e57be:
	bl.d L_8cc024
L_8e57c2:
	mov_s r1,r19
L_8e57c4:
	mov_s r14,r0
L_8e57c6:
	mov_s r0,r13
L_8e57c8:
	bl.d L_8c9790
L_8e57cc:
	mov_s r1,r16
L_8e57ce:
	mov r18,sp
L_8e57d2:
	breq_s r13,0,L_8e5834
	.global L_8e57d4
L_8e57d4:
	st r13,[r18, 0x4]
L_8e57d8:
	sub r13,r13,0x24
L_8e57dc:
	st r13,[r18]
L_8e57e0:
	ld r18,[sp]
L_8e57e4:
	mov_s r1,0x1018708
L_8e57ea:
	mov_s r0,0x27
L_8e57ec:
	mov_s r2,r16
L_8e57ee:
	mov_s r3,r17
L_8e57f0:
	bl.d L_8dcd00
L_8e57f4:
	mov r4,r18
L_8e57f8:
	stw r16,[r18, 0x8]
L_8e57fc:
	add r0,r18,0xc
L_8e5800:
	mov_s r1,r19
L_8e5802:
	bl.d L_8c0380
L_8e5806:
	mov_s r2,0x6
L_8e5808:
	stw r15,[r18, 0x12]
L_8e580c:
	st.as r18,[gp,-0x30]
L_8e5810:
	st.as r17,[gp,0x0]
L_8e5814:
	breq_s r14,0,L_8e5842
L_8e5816:
	mov_s r1,0x1018750
L_8e581c:
	mov_s r0,0x27
L_8e581e:
	bl.d L_8dcc10
L_8e5822:
	mov_s r2,r14
L_8e5824:
	ldb_s r0,[r14,0x8]
L_8e5826:
	stb r0,[gp, 0xcb]
L_8e582a:
	mov_s r0,r14
L_8e582c:
	bl.d L_8dabfc
L_8e5830:
	mov_s r1,0x0
L_8e5832:
	b_s L_8e586e
	.global L_8e5834
L_8e5834:
	mov_s r0,blink
L_8e5836:
	mov_s r1,0x11e9
L_8e583c:
	bl L_8c9b28
L_8e5840:
	b_s L_8e57d4
	.global L_8e5842
L_8e5842:
	mov_s r1,0x10187b4
L_8e5848:
	mov_s r0,0x27
L_8e584a:
	bl.d L_8dcc10
L_8e584e:
	mov_s r2,r14
L_8e5850:
	bl L_8dab34
L_8e5854:
	b_s L_8e586e
	.global L_8e5856
L_8e5856:
	mov_s r1,0x1018808
L_8e585c:
	bl.d L_8dcba8
L_8e5860:
	mov_s r0,0x17
L_8e5862:
	mov_s r0,r13
L_8e5864:
	mov_s r1,0x1
L_8e5866:
	mov_s r2,r15
L_8e5868:
	bl.d L_8df624
L_8e586c:
	mov_s r3,r17
	.global L_8e586e
L_8e586e:
	b.d L_8c022c
L_8e5872:
	add_s sp,sp,0x8
