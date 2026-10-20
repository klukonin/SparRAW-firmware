/* tx_ppdu_ageing_timeout_detector__task @ 0x8e3ed4, 824 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_ppdu_ageing_timeout_detector::task(): Task scheduled while detector is disabled cid=%d. Task will be stopped
 *   tx_ageing_detector: Ageing Reset
 *   tx_ageing_detector: Ageing Up
 *   [NNL] dt_vr %d | dt_blocked %d  | dt_nav %d
 *   tx_ageing_detector: Link-Loss detected for cid=%d. Initating disconnect flow.
 *   tx_ageing_detector: Link-Loss detected for cid=%d. missing ack for ATIM in 10 consecutive beacons.
 *   tx_ageing_detector: Link-Loss
 *   tx_ageing_detector: PeriodicPrint
 * Зовёт сам: __ld_r24_to_r13_ret, __st_r24_to_r13, ageing_detector__drop_connection, ageing_detector__get_state, ageing_detector__log_state, ageing_detector__rearm, detector__deadline_is_unset, fw_log__emit0, fw_log__emit1, fw_log__emit3, get_g_800236, mac_read_tsf64
 * Глобалы (через gp): 0x8003a4
 */
	.section .text.tx_ppdu_ageing_timeout_detector__task,"ax",@progbits
	.global tx_ppdu_ageing_timeout_detector__task
tx_ppdu_ageing_timeout_detector__task:
L_8e3ed4:
	add_s sp,sp,0x28
	.global fwlog_tx_ppdu_ageing_timeout_detector_task_Tas
fwlog_tx_ppdu_ageing_timeout_detector_task_Tas:
L_8e3ed6:
	nop_s
L_8e3ed8:
	push_s blink
L_8e3eda:
	bl L_8c029c
L_8e3ede:
	sub_s sp,sp,0x38
L_8e3ee0:
	bl.d L_8d71a0
L_8e3ee4:
	mov_s r13,r0
L_8e3ee6:
	mov r22,0x0
L_8e3eea:
	brne_s r0,0,L_8e3f08
L_8e3eec:
	mov_s r2,0x10111a0
L_8e3ef2:
	mov_s r0,0xb
L_8e3ef4:
	mov_s r1,r22
L_8e3ef6:
	bl.d L_8edfcc
L_8e3efa:
	ldb r3,[r13, 0x30]
L_8e3efe:
	bl.d L_8e2fa8
L_8e3f02:
	mov_s r0,r13
L_8e3f04:
	b L_8e4206
	.global L_8e3f08
L_8e3f08:
	add r17,sp,0x20
L_8e3f0c:
	mov_s r0,r22
L_8e3f0e:
	mov_s r1,r17
L_8e3f10:
	bl.d L_8e4840
L_8e3f14:
	mov_s r2,r22
L_8e3f16:
	bl.d L_8d71f4
L_8e3f1a:
	mov_s r0,r13
L_8e3f1c:
	cmp_s r0,0x0
L_8e3f1e:
	mov.ne r0,r17
L_8e3f22:
	bne_s L_8e3f2e
L_8e3f24:
	ld_s r1,[r13,0x1c]
L_8e3f26:
	ld_s r0,[r13,0x20]
L_8e3f28:
	st_s r1,[sp,0x30]
L_8e3f2a:
	st_s r0,[sp,0x34]
L_8e3f2c:
	add_s r0,sp,0x30
	.global L_8e3f2e
L_8e3f2e:
	ld_s r2,[r0]
L_8e3f30:
	ld_s r3,[r0,0x4]
L_8e3f32:
	ld_s r1,[sp,0x24]
L_8e3f34:
	ld_s r0,[sp,0x20]
L_8e3f36:
	cmp_s r3,r1
L_8e3f38:
	cmp.eq r2,r0
L_8e3f3c:
	mov r21,0x0
L_8e3f40:
	bhi_s L_8e3f46
L_8e3f42:
	sub r21,r0,r2
	.global L_8e3f46
L_8e3f46:
	add r14,r13,0x20
L_8e3f4a:
	ld_s r1,[r13,0x34]
L_8e3f4c:
	ldb_s r0,[r14,0x10]
L_8e3f4e:
	add r1,r1,0x120
L_8e3f52:
	bl.d L_8cad1c
L_8e3f56:
	ld.as r16,[r1,r0]
L_8e3f5a:
	mov_s r20,r0
L_8e3f5c:
	ld_s r0,[r13,0x34]
L_8e3f5e:
	ldb_s r1,[r14,0x10]
L_8e3f60:
	add r0,r0,0x140
L_8e3f64:
	bl.d L_8ebda4
L_8e3f68:
	ld.as r15,[r0,r1]
L_8e3f6c:
	bl.d L_8c9b0c
L_8e3f70:
	mov_s r24,r0
L_8e3f72:
	mov_s r23,r0
L_8e3f74:
	bl.d L_8cac60
L_8e3f78:
	ldb_s r0,[r14,0x10]
L_8e3f7a:
	mov_s r1,0x0
L_8e3f7c:
	st_s r0,[sp,0xc]
L_8e3f7e:
	ldb_s r0,[r14,0x10]
L_8e3f80:
	bset r1,r1,r0
L_8e3f84:
	ld_s r0,[r13,0x34]
L_8e3f86:
	ld.as r0,[r0,0x58]
L_8e3f8a:
	and_s r0,r0,r1
L_8e3f8c:
	bl.d L_8c9898
L_8e3f90:
	st_s r0,[sp,0x10]
L_8e3f92:
	ldb_s r1,[r14,0x10]
L_8e3f94:
	mov_s r2,0x0
L_8e3f96:
	bset r2,r2,r1
L_8e3f9a:
	and_s r0,r0,r2
L_8e3f9c:
	st_s r0,[sp,0x14]
L_8e3f9e:
	ld_s r0,[sp,0xc]
L_8e3fa0:
	breq_s r0,0,L_8e3fa8
L_8e3fa2:
	ld_s r0,[r13,0x38]
L_8e3fa4:
	breq r0,r16,L_8e4002
	.global L_8e3fa8
L_8e3fa8:
	ld_s r0,[r13,0x34]
L_8e3faa:
	add r0,r0,0x164
L_8e3fae:
	ld.as r0,[r0,r1]
L_8e3fb2:
	breq_s r0,0,L_8e3ff2
L_8e3fb4:
	mov_s r2,0x1011210
L_8e3fba:
	mov_s r0,0xb
L_8e3fbc:
	bl.d L_8edfb0
L_8e3fc0:
	mov_s r1,0x2
L_8e3fc2:
	ld_s r0,[r13,0x34]
L_8e3fc4:
	ldb_s r1,[r14,0x10]
L_8e3fc6:
	add r0,r0,0x164
L_8e3fca:
	ld.as r2,[r0,r1]
L_8e3fce:
	mov_s r0,r13
L_8e3fd0:
	ld r4,[r13, 0x38]
L_8e3fd4:
	st r20,[sp]
L_8e3fd8:
	st_s r15,[sp,0x4]
L_8e3fda:
	st r21,[sp, 0x8]
L_8e3fde:
	ld r5,[sp, 0xc]
L_8e3fe2:
	mov_s r1,r17
L_8e3fe4:
	ld r6,[sp, 0x10]
L_8e3fe8:
	mov_s r3,r16
L_8e3fea:
	bl.d L_8dcf7c
L_8e3fee:
	ld r7,[sp, 0x14]
	.global L_8e3ff2
L_8e3ff2:
	ld_s r0,[r13,0x34]
L_8e3ff4:
	ldb_s r1,[r14,0x10]
L_8e3ff6:
	add r0,r0,0x164
L_8e3ffa:
	add2_s r0,r0,r1
L_8e3ffc:
	st r22,[r0]
L_8e4000:
	b_s L_8e4104
	.global L_8e4002
L_8e4002:
	ld_s r2,[r13,0x3c]
L_8e4004:
	brlo r20,r2,L_8e400e
L_8e4008:
	sub r18,r20,r2
L_8e400c:
	b_s L_8e401a
	.global L_8e400e
L_8e400e:
	rsub r0,r2,0xffffffff
L_8e4016:
	add r18,r0,r20
	.global L_8e401a
L_8e401a:
	ld_s r2,[r13,0x40]
L_8e401c:
	brlo r15,r2,L_8e4026
L_8e4020:
	sub r0,r15,r2
L_8e4024:
	b_s L_8e4030
	.global L_8e4026
L_8e4026:
	rsub r0,r2,0xffffffff
L_8e402e:
	add_s r0,r0,r15
	.global L_8e4030
L_8e4030:
	st_s r0,[sp,0x18]
L_8e4032:
	ld_s r0,[r13,0x44]
L_8e4034:
	brlo r24,r0,L_8e403e
L_8e4038:
	sub r2,r24,r0
L_8e403c:
	b_s L_8e4048
	.global L_8e403e
L_8e403e:
	rsub r2,r0,0xffffffff
L_8e4046:
	add_s r2,r2,r24
	.global L_8e4048
L_8e4048:
	ld_s r0,[r13,0x48]
L_8e404a:
	brlo r23,r0,L_8e4054
L_8e404e:
	sub r3,r23,r0
L_8e4052:
	b_s L_8e405e
	.global L_8e4054
L_8e4054:
	rsub r3,r0,0xffffffff
L_8e405c:
	add_s r3,r3,r23
	.global L_8e405e
L_8e405e:
	ld_s r0,[sp,0x18]
L_8e4060:
	add_s r2,r2,r0
L_8e4062:
	add_s r3,r3,r2
L_8e4064:
	st_s r3,[sp,0x1c]
L_8e4066:
	breq r18,0x0,L_8e4080
L_8e406a:
	ld_s r0,[sp,0x14]
L_8e406c:
	brne_s r0,0,L_8e4080
L_8e406e:
	sub r0,r18,r3
L_8e4072:
	cmp r18,r3
L_8e4076:
	mov.hi r19,r0
L_8e407a:
	mov.ls r19,0x0
L_8e407e:
	b_s L_8e4098
	.global L_8e4080
L_8e4080:
	ld_s r2,[sp,0x14]
L_8e4082:
	ld_s r0,[r13,0x34]
L_8e4084:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8e4086:
	brne_s r2,0,L_8e4090
L_8e4088:
	ld_s r2,[sp,0x10]
L_8e408a:
	mov r19,0x0
L_8e408e:
	breq_s r2,0,L_8e4098
	.global L_8e4090
L_8e4090:
	asl_s r2,r1,0x2
L_8e4092:
	add3_s r2,r2,r2
L_8e4094:
	ld r19,[r0,r2]
	.global L_8e4098
L_8e4098:
	ld_s r0,[r13,0x34]
L_8e409a:
	add r0,r0,0x164
L_8e409e:
	ld.as r0,[r0,r1]
L_8e40a2:
	brne_s r0,0,L_8e40f4
L_8e40a4:
	breq r19,0x0,L_8e40f4
L_8e40a8:
	mov_s r2,0x1011234
L_8e40ae:
	mov_s r0,0xb
L_8e40b0:
	bl.d L_8edfb0
L_8e40b4:
	mov_s r1,0x2
L_8e40b6:
	ld r4,[r13, 0x38]
L_8e40ba:
	st r20,[sp]
L_8e40be:
	st_s r15,[sp,0x4]
L_8e40c0:
	st r21,[sp, 0x8]
L_8e40c4:
	ld r5,[sp, 0xc]
L_8e40c8:
	mov_s r0,r13
L_8e40ca:
	ld r6,[sp, 0x10]
L_8e40ce:
	mov_s r1,r17
L_8e40d0:
	mov_s r2,r19
L_8e40d2:
	mov_s r3,r16
L_8e40d4:
	bl.d L_8dcf7c
L_8e40d8:
	ld r7,[sp, 0x14]
L_8e40dc:
	mov_s r2,0x1011258
L_8e40e2:
	ld r4,[sp, 0x1c]
L_8e40e6:
	mov_s r0,0xb
L_8e40e8:
	mov_s r1,0x2
L_8e40ea:
	mov_s r3,r18
L_8e40ec:
	bl.d L_8ee034
L_8e40f0:
	ld r5,[sp, 0x18]
	.global L_8e40f4
L_8e40f4:
	ld_s r0,[r13,0x34]
L_8e40f6:
	ldb_s r1,[r14,0x10]
L_8e40f8:
	add r0,r0,0x100
L_8e40fc:
	add2_s r0,r0,r1
L_8e40fe:
	ld_s r1,[r0,0x64]
L_8e4100:
	add_s r1,r1,r19
L_8e4102:
	st_s r1,[r0,0x64]
	.global L_8e4104
L_8e4104:
	st r16,[r13, 0x38]
L_8e4108:
	st r20,[r13, 0x3c]
L_8e410c:
	st_s r15,[r13,0x40]
L_8e410e:
	st r24,[r13, 0x44]
L_8e4112:
	st r23,[r13, 0x48]
L_8e4116:
	ld_s r1,[r13,0x34]
L_8e4118:
	ldb_s r3,[r14,0x10]
L_8e411a:
	mov_s r0,r1
L_8e411c:
	add r0,r0,0x164
L_8e4120:
	ld.as r4,[r0,r3]
L_8e4124:
	asl_s r0,r3,0x2
L_8e4126:
	add3_s r0,r0,r0
L_8e4128:
	add r2,r1,0x8
L_8e412c:
	ld_s r0,[r2,r0]
L_8e412e:
	brhs r0,r4,L_8e413a
L_8e4132:
	mov_s r2,0x1011284
L_8e4138:
	b_s L_8e414c
	.global L_8e413a
L_8e413a:
	ldb r0,[r1,0x1ec]
L_8e4142:
	bbit0 r0,r3,L_8e41aa
L_8e4146:
	mov_s r2,0x10112d4
	.global L_8e414c
L_8e414c:
	mov_s r0,0xb
L_8e414e:
	bl.d L_8edfcc
L_8e4152:
	mov_s r1,0x1
L_8e4154:
	mov_s r2,0x1011338
L_8e415a:
	mov_s r0,0xb
L_8e415c:
	bl.d L_8edfb0
L_8e4160:
	mov_s r1,0x2
L_8e4162:
	ld_s r0,[r13,0x34]
L_8e4164:
	ldb_s r1,[r14,0x10]
L_8e4166:
	add r0,r0,0x164
L_8e416a:
	ld.as r2,[r0,r1]
L_8e416e:
	mov_s r0,r13
L_8e4170:
	ld r4,[r13, 0x38]
L_8e4174:
	st r20,[sp]
L_8e4178:
	st_s r15,[sp,0x4]
L_8e417a:
	st r21,[sp, 0x8]
L_8e417e:
	ld r5,[sp, 0xc]
L_8e4182:
	mov_s r1,r17
L_8e4184:
	ld r6,[sp, 0x10]
L_8e4188:
	mov_s r3,r16
L_8e418a:
	bl.d L_8dcf7c
L_8e418e:
	ld r7,[sp, 0x14]
L_8e4192:
	ld_s r0,[r13,0x34]
L_8e4194:
	ldb_s r1,[r14,0x10]
L_8e4196:
	add r0,r0,0x164
L_8e419a:
	add2_s r0,r0,r1
L_8e419c:
	st r22,[r0]
L_8e41a0:
	ldb_s r0,[r14,0x10]
L_8e41a2:
	mov_s r1,0x1
L_8e41a4:
	bl.d L_8c7a40
L_8e41a8:
	mov_s r2,r1
	.global L_8e41aa
L_8e41aa:
	ld_s r3,[r13,0x4c]
L_8e41ac:
	ld_s r1,[sp,0x20]
L_8e41ae:
	sub.f r1,r1,r3
L_8e41b2:
	ld_s r0,[r13,0x50]
L_8e41b4:
	mov_s r3,0x0
L_8e41b6:
	ld_s r2,[sp,0x24]
L_8e41b8:
	sbc r2,r2,r0
L_8e41bc:
	ld_s r0,[gp,0x234]
L_8e41be:
	cmp_s r2,r3
L_8e41c0:
	cmp.eq r1,r0
L_8e41c4:
	bls L_8e4206
L_8e41c8:
	mov_s r2,0x101135c
L_8e41ce:
	mov_s r0,0xb
L_8e41d0:
	bl.d L_8edfb0
L_8e41d4:
	mov_s r1,0x2
L_8e41d6:
	ld_s r0,[r13,0x34]
L_8e41d8:
	ldb_s r1,[r14,0x10]
L_8e41da:
	add r0,r0,0x164
L_8e41de:
	ld.as r2,[r0,r1]
L_8e41e2:
	mov_s r0,r13
L_8e41e4:
	ld r4,[r13, 0x38]
L_8e41e8:
	st r20,[sp]
L_8e41ec:
	st_s r15,[sp,0x4]
L_8e41ee:
	st r21,[sp, 0x8]
L_8e41f2:
	ld r5,[sp, 0xc]
L_8e41f6:
	mov_s r1,r17
L_8e41f8:
	ld r6,[sp, 0x10]
L_8e41fc:
	mov_s r3,r16
L_8e41fe:
	bl.d L_8dcf7c
L_8e4202:
	ld r7,[sp, 0x14]
	.global L_8e4206
L_8e4206:
	b.d L_8c02e4
L_8e420a:
	add_s sp,sp,0x38
