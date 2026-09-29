/* ka_necessity_detector__task @ 0x8e8bfc, 488 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ka_necessity_detector::task(): Task scheduled while detector is disabled. Task will be stopped
 *   ka_necessity_detector::task(): Neccesity for Keep Alive detected for cid=%d. Initiating CMD_KEEP_ALIVE_TRIGGER to uCode
 *   ka_detector:: flush_no_ack_vec 0x%x | cid %d | slot_missed_counter_vec 0x%x
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, detector__deadline_is_unset, fw_log_emit0, fw_log_emit1, fw_log_emit3, ka__period_for_snr, ka_detector__is_enabled, ka_detector__log_state, lm_if__stop_link_a, mac_read_tsf64, ps__sta_has_pending_data
 * Глобалы (через gp): 0x8003c4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ka_necessity_detector__task
ka_necessity_detector__task:
	.global L_8e8bfc
L_8e8bfc:
	push_s blink
L_8e8bfe:
	bl L_8c01c0
L_8e8c02:
	sub_s sp,sp,0x28
L_8e8c04:
	bl.d L_8da214
L_8e8c08:
	mov_s r13,r0
L_8e8c0a:
	brne_s r0,0,L_8e8c20
L_8e8c0c:
	mov_s r1,0x1014be8
L_8e8c12:
	bl.d L_8dcba8
L_8e8c16:
	mov_s r0,0xb
L_8e8c18:
	bl.d L_8e806c
L_8e8c1c:
	mov_s r0,r13
L_8e8c1e:
	b_s L_8e8dde
	.global L_8e8c20
L_8e8c20:
	add r16,sp,0x10
L_8e8c24:
	mov r20,0x0
L_8e8c28:
	mov_s r0,r20
L_8e8c2a:
	mov_s r1,r16
L_8e8c2c:
	bl.d L_8e9900
L_8e8c30:
	mov_s r2,r20
L_8e8c32:
	bl.d L_8da2ac
L_8e8c36:
	mov_s r0,r13
L_8e8c38:
	cmp_s r0,0x0
L_8e8c3a:
	mov.ne r0,r16
L_8e8c3e:
	bne_s L_8e8c4a
L_8e8c40:
	ld_s r1,[r13,0x1c]
L_8e8c42:
	ld_s r0,[r13,0x20]
L_8e8c44:
	st_s r1,[sp,0x20]
L_8e8c46:
	st_s r0,[sp,0x24]
L_8e8c48:
	add_s r0,sp,0x20
	.global L_8e8c4a
L_8e8c4a:
	ld_s r1,[r0]
L_8e8c4c:
	ld_s r3,[r0,0x4]
L_8e8c4e:
	ld_s r2,[sp,0x14]
L_8e8c50:
	ld_s r0,[sp,0x10]
L_8e8c52:
	cmp_s r3,r2
L_8e8c54:
	cmp.eq r1,r0
L_8e8c58:
	add r14,r13,0x20
L_8e8c5c:
	bhi_s L_8e8c64
L_8e8c5e:
	sub r18,r0,r1
L_8e8c62:
	b_s L_8e8c70
	.global L_8e8c64
L_8e8c64:
	ld_s r0,[r13,0x34]
L_8e8c66:
	ldb_s r1,[r14,0x10]
L_8e8c68:
	add r0,r0,0x1a4
L_8e8c6c:
	ld.as r18,[r0,r1]
	.global L_8e8c70
L_8e8c70:
	ld_s r1,[r13,0x34]
L_8e8c72:
	ldb_s r0,[r14,0x10]
L_8e8c74:
	add r1,r1,0x120
L_8e8c78:
	bl.d L_8ccf0c
L_8e8c7c:
	ld.as r17,[r1,r0]
L_8e8c80:
	st_s r0,[sp,0xc]
L_8e8c82:
	ldb_s r0,[r14,0x10]
L_8e8c84:
	mov r23,0x0
L_8e8c88:
	bset r23,r23,r0
L_8e8c8c:
	ld_s r0,[r13,0x34]
L_8e8c8e:
	mov r19,0x853940
L_8e8c96:
	ld.as r22,[r0,0x58]
L_8e8c9a:
	mov_s r0,r13
L_8e8c9c:
	ldb r1,[r19, 0x2a]
L_8e8ca0:
	ldb r2,[r19, 0x20]
L_8e8ca4:
	bl.d L_8c6b4c
L_8e8ca8:
	ld r3,[r19, 0x24]
L_8e8cac:
	ld_s r1,[r13,0x34]
L_8e8cae:
	ldb_s r2,[r14,0x10]
L_8e8cb0:
	add r1,r1,0x1a4
L_8e8cb4:
	add2_s r1,r1,r2
L_8e8cb6:
	st_s r0,[r1]
L_8e8cb8:
	ld_s r0,[r13,0x34]
L_8e8cba:
	ldb_s r1,[r14,0x10]
L_8e8cbc:
	add r0,r0,0x180
L_8e8cc0:
	ld_s r2,[sp,0xc]
L_8e8cc2:
	add2_s r0,r0,r1
L_8e8cc4:
	ld_s r1,[r0,0x4]
L_8e8cc6:
	brne_s r2,0,L_8e8cce
L_8e8cc8:
	ld_s r2,[r13,0x38]
L_8e8cca:
	breq r2,r17,L_8e8cd4
	.global L_8e8cce
L_8e8cce:
	st r20,[r0, 0x4]
L_8e8cd2:
	b_s L_8e8cd8
	.global L_8e8cd4
L_8e8cd4:
	add_s r1,r1,r18
L_8e8cd6:
	st_s r1,[r0,0x4]
	.global L_8e8cd8
L_8e8cd8:
	st r17,[r13, 0x38]
L_8e8cdc:
	ld_s r0,[r13,0x34]
L_8e8cde:
	ldb_s r2,[r14,0x10]
L_8e8ce0:
	add r0,r0,0x180
L_8e8ce4:
	add2_s r0,r0,r2
L_8e8ce6:
	ld_s r1,[r0,0x4]
L_8e8ce8:
	ld_s r0,[r0,0x24]
L_8e8cea:
	mov r21,0x847adc
L_8e8cf2:
	brhs r0,r1,L_8e8cfe
L_8e8cf6:
	mov_s r15,0x857200
L_8e8cfc:
	b_s L_8e8d12
	.global L_8e8cfe
L_8e8cfe:
	ldb r0,[r21, 0x5]
L_8e8d02:
	breq r0,0x0,L_8e8d9e
L_8e8d06:
	mov_s r15,0x857200
L_8e8d0c:
	ld_s r0,[r15,0x4c]
L_8e8d0e:
	bbit0 r0,r2,L_8e8d9e
	.global L_8e8d12
L_8e8d12:
	mov_s r1,0x1014c48
L_8e8d18:
	bl.d L_8dcc10
L_8e8d1c:
	mov_s r0,0x2b
L_8e8d1e:
	ld_s r2,[r13,0x34]
L_8e8d20:
	ldb_s r0,[r14,0x10]
L_8e8d22:
	add r2,r2,0x180
L_8e8d26:
	add2_s r2,r2,r0
L_8e8d28:
	ld_s r0,[r2,0x44]
L_8e8d2a:
	ld r7,[r2, 0x24]
L_8e8d2e:
	st_s r0,[sp,0x0]
L_8e8d30:
	ld r0,[r19, 0x24]
L_8e8d34:
	ld r4,[r13, 0x38]
L_8e8d38:
	st_s r0,[sp,0x4]
L_8e8d3a:
	st r18,[sp, 0x8]
L_8e8d3e:
	ld_s r2,[r2,0x4]
L_8e8d40:
	mov_s r0,r13
L_8e8d42:
	ld r5,[sp, 0xc]
L_8e8d46:
	mov_s r1,r16
L_8e8d48:
	mov_s r3,r17
L_8e8d4a:
	bl.d L_8e10a4
L_8e8d4e:
	and r6,r22,r23
L_8e8d52:
	ldb r0,[r21, 0x5]
L_8e8d56:
	ldb_s r3,[r14,0x10]
L_8e8d58:
	breq_s r0,0,L_8e8d6c
L_8e8d5a:
	mov_s r1,0x1014cc0
L_8e8d60:
	ld r4,[r15, 0x4c]
L_8e8d64:
	mov_s r0,0x2b
L_8e8d66:
	bl.d L_8dcd00
L_8e8d6a:
	ld_s r2,[r15,0x48]
	.global L_8e8d6c
L_8e8d6c:
	ld_s r0,[r13,0x34]
L_8e8d6e:
	ldb_s r1,[r14,0x10]
L_8e8d70:
	add r0,r0,0x180
L_8e8d74:
	add2_s r0,r0,r1
L_8e8d76:
	ld_s r1,[r0,0x44]
L_8e8d78:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e8d7a:
	st_s r1,[r0,0x44]
L_8e8d7c:
	ld_s r0,[r13,0x34]
L_8e8d7e:
	ldb_s r1,[r14,0x10]
L_8e8d80:
	add r0,r0,0x184
L_8e8d84:
	add2_s r0,r0,r1
L_8e8d86:
	st r20,[r0]
L_8e8d8a:
	ldb_s r1,[r14,0x10]
L_8e8d8c:
	ld_s r0,[r15,0x48]
L_8e8d8e:
	bclr r0,r0,r1
L_8e8d92:
	st_s r0,[r15,0x48]
L_8e8d94:
	ldb_s r1,[r14,0x10]
L_8e8d96:
	ld_s r0,[r15,0x4c]
L_8e8d98:
	bclr r0,r0,r1
L_8e8d9c:
	st_s r0,[r15,0x4c]
	.global L_8e8d9e
L_8e8d9e:
	ld_s r0,[r13,0x3c]
L_8e8da0:
	ld_s r1,[sp,0x10]
L_8e8da2:
	sub_s r1,r1,r0
L_8e8da4:
	ld_s r0,[gp,0x240]
L_8e8da6:
	brhs r0,r1,L_8e8dde
L_8e8daa:
	ld_s r2,[r13,0x34]
L_8e8dac:
	ldb_s r0,[r14,0x10]
L_8e8dae:
	add r2,r2,0x180
L_8e8db2:
	add2_s r2,r2,r0
L_8e8db4:
	ld_s r0,[r2,0x44]
L_8e8db6:
	ld r7,[r2, 0x24]
L_8e8dba:
	st_s r0,[sp,0x0]
L_8e8dbc:
	ld r0,[r19, 0x24]
L_8e8dc0:
	ld r4,[r13, 0x38]
L_8e8dc4:
	st_s r0,[sp,0x4]
L_8e8dc6:
	st r18,[sp, 0x8]
L_8e8dca:
	ld_s r2,[r2,0x4]
L_8e8dcc:
	mov_s r0,r13
L_8e8dce:
	ld r5,[sp, 0xc]
L_8e8dd2:
	mov_s r1,r16
L_8e8dd4:
	mov_s r3,r17
L_8e8dd6:
	bl.d L_8e10a4
L_8e8dda:
	and r6,r22,r23
	.global L_8e8dde
L_8e8dde:
	b.d L_8c020c
L_8e8de2:
	add_s sp,sp,0x28
