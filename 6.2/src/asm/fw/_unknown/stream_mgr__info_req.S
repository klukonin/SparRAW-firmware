/* stream_mgr__info_req @ 0x8d87a0, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Information request -Ignored sta_idx %d, isn't active.
 *   CID[%d] Handle Information Req from for ADDR-%04X%08X
 *   CID [%d]:Ignore Information request, my addr: ADDR-%04X%08X
 * Зовут его: stream_mgr__action
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn_mgr__by_cid, fw_log_emit1, fw_log_emit3, stream_mgr__send_info_response
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__info_req
stream_mgr__info_req:
	.global L_8d87a0
L_8d87a0:
	push_s blink
L_8d87a2:
	bl L_8c01e0
L_8d87a6:
	mov_s r15,r2
L_8d87a8:
	add_s r13,r0,0x2
L_8d87aa:
	bl.d L_8cbffc
L_8d87ae:
	mov_s r0,r2
L_8d87b0:
	mov.f r14,r0
L_8d87b4:
	bne_s L_8d87c6
L_8d87b6:
	mov_s r1,0x10106f0
L_8d87bc:
	mov_s r0,0x2b
L_8d87be:
	bl.d L_8dcc10
L_8d87c2:
	mov_s r2,r15
L_8d87c4:
	b_s L_8d8856
	.global L_8d87c6
L_8d87c6:
	mov_s r1,0x1010728
L_8d87cc:
	ld r4,[r13]
L_8d87d0:
	mov_s r0,0x2b
L_8d87d2:
	mov_s r2,r15
L_8d87d4:
	bl.d L_8dcd00
L_8d87d8:
	ldw_s r3,[r13,0x4]
L_8d87da:
	mov_s r2,0xff
L_8d87dc:
	ldb_s r1,[r13]
L_8d87de:
	ld_s r0,[r14,0x18]
L_8d87e0:
	add r3,r0,0xa
L_8d87e4:
	brne r1,r2,L_8d8806
L_8d87e8:
	ldb_s r1,[r13,0x1]
L_8d87ea:
	brne r1,r2,L_8d8806
L_8d87ee:
	ldb_s r1,[r13,0x2]
L_8d87f0:
	brne r1,r2,L_8d8806
L_8d87f4:
	ldb_s r1,[r13,0x3]
L_8d87f6:
	brne r1,r2,L_8d8806
L_8d87fa:
	ldb_s r1,[r13,0x4]
L_8d87fc:
	brne r1,r2,L_8d8806
L_8d8800:
	ldb_s r1,[r13,0x5]
L_8d8802:
	breq r1,r2,L_8d8836
	.global L_8d8806
L_8d8806:
	ldb_s r2,[r13]
L_8d8808:
	ldb_s r1,[r3]
L_8d880a:
	brne r2,r1,L_8d8842
L_8d880e:
	ldb_s r2,[r13,0x1]
L_8d8810:
	ldb_s r1,[r3,0x1]
L_8d8812:
	brne r2,r1,L_8d8842
L_8d8816:
	ldb_s r2,[r13,0x2]
L_8d8818:
	ldb_s r1,[r3,0x2]
L_8d881a:
	brne r2,r1,L_8d8842
L_8d881e:
	ldb_s r2,[r13,0x3]
L_8d8820:
	ldb_s r1,[r3,0x3]
L_8d8822:
	brne r2,r1,L_8d8842
L_8d8826:
	ldb_s r2,[r13,0x4]
L_8d8828:
	ldb_s r1,[r3,0x4]
L_8d882a:
	brne r2,r1,L_8d8842
L_8d882e:
	ldb_s r2,[r13,0x5]
L_8d8830:
	ldb_s r1,[r3,0x5]
L_8d8832:
	brne r2,r1,L_8d8842
	.global L_8d8836
L_8d8836:
	add_s r3,r13,0x7
L_8d8838:
	mov_s r1,r14
L_8d883a:
	bl.d L_8d885c
L_8d883e:
	mov_s r2,r13
L_8d8840:
	b_s L_8d8856
	.global L_8d8842
L_8d8842:
	mov_s r1,0x1010760
L_8d8848:
	ld r4,[r3]
L_8d884c:
	mov_s r0,0x2b
L_8d884e:
	mov_s r2,r15
L_8d8850:
	bl.d L_8dcd00
L_8d8854:
	ldw_s r3,[r3,0x4]
	.global L_8d8856
L_8d8856:
	b L_8c024c
L_8d885a:
	nop_s
