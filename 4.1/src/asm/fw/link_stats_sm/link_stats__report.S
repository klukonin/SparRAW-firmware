/* link_stats__report @ 0x8e2ae8, 624 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LINK_STATS TX_GOODPUT=%d RX_GOODPUT=%d PER=%d
 *   LINK_STATS MCS0_FRAMES_CRC_OK=%d MCS0_FRAMES_CRC_ERR=%d
 *   LINK_STATS PPDU_REP_CNT=%d CCA2_TO_CCA3=%d HANDLED_PPDUS=%d
 *   LINK_STATS FA_IN_TXOP_AD=%d FA_IN_TXOP_CD=%d FA_IN_TXOP_DD=%d
 *   LINK_STATS FA_OUT_TXOP_AD=%d FA_OUT_TXOP_CD=%d FA_OUT_TXOP_DD=%d
 *       ### LINK STATS:Neighbor Beacon ### beacon_neighbor =%5d   beacon_neighbor_aw=%5d
 *       ### LINK STATS:NAV ### beacon_nav=%5d
 *       ### LINK STATS:Keep Alive### KA_cnt     =%5d    KA_fail_cnt=%5d
 * Зовут его: link_stats_sm__on_pause, link_stats_sm__on_resume
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, arith64_op, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_read_timer, fw_sysassert_fatal, get_p8003b0_10, get_p8003b0_48, led__update_by_link_rate, link_stats__calc_goodput
 * Глобалы (через gp): 0x800318
 */
	.section .text.link_stats__report,"ax",@progbits
	.global link_stats__report
link_stats__report:
	.global L_8e2ae8
L_8e2ae8:
	push_s blink
L_8e2aea:
	bl L_8c02a4
L_8e2aee:
	sub_s sp,sp,0x20
L_8e2af0:
	mov_s r13,r0
L_8e2af2:
	mov_s r22,r1
L_8e2af4:
	bl.d L_8c9d7c
L_8e2af8:
	ld_s r0,[r0,0x34]
L_8e2afa:
	bl.d L_8e4694
L_8e2afe:
	extb r21,r0
L_8e2b02:
	mov_s r15,r0
L_8e2b04:
	bl.d L_8cacbc
L_8e2b08:
	mov_s r0,r13
L_8e2b0a:
	mov_s r19,r0
L_8e2b0c:
	mov_s r17,r1
L_8e2b0e:
	bl.d L_8ca824
L_8e2b12:
	mov_s r0,r13
L_8e2b14:
	mov_s r18,r0
L_8e2b16:
	mov_s r16,r1
L_8e2b18:
	bl.d L_8dc190
L_8e2b1c:
	mov_s r0,0x0
L_8e2b1e:
	ld_s r1,[r13,0x5c]
L_8e2b20:
	ld_s r2,[r13,0x3c]
L_8e2b22:
	sub r0,r15,r1
L_8e2b26:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8e2b28:
	ld_s r1,[r13,0x38]
L_8e2b2a:
	st_s r0,[sp,0x0]
L_8e2b2c:
	sub.f r0,r19,r1
L_8e2b30:
	sbc r1,r17,r2
L_8e2b34:
	bl.d L_8c053c
L_8e2b38:
	mov_s r2,0x3
L_8e2b3a:
	ld_s r2,[sp,0x0]
L_8e2b3c:
	bl.d L_8c0568
L_8e2b40:
	mov_s r3,0x0
L_8e2b42:
	st_s r0,[r13,0x40]
L_8e2b44:
	mov r20,0x880a3c
L_8e2b4c:
	st r0,[r20, 0x1c]
L_8e2b50:
	ld_s r14,[r13,0x44]
L_8e2b52:
	ld_s r0,[r13,0x48]
L_8e2b54:
	sub.f r4,r18,r14
L_8e2b58:
	sbc r1,r16,r0
L_8e2b5c:
	mov_s r0,r4
L_8e2b5e:
	bl.d L_8c053c
L_8e2b62:
	mov_s r2,0x3
L_8e2b64:
	ld_s r2,[sp,0x0]
L_8e2b66:
	bl.d L_8c0568
L_8e2b6a:
	mov_s r3,0x0
L_8e2b6c:
	st_s r0,[r13,0x4c]
L_8e2b6e:
	st r0,[r20, 0x20]
L_8e2b72:
	add_s r3,sp,0x4
L_8e2b74:
	add_s r2,sp,0x8
L_8e2b76:
	mov_s r0,r13
L_8e2b78:
	bl.d L_8c48ec
L_8e2b7c:
	mov_s r1,r3
L_8e2b7e:
	mov_s r14,0x854d80
L_8e2b84:
	ld_s r0,[r14,0x4]
L_8e2b86:
	st_s r0,[r13,0x58]
L_8e2b88:
	ld_s r0,[sp,0x4]
L_8e2b8a:
	st r0,[r20, 0x30]
L_8e2b8e:
	st_s r15,[r13,0x5c]
L_8e2b90:
	st r19,[r13, 0x38]
L_8e2b94:
	st r18,[r13, 0x44]
L_8e2b98:
	st r16,[r13, 0x48]
L_8e2b9c:
	ld_s r0,[gp,-0x70]
L_8e2b9e:
	ld_s r1,[r13,0x40]
L_8e2ba0:
	st r17,[r13, 0x3c]
L_8e2ba4:
	cmp_s r0,r1
L_8e2ba6:
	mov.ls r0,r1
L_8e2baa:
	st.as r0,[gp,-0x1c]
L_8e2bae:
	ld_s r0,[r13,0x4c]
L_8e2bb0:
	bl.d L_8d77e4
L_8e2bb4:
	add_s r0,r0,r1
L_8e2bb6:
	cmp r21,0x8
L_8e2bba:
	bge L_8e2d40
	.global L_8e2bbe
L_8e2bbe:
	ld_s r1,[sp,0x4]
L_8e2bc0:
	asl r0,r21,0x4
L_8e2bc4:
	add3_s r0,r0,r0
L_8e2bc6:
	add_s r0,r0,0x854900
L_8e2bcc:
	stb_s r1,[r0,0x6]
L_8e2bce:
	ld_s r1,[r13,0x4c]
L_8e2bd0:
	add3 r17,r13,0xc
L_8e2bd4:
	stw_s r1,[r0,0xe]
L_8e2bd6:
	ld_s r1,[r13,0x40]
L_8e2bd8:
	stw_s r1,[r0,0xc]
L_8e2bda:
	ldb r0,[r17]
L_8e2bde:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e2be0:
	extb_s r0,r0
L_8e2be2:
	stb r0,[r17]
L_8e2be6:
	ld_s r0,[gp,0x1a8]
L_8e2be8:
	mov r16,0x0
L_8e2bec:
	breq_s r0,0,L_8e2c42
L_8e2bee:
	bl.d L_8ca1b0
L_8e2bf2:
	mov_s r0,r16
L_8e2bf4:
	mov lp_count,0x3
L_8e2bf8:
	mov_s r2,r16
L_8e2bfa:
	mov_s r1,r16
L_8e2bfc:
	lp L_8e2c36
L_8e2c00:
	add r0,gp,r2
L_8e2c04:
	ldb r3,[r0, 0xfc]
L_8e2c08:
	add_s r0,r2,r2
L_8e2c0a:
	add1_s r0,r0,r0
L_8e2c0c:
	add_s r0,r0,sp
L_8e2c0e:
	stb_s r3,[r0,0xd]
L_8e2c10:
	add r3,gp,r2
L_8e2c14:
	ldb r3,[r3, 0xf8]
L_8e2c18:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e2c1a:
	stb_s r3,[r0,0xe]
L_8e2c1c:
	mov_s r3,0x1
L_8e2c1e:
	stb_s r3,[r0,0xf]
L_8e2c20:
	mov_s r3,0x8004bc
L_8e2c26:
	add1_s r3,r3,r2
L_8e2c28:
	ldw_s r15,[r3,0x8]
L_8e2c2a:
	extb_s r1,r1
L_8e2c2c:
	stb_s r15,[r0,0x11]
L_8e2c2e:
	lsr_s r15,r15,0x8
L_8e2c30:
	stb_s r15,[r0,0x12]
L_8e2c32:
	stb_s r1,[sp,0xc]
L_8e2c34:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_8e2c36
L_8e2c36:
	add_s r0,sp,0xc
L_8e2c38:
	bl.d L_8f2c6c
L_8e2c3c:
	mov_s r1,0x0
L_8e2c3e:
	st.as r16,[gp,0x6a]
	.global L_8e2c42
L_8e2c42:
	ldb r0,[r17]
L_8e2c46:
	mov_s r15,0x857000
L_8e2c4c:
	brne r0,0xa,L_8e2ce6
L_8e2c50:
	ld r4,[r20, 0x20]
L_8e2c54:
	mov_s r2,0x1011b2c
L_8e2c5a:
	ld r5,[sp, 0x4]
L_8e2c5e:
	mov_s r0,0x0
L_8e2c60:
	mov_s r1,0x2
L_8e2c62:
	bl.d L_8ee034
L_8e2c66:
	ld r3,[r20, 0x1c]
L_8e2c6a:
	bl L_8d9af4
L_8e2c6e:
	bl.d L_8d9aec
L_8e2c72:
	mov_s r18,r0
L_8e2c74:
	mov_s r4,r0
L_8e2c76:
	mov_s r2,0x1011b5c
L_8e2c7c:
	mov_s r0,0x0
L_8e2c7e:
	mov_s r1,0x2
L_8e2c80:
	bl.d L_8edff8
L_8e2c84:
	mov_s r3,r18
L_8e2c86:
	mov_s r0,0x886e80
L_8e2c8c:
	ld_s r3,[r0,0x4c]
L_8e2c8e:
	mov_s r2,0x1011b94
L_8e2c94:
	ld_s r0,[r0,0x4c]
L_8e2c96:
	lsr_s r3,r3,0x8
L_8e2c98:
	lsr r4,r0,0x10
L_8e2c9c:
	ld r5,[r15, 0x48]
L_8e2ca0:
	mov_s r0,0x0
L_8e2ca2:
	mov_s r1,0x2
L_8e2ca4:
	bmsk_s r3,r3,0x5
L_8e2ca6:
	bl.d L_8ee034
L_8e2caa:
	bmsk r4,r4,0x5
L_8e2cae:
	ld r4,[r14, 0x8]
L_8e2cb2:
	mov_s r2,0x1011bd0
L_8e2cb8:
	ld r5,[r14, 0xc]
L_8e2cbc:
	mov_s r0,0x0
L_8e2cbe:
	mov_s r1,0x2
L_8e2cc0:
	bl.d L_8ee034
L_8e2cc4:
	ld_s r3,[r14,0x10]
L_8e2cc6:
	mov_s r2,0x1011c10
L_8e2ccc:
	ld r4,[r14, 0x14]
L_8e2cd0:
	mov_s r0,0x0
L_8e2cd2:
	ld r5,[r14, 0x18]
L_8e2cd6:
	mov_s r1,0x2
L_8e2cd8:
	bl.d L_8ee034
L_8e2cdc:
	ld_s r3,[r14,0x1c]
L_8e2cde:
	bl L_8cfb40
L_8e2ce2:
	stb r16,[r17]
	.global L_8e2ce6
L_8e2ce6:
	mov_s r2,0x1011c54
L_8e2cec:
	ld r4,[r15, 0x18]
L_8e2cf0:
	mov_s r0,0x0
L_8e2cf2:
	mov_s r1,0x2
L_8e2cf4:
	bl.d L_8edff8
L_8e2cf8:
	ld_s r3,[r15,0x14]
L_8e2cfa:
	mov_s r2,0x1011cac
L_8e2d00:
	mov_s r0,0x0
L_8e2d02:
	mov_s r1,0x2
L_8e2d04:
	bl.d L_8edfcc
L_8e2d08:
	ld_s r3,[r15,0x44]
L_8e2d0a:
	mov_s r2,0x1011cd8
L_8e2d10:
	ld r4,[r15, 0x10]
L_8e2d14:
	mov_s r0,0x0
L_8e2d16:
	mov_s r1,0x2
L_8e2d18:
	bl.d L_8edff8
L_8e2d1c:
	ld_s r3,[r15]
L_8e2d1e:
	mov_s r2,0x1011d1c
L_8e2d24:
	mov_s r0,0x0
L_8e2d26:
	mov_s r1,0x2
L_8e2d28:
	bl.d L_8edfcc
L_8e2d2c:
	ld_s r3,[r15,0x40]
L_8e2d2e:
	cmp r22,0x0
L_8e2d32:
	bl.eq.d L_8dfc54
L_8e2d36:
	mov.eq r0,r13
L_8e2d3a:
	b.d L_8c02f4
L_8e2d3e:
	add_s sp,sp,0x20
	.global L_8e2d40
L_8e2d40:
	mov_s r0,blink
L_8e2d42:
	mov_s r2,0x1011b18
L_8e2d48:
	mov_s r1,0x1256
L_8e2d4e:
	bl.d L_8c82c0
L_8e2d52:
	mov r3,0x14b
L_8e2d56:
	b_s L_8e2bbe
