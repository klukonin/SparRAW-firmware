/* hwf_sector_rf_chain_get @ 0x8d4764, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_sector_rf_chain_get(): Inputs: sector_num=%d, is_tx_sector=%d, chain_num=%d
 *   hwf_sector_rf_chain_get(): Outputs: edge_gain=%d, edge_phase=%d, dist_gain=%d
 *   [NNL] x16_state=%d
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, hwf_sector_rf_chains_array_get
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit1, fw_log__emit3, hwd_rfc__read_sector_chain, hwd_rfc__read_sector_reg, ut_hw_drivers_cmd_0x50f, ut_hw_drivers_cmd_0x513
 */
	.section .text.hwf_sector_rf_chain_get,"ax",@progbits
	.global hwf_sector_rf_chain_get
hwf_sector_rf_chain_get:
	.global L_8d4764
L_8d4764:
	push_s blink
L_8d4766:
	bl L_8c02b4
L_8d476a:
	mov_s r18,r0
L_8d476c:
	mov_s r15,r1
L_8d476e:
	mov_s r16,r2
L_8d4770:
	mov_s r17,r3
L_8d4772:
	bl.d L_8d08bc
L_8d4776:
	mov_s r13,r4
L_8d4778:
	stb_s r0,[r13,0x1]
L_8d477a:
	mov_s r0,r18
L_8d477c:
	mov_s r1,r15
L_8d477e:
	mov_s r2,r16
L_8d4780:
	bl.d L_8d0ae4
L_8d4784:
	mov_s r3,r17
L_8d4786:
	stb_s r0,[r13]
L_8d4788:
	asr r14,r17,0x2
L_8d478c:
	extb_s r14,r14
L_8d478e:
	mov_s r0,r18
L_8d4790:
	mov_s r1,r15
L_8d4792:
	mov_s r2,r16
L_8d4794:
	bl.d L_8d07c8
L_8d4798:
	mov_s r3,r14
L_8d479a:
	stb_s r0,[r13,0x2]
L_8d479c:
	asr_s r3,r14,0x2
L_8d479e:
	mov_s r0,r18
L_8d47a0:
	mov_s r1,r15
L_8d47a2:
	bl.d L_8d0cbc
L_8d47a6:
	mov_s r2,r16
L_8d47a8:
	stb_s r0,[r13,0x3]
L_8d47aa:
	mov_s r2,0x1016db0
L_8d47b0:
	mov_s r0,0x0
L_8d47b2:
	mov_s r1,0x2
L_8d47b4:
	mov_s r3,r15
L_8d47b6:
	mov r4,r16
L_8d47ba:
	bl.d L_8ee034
L_8d47be:
	mov r5,r17
L_8d47c2:
	ldb r4,[r13]
L_8d47c6:
	mov_s r2,0x1016e00
L_8d47cc:
	ldb r5,[r13, 0x2]
L_8d47d0:
	mov_s r0,0x0
L_8d47d2:
	mov_s r1,0x2
L_8d47d4:
	bl.d L_8ee034
L_8d47d8:
	ldb_s r3,[r13,0x1]
L_8d47da:
	mov_s r2,0x1016e50
L_8d47e0:
	mov_s r0,0x0
L_8d47e2:
	mov_s r1,0x2
L_8d47e4:
	bl.d L_8edfcc
L_8d47e8:
	ldb_s r3,[r13,0x3]
L_8d47ea:
	b L_8c0314
L_8d47ee:
	nop_s
