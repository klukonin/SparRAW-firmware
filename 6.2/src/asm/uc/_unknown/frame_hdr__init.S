/* frame_hdr__init @ 0x9246fc, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: direct_tx__send_ctrl_frame
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bits__uc_set32_s4_w3, frame_hdr__bits_uc_set32_s0_w7, frame_hdr__bits_uc_set32_s15_w8, frame_hdr__bits_uc_set32_s23_w9, frame_hdr__bits_uc_set32_s7_w8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global frame_hdr__init
frame_hdr__init:
	.global L_9246fc
L_9246fc:
	push_s blink
L_9246fe:
	bl.d L_920234
L_924702:
	bmsk_s r2,r2,0x0
L_924704:
	mov_s r14,r0
L_924706:
	mov r0,0x464
L_92470a:
	stw_s r0,[r14]
L_92470c:
	ldw_s r0,[r3]
L_92470e:
	mov_s r13,r1
L_924710:
	stw_s r0,[r14,0x2]
L_924712:
	mov_s r0,0x0
L_924714:
	st_s r0,[r14,0x10]
L_924716:
	stb_s r0,[r14,0x15]
L_924718:
	stb_s r0,[r14,0x16]
L_92471a:
	ldw_s r1,[r3]
L_92471c:
	add r0,r14,0x10
L_924720:
	/* asr_s r1,r1,0x7 */
	.byte 0x47,0xb9
L_924722:
	bl.d L_93e3cc
L_924726:
	bmsk_s r13,r13,0x0
L_924728:
	ldw_s r1,[r3]
L_92472a:
	add r0,r14,0x14
L_92472e:
	bmsk_s r1,r1,0x6
L_924730:
	bl.d L_93e3a8
L_924734:
	asl_s r13,r13
L_924736:
	ld_s r0,[r3,0x4]
L_924738:
	mov_s r1,0x1
L_92473a:
	cmp_s r0,0x1
L_92473c:
	sub_s.ne r1,r1,r1
L_92473e:
	add r0,r14,0x10
L_924742:
	bl.d L_93e3e4
L_924746:
	/* _asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_924748:
	ldb_s r1,[r3,0x9]
L_92474a:
	bl L_93e3b4
L_92474e:
	ldb_s r1,[r3,0x8]
L_924750:
	bl L_93e408
L_924754:
	ldb_s r0,[r14,0x15]
L_924756:
	bset_s r0,r0,0x0
L_924758:
	bclr_s r0,r0,0x1
L_92475a:
	or_s r0,r0,r13
L_92475c:
	bclr_s r0,r0,0x2
L_92475e:
	or_s r2,r2,r0
L_924760:
	b.d L_9202a4
L_924764:
	stb_s r2,[r14,0x15]
L_924766:
	nop_s
