/* scan_mngr__probe_resp_ind @ 0x8ef694, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::probe_resp_ind() m_active_probs=%d
 *   scan_mngr::probe_resp_ind() from  ADDR-%04X%08X-- m_active_probs=%d
 * Зовут его: discovery_handle_probe_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_log__emit3, scan_mngr__prob_done, search_scan_elem_in_list
 */
	.section .text.scan_mngr__probe_resp_ind,"ax",@progbits
	.global scan_mngr__probe_resp_ind
scan_mngr__probe_resp_ind:
	.global L_8ef694
L_8ef694:
	push_s blink
L_8ef696:
	bl.d L_8c02bc
L_8ef69a:
	mov_s r1,0x2
L_8ef69c:
	mov_s r16,r0
L_8ef69e:
	mov_s r14,r2
L_8ef6a0:
	mov_s r2,0x101388c
L_8ef6a6:
	add3 r13,r0,0x10
L_8ef6aa:
	mov_s r0,0x9
L_8ef6ac:
	bl.d L_8edfcc
L_8ef6b0:
	ldb_s r3,[r13,0xc]
L_8ef6b2:
	ld_s r0,[r13,0x4]
L_8ef6b4:
	ldb_s r0,[r0]
L_8ef6b6:
	brne r0,0x4,L_8ef6cc
L_8ef6ba:
	ldb_s r0,[r13,0xc]
L_8ef6bc:
	breq_s r0,0,L_8ef6cc
L_8ef6be:
	mov_s r0,r16
L_8ef6c0:
	bl.d L_8f020c
L_8ef6c4:
	mov_s r1,r14
L_8ef6c6:
	mov.f r15,r0
L_8ef6ca:
	bne_s L_8ef6d0
	.global L_8ef6cc
L_8ef6cc:
	mov_s r0,0x0
L_8ef6ce:
	b_s L_8ef6fe
	.global L_8ef6d0
L_8ef6d0:
	ldb_s r0,[r13,0xc]
L_8ef6d2:
	mov_s r2,0x10138bc
L_8ef6d8:
	sub r5,r0,0x1
L_8ef6dc:
	extb r5,r5
L_8ef6e0:
	stb r5,[r13, 0xc]
L_8ef6e4:
	ld r4,[r14]
L_8ef6e8:
	mov_s r0,0x9
L_8ef6ea:
	mov_s r1,0x2
L_8ef6ec:
	bl.d L_8ee034
L_8ef6f0:
	ldw_s r3,[r14,0x4]
L_8ef6f2:
	mov_s r0,r16
L_8ef6f4:
	mov_s r1,0x0
L_8ef6f6:
	bl.d L_8ef034
L_8ef6fa:
	mov_s r2,r15
L_8ef6fc:
	mov_s r0,0x1
	.global L_8ef6fe
L_8ef6fe:
	.byte 0x29,0x04
