/* scan_mngr__send_prob_req @ 0x8f082c, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::send_prob_req() to:  ADDR-%04X%08X
 *   scan_mngr::send_prob_req() NEW prob_resp_timeout_event_id:%d , p_dband_info=0x%X
 *   [NNL] ++ m_active_probs=%d
 *   scan_mngr.cpp
 * Зовут его: scan_mngr__handle_link_up_event
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_log__emit2, fw_sysassert_fatal, tx_probe__send_probe_req, u_schd__schedule
 */
	.section .text.scan_mngr__send_prob_req,"ax",@progbits
	.global scan_mngr__send_prob_req
scan_mngr__send_prob_req:
	.global L_8f082c
L_8f082c:
	push_s blink
L_8f082e:
	bl L_8c02bc
L_8f0832:
	sub_s sp,sp,0x14
L_8f0834:
	mov_s r13,r0
L_8f0836:
	ld_s r14,[r1,0x3c]
L_8f0838:
	mov_s r16,r1
L_8f083a:
	add_s r14,r14,0x10
L_8f083c:
	mov_s r2,0x1013900
L_8f0842:
	ld r4,[r1, 0x8]
L_8f0846:
	mov_s r0,0x9
L_8f0848:
	mov_s r1,0x2
L_8f084a:
	bl.d L_8edff8
L_8f084e:
	ldw r3,[r16, 0xc]
L_8f0852:
	add r0,r16,0x8
L_8f0856:
	st_s r0,[sp,0x4]
L_8f0858:
	add r0,r16,0x10
L_8f085c:
	st_s r0,[sp,0x8]
L_8f085e:
	ldb r0,[r16, 0x30]
L_8f0862:
	st_s r14,[sp,0x0]
L_8f0864:
	st_s r0,[sp,0xc]
L_8f0866:
	ld r0,[r16, 0x40]
L_8f086a:
	mov_s r3,0x1
L_8f086c:
	st_s r3,[sp,0x10]
L_8f086e:
	brne r0,0x0,L_8f08ea
L_8f0872:
	mov_s r0,0x3
L_8f0874:
	stb r0,[r16, 0x39]
L_8f0878:
	mov_s r0,0x2f1c4
L_8f087e:
	mov_s r1,0x8004cc
L_8f0884:
	ld r4,[r1, 0x4]
L_8f0888:
	mov_s r1,r13
L_8f088a:
	mov_s r2,r16
L_8f088c:
	mov r5,0x0
L_8f0890:
	bl.d L_8dc92c
L_8f0894:
	mov r6,r5
L_8f0898:
	mov_s r3,r0
L_8f089a:
	st r0,[r16, 0x40]
L_8f089e:
	mov_s r2,0x1013930
L_8f08a4:
	mov_s r0,0x9
L_8f08a6:
	mov_s r1,0x2
L_8f08a8:
	bl.d L_8edff8
L_8f08ac:
	mov r4,r16
L_8f08b0:
	bl L_8c2c80
L_8f08b4:
	mov.f r14,r0
L_8f08b8:
	beq_s L_8f08f0
	.global L_8f08ba
L_8f08ba:
	ld_s r1,[r13,0x7c]
L_8f08bc:
	mov_s r3,sp
L_8f08be:
	mov r4,0x2f654
L_8f08c6:
	mov_s r0,r14
L_8f08c8:
	bl.d L_8f09c4
L_8f08cc:
	ld r2,[r16, 0x3c]
L_8f08d0:
	add r13,r13,0x80
L_8f08d4:
	ldb_s r3,[r13,0xc]
L_8f08d6:
	mov_s r2,0x1013984
L_8f08dc:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8f08de:
	extb_s r3,r3
L_8f08e0:
	stb_s r3,[r13,0xc]
L_8f08e2:
	mov_s r0,0x9
L_8f08e4:
	bl.d L_8edfcc
L_8f08e8:
	mov_s r1,0x2
	.global L_8f08ea
L_8f08ea:
	b.d L_8c0324
L_8f08ee:
	add_s sp,sp,0x14
	.global L_8f08f0
L_8f08f0:
	mov_s r0,blink
L_8f08f2:
	mov_s r2,0x1012bb8
L_8f08f8:
	mov_s r1,0x124d
L_8f08fe:
	bl.d L_8c82c0
L_8f0902:
	mov r3,0x38d
L_8f0906:
	b_s L_8f08ba
