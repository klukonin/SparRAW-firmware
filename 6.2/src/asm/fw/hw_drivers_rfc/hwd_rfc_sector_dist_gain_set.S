/* hwd_rfc_sector_dist_gain_set @ 0x8d3888, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_sector_dist_gain_set(): TX sector# %d activated (settings applied to current RF chain HW)
 *   hwd_rfc_sector_dist_gain_set(): RX sector# %d activated (settings applied to current RF chain HW)
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit1, hwd_rfc_read_rgf, rf_sector_commit_rx, rf_sector_commit_tx, rfc_field_write, ut_hw_drivers_cmd_0x507, ut_hw_drivers_cmd_0x508
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_sector_dist_gain_set
hwd_rfc_sector_dist_gain_set:
	.global L_8d3888
L_8d3888:
	push_s blink
L_8d388a:
	bl L_8c01d0
L_8d388e:
	mov_s r17,r0
L_8d3890:
	mov_s r18,r1
L_8d3892:
	mov.f r16,r2
L_8d3896:
	mov_s r15,r3
L_8d3898:
	mov r19,r4
L_8d389c:
	mov_s r13,r5
L_8d389e:
	asl_s r14,r1,0x6
L_8d38a0:
	add1_s r14,r14,r14
L_8d38a2:
	beq_s L_8d38ae
L_8d38a4:
	add r0,r14,0x8080
L_8d38ac:
	b_s L_8d38b6
	.global L_8d38ae
L_8d38ae:
	add r0,r14,0x10080
	.global L_8d38b6
L_8d38b6:
	lsr_s r0,r0,0x3
L_8d38b8:
	bic r1,r0,0x3
L_8d38bc:
	bl.d L_8d3588
L_8d38c0:
	mov_s r0,r17
L_8d38c2:
	add1_s r15,r15,r15
L_8d38c4:
	add_s r2,r15,0x2
L_8d38c6:
	mov_s r1,0x0
L_8d38c8:
	bset r1,r1,r2
L_8d38cc:
	mov_s r3,0x0
L_8d38ce:
	bset r3,r3,r15
L_8d38d2:
	sub r2,r1,r3
L_8d38d6:
	or_s r1,r1,r2
L_8d38d8:
	bic r2,r0,r1
L_8d38dc:
	bmsk r3,r19,0x2
L_8d38e0:
	asl_s r3,r3,r15
L_8d38e2:
	breq r16,0x0,L_8d3918
L_8d38e6:
	add_s r14,r14,0x8080
L_8d38ec:
	lsr_s r14,r14,0x3
L_8d38ee:
	bic r1,r14,0x3
L_8d38f2:
	mov_s r0,r17
L_8d38f4:
	bl.d L_8d4308
L_8d38f8:
	or_s r2,r2,r3
L_8d38fa:
	brge r13,0x10,L_8d3950
L_8d38fe:
	mov_s r0,r17
L_8d3900:
	bl.d L_8d40d8
L_8d3904:
	mov_s r1,r18
L_8d3906:
	mov_s r0,r17
L_8d3908:
	mov_s r1,r18
L_8d390a:
	bl.d L_8d4104
L_8d390e:
	mov_s r2,r13
L_8d3910:
	mov_s r1,0x101e664
L_8d3916:
	b_s L_8d3948
	.global L_8d3918
L_8d3918:
	add_s r14,r14,0x10080
L_8d391e:
	lsr_s r14,r14,0x3
L_8d3920:
	bic r1,r14,0x3
L_8d3924:
	mov_s r0,r17
L_8d3926:
	bl.d L_8d4308
L_8d392a:
	or_s r2,r2,r3
L_8d392c:
	brge r13,0x10,L_8d3950
L_8d3930:
	mov_s r0,r17
L_8d3932:
	bl.d L_8d37dc
L_8d3936:
	mov_s r1,r18
L_8d3938:
	mov_s r0,r17
L_8d393a:
	mov_s r1,r18
L_8d393c:
	bl.d L_8d3808
L_8d3940:
	mov_s r2,r13
L_8d3942:
	mov_s r1,0x101e6c8
	.global L_8d3948
L_8d3948:
	mov_s r0,0x20
L_8d394a:
	bl.d L_8dcc10
L_8d394e:
	mov_s r2,r18
	.global L_8d3950
L_8d3950:
	b L_8c022c
