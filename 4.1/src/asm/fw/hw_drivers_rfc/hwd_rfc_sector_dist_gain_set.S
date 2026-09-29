/* hwd_rfc_sector_dist_gain_set @ 0x8d0800, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_sector_dist_gain_set(): TX sector# %d activated (settings applied to current RF chain HW)
 *   hwd_rfc_sector_dist_gain_set(): RX sector# %d activated (settings applied to current RF chain HW)
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit1, hwd_rfc_read_rgf, rf_sector_commit_rx, rf_sector_commit_tx, rfc_field_write
 */
	.section .text.hwd_rfc_sector_dist_gain_set,"ax",@progbits
	.global hwd_rfc_sector_dist_gain_set
hwd_rfc_sector_dist_gain_set:
	.global L_8d0800
L_8d0800:
	push_s blink
L_8d0802:
	bl L_8c02b0
L_8d0806:
	mov_s r16,r0
L_8d0808:
	mov_s r17,r1
L_8d080a:
	mov.f r14,r2
L_8d080e:
	mov_s r15,r3
L_8d0810:
	mov r19,r4
L_8d0814:
	mov r18,r5
L_8d0818:
	asl_s r13,r1,0x6
L_8d081a:
	add1_s r13,r13,r13
L_8d081c:
	beq_s L_8d0828
L_8d081e:
	add r0,r13,0x8080
L_8d0826:
	b_s L_8d0830
	.global L_8d0828
L_8d0828:
	add r0,r13,0x10080
	.global L_8d0830
L_8d0830:
	lsr_s r0,r0,0x3
L_8d0832:
	bic r1,r0,0x3
L_8d0836:
	bl.d L_8d04fc
L_8d083a:
	mov_s r0,r16
L_8d083c:
	add1_s r15,r15,r15
L_8d083e:
	add_s r2,r15,0x2
L_8d0840:
	mov_s r1,0x0
L_8d0842:
	bset r1,r1,r2
L_8d0846:
	mov_s r3,0x0
L_8d0848:
	bset r3,r3,r15
L_8d084c:
	sub r2,r1,r3
L_8d0850:
	or_s r1,r1,r2
L_8d0852:
	bic r2,r0,r1
L_8d0856:
	bmsk r3,r19,0x2
L_8d085a:
	asl_s r3,r3,r15
L_8d085c:
	breq_s r14,0,L_8d0886
L_8d085e:
	add_s r13,r13,0x8080
L_8d0864:
	lsr_s r13,r13,0x3
L_8d0866:
	bic r1,r13,0x3
L_8d086a:
	mov_s r0,r16
L_8d086c:
	bl.d L_8d113c
L_8d0870:
	or_s r2,r2,r3
L_8d0872:
	breq r18,0x0,L_8d08b6
L_8d0876:
	mov_s r0,r16
L_8d0878:
	bl.d L_8d0ef4
L_8d087c:
	mov_s r1,r17
L_8d087e:
	mov_s r2,0x1019434
L_8d0884:
	b_s L_8d08ac
	.global L_8d0886
L_8d0886:
	add_s r13,r13,0x10080
L_8d088c:
	lsr_s r13,r13,0x3
L_8d088e:
	bic r1,r13,0x3
L_8d0892:
	mov_s r0,r16
L_8d0894:
	bl.d L_8d113c
L_8d0898:
	or_s r2,r2,r3
L_8d089a:
	breq r18,0x0,L_8d08b6
L_8d089e:
	mov_s r0,r16
L_8d08a0:
	bl.d L_8d073c
L_8d08a4:
	mov_s r1,r17
L_8d08a6:
	mov_s r2,0x1019498
	.global L_8d08ac
L_8d08ac:
	mov_s r0,0x0
L_8d08ae:
	mov_s r1,0x2
L_8d08b0:
	bl.d L_8edfcc
L_8d08b4:
	mov_s r3,r17
	.global L_8d08b6
L_8d08b6:
	b L_8c030c
L_8d08ba:
	nop_s
