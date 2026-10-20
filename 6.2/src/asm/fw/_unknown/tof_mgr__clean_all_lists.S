/* tof_mgr__clean_all_lists @ 0x8c661c, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] clean m_ftm_pend_list (size: %d)
 *   tof_mgr::clean_all_lists() from pending list:  ADDR-%04X%08X
 *   [TOF] clean m_ftm_active_list (size: %d)
 *   [TOF] clean_all_lists() free active elements  0x%X
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, free_ftm_session, fw_log_emit1, fw_log_emit2, llist__pop_front
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof_mgr__clean_all_lists
tof_mgr__clean_all_lists:
	.global L_8c661c
L_8c661c:
	push_s blink
L_8c661e:
	bl L_8c01e0
L_8c6622:
	mov_s r13,r0
L_8c6624:
	mov_s r1,0x1019960
L_8c662a:
	mov_s r0,0x2b
L_8c662c:
	bl.d L_8dcc10
L_8c6630:
	ld_s r2,[r13]
L_8c6632:
	b_s L_8c6654
	.global L_8c6634
L_8c6634:
	bl.d L_8e2674
L_8c6638:
	mov_s r0,r13
L_8c663a:
	mov_s r14,r0
L_8c663c:
	ldw_s r2,[r14,0x14]
L_8c663e:
	mov_s r1,0x1019988
L_8c6644:
	mov_s r0,0x2b
L_8c6646:
	bl.d L_8dcc80
L_8c664a:
	ld_s r3,[r14,0x10]
L_8c664c:
	mov_s r0,r13
L_8c664e:
	bl.d L_8cb05c
L_8c6652:
	mov_s r1,r14
	.global L_8c6654
L_8c6654:
	ld_s r0,[r13]
L_8c6656:
	sub.f r0,r0,0x0
L_8c665a:
	mov.ne r0,0x1
L_8c665e:
	extb.f 0x0,r0
L_8c6662:
	bne_s L_8c6634
L_8c6664:
	add r14,r13,0xc
L_8c6668:
	mov_s r1,0x10199c8
L_8c666e:
	mov_s r0,0x2b
L_8c6670:
	bl.d L_8dcc10
L_8c6674:
	ld_s r2,[r14]
L_8c6676:
	b_s L_8c6696
	.global L_8c6678
L_8c6678:
	bl.d L_8e2674
L_8c667c:
	mov_s r0,r14
L_8c667e:
	mov_s r15,r0
L_8c6680:
	mov_s r1,0x10199f4
L_8c6686:
	mov_s r0,0x29
L_8c6688:
	bl.d L_8dcc10
L_8c668c:
	mov_s r2,r15
L_8c668e:
	mov_s r0,r13
L_8c6690:
	bl.d L_8cb05c
L_8c6694:
	mov_s r1,r15
	.global L_8c6696
L_8c6696:
	ld_s r0,[r14]
L_8c6698:
	sub.f r0,r0,0x0
L_8c669c:
	mov.ne r0,0x1
L_8c66a0:
	extb.f 0x0,r0
L_8c66a4:
	bne_s L_8c6678
L_8c66a6:
	b L_8c024c
L_8c66aa:
	nop_s
