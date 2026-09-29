/* ka_necessity_detector__task @ 0x8e3c74, 608 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ka_necessity_detector::task(): Task scheduled while detector is disabled. Task will be stopped
 *   ka_detector: NoTxTime Reset
 *   ka_detector: NoTxTime Up
 *   ka_necessity_detector::task(): Neccesity for Keep Alive detected for cid=%d. Initiating CMD_KEEP_ALIVE_TRIGGER to uCode
 *   ka_detector: KA Trigger
 *   ka_detector: PeriodicPrint
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, detector__deadline_is_unset, frag_8c5db8, fw_log__emit0, fw_log__emit1, ka_detector__get_state, ka_detector__log_state, ka_detector__rearm, lmac_if_keep_alive_trigger_handler, mac_read_tsf64, macq__is_queue_busy
 * Глобалы (через gp): 0x8003a4
 */
	.section .text.ka_necessity_detector__task,"ax",@progbits
	.global ka_necessity_detector__task
ka_necessity_detector__task:
L_8e3c74:
	push_s blink
L_8e3c76:
	bl L_8c02a8
L_8e3c7a:
	sub_s sp,sp,0x28
L_8e3c7c:
	bl.d L_8d714c
L_8e3c80:
	mov_s r14,r0
L_8e3c82:
	mov r17,0x0
L_8e3c86:
	brne_s r0,0,L_8e3ca0
L_8e3c88:
	mov_s r2,0x10115a4
L_8e3c8e:
	mov_s r0,0xb
L_8e3c90:
	bl.d L_8edfb0
L_8e3c94:
	mov_s r1,r17
L_8e3c96:
	bl.d L_8e2f8c
L_8e3c9a:
	mov_s r0,r14
L_8e3c9c:
	b L_8e3ed0
	.global L_8e3ca0
L_8e3ca0:
	add r18,sp,0x10
L_8e3ca4:
	mov_s r0,r17
L_8e3ca6:
	mov_s r1,r18
L_8e3ca8:
	bl.d L_8e4840
L_8e3cac:
	mov_s r2,r17
L_8e3cae:
	bl.d L_8d71f4
L_8e3cb2:
	mov_s r0,r14
L_8e3cb4:
	cmp_s r0,0x0
L_8e3cb6:
	mov.ne r0,r18
L_8e3cba:
	bne_s L_8e3cc6
L_8e3cbc:
	ld_s r1,[r14,0x1c]
L_8e3cbe:
	ld_s r0,[r14,0x20]
L_8e3cc0:
	st_s r1,[sp,0x20]
L_8e3cc2:
	st_s r0,[sp,0x24]
L_8e3cc4:
	add_s r0,sp,0x20
	.global L_8e3cc6
L_8e3cc6:
	ld_s r1,[r0]
L_8e3cc8:
	ld_s r3,[r0,0x4]
L_8e3cca:
	ld_s r2,[sp,0x14]
L_8e3ccc:
	ld_s r0,[sp,0x10]
L_8e3cce:
	cmp_s r3,r2
L_8e3cd0:
	cmp.eq r1,r0
L_8e3cd4:
	add r13,r14,0x20
L_8e3cd8:
	bhi_s L_8e3ce0
L_8e3cda:
	sub r19,r0,r1
L_8e3cde:
	b_s L_8e3cec
	.global L_8e3ce0
L_8e3ce0:
	ld_s r0,[r14,0x34]
L_8e3ce2:
	ldb_s r1,[r13,0x10]
L_8e3ce4:
	add r0,r0,0x1a4
L_8e3ce8:
	ld.as r19,[r0,r1]
	.global L_8e3cec
L_8e3cec:
	ld_s r1,[r14,0x34]
L_8e3cee:
	ldb_s r0,[r13,0x10]
L_8e3cf0:
	add r1,r1,0x120
L_8e3cf4:
	bl.d L_8cac60
L_8e3cf8:
	ld.as r16,[r1,r0]
L_8e3cfc:
	st_s r0,[sp,0xc]
L_8e3cfe:
	ldb_s r0,[r13,0x10]
L_8e3d00:
	mov r21,0x0
L_8e3d04:
	bset r21,r21,r0
L_8e3d08:
	ld_s r0,[r14,0x34]
L_8e3d0a:
	mov_s r15,0x854de0
L_8e3d10:
	ld.as r20,[r0,0x58]
L_8e3d14:
	mov_s r0,r14
L_8e3d16:
	ldb r1,[r15, 0x2a]
L_8e3d1a:
	ldb r2,[r15, 0x20]
L_8e3d1e:
	bl.d L_8c5db8
L_8e3d22:
	ld_s r3,[r15,0x24]
L_8e3d24:
	ld_s r2,[r14,0x34]
L_8e3d26:
	ldb_s r1,[r13,0x10]
L_8e3d28:
	add r2,r2,0x1a4
L_8e3d2c:
	add2_s r2,r2,r1
L_8e3d2e:
	st_s r0,[r2]
L_8e3d30:
	ld_s r0,[r14,0x34]
L_8e3d32:
	ldb_s r1,[r13,0x10]
L_8e3d34:
	add r0,r0,0x184
L_8e3d38:
	ld.as r1,[r0,r1]
L_8e3d3c:
	ld_s r0,[sp,0xc]
L_8e3d3e:
	brne_s r0,0,L_8e3d46
L_8e3d40:
	ld_s r0,[r14,0x38]
L_8e3d42:
	breq r0,r16,L_8e3d98
	.global L_8e3d46
L_8e3d46:
	breq_s r1,0,L_8e3d88
L_8e3d48:
	mov_s r2,0x1011604
L_8e3d4e:
	mov_s r0,0xb
L_8e3d50:
	bl.d L_8edfb0
L_8e3d54:
	mov_s r1,0x2
L_8e3d56:
	ld_s r2,[r14,0x34]
L_8e3d58:
	ldb_s r0,[r13,0x10]
L_8e3d5a:
	add r2,r2,0x180
L_8e3d5e:
	add2_s r2,r2,r0
L_8e3d60:
	ld_s r0,[r2,0x44]
L_8e3d62:
	ld r7,[r2, 0x24]
L_8e3d66:
	st_s r0,[sp,0x0]
L_8e3d68:
	ld_s r0,[r15,0x24]
L_8e3d6a:
	ld r4,[r14, 0x38]
L_8e3d6e:
	st_s r0,[sp,0x4]
L_8e3d70:
	st r19,[sp, 0x8]
L_8e3d74:
	ld_s r2,[r2,0x4]
L_8e3d76:
	mov_s r0,r14
L_8e3d78:
	ld r5,[sp, 0xc]
L_8e3d7c:
	mov_s r1,r18
L_8e3d7e:
	mov_s r3,r16
L_8e3d80:
	bl.d L_8dcef8
L_8e3d84:
	and r6,r20,r21
	.global L_8e3d88
L_8e3d88:
	ld_s r0,[r14,0x34]
L_8e3d8a:
	ldb_s r1,[r13,0x10]
L_8e3d8c:
	add r0,r0,0x184
L_8e3d90:
	add2_s r0,r0,r1
L_8e3d92:
	st r17,[r0]
L_8e3d96:
	b_s L_8e3dea
	.global L_8e3d98
L_8e3d98:
	brne_s r1,0,L_8e3dda
L_8e3d9a:
	mov_s r2,0x1011620
L_8e3da0:
	mov_s r0,0xb
L_8e3da2:
	bl.d L_8edfb0
L_8e3da6:
	mov_s r1,0x2
L_8e3da8:
	ld_s r2,[r14,0x34]
L_8e3daa:
	ldb_s r0,[r13,0x10]
L_8e3dac:
	add r2,r2,0x180
L_8e3db0:
	add2_s r2,r2,r0
L_8e3db2:
	ld_s r0,[r2,0x44]
L_8e3db4:
	ld r7,[r2, 0x24]
L_8e3db8:
	st_s r0,[sp,0x0]
L_8e3dba:
	ld_s r0,[r15,0x24]
L_8e3dbc:
	ld r4,[r14, 0x38]
L_8e3dc0:
	st_s r0,[sp,0x4]
L_8e3dc2:
	st r19,[sp, 0x8]
L_8e3dc6:
	ld_s r2,[r2,0x4]
L_8e3dc8:
	mov_s r0,r14
L_8e3dca:
	ld r5,[sp, 0xc]
L_8e3dce:
	mov_s r1,r18
L_8e3dd0:
	mov_s r3,r16
L_8e3dd2:
	bl.d L_8dcef8
L_8e3dd6:
	and r6,r20,r21
	.global L_8e3dda
L_8e3dda:
	ld_s r0,[r14,0x34]
L_8e3ddc:
	ldb_s r1,[r13,0x10]
L_8e3dde:
	add r0,r0,0x180
L_8e3de2:
	add2_s r0,r0,r1
L_8e3de4:
	ld_s r1,[r0,0x4]
L_8e3de6:
	add_s r1,r1,r19
L_8e3de8:
	st_s r1,[r0,0x4]
	.global L_8e3dea
L_8e3dea:
	st r16,[r14, 0x38]
L_8e3dee:
	ld_s r0,[r14,0x34]
L_8e3df0:
	ldb_s r3,[r13,0x10]
L_8e3df2:
	add r0,r0,0x180
L_8e3df6:
	add2_s r0,r0,r3
L_8e3df8:
	ld_s r1,[r0,0x4]
L_8e3dfa:
	ld_s r0,[r0,0x24]
L_8e3dfc:
	brhs r0,r1,L_8e3e72
L_8e3e00:
	mov_s r2,0x101163c
L_8e3e06:
	mov_s r0,0xb
L_8e3e08:
	bl.d L_8edfcc
L_8e3e0c:
	mov_s r1,0x2
L_8e3e0e:
	mov_s r2,0x10116b4
L_8e3e14:
	mov_s r0,0xb
L_8e3e16:
	bl.d L_8edfb0
L_8e3e1a:
	mov_s r1,0x2
L_8e3e1c:
	ld_s r2,[r14,0x34]
L_8e3e1e:
	ldb_s r0,[r13,0x10]
L_8e3e20:
	add r2,r2,0x180
L_8e3e24:
	add2_s r2,r2,r0
L_8e3e26:
	ld_s r0,[r2,0x44]
L_8e3e28:
	ld r7,[r2, 0x24]
L_8e3e2c:
	st_s r0,[sp,0x0]
L_8e3e2e:
	ld_s r0,[r15,0x24]
L_8e3e30:
	ld r4,[r14, 0x38]
L_8e3e34:
	st_s r0,[sp,0x4]
L_8e3e36:
	st r19,[sp, 0x8]
L_8e3e3a:
	ld_s r2,[r2,0x4]
L_8e3e3c:
	mov_s r0,r14
L_8e3e3e:
	ld r5,[sp, 0xc]
L_8e3e42:
	mov_s r1,r18
L_8e3e44:
	mov_s r3,r16
L_8e3e46:
	bl.d L_8dcef8
L_8e3e4a:
	and r6,r20,r21
L_8e3e4e:
	bl.d L_8d85e4
L_8e3e52:
	ldb_s r0,[r13,0x10]
L_8e3e54:
	ld_s r1,[r14,0x34]
L_8e3e56:
	ldb_s r0,[r13,0x10]
L_8e3e58:
	add r1,r1,0x180
L_8e3e5c:
	add2_s r1,r1,r0
L_8e3e5e:
	ld_s r0,[r1,0x44]
L_8e3e60:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e3e62:
	st_s r0,[r1,0x44]
L_8e3e64:
	ld_s r0,[r14,0x34]
L_8e3e66:
	ldb_s r1,[r13,0x10]
L_8e3e68:
	add r0,r0,0x184
L_8e3e6c:
	add2_s r0,r0,r1
L_8e3e6e:
	st r17,[r0]
	.global L_8e3e72
L_8e3e72:
	ld_s r3,[r14,0x3c]
L_8e3e74:
	ld_s r2,[sp,0x10]
L_8e3e76:
	sub.f r2,r2,r3
L_8e3e7a:
	ld_s r0,[r14,0x40]
L_8e3e7c:
	mov_s r3,0x0
L_8e3e7e:
	ld_s r1,[sp,0x14]
L_8e3e80:
	sbc r1,r1,r0
L_8e3e84:
	ld_s r0,[gp,0x234]
L_8e3e86:
	cmp_s r1,r3
L_8e3e88:
	cmp.eq r2,r0
L_8e3e8c:
	bls L_8e3ed0
L_8e3e90:
	mov_s r2,0x10116cc
L_8e3e96:
	mov_s r0,0xb
L_8e3e98:
	bl.d L_8edfb0
L_8e3e9c:
	mov_s r1,0x2
L_8e3e9e:
	ld_s r2,[r14,0x34]
L_8e3ea0:
	ldb_s r0,[r13,0x10]
L_8e3ea2:
	add r2,r2,0x180
L_8e3ea6:
	add2_s r2,r2,r0
L_8e3ea8:
	ld_s r0,[r2,0x44]
L_8e3eaa:
	ld r7,[r2, 0x24]
L_8e3eae:
	st_s r0,[sp,0x0]
L_8e3eb0:
	ld_s r0,[r15,0x24]
L_8e3eb2:
	ld r4,[r14, 0x38]
L_8e3eb6:
	st_s r0,[sp,0x4]
L_8e3eb8:
	st r19,[sp, 0x8]
L_8e3ebc:
	ld_s r2,[r2,0x4]
L_8e3ebe:
	mov_s r0,r14
L_8e3ec0:
	ld r5,[sp, 0xc]
L_8e3ec4:
	mov_s r1,r18
L_8e3ec6:
	mov_s r3,r16
L_8e3ec8:
	bl.d L_8dcef8
L_8e3ecc:
	and r6,r20,r21
	.global L_8e3ed0
L_8e3ed0:
	b.d L_8c02fc
