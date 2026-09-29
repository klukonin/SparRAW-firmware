/* scan_mngr__handle_link_up_event @ 0x8cd790, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::handle_link_up_event() SM STATE = %d, m_active_probs = %d
 *   scan_mngr::handle_link_up_event() Rx Link_UP from: ADDR-%04X%08X
 *   scan_mngr::handle_link_up_event() p_dband_info->status = %d
 *   scan_mngr::handle_link_up_event() p_dband_info->conn_ptr = 0x%X, p_conn = 0x%X
 *   scan_mngr::handle_link_up_event() Link up failure notification CID %d.
 *   scan_mngr::handle_link_up_event() Link up event from non desired connection
 * Зовут его: l2mgr__notify_link_up
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, find_main_sm__bcon_step, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, scan_mngr__prob_done, scan_mngr__send_prob_req
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__handle_link_up_event
scan_mngr__handle_link_up_event:
	.global L_8cd790
L_8cd790:
	push_s blink
L_8cd792:
	bl L_8c01dc
L_8cd796:
	mov_s r14,r0
L_8cd798:
	ld.as r0,[r0,0x78]
L_8cd79c:
	mov_s r15,r1
L_8cd79e:
	mov_s r16,r2
L_8cd7a0:
	brne r0,0x0,L_8cd860
L_8cd7a4:
	ld r2,[r14, 0x80]
L_8cd7a8:
	mov_s r1,0x10161ec
L_8cd7ae:
	ldb r3,[r14,0x215]
L_8cd7b6:
	mov_s r0,0x29
L_8cd7b8:
	bl.d L_8dcc80
L_8cd7bc:
	ldb_s r2,[r2]
L_8cd7be:
	ld r0,[r14, 0x80]
L_8cd7c2:
	ldb_s r0,[r0]
L_8cd7c4:
	brne r0,0x4,L_8cd860
L_8cd7c8:
	breq_s r15,0,L_8cd83c
	.global L_8cd7ca
L_8cd7ca:
	add r13,r15,0x1c
L_8cd7ce:
	ldw_s r2,[r13,0x4]
L_8cd7d0:
	mov_s r1,0x1016234
L_8cd7d6:
	mov_s r0,0x29
L_8cd7d8:
	bl.d L_8dcc80
L_8cd7dc:
	ld_s r3,[r13]
L_8cd7de:
	mov_s r0,r14
L_8cd7e0:
	bl.d L_8f8574
L_8cd7e4:
	mov_s r1,r13
L_8cd7e6:
	mov.f r13,r0
L_8cd7ea:
	beq_s L_8cd854
L_8cd7ec:
	mov_s r1,0x1016278
L_8cd7f2:
	mov_s r0,0x29
L_8cd7f4:
	bl.d L_8dcc10
L_8cd7f8:
	ldb r2,[r13, 0x41]
L_8cd7fc:
	mov_s r1,0x10162b4
L_8cd802:
	ld_s r2,[r13,0x44]
L_8cd804:
	mov_s r0,0x29
L_8cd806:
	bl.d L_8dcc80
L_8cd80a:
	mov_s r3,r15
L_8cd80c:
	ldb r0,[r13, 0x41]
L_8cd810:
	cmp_s r0,0x1
L_8cd812:
	cmp.ne r0,0x2
L_8cd816:
	bne_s L_8cd860
L_8cd818:
	st_s r15,[r13,0x44]
L_8cd81a:
	brne r16,0x1,L_8cd84a
L_8cd81e:
	brne r0,0x1,L_8cd860
L_8cd822:
	mov_s r1,0x1016304
L_8cd828:
	mov_s r0,0x29
L_8cd82a:
	bl.d L_8dcc10
L_8cd82e:
	ldb_s r2,[r15,0x8]
L_8cd830:
	mov_s r0,r14
L_8cd832:
	mov_s r1,0x2
L_8cd834:
	bl.d L_8f74c4
L_8cd838:
	mov_s r2,r13
L_8cd83a:
	b_s L_8cd860
	.global L_8cd83c
L_8cd83c:
	mov_s r0,blink
L_8cd83e:
	mov_s r1,0x1249
L_8cd844:
	bl L_8c9b28
L_8cd848:
	b_s L_8cd7ca
	.global L_8cd84a
L_8cd84a:
	mov_s r0,r14
L_8cd84c:
	bl.d L_8f8bcc
L_8cd850:
	mov_s r1,r13
L_8cd852:
	b_s L_8cd860
	.global L_8cd854
L_8cd854:
	mov_s r1,0x101634c
L_8cd85a:
	bl.d L_8dcba8
L_8cd85e:
	mov_s r0,0x29
	.global L_8cd860
L_8cd860:
	b L_8c0244
