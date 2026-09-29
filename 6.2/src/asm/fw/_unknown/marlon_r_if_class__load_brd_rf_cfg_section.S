/* marlon_r_if_class__load_brd_rf_cfg_section @ 0x8dc830, 372 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if_class::load_brd_rf_cfg_section: BRD Section Write to RF Started, section_type=%d
 *   marlon_r_if_class::load_brd_rf_cfg_section: BRD Section Write to RF Completed, section_type=%d, elapsed_time=%d [usec]
 *   marlon_r_if_class::load_brd_rf_cfg_section: RF write failure for chunk_idx=%d, block_idx=%d, section_type=%d
 * Зовут его: marlon_r_if_class__config_channel, marlon_r_if_class__rf_configure_role_power
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, brd_if__clear_block_info_thunk, brd_if__noop_hook_b, brd_if__noop_hook_c, brd_if__section_info_reset_thunk, div_round_up, fw_log_emit1, fw_log_emit2, fw_log_emit3, hwd__args_to_regs_default, hwd_abif__dvs_rfca_cmd_enable
 * Глобалы (через gp): 0x800242, 0x800243
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global marlon_r_if_class__load_brd_rf_cfg_section
marlon_r_if_class__load_brd_rf_cfg_section:
	.global L_8dc830
L_8dc830:
	push_s blink
L_8dc832:
	bl L_8c01c0
L_8dc836:
	mov_s r14,r0
L_8dc838:
	st.a r1,[sp,-0x3c]
L_8dc83c:
	st_s r2,[sp,0x4]
L_8dc83e:
	mov_s r21,r3
L_8dc840:
	st r4,[sp, 0x8]
L_8dc844:
	brne_s r1,0,L_8dc850
L_8dc846:
	mov_s r0,r14
L_8dc848:
	bl.d L_8dc690
L_8dc84c:
	mov_s r1,r21
L_8dc84e:
	b_s L_8dc986
	.global L_8dc850
L_8dc850:
	bl.d L_8e9524
L_8dc854:
	add r16,sp,0xc
L_8dc858:
	mov_s r23,r0
L_8dc85a:
	mov_s r0,r16
L_8dc85c:
	mov_s r13,0x0
L_8dc85e:
	bl.d L_8c18d0
L_8dc862:
	mov_s r1,r13
L_8dc864:
	mov_s r0,0x857700
L_8dc86a:
	ld_s r0,[r0,0x68]
L_8dc86c:
	mov r22,0x1
L_8dc870:
	cmp_s r0,0x1
L_8dc872:
	ld_s r0,[r14,0x58]
L_8dc874:
	sub.ls r22,r22,r22
L_8dc878:
	cmp_s r0,0x0
L_8dc87a:
	beq_s L_8dc984
L_8dc87c:
	ld_s r1,[r0,0x44]
L_8dc87e:
	ld_s r3,[r1,0x8]
L_8dc880:
	ld_s r1,[sp,0x0]
L_8dc882:
	jl_s.d [r3]
L_8dc884:
	mov_s r2,r16
L_8dc886:
	cmp_s r0,0x0
L_8dc888:
	beq_s L_8dc984
L_8dc88a:
	mov_s r1,0x1005674
L_8dc890:
	mov_s r0,0x20
L_8dc892:
	bl.d L_8dcc10
L_8dc896:
	ld_s r2,[sp,0x0]
L_8dc898:
	bl.d L_8ebd14
L_8dc89c:
	mov_s r0,r16
L_8dc89e:
	add r18,sp,0x24
L_8dc8a2:
	mov_s r0,r18
L_8dc8a4:
	bl.d L_8c18cc
L_8dc8a8:
	mov_s r1,r13
L_8dc8aa:
	ld_s r0,[sp,0x10]
L_8dc8ac:
	brlo r0,0x1,L_8dc95a
L_8dc8b0:
	mov_s r17,r13
	.global L_8dc8b2
L_8dc8b2:
	ld_s r0,[r14,0x58]
L_8dc8b4:
	breq r22,0x0,L_8dc8c2
L_8dc8b8:
	ld_s r1,[r0,0x44]
L_8dc8ba:
	ld_s r3,[r1,0x1c]
L_8dc8bc:
	mov_s r1,r16
L_8dc8be:
	jl_s.d [r3]
L_8dc8c0:
	mov_s r2,r17
	.global L_8dc8c2
L_8dc8c2:
	ld_s r0,[r14,0x58]
L_8dc8c4:
	mov_s r2,r17
L_8dc8c6:
	ld_s r1,[r0,0x44]
L_8dc8c8:
	ld_s r13,[r1,0xc]
L_8dc8ca:
	mov_s r1,r16
L_8dc8cc:
	jl_s.d [r13]
L_8dc8ce:
	mov_s r3,r18
L_8dc8d0:
	breq r0,0x0,L_8dc984
L_8dc8d4:
	ld_s r1,[sp,0x2c]
L_8dc8d6:
	mov_s r0,0x0
L_8dc8d8:
	bset r0,r0,r1
L_8dc8dc:
	ldb r1,[r14,0x45e]
L_8dc8e4:
	tst_s r1,r0
L_8dc8e6:
	beq_s L_8dc950
L_8dc8e8:
	extb_s r0,r0
L_8dc8ea:
	bl.d L_8ce910
L_8dc8ee:
	mov_s r1,0x0
L_8dc8f0:
	mov_s r0,r18
L_8dc8f2:
	bl.d L_8cbea0
L_8dc8f6:
	mov_s r1,r21
L_8dc8f8:
	mov_s r13,r0
L_8dc8fa:
	bl.d L_8ebd10
L_8dc8fe:
	mov_s r0,r18
L_8dc900:
	brlo r13,0x1,L_8dc950
L_8dc904:
	mov_s r15,0x0
	.global L_8dc906
L_8dc906:
	ld_s r0,[r14,0x58]
L_8dc908:
	mov_s r2,r18
L_8dc90a:
	ld_s r1,[r0,0x44]
L_8dc90c:
	add2 r20,r14,0x17
L_8dc910:
	ld r7,[r1, 0x10]
L_8dc914:
	mov_s r1,r16
L_8dc916:
	mov_s r3,r15
L_8dc918:
	mov r4,r20
L_8dc91c:
	mov r5,r21
L_8dc920:
	jl.d [r7]
L_8dc924:
	ld r6,[sp, 0x4]
L_8dc928:
	mov_s r4,r0
L_8dc92a:
	mov_s r0,r14
L_8dc92c:
	mov_s r1,0x0
L_8dc92e:
	mov_s r2,r20
L_8dc930:
	mov_s r3,r4
L_8dc932:
	mov r4,0x10
L_8dc936:
	mov r5,0x5
L_8dc93a:
	bl.d L_8e3418
L_8dc93e:
	ld r6,[sp, 0x8]
L_8dc942:
	mov_s r19,r13
L_8dc944:
	breq_s r0,0,L_8dc98c
L_8dc946:
	sub r13,r19,0x1
L_8dc94a:
	brhs.d r13,0x1,L_8dc906
L_8dc94e:
	/* _add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_8dc950
L_8dc950:
	ld_s r0,[sp,0x10]
L_8dc952:
	add r17,r17,0x1
L_8dc956:
	brlo r17,r0,L_8dc8b2
	.global L_8dc95a
L_8dc95a:
	bl.d L_8d3380
L_8dc95e:
	ldb_s r0,[gp,0xbf]
L_8dc960:
	ldb_s r0,[gp,0xbe]
L_8dc962:
	bl.d L_8ce910
L_8dc966:
	mov_s r1,0x0
L_8dc968:
	bl L_8e9524
L_8dc96c:
	mov_s r1,0x10056d4
L_8dc972:
	sub r0,r0,r23
L_8dc976:
	asl_s r3,r0,0x4
L_8dc978:
	mov_s r0,0x20
L_8dc97a:
	bl.d L_8dcc80
L_8dc97e:
	ld_s r2,[sp,0x0]
L_8dc980:
	mov_s r0,0x1
L_8dc982:
	b_s L_8dc986
	.global L_8dc984
L_8dc984:
	mov_s r0,0x0
	.global L_8dc986
L_8dc986:
	b.d L_8c020c
L_8dc98a:
	add_s sp,sp,0x3c
	.global L_8dc98c
L_8dc98c:
	mov_s r1,0x100574c
L_8dc992:
	mov_s r0,0x0
L_8dc994:
	mov_s r2,r15
L_8dc996:
	mov_s r3,r17
L_8dc998:
	bl.d L_8dcd00
L_8dc99c:
	ld r4,[sp]
L_8dc9a0:
	b_s L_8dc984
L_8dc9a2:
	nop_s
