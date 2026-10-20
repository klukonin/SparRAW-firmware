/* marlon_r_if_class__load_brd_parameters_section @ 0x8dc690, 416 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if_class::load_brd_parameters_section: BRD Section Write to RF Started, section_type=%d
 *   marlon_r_if_class::load_brd_parameters_section: idx=%d, address=0x%X, value=0x%X
 *   marlon_r_if_class::load_brd_parameters_section: BRD Section Write to RF Completed, section_type=%d, elapsed_time=%d [usec]
 * Зовут его: marlon_r_if_class__init_board_file_interface, marlon_r_if_class__load_brd_rf_cfg_section
 * Зовёт сам: __ld_r25_to_r13_ret, __st_r25_to_r13, brd_if__clear_block_info_thunk, brd_if__noop_hook_b, brd_if__noop_hook_c, brd_if__section_info_reset_thunk, div_round_up, fw_log_emit1, fw_log_emit2, fw_log_emit3, handle_rf_sets_info, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global marlon_r_if_class__load_brd_parameters_section
marlon_r_if_class__load_brd_parameters_section:
	.global L_8dc690
L_8dc690:
	push_s blink
L_8dc692:
	bl L_8c01b8
L_8dc696:
	mov_s r13,r0
L_8dc698:
	st.a r1,[sp,-0x38]
L_8dc69c:
	add r18,sp,0x4
L_8dc6a0:
	mov_s r0,r18
L_8dc6a2:
	mov r24,0x0
L_8dc6a6:
	bl.d L_8c18d0
L_8dc6aa:
	mov_s r1,r24
L_8dc6ac:
	ld_s r0,[r13,0x58]
L_8dc6ae:
	breq r0,0x0,L_8dc7a0
L_8dc6b2:
	ld_s r1,[r0,0x44]
L_8dc6b4:
	ld_s r3,[r1,0x8]
L_8dc6b6:
	mov_s r1,r24
L_8dc6b8:
	jl_s.d [r3]
L_8dc6ba:
	mov_s r2,r18
L_8dc6bc:
	breq r0,0x0,L_8dc7a0
L_8dc6c0:
	mov r20,0x880a3c
L_8dc6c8:
	bl.d L_8e9524
L_8dc6cc:
	add3 r21,r20,0x10
L_8dc6d0:
	mov_s r25,r0
L_8dc6d2:
	mov_s r1,0x10053b0
L_8dc6d8:
	mov_s r0,0x20
L_8dc6da:
	bl.d L_8dcc10
L_8dc6de:
	ld_s r2,[sp,0x4]
L_8dc6e0:
	bl.d L_8ebd14
L_8dc6e4:
	mov_s r0,r18
L_8dc6e6:
	add r16,sp,0x1c
L_8dc6ea:
	mov_s r0,r16
L_8dc6ec:
	bl.d L_8c18cc
L_8dc6f0:
	mov_s r1,r24
L_8dc6f2:
	ld_s r0,[sp,0x8]
L_8dc6f4:
	cmp_s r0,0x0
L_8dc6f6:
	bls L_8dc80e
L_8dc6fa:
	mov r22,r24
	.global L_8dc6fe
L_8dc6fe:
	ld_s r0,[r13,0x58]
L_8dc700:
	mov_s r2,r22
L_8dc702:
	ld_s r1,[r0,0x44]
L_8dc704:
	ld_s r14,[r1,0xc]
L_8dc706:
	mov_s r1,r18
L_8dc708:
	jl_s.d [r14]
L_8dc70a:
	mov_s r3,r16
L_8dc70c:
	breq r0,0x0,L_8dc7a0
L_8dc710:
	mov_s r0,r16
L_8dc712:
	bl.d L_8cbea0
L_8dc716:
	ld_s r1,[sp,0x0]
L_8dc718:
	mov_s r14,r0
L_8dc71a:
	bl.d L_8ebd10
L_8dc71e:
	mov_s r0,r16
L_8dc720:
	brlo.d r14,0x1,L_8dc802
L_8dc724:
	mov_s r0,0x0
	.global L_8dc726
L_8dc726:
	mov_s r17,r0
L_8dc728:
	ld_s r0,[r13,0x58]
L_8dc72a:
	mov_s r23,r14
L_8dc72c:
	ld_s r1,[r0,0x44]
L_8dc72e:
	add2 r4,r13,0x17
L_8dc732:
	ld_s r14,[r1,0x10]
L_8dc734:
	mov_s r1,r18
L_8dc736:
	ld r5,[sp]
L_8dc73a:
	mov_s r2,r16
L_8dc73c:
	mov_s r3,r17
L_8dc73e:
	jl_s.d [r14]
L_8dc740:
	mov r6,0x0
L_8dc744:
	mov.f r19,r0
L_8dc748:
	st r24,[sp, 0x34]
L_8dc74c:
	beq_s L_8dc7f6
L_8dc74e:
	mov_s r2,0x0
	.global L_8dc750
L_8dc750:
	add3 r0,r13,r2
L_8dc754:
	ld_s r14,[r0,0x5c]
L_8dc756:
	mov_s r1,0x1005414
L_8dc75c:
	ld r4,[r0, 0x60]
L_8dc760:
	mov_s r0,0x20
L_8dc762:
	bl.d L_8dcd00
L_8dc766:
	mov_s r3,r14
L_8dc768:
	brne r14,0x8fffff,L_8dc7c0
L_8dc770:
	ld_s r15,[sp,0x34]
L_8dc772:
	sub r0,r19,r15
L_8dc776:
	brlo.d r0,0x5,L_8dc7a4
L_8dc77a:
	add3 r14,r13,r15
L_8dc77e:
	mov_s r0,0x85776c
L_8dc784:
	add3 r1,r14,0xc
L_8dc788:
	bl.d L_8c0380
L_8dc78c:
	mov_s r2,0x20
L_8dc78e:
	ld r1,[r14, 0x80]
L_8dc792:
	mov_s r0,0x857000
L_8dc798:
	st_s r1,[r0,0x38]
L_8dc79a:
	/* add_s r15,0x4 */
	.byte 0x04,0xe7
L_8dc79c:
	st_s r15,[sp,0x34]
L_8dc79e:
	b_s L_8dc7ec
	.global L_8dc7a0
L_8dc7a0:
	mov_s r0,0x0
L_8dc7a2:
	b_s L_8dc828
	.global L_8dc7a4
L_8dc7a4:
	ld_s r2,[r14,0x60]
L_8dc7a6:
	mov lp_count,0x8
L_8dc7aa:
	mov_s r0,0x0
L_8dc7ac:
	lp L_8dc7be
L_8dc7b0:
	mov_s r1,0x85776c
L_8dc7b6:
	add2_s r1,r1,r0
L_8dc7b8:
	st_s r2,[r1]
L_8dc7ba:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8dc7bc:
	extw_s r0,r0
	.global L_8dc7be
L_8dc7be:
	b_s L_8dc7ec
	.global L_8dc7c0
L_8dc7c0:
	brne r14,0x8ffffe,L_8dc7d2
L_8dc7c8:
	add_s r1,sp,0x34
L_8dc7ca:
	bl.d L_8ed5ec
L_8dc7ce:
	mov_s r0,r13
L_8dc7d0:
	b_s L_8dc7ec
	.global L_8dc7d2
L_8dc7d2:
	brlo.d r14,r20,L_8dc7dc
L_8dc7d6:
	ld_s r1,[sp,0x34]
L_8dc7d8:
	brlo r14,r21,L_8dc7e4
	.global L_8dc7dc
L_8dc7dc:
	brne r14,0x880014,L_8dc7ec
	.global L_8dc7e4
L_8dc7e4:
	add3 r0,r13,r1
L_8dc7e8:
	ld_s r0,[r0,0x60]
L_8dc7ea:
	st_s r0,[r14]
	.global L_8dc7ec
L_8dc7ec:
	ld_s r2,[sp,0x34]
L_8dc7ee:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8dc7f0:
	brlo.d r2,r19,L_8dc750
L_8dc7f4:
	st_s r2,[sp,0x34]
	.global L_8dc7f6
L_8dc7f6:
	sub r14,r23,0x1
L_8dc7fa:
	brhs.d r14,0x1,L_8dc726
L_8dc7fe:
	add r0,r17,0x1
	.global L_8dc802
L_8dc802:
	ld_s r0,[sp,0x8]
L_8dc804:
	add r22,r22,0x1
L_8dc808:
	cmp_s r0,r22
L_8dc80a:
	bhi L_8dc6fe
	.global L_8dc80e
L_8dc80e:
	bl L_8e9524
L_8dc812:
	mov_s r1,0x1005468
L_8dc818:
	sub r0,r0,r25
L_8dc81c:
	asl_s r3,r0,0x4
L_8dc81e:
	mov_s r0,0x20
L_8dc820:
	bl.d L_8dcc80
L_8dc824:
	mov_s r2,0x0
L_8dc826:
	mov_s r0,0x1
	.global L_8dc828
L_8dc828:
	b.d L_8c01fc
L_8dc82c:
	add_s sp,sp,0x38
L_8dc82e:
	nop_s
