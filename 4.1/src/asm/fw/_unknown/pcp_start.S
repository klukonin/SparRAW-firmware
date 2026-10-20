/* pcp_start @ 0x8eef18, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_start()
 *   [NNL] discovery_mode %d, PCP_assoc_ready %d.
 * Зовут его: l2_mgr__pcp_start_flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit2, lmac_if__send_abft_resp_ctrl, tx_bcon__update_bcon
 */
	.section .text.pcp_start,"ax",@progbits
	.global pcp_start
pcp_start:
	.global L_8eef18
L_8eef18:
	push_s blink
L_8eef1a:
	bl.d L_8c02c4
L_8eef1e:
	mov_s r1,0x2
L_8eef20:
	mov_s r13,r0
L_8eef22:
	mov_s r2,0x1012548
L_8eef28:
	bl.d L_8edfb0
L_8eef2c:
	mov_s r0,0xc
L_8eef2e:
	ld_s r0,[r13,0x4]
L_8eef30:
	mov_s r2,0x1012554
L_8eef36:
	add r0,r0,0x14f
L_8eef3a:
	ldb_s r3,[r0]
L_8eef3c:
	ldb_s r14,[r0,0x5]
L_8eef3e:
	bclr_s r3,r3,0x1
L_8eef40:
	stb_s r3,[r0]
L_8eef42:
	lsr_s r3,r3
L_8eef44:
	lsr_s r14,r14,0x4
L_8eef46:
	mov_s r0,0xc
L_8eef48:
	mov_s r1,0x2
L_8eef4a:
	bmsk_s r3,r3,0x0
L_8eef4c:
	bl.d L_8edff8
L_8eef50:
	bmsk r4,r14,0x1
L_8eef54:
	bl.d L_8c2190
L_8eef58:
	ld_s r0,[r13,0x4]
L_8eef5a:
	mov_s r1,0x843104
L_8eef60:
	ld_s r0,[r1,0x20]
L_8eef62:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eef64:
	st_s r0,[r1,0x20]
L_8eef66:
	bl.d L_8d7efc
L_8eef6a:
	mov_s r0,0x1
L_8eef6c:
	b L_8c0334
