/* macq_desc__write @ 0x8c5010, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__2, ie__scan_buf_10, l2mgr__data_port_open_and_keys, mac_bringup__init_rx_fields, mac_bringup__init_seq, qh__write_by_flags_fw, rx_chain__configure, rx_chain__configure_b, rx_macq__program_ba_win, rx_macq__program_desc_848018
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bits__set32_s0_w2, bits__set32_s2_w2, bits__set32_s4_w3, bits__set32_s4_w5, macq_desc__release_window, macq_desc__wait_window_free
 * Глобалы (через gp): 0x800236
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq_desc__write
macq_desc__write:
	.global L_8c5010
L_8c5010:
	push_s blink
L_8c5012:
	bl.d L_8c01d8
L_8c5016:
	mov_s r8,r1
L_8c5018:
	sub_s sp,sp,0x8
L_8c501a:
	mov_s r14,r0
L_8c501c:
	mov_s r1,r2
L_8c501e:
	mov_s r16,r3
L_8c5020:
	mov_s r2,r4
L_8c5022:
	mov_s r13,0x0
L_8c5024:
	stw r13,[sp, 0x4]
L_8c5028:
	stw r13,[sp, 0x6]
L_8c502c:
	bmsk_s r1,r1,0x2
L_8c502e:
	add_s r0,sp,0x4
L_8c5030:
	bl.d L_8ed514
L_8c5034:
	st_s r13,[sp,0x0]
L_8c5036:
	bmsk r1,r2,0x1
L_8c503a:
	bl.d L_8ed358
L_8c503e:
	mov_s r15,r7
L_8c5040:
	bmsk r1,r16,0x1
L_8c5044:
	mov_s r0,sp
L_8c5046:
	bl.d L_8ed4cc
L_8c504a:
	mov r17,r6
L_8c504e:
	bmsk r1,r8,0x4
L_8c5052:
	bl.d L_8ed52c
L_8c5056:
	mov_s r3,r5
L_8c5058:
	bl L_8c50e4
L_8c505c:
	ldw r0,[sp, 0x4]
L_8c5060:
	mov_s r2,0x886600
L_8c5066:
	asl_s r0,r0,0x10
L_8c5068:
	bset_s r0,r0,0x1f
L_8c506a:
	or_s r0,r0,r3
L_8c506c:
	st_s r0,[r2,0xc]
L_8c506e:
	brlo r15,0x1,L_8c50da
	.global L_8c5072
L_8c5072:
	add r1,r13,r17
L_8c5076:
	bmsk_s r1,r1,0x1
L_8c5078:
	mov_s r0,sp
L_8c507a:
	bl.d L_8ed358
L_8c507e:
	cmp r16,0x2
L_8c5082:
	ld_s r0,[sp,0x0]
L_8c5084:
	mov_s r1,0x2
L_8c5086:
	st_s r0,[r2,0x10]
L_8c5088:
	mov_s r0,0x1
L_8c508a:
	sub.eq r0,r0,r0
L_8c508e:
	add1_s r1,r1,r0
L_8c5090:
	mov_s r0,0x0
L_8c5092:
	cmp_s r1,0x0
L_8c5094:
	mov.hi lp_count,r1
L_8c5098:
	lphi L_8c50ac
L_8c509c:
	mov_s r3,0x886614
L_8c50a2:
	ld.ab r1,[r14,0x4]
L_8c50a6:
	add2_s r3,r3,r0
L_8c50a8:
	st_s r1,[r3]
L_8c50aa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8c50ac
L_8c50ac:
	ldb_s r0,[gp,0xb2]
L_8c50ae:
	brne_s r0,0,L_8c50ba
L_8c50b0:
	st 0xc0000000,[r2, 0x8]
L_8c50b8:
	b_s L_8c50c2
	.global L_8c50ba
L_8c50ba:
	st 0x40000000,[r2, 0x8]
	.global L_8c50c2
L_8c50c2:
	sync
	.global L_8c50c6
L_8c50c6:
	mov_s r2,0x886600
L_8c50cc:
	ld_s r0,[r2,0x8]
L_8c50ce:
	bbit1 r0,0x1d,L_8c50c6
L_8c50d2:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8c50d4:
	/* brhs.d r15,0x1,0x008c5072 */
	.byte 0x9f,0x0f,0x75,0x90
L_8c50d8:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8c50da
L_8c50da:
	bl L_8c5238
L_8c50de:
	b.d L_8c023c
L_8c50e2:
	add_s sp,sp,0x8
