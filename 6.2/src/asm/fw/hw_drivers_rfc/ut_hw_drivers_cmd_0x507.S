/* ut_hw_drivers_cmd_0x507 @ 0x8d3808, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_rfc_sector_dist_gain_set, hwd_rfc_sector_edge_gain_set, hwd_rfc_sector_edge_phase_set, hwd_rfc_sector_x16_state_set, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, hwd_rfc_write_core_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_drivers_cmd_0x507
ut_hw_drivers_cmd_0x507:
	.global L_8d3808
L_8d3808:
	push_s blink
L_8d380a:
	bl L_8c01dc
L_8d380e:
	mov_s r16,r0
L_8d3810:
	cmp_s r1,0x7f
L_8d3812:
	mov_s r13,r1
L_8d3814:
	mov_s r14,r2
L_8d3816:
	bgt_s L_8d3834
	.global L_8d3818
L_8d3818:
	brge r14,0x10,L_8d3842
	.global L_8d381c
L_8d381c:
	bmsk_s r14,r14,0x3
L_8d381e:
	asl_s r3,r14,0x7
L_8d3820:
	bmsk r2,r13,0x6
L_8d3824:
	mov_s r0,r16
L_8d3826:
	mov_s r1,0x9
L_8d3828:
	or_s r2,r2,r3
L_8d382a:
	bl.d L_8d415c
L_8d382e:
	mov_s r3,0x0
L_8d3830:
	b L_8c0244
	.global L_8d3834
L_8d3834:
	mov_s r0,blink
L_8d3836:
	mov_s r1,0x1151
L_8d383c:
	bl L_8c9b28
L_8d3840:
	b_s L_8d3818
	.global L_8d3842
L_8d3842:
	mov_s r0,blink
L_8d3844:
	mov_s r1,0x1155
L_8d384a:
	bl L_8c9b28
L_8d384e:
	b_s L_8d381c
