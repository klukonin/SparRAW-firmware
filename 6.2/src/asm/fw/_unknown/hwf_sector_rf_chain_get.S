/* hwf_sector_rf_chain_get @ 0x8d70d4, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_sector_rf_chain_get(): Inputs: sector_num=%d, is_tx_sector=%d, chain_num=%d
 *   hwf_sector_rf_chain_get(): Outputs: edge_gain=%d, edge_phase=%d, dist_gain=%d
 *   [NNL] x16_state=%d
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit1, fw_log_emit3, hwd_rfc__read_sector_chain, hwd_rfc__read_sector_reg, ut_hw_drivers_cmd_0x50f, ut_hw_drivers_cmd_0x513
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_sector_rf_chain_get
hwf_sector_rf_chain_get:
	.global L_8d70d4
L_8d70d4:
	push_s blink
L_8d70d6:
	bl L_8c01d4
L_8d70da:
	mov_s r18,r0
L_8d70dc:
	mov_s r15,r1
L_8d70de:
	mov_s r16,r2
L_8d70e0:
	mov_s r17,r3
L_8d70e2:
	bl.d L_8d3954
L_8d70e6:
	mov_s r13,r4
L_8d70e8:
	stb_s r0,[r13,0x1]
L_8d70ea:
	mov_s r0,r18
L_8d70ec:
	mov_s r1,r15
L_8d70ee:
	mov_s r2,r16
L_8d70f0:
	bl.d L_8d3b90
L_8d70f4:
	mov_s r3,r17
L_8d70f6:
	stb_s r0,[r13]
L_8d70f8:
	asr r14,r17,0x2
L_8d70fc:
	extb_s r14,r14
L_8d70fe:
	mov_s r0,r18
L_8d7100:
	mov_s r1,r15
L_8d7102:
	mov_s r2,r16
L_8d7104:
	bl.d L_8d3850
L_8d7108:
	mov_s r3,r14
L_8d710a:
	stb_s r0,[r13,0x2]
L_8d710c:
	asr_s r3,r14,0x2
L_8d710e:
	mov_s r0,r18
L_8d7110:
	mov_s r1,r15
L_8d7112:
	bl.d L_8d3d64
L_8d7116:
	mov_s r2,r16
L_8d7118:
	stb_s r0,[r13,0x3]
L_8d711a:
	mov_s r1,0x101b520
L_8d7120:
	mov_s r0,0x20
L_8d7122:
	mov_s r2,r15
L_8d7124:
	mov_s r3,r16
L_8d7126:
	bl.d L_8dcd00
L_8d712a:
	mov r4,r17
L_8d712e:
	ldb r4,[r13, 0x2]
L_8d7132:
	mov_s r1,0x101b570
L_8d7138:
	ldb_s r2,[r13,0x1]
L_8d713a:
	mov_s r0,0x20
L_8d713c:
	bl.d L_8dcd00
L_8d7140:
	ldb_s r3,[r13]
L_8d7142:
	mov_s r1,0x101b5c0
L_8d7148:
	mov_s r0,0x20
L_8d714a:
	bl.d L_8dcc10
L_8d714e:
	ldb_s r2,[r13,0x3]
L_8d7150:
	b L_8c0234
