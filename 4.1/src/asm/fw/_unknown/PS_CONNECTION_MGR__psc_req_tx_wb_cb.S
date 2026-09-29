/* PS_CONNECTION_MGR__psc_req_tx_wb_cb @ 0x8dd8a4, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_CONNECTION_MGR::psc_req_tx_wb_cb - p_conn is NULL
 *   psc_if::psc_req_tx_wb_cb. received WB after disconnect
 *   psc_if::psc_req_tx_wb_cb, success:%d
 * Зовёт сам: TX_API__free_memory, __ld_r13_ret, __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__inject_event, fw_log__emit0, fw_log__emit1, sta_psc_sm__m_psc_req_tx_wb_timeout_event
 */
	.section .text.PS_CONNECTION_MGR__psc_req_tx_wb_cb,"ax",@progbits
	.global PS_CONNECTION_MGR__psc_req_tx_wb_cb
PS_CONNECTION_MGR__psc_req_tx_wb_cb:
	.global L_8dd8a4
L_8dd8a4:
	b.d L_8dd8e8
L_8dd8a8:
	add_s r0,r0,0x5c
L_8dd8aa:
	nop_s
L_8dd8ac:
	push_s blink
L_8dd8ae:
	push_s r13
L_8dd8b0:
	mov_s r13,r0
L_8dd8b2:
	mov_s r3,r1
L_8dd8b4:
	brne_s r2,0,L_8dd8c6
L_8dd8b6:
	mov_s r2,0x1002858
L_8dd8bc:
	mov_s r0,0xe
L_8dd8be:
	bl.d L_8edfb0
L_8dd8c2:
	mov_s r1,0x2
L_8dd8c4:
	b_s L_8dd8dc
	.global L_8dd8c6
L_8dd8c6:
	ldb_s r0,[r2,0x8]
L_8dd8c8:
	mov_s r1,r13
L_8dd8ca:
	mul64 r0,0xf4
L_8dd8ce:
	add r0,mlo,0x80361c
L_8dd8d6:
	bl.d L_8dd8a4
L_8dd8da:
	mov_s r2,r3
	.global L_8dd8dc
L_8dd8dc:
	bl.d L_8c94c4
L_8dd8e0:
	mov_s r0,r13
L_8dd8e2:
	b L_8c033c
L_8dd8e6:
	nop_s
	.global L_8dd8e8
L_8dd8e8:
	push_s blink
L_8dd8ea:
	bl L_8c02c0
L_8dd8ee:
	mov_s r14,r0
L_8dd8f0:
	cmp_s r2,0x0
L_8dd8f2:
	mov_s r15,0x1
L_8dd8f4:
	sub_s.ne r15,r15,r15
L_8dd8f6:
	add2 r13,r0,0x11
L_8dd8fa:
	bl.d L_8c5c74
L_8dd8fe:
	mov_s r0,r13
L_8dd900:
	ld r0,[r14, 0x8c]
L_8dd904:
	brne_s r0,0,L_8dd916
L_8dd906:
	mov_s r2,0x1002ab4
L_8dd90c:
	mov_s r0,0xe
L_8dd90e:
	bl.d L_8edfb0
L_8dd912:
	mov_s r1,0x2
L_8dd914:
	b_s L_8dd93e
	.global L_8dd916
L_8dd916:
	mov_s r2,0x1002aec
L_8dd91c:
	mov_s r0,0xe
L_8dd91e:
	mov_s r1,0x2
L_8dd920:
	bl.d L_8edfcc
L_8dd924:
	mov_s r3,r15
L_8dd926:
	breq_s r15,0,L_8dd946
L_8dd928:
	ldb r0,[r13, 0x44]
L_8dd92c:
	cmp_s r0,0x0
L_8dd92e:
	mov_s r0,r13
L_8dd930:
	beq_s L_8dd942
L_8dd932:
	mov_s r1,0x1
L_8dd934:
	mov_s r2,r1
	.global L_8dd936
L_8dd936:
	mov_s r3,0x0
L_8dd938:
	bl.d L_8d6a1c
L_8dd93c:
	mov_s r4,r3
	.global L_8dd93e
L_8dd93e:
	b L_8c032c
	.global L_8dd942
L_8dd942:
	mov_s r1,0x2
L_8dd944:
	b_s L_8dd954
	.global L_8dd946
L_8dd946:
	ldb r0,[r13, 0x35]
L_8dd94a:
	cmp_s r0,0x3
L_8dd94c:
	mov_s r0,r13
L_8dd94e:
	mov_s r1,0x4
L_8dd950:
	mov.lt r1,0x1
	.global L_8dd954
L_8dd954:
	mov_s r2,0x0
L_8dd956:
	b_s L_8dd936
