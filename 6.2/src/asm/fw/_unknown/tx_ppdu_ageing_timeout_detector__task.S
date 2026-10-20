/* tx_ppdu_ageing_timeout_detector__task @ 0x8e8de4, 696 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_ppdu_ageing_timeout_detector::task(): Task scheduled while detector is disabled cid=%d. Task will be stopped
 *   tx_ppdu m_cid corrupted: %x %u
 *   tx_ppdu m_cid%u@%x dump mem @%x
 *   %08x: %08x %08x
 *   tx_ageing_detector: Link-Loss detected for cid=%d. Initiating disconnect flow.
 *   tx_ageing_detector: Link-Loss detected for cid=%d. missing ack for ATIM in 10 consecutive beacons.
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, ageing_detector__drop_connection, ageing_detector__log_state, detector__deadline_is_unset, fw_log_emit1, fw_log_emit2, fw_log_emit3, lm_if__stop_link_b, lmac_if__get_evt_byte3, mac_read_tsf64, mid__field_18_step
 * Глобалы (через gp): 0x8003c4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_ppdu_ageing_timeout_detector__task
tx_ppdu_ageing_timeout_detector__task:
	.global L_8e8de4
L_8e8de4:
	push_s blink
L_8e8de6:
	bl L_8c01c4
L_8e8dea:
	sub_s sp,sp,0x30
L_8e8dec:
	bl.d L_8da260
L_8e8df0:
	mov_s r14,r0
L_8e8df2:
	brne_s r0,0,L_8e8e0e
L_8e8df4:
	mov_s r1,0x10148c0
L_8e8dfa:
	mov_s r0,0xb
L_8e8dfc:
	bl.d L_8dcc10
L_8e8e00:
	ldb r2,[r14, 0x30]
L_8e8e04:
	bl.d L_8e8088
L_8e8e08:
	mov_s r0,r14
L_8e8e0a:
	b L_8e9096
	.global L_8e8e0e
L_8e8e0e:
	add r18,sp,0x18
L_8e8e12:
	mov r22,0x0
L_8e8e16:
	mov_s r0,r22
L_8e8e18:
	mov_s r1,r18
L_8e8e1a:
	bl.d L_8e9900
L_8e8e1e:
	mov_s r2,r22
L_8e8e20:
	bl.d L_8da2ac
L_8e8e24:
	mov_s r0,r14
L_8e8e26:
	cmp_s r0,0x0
L_8e8e28:
	mov.ne r0,r18
L_8e8e2c:
	bne_s L_8e8e38
L_8e8e2e:
	ld_s r1,[r14,0x1c]
L_8e8e30:
	ld_s r0,[r14,0x20]
L_8e8e32:
	st_s r1,[sp,0x28]
L_8e8e34:
	st_s r0,[sp,0x2c]
L_8e8e36:
	add_s r0,sp,0x28
	.global L_8e8e38
L_8e8e38:
	ld_s r2,[r0]
L_8e8e3a:
	ld_s r3,[r0,0x4]
L_8e8e3c:
	ld_s r1,[sp,0x1c]
L_8e8e3e:
	ld_s r0,[sp,0x18]
L_8e8e40:
	cmp_s r3,r1
L_8e8e42:
	cmp.eq r2,r0
L_8e8e46:
	mov r20,0x0
L_8e8e4a:
	bhi_s L_8e8e50
L_8e8e4c:
	sub r20,r0,r2
	.global L_8e8e50
L_8e8e50:
	add r13,r14,0x20
L_8e8e54:
	ld_s r0,[r14,0x34]
L_8e8e56:
	ldb_s r1,[r13,0x10]
L_8e8e58:
	add r0,r0,0x120
L_8e8e5c:
	bl.d L_8cd080
L_8e8e60:
	ld.as r19,[r0,r1]
L_8e8e64:
	ld_s r1,[r0]
L_8e8e66:
	ld_s r2,[r1,0x28]
L_8e8e68:
	jl_s.d [r2]
L_8e8e6a:
	ldb_s r1,[r13,0x10]
L_8e8e6c:
	mov_s r15,r0
L_8e8e6e:
	ld_s r0,[r14,0x34]
L_8e8e70:
	ldb_s r3,[r13,0x10]
L_8e8e72:
	add r0,r0,0x140
L_8e8e76:
	brlt.d r3,0x8,L_8e8e8e
L_8e8e7a:
	ld.as r21,[r0,r3]
L_8e8e7e:
	mov_s r1,0x1014930
L_8e8e84:
	add r2,r14,0x30
L_8e8e88:
	bl.d L_8dcc80
L_8e8e8c:
	mov_s r0,0x0
	.global L_8e8e8e
L_8e8e8e:
	ldb_s r2,[r13,0x10]
L_8e8e90:
	brlt r2,0x8,L_8e8ece
L_8e8e94:
	sub3 r17,r14,0xe
L_8e8e98:
	mov_s r1,0x1014950
L_8e8e9e:
	add r3,r14,0x30
L_8e8ea2:
	mov_s r0,0x0
L_8e8ea4:
	bl.d L_8dcd00
L_8e8ea8:
	mov r4,r17
L_8e8eac:
	mov r16,0x28
	.global L_8e8eb0
L_8e8eb0:
	mov_s r1,0x1014970
L_8e8eb6:
	ld r4,[r17, 0x4]
L_8e8eba:
	mov_s r0,0x0
L_8e8ebc:
	mov_s r2,r17
L_8e8ebe:
	bl.d L_8dcd00
L_8e8ec2:
	ld.ab r3,[r17,0x8]
L_8e8ec6:
	sub r16,r16,0x1
L_8e8eca:
	brhs r16,0x1,L_8e8eb0
	.global L_8e8ece
L_8e8ece:
	bl.d L_8cbf18
L_8e8ed2:
	ldb_s r0,[r13,0x10]
L_8e8ed4:
	bl.d L_8cbb80
L_8e8ed8:
	mov_s r17,r0
L_8e8eda:
	mov_s r16,r0
L_8e8edc:
	bl.d L_8ccf0c
L_8e8ee0:
	ldb_s r0,[r13,0x10]
L_8e8ee2:
	mov_s r1,0x0
L_8e8ee4:
	st_s r0,[sp,0xc]
L_8e8ee6:
	ldb_s r0,[r13,0x10]
L_8e8ee8:
	bset r1,r1,r0
L_8e8eec:
	ld_s r0,[r14,0x34]
L_8e8eee:
	ld.as r0,[r0,0x58]
L_8e8ef2:
	and_s r0,r0,r1
L_8e8ef4:
	bl.d L_8cb910
L_8e8ef8:
	st_s r0,[sp,0x10]
L_8e8efa:
	ldb_s r1,[r13,0x10]
L_8e8efc:
	mov_s r2,0x0
L_8e8efe:
	bset r2,r2,r1
L_8e8f02:
	and_s r0,r0,r2
L_8e8f04:
	st_s r0,[sp,0x14]
L_8e8f06:
	ld_s r0,[sp,0xc]
L_8e8f08:
	breq_s r0,0,L_8e8f10
L_8e8f0a:
	ld_s r0,[r14,0x38]
L_8e8f0c:
	breq r0,r19,L_8e8f1e
	.global L_8e8f10
L_8e8f10:
	ld_s r0,[r14,0x34]
L_8e8f12:
	add r0,r0,0x164
L_8e8f16:
	add2_s r0,r0,r1
L_8e8f18:
	st r22,[r0]
L_8e8f1c:
	b_s L_8e8fc4
	.global L_8e8f1e
L_8e8f1e:
	ld_s r0,[r14,0x3c]
L_8e8f20:
	brlo r15,r0,L_8e8f2a
L_8e8f24:
	sub r2,r15,r0
L_8e8f28:
	b_s L_8e8f34
	.global L_8e8f2a
L_8e8f2a:
	rsub r2,r0,0xffffffff
L_8e8f32:
	add_s r2,r2,r15
	.global L_8e8f34
L_8e8f34:
	ld_s r3,[r14,0x40]
L_8e8f36:
	brlo r21,r3,L_8e8f40
L_8e8f3a:
	sub r5,r21,r3
L_8e8f3e:
	b_s L_8e8f4c
	.global L_8e8f40
L_8e8f40:
	rsub r0,r3,0xffffffff
L_8e8f48:
	add r5,r0,r21
	.global L_8e8f4c
L_8e8f4c:
	ld_s r3,[r14,0x44]
L_8e8f4e:
	brlo r17,r3,L_8e8f58
L_8e8f52:
	sub r4,r17,r3
L_8e8f56:
	b_s L_8e8f64
	.global L_8e8f58
L_8e8f58:
	rsub r0,r3,0xffffffff
L_8e8f60:
	add r4,r0,r17
	.global L_8e8f64
L_8e8f64:
	ld_s r3,[r14,0x48]
L_8e8f66:
	brlo r16,r3,L_8e8f70
L_8e8f6a:
	sub r6,r16,r3
L_8e8f6e:
	b_s L_8e8f7c
	.global L_8e8f70
L_8e8f70:
	rsub r0,r3,0xffffffff
L_8e8f78:
	add r6,r0,r16
	.global L_8e8f7c
L_8e8f7c:
	add r0,r4,r5
L_8e8f80:
	add_s r0,r0,r6
L_8e8f82:
	breq_s r2,0,L_8e8f9a
L_8e8f84:
	ld_s r3,[sp,0x14]
L_8e8f86:
	brne_s r3,0,L_8e8f9a
L_8e8f88:
	sub r3,r2,r0
L_8e8f8c:
	cmp_s r2,r0
L_8e8f8e:
	mov.hi r2,r3
L_8e8f92:
	mov.ls r2,0x0
L_8e8f96:
	ld_s r0,[r14,0x34]
L_8e8f98:
	b_s L_8e8fb8
	.global L_8e8f9a
L_8e8f9a:
	ld_s r3,[sp,0x14]
L_8e8f9c:
	ld_s r0,[r14,0x34]
L_8e8f9e:
	add_s r2,r0,0x4
L_8e8fa0:
	brne_s r3,0,L_8e8fac
L_8e8fa2:
	ld_s r3,[sp,0x10]
L_8e8fa4:
	cmp_s r3,0x0
L_8e8fa6:
	mov.eq r2,0x0
L_8e8faa:
	beq_s L_8e8fb8
	.global L_8e8fac
L_8e8fac:
	asl_s r3,r1,0x2
L_8e8fae:
	add3_s r3,r3,r3
L_8e8fb0:
	ld_s r2,[r2,r3]
L_8e8fb2:
	cmp_s r2,r20
L_8e8fb4:
	mov.cc r2,r20
	.global L_8e8fb8
L_8e8fb8:
	add r0,r0,0x100
L_8e8fbc:
	add2_s r0,r0,r1
L_8e8fbe:
	ld_s r1,[r0,0x64]
L_8e8fc0:
	add_s r1,r1,r2
L_8e8fc2:
	st_s r1,[r0,0x64]
	.global L_8e8fc4
L_8e8fc4:
	st r19,[r14, 0x38]
L_8e8fc8:
	st_s r15,[r14,0x3c]
L_8e8fca:
	st r21,[r14, 0x40]
L_8e8fce:
	st r17,[r14, 0x44]
L_8e8fd2:
	st r16,[r14, 0x48]
L_8e8fd6:
	ld_s r1,[r14,0x34]
L_8e8fd8:
	ldb_s r2,[r13,0x10]
L_8e8fda:
	mov_s r0,r1
L_8e8fdc:
	add r0,r0,0x164
L_8e8fe0:
	ld.as r4,[r0,r2]
L_8e8fe4:
	asl_s r0,r2,0x2
L_8e8fe6:
	add3_s r0,r0,r0
L_8e8fe8:
	add r3,r1,0x8
L_8e8fec:
	ld_s r0,[r3,r0]
L_8e8fee:
	brhs r0,r4,L_8e8ffa
L_8e8ff2:
	mov_s r1,0x1014980
L_8e8ff8:
	b_s L_8e900c
	.global L_8e8ffa
L_8e8ffa:
	ldb r0,[r1,0x1fc]
L_8e9002:
	bbit0 r0,r2,L_8e905a
L_8e9006:
	mov_s r1,0x10149d0
	.global L_8e900c
L_8e900c:
	bl.d L_8dcc10
L_8e9010:
	mov_s r0,0x1b
L_8e9012:
	ld_s r0,[r14,0x34]
L_8e9014:
	ldb_s r1,[r13,0x10]
L_8e9016:
	add r0,r0,0x164
L_8e901a:
	ld.as r2,[r0,r1]
L_8e901e:
	mov_s r0,r14
L_8e9020:
	ld r4,[r14, 0x38]
L_8e9024:
	st_s r15,[sp,0x0]
L_8e9026:
	st r21,[sp, 0x4]
L_8e902a:
	st r20,[sp, 0x8]
L_8e902e:
	ld r5,[sp, 0xc]
L_8e9032:
	mov_s r1,r18
L_8e9034:
	ld r6,[sp, 0x10]
L_8e9038:
	mov_s r3,r19
L_8e903a:
	bl.d L_8e110c
L_8e903e:
	ld r7,[sp, 0x14]
L_8e9042:
	ld_s r0,[r14,0x34]
L_8e9044:
	ldb_s r1,[r13,0x10]
L_8e9046:
	add r0,r0,0x164
L_8e904a:
	add2_s r0,r0,r1
L_8e904c:
	st r22,[r0]
L_8e9050:
	ldb_s r0,[r13,0x10]
L_8e9052:
	mov_s r1,0x1
L_8e9054:
	bl.d L_8c90f0
L_8e9058:
	mov_s r2,r1
	.global L_8e905a
L_8e905a:
	ld_s r0,[r14,0x4c]
L_8e905c:
	ld_s r1,[sp,0x18]
L_8e905e:
	sub_s r1,r1,r0
L_8e9060:
	ld_s r0,[gp,0x240]
L_8e9062:
	brhs r0,r1,L_8e9096
L_8e9066:
	ld_s r0,[r14,0x34]
L_8e9068:
	ldb_s r1,[r13,0x10]
L_8e906a:
	add r0,r0,0x164
L_8e906e:
	ld.as r2,[r0,r1]
L_8e9072:
	mov_s r0,r14
L_8e9074:
	ld r4,[r14, 0x38]
L_8e9078:
	st_s r15,[sp,0x0]
L_8e907a:
	st r21,[sp, 0x4]
L_8e907e:
	st r20,[sp, 0x8]
L_8e9082:
	ld r5,[sp, 0xc]
L_8e9086:
	mov_s r1,r18
L_8e9088:
	ld r6,[sp, 0x10]
L_8e908c:
	mov_s r3,r19
L_8e908e:
	bl.d L_8e110c
L_8e9092:
	ld r7,[sp, 0x14]
	.global L_8e9096
L_8e9096:
	b.d L_8c0214
L_8e909a:
	add_s sp,sp,0x30
