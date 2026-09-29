/* hwf_sector_rf_chains_array_get @ 0x8d49e8, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_sector_rf_chains_array_get():  Reading chains 0 to %d of sector %d, is_tx_sector=%d
 *   hwf_sector_rf_chains_array_get(): chain_idx=%d, edge_phase=%d, edge_gain=%d
 *   hwf_sector_rf_chains_array_get(): dist_gain=%d, x16_state=%d
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bf_b_s0_w2, bf_b_s2_w3, bf_b_s5_w3, fw_log__emit2, fw_log__emit3, hwf_sector_rf_chain_get
 */
	.section .text.hwf_sector_rf_chains_array_get,"ax",@progbits
	.global hwf_sector_rf_chains_array_get
hwf_sector_rf_chains_array_get:
	.global L_8d49e8
L_8d49e8:
	push_s blink
L_8d49ea:
	bl L_8c02b0
L_8d49ee:
	sub_s sp,sp,0x4
L_8d49f0:
	mov_s r19,r0
L_8d49f2:
	mov_s r18,r1
L_8d49f4:
	mov_s r17,r2
L_8d49f6:
	mov_s r15,r3
L_8d49f8:
	mov_s r13,r4
L_8d49fa:
	mov_s r2,0x1016e64
L_8d4a00:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_8d4a02:
	mov_s r14,0x0
L_8d4a04:
	mov_s r0,r14
L_8d4a06:
	mov_s r1,0x2
L_8d4a08:
	mov r4,r18
L_8d4a0c:
	bl.d L_8ee034
L_8d4a10:
	mov r5,r17
L_8d4a14:
	mov_s r0,0x802d20
L_8d4a1a:
	ld_s r0,[r0]
L_8d4a1c:
	stb_s r15,[r13]
L_8d4a1e:
	st_s r0,[sp,0x0]
L_8d4a20:
	brlt.d r15,0x1,L_8d4aa2
L_8d4a24:
	add r16,r13,0x2
L_8d4a28:
	extb_s r15,r15
	.global L_8d4a2a
L_8d4a2a:
	mov r4,sp
L_8d4a2e:
	mov_s r0,r19
L_8d4a30:
	mov_s r1,r18
L_8d4a32:
	mov_s r2,r17
L_8d4a34:
	bl.d L_8d4764
L_8d4a38:
	mov_s r3,r14
L_8d4a3a:
	ldb_s r1,[sp,0x0]
L_8d4a3c:
	add1 r13,r16,r14
L_8d4a40:
	bmsk_s r1,r1,0x1
L_8d4a42:
	mov_s r0,r13
L_8d4a44:
	bl.d L_8e81f8
L_8d4a48:
	mov_s r3,r14
L_8d4a4a:
	ldb r1,[sp, 0x1]
L_8d4a4e:
	mov_s r2,0x1016ebc
L_8d4a54:
	bmsk_s r1,r1,0x2
L_8d4a56:
	/* bl.d 0x008e8234 */
	.byte 0xe2,0x0f,0xa0,0x09
L_8d4a5a:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d4a5c:
	ldb r1,[sp, 0x2]
L_8d4a60:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8d4a62:
	bmsk_s r1,r1,0x2
L_8d4a64:
	bl.d L_8e827c
L_8d4a68:
	extb_s r14,r14
L_8d4a6a:
	ldb r0,[sp, 0x3]
L_8d4a6e:
	mov_s r1,0x2
L_8d4a70:
	stb_s r0,[r13,0x1]
L_8d4a72:
	ldb r4,[r13]
L_8d4a76:
	mov_s r0,0x0
L_8d4a78:
	lsr r5,r4,0x2
L_8d4a7c:
	bmsk r4,r4,0x1
L_8d4a80:
	bl.d L_8ee034
L_8d4a84:
	bmsk r5,r5,0x2
L_8d4a88:
	ldb_s r3,[r13]
L_8d4a8a:
	mov_s r2,0x1016f08
L_8d4a90:
	lsr_s r3,r3,0x5
L_8d4a92:
	ldb r4,[r13, 0x1]
L_8d4a96:
	mov_s r0,0x0
L_8d4a98:
	bl.d L_8edff8
L_8d4a9c:
	mov_s r1,0x2
L_8d4a9e:
	brhs r15,0x1,L_8d4a2a
	.global L_8d4aa2
L_8d4aa2:
	b.d L_8c030c
L_8d4aa6:
	add_s sp,sp,0x4
