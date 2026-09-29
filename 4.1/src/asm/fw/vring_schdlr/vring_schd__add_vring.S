/* vring_schd__add_vring @ 0x8c276c, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schdlr.cpp
 *   ADD_VRING completed: V-ring #%d cid = %d mac_qid=%d
 * Зовут его: STREAM_MGR__ADD, stream_mgr__add_bcast_vring
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_log__emit3, fw_sysassert_fatal, hwd_dma__program_vring_desc, llist__insert, lmac_if_send_cmd_0x08, mem_pool__allocate, tail_hwd_dma__reset_vring, vring__get_pring_id, vring_by_index, vring_schd__fill_vring_cfg
 */
	.section .text.vring_schd__add_vring,"ax",@progbits
	.global vring_schd__add_vring
vring_schd__add_vring:
	.global L_8c276c
L_8c276c:
	push_s blink
L_8c276e:
	bl L_8c02a8
L_8c2772:
	mov_s r14,r0
L_8c2774:
	mov_s r13,r1
L_8c2776:
	mov_s r15,r2
L_8c2778:
	mov_s r0,0x80456c
L_8c277e:
	bl.d L_8c2dc8
L_8c2782:
	mov_s r21,r3
L_8c2784:
	mov.f r16,r0
L_8c2788:
	beq_s L_8c27b2
	.global L_8c278a
L_8c278a:
	mov_s r0,0x804580
L_8c2790:
	bl.d L_8c1fc4
L_8c2794:
	mov_s r1,r16
L_8c2796:
	ldb r18,[r13, 0x7]
L_8c279a:
	bl.d L_8c9d94
L_8c279e:
	mov_s r0,r13
L_8c27a0:
	ld r19,[r13, 0xc]
L_8c27a4:
	mov_s r20,r0
L_8c27a6:
	mov_s r0,0x0
L_8c27a8:
	breq r19,0x0,L_8c27c8
L_8c27ac:
	mov_s r17,r0
L_8c27ae:
	mov_s r15,r0
L_8c27b0:
	b_s L_8c27d0
	.global L_8c27b2
L_8c27b2:
	mov_s r0,blink
L_8c27b4:
	mov_s r2,0x100a584
L_8c27ba:
	mov_s r1,0x12b7
L_8c27c0:
	bl.d L_8c82c0
L_8c27c4:
	mov_s r3,0xe6
L_8c27c6:
	b_s L_8c278a
	.global L_8c27c8
L_8c27c8:
	breq_s r15,0,L_8c2832
	.global L_8c27ca
L_8c27ca:
	ldw r17,[r15]
L_8c27ce:
	ldw_s r15,[r15,0x2]
	.global L_8c27d0
L_8c27d0:
	bl.d L_8de5b4
L_8c27d4:
	mov_s r0,r18
L_8c27d6:
	ld_s r1,[r14]
L_8c27d8:
	mov_s r0,r18
L_8c27da:
	ld_s r2,[r14,0x4]
L_8c27dc:
	bl.d L_8cdfac
L_8c27e0:
	ldw_s r3,[r14,0x8]
L_8c27e2:
	extb r2,r20
L_8c27e6:
	mov_s r14,0x3
L_8c27e8:
	mov_s r0,r14
L_8c27ea:
	mov_s r1,0x0
L_8c27ec:
	mov_s r3,r18
L_8c27ee:
	mov_s r4,r1
L_8c27f0:
	mov_s r5,r1
L_8c27f2:
	bl.d L_8d8864
L_8c27f6:
	mov_s r6,r1
L_8c27f8:
	bl.d L_8cacc0
L_8c27fc:
	mov_s r0,r18
L_8c27fe:
	stb_s r14,[r0,0x2]
L_8c2800:
	mov_s r2,0x100a668
L_8c2806:
	mov_s r0,0x7
L_8c2808:
	mov_s r1,0x2
L_8c280a:
	mov_s r3,r18
L_8c280c:
	mov r4,r20
L_8c2810:
	bl.d L_8ee034
L_8c2814:
	mov r5,r18
L_8c2818:
	extw r2,r17
L_8c281c:
	extw_s r3,r15
L_8c281e:
	mov_s r0,r16
L_8c2820:
	mov_s r1,r13
L_8c2822:
	mov r4,r19
L_8c2826:
	bl.d L_8e267c
L_8c282a:
	mov r5,r21
L_8c282e:
	b L_8c02fc
	.global L_8c2832
L_8c2832:
	mov_s r0,blink
L_8c2834:
	mov_s r2,0x100a584
L_8c283a:
	mov_s r1,0x29
L_8c283c:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8c283e:
	bl.d L_8c82c0
L_8c2842:
	mov_s r3,0xf3
L_8c2844:
	b_s L_8c27ca
L_8c2846:
	nop_s
