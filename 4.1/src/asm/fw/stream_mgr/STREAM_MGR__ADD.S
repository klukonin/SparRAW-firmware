/* STREAM_MGR__ADD @ 0x8c263c, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   STREAM_MGR::ADD VRING to already added Vring index  %d.
 *   stream_mgr.cpp
 *   STREAM_MGR::Automatic BA AGREEMENT  of window %d, max_msdu_size %d
 *   STREAM_MGR:: wrong window %d (max_msdu_size %d).
 *   STREAM_MGR::VRING was added with IMM ACK policy (max_msdu_size = %d)
 * Зовут его: encap_trans_type
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, conn_mgr__by_cid, fw_log__emit1, fw_log__emit2, fw_sysassert_fatal, hwd_dma__macq_reg_addr, l2mgr__send_vring_cfg_done, l2mgr__send_vring_en_evt, stream_mgr__install_ba_rule, vring_schd__add_vring
 */
	.section .text.STREAM_MGR__ADD,"ax",@progbits
	.global STREAM_MGR__ADD
STREAM_MGR__ADD:
	.global L_8c263c
L_8c263c:
	push_s blink
L_8c263e:
	bl L_8c02b4
L_8c2642:
	mov_s r17,r0
L_8c2644:
	mov_s r15,r1
L_8c2646:
	mov_s r18,r2
L_8c2648:
	ldb_s r14,[r0,0x7]
L_8c264a:
	ldb_s r0,[r1,0xd]
L_8c264c:
	bl.d L_8c9e44
L_8c2650:
	bmsk_s r0,r0,0x3
L_8c2652:
	mov.f r13,r0
L_8c2656:
	beq_s L_8c268a
	.global L_8c2658
L_8c2658:
	mov_s r0,0x8485dc
L_8c265e:
	add2_s r0,r0,r14
L_8c2660:
	ld_s r1,[r0,0x18]
L_8c2662:
	breq_s r1,0,L_8c26a0
L_8c2664:
	mov_s r2,0x100e7c4
L_8c266a:
	mov_s r0,0xb
L_8c266c:
	mov_s r1,0x2
L_8c266e:
	bl.d L_8edfcc
L_8c2672:
	mov_s r3,r14
L_8c2674:
	bl.d L_8cda90
L_8c2678:
	mov_s r0,r14
L_8c267a:
	mov_s r1,r0
L_8c267c:
	ld_s r3,[r13,0xc]
L_8c267e:
	mov_s r0,r14
L_8c2680:
	mov_s r2,0x1
L_8c2682:
	bl.d L_8f0b8c
L_8c2686:
	ldb_s r3,[r3,0x10]
L_8c2688:
	b_s L_8c2768
	.global L_8c268a
L_8c268a:
	mov_s r0,blink
L_8c268c:
	mov_s r2,0x100e398
L_8c2692:
	mov_s r1,0x128a
L_8c2698:
	bl.d L_8c82c0
L_8c269c:
	mov_s r3,0x45
L_8c269e:
	b_s L_8c2658
	.global L_8c26a0
L_8c26a0:
	st r17,[r0, 0x18]
L_8c26a4:
	add3 r1,r13,0x16
L_8c26a8:
	ldb_s r0,[r1]
L_8c26aa:
	breq r0,0x2,L_8c26b4
L_8c26ae:
	ld_s r0,[r1,0x30]
L_8c26b0:
	breq r0,0x0,L_8c2736
	.global L_8c26b4
L_8c26b4:
	ldb_s r0,[r13,0xa]
L_8c26b6:
	add r2,r15,0x14
L_8c26ba:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c26bc:
	stb_s r0,[r13,0xa]
L_8c26be:
	mov_s r0,r15
L_8c26c0:
	mov_s r1,r17
L_8c26c2:
	mov_s r3,0x1
L_8c26c4:
	bl.d L_8c276c
L_8c26c8:
	mov_s r16,r3
L_8c26ca:
	ldb_s r0,[r13,0x8]
L_8c26cc:
	bl.d L_8dbb5c
L_8c26d0:
	mov_s r1,0x2
L_8c26d2:
	ldb_s r3,[r15,0x13]
L_8c26d4:
	breq_s r3,0,L_8c2722
L_8c26d6:
	mul64 r3,r18
L_8c26da:
	brlt 0x14000,mlo,L_8c270c
L_8c26e2:
	mov_s r2,0x100e7fc
L_8c26e8:
	mov_s r0,0xb
L_8c26ea:
	mov_s r1,0x2
L_8c26ec:
	bl.d L_8edff8
L_8c26f0:
	mov r4,r18
L_8c26f4:
	ld r0,[r17, 0xd4]
L_8c26f8:
	ldb_s r1,[r15,0x13]
L_8c26fa:
	mov_s r2,0x0
L_8c26fc:
	ld r4,[r0, 0x18]
L_8c2700:
	mov_s r0,r17
L_8c2702:
	mov_s r15,r4
L_8c2704:
	jl_s.d [r15]
L_8c2706:
	mov_s r3,0x0
L_8c2708:
	mov_s r15,0x0
L_8c270a:
	b_s L_8c2738
	.global L_8c270c
L_8c270c:
	mov_s r2,0x100e840
L_8c2712:
	mov_s r0,0xb
L_8c2714:
	mov_s r1,0x2
L_8c2716:
	bl.d L_8edff8
L_8c271a:
	mov r4,r18
L_8c271e:
	mov_s r15,r16
L_8c2720:
	b_s L_8c2738
	.global L_8c2722
L_8c2722:
	mov_s r2,0x100e874
L_8c2728:
	mov_s r0,0xb
L_8c272a:
	mov_s r1,0x2
L_8c272c:
	bl.d L_8edfcc
L_8c2730:
	mov_s r3,r18
L_8c2732:
	mov_s r15,0x0
L_8c2734:
	b_s L_8c2738
	.global L_8c2736
L_8c2736:
	mov_s r15,0x1
	.global L_8c2738
L_8c2738:
	bl.d L_8cda90
L_8c273c:
	mov_s r0,r14
L_8c273e:
	mov_s r1,r0
L_8c2740:
	ld_s r3,[r13,0xc]
L_8c2742:
	extb_s r2,r15
L_8c2744:
	mov_s r0,r14
L_8c2746:
	bl.d L_8f0b8c
L_8c274a:
	ldb_s r3,[r3,0x10]
L_8c274c:
	brne_s r15,0,L_8c2768
L_8c274e:
	ldb r0,[r13, 0xfc]
L_8c2752:
	cmp_s r0,0x7
L_8c2754:
	mov_s r0,0x1
L_8c2756:
	sub_s.ne r0,r0,r0
L_8c2758:
	extb.f 0x0,r0
L_8c275c:
	beq_s L_8c2768
L_8c275e:
	ld_s r1,[r13,0xc]
L_8c2760:
	mov_s r0,r14
L_8c2762:
	bl.d L_8f0bd4
L_8c2766:
	ldb_s r1,[r1,0x10]
	.global L_8c2768
L_8c2768:
	b L_8c0314
