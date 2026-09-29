/* tx_mtp__open_window @ 0x9247c0, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_flow_size_step, tx_initiator_substep, tx_mtp_queue_gate
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, cf_end__tx_flow, mac__build_tx_common_params, mac__cmd_29000001, mac__select_all_sectors_and_wait
 * Глобалы (через gp): 0x800608
 */
	.section .text.tx_mtp__open_window,"ax",@progbits
	.global tx_mtp__open_window
tx_mtp__open_window:
	.global L_9247c0
L_9247c0:
	push_s blink
L_9247c2:
	bl L_920214
L_9247c6:
	mov_s r13,r0
L_9247c8:
	ld_s r0,[gp,-0x44]
L_9247ca:
	mov_s r14,r1
L_9247cc:
	and r0,r0,0xffff0fff
L_9247d4:
	bset r1,r0,0xd
L_9247d8:
	bset_s r1,r1,0xf
L_9247da:
	st.as r1,[gp,-0x11]
L_9247de:
	or r0,r0,0x1d00a000
L_9247e6:
	mov_s r32,r0
L_9247e8:
	st.ab r0,[r25,0x4]
L_9247ec:
	bclr r25,r25,0xa
L_9247f0:
	bl L_931980
L_9247f4:
	bl L_931640
L_9247f8:
	mov_s r1,r40
L_9247fa:
	mov_s r0,r42
L_9247fc:
	bbit1 r0,0xe,L_924804
L_924800:
	bbit1 r1,0x18,L_924816
	.global L_924804
L_924804:
	mov_s r0,0x29000002
L_92480a:
	mov_s r32,r0
L_92480c:
	st.ab r0,[r25,0x4]
L_924810:
	bclr r25,r25,0xa
L_924814:
	b_s L_924834
	.global L_924816
L_924816:
	ld_s r3,[r13]
L_924818:
	mov_s r0,0x5
L_92481a:
	/* asl_s r3,r3,0x3 */
	.byte 0x03,0xbb
L_92481c:
	add3_s r3,r3,r3
L_92481e:
	add_s r3,r3,0x801190
L_924824:
	ld_s r1,[r3,0x8]
L_924826:
	mov_s r2,r14
L_924828:
	bl.d L_92bb2c
L_92482c:
	ld_s r3,[r3,0xc]
L_92482e:
	bl.d L_924578
L_924832:
	mov_s r0,r13
	.global L_924834
L_924834:
	ld_s r0,[gp,0xe0]
L_924836:
	bset_s r0,r0,0x9
L_924838:
	b.d L_920284
L_92483c:
	st.as r0,[gp,0x38]
