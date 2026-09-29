/* mlme_sm_802458__action_8f1080 @ 0x8f1080, 528 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   REJECT ASSOCIATING REQ from CID %d
 *   PCP Assoc Req OLD VS: networkType %x,test mode = %x, srv_id_1 = %x
 *   PCP Assoc Req with networkType %x, test_mode = %x, pbc = %x
 *   Handle associate event State %d
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r21_to_r13_ret, __st_r21_to_r13, conn__config_txss_and_sta, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, l2_mgr__connect_args, mem_pool__free_thunk, mgmt_pkt__release, mgmt_tx__build_assoc_resp_8f9e88, mlme_notify
 * Глобалы (через gp): 0x8002e4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_802458__action_8f1080
mlme_sm_802458__action_8f1080:
	.global L_8f1080
L_8f1080:
	push_s blink
L_8f1082:
	bl L_8c01c8
L_8f1086:
	mov_s r14,r0
L_8f1088:
	ld_s r0,[gp,0x160]
L_8f108a:
	mov_s r13,r1
L_8f108c:
	mulu64 r0,0x3e8
L_8f1090:
	ld_s r0,[r14,0x20]
L_8f1092:
	mov r19,mlo
L_8f1096:
	ld_s r1,[r0,0x18]
L_8f1098:
	sub_s sp,sp,0xc
L_8f109a:
	ld_s r1,[r1,0x50]
L_8f109c:
	mov_s r0,0x0
L_8f109e:
	cmp_s r1,0x2
L_8f10a0:
	cmp.ne r1,0x3
L_8f10a4:
	mov.eq r0,0x1
L_8f10a8:
	extb.f 0x0,r0
L_8f10ac:
	beq_s L_8f1244
L_8f10ae:
	mov_s r0,0xd
L_8f10b0:
	st_s r0,[sp,0x4]
L_8f10b2:
	mov_s r0,0x0
L_8f10b4:
	mov_s r17,r0
L_8f10b6:
	st_s r0,[sp,0x8]
L_8f10b8:
	breq r13,0x0,L_8f1154
	.global L_8f10bc
L_8f10bc:
	ld_s r0,[r14,0x20]
L_8f10be:
	ld r16,[r0, 0x18]
L_8f10c2:
	breq r16,0x0,L_8f1162
	.global L_8f10c6
L_8f10c6:
	bl.d L_8c6888
L_8f10ca:
	mov_s r0,r14
L_8f10cc:
	ld_s r0,[r13,0x8]
L_8f10ce:
	add_s r3,sp,0x4
L_8f10d0:
	ldw_s r2,[r0]
L_8f10d2:
	ld_s r1,[r13,0xc]
L_8f10d4:
	lsr_s r2,r2,0x4
L_8f10d6:
	mov_s r0,r16
L_8f10d8:
	bl.d L_8c4e4c
L_8f10dc:
	bmsk_s r2,r2,0x3
L_8f10de:
	brne r0,0x0,L_8f117e
L_8f10e2:
	ld_s r0,[r14,0xc]
L_8f10e4:
	brne r0,0x0,L_8f117e
L_8f10e8:
	mov_s r0,0x25
L_8f10ea:
	stw_s r0,[r14,0x28]
L_8f10ec:
	mov_s r1,0x101141c
L_8f10f2:
	mov_s r0,0x1a
L_8f10f4:
	bl.d L_8dcc10
L_8f10f8:
	ldb r2,[r13, 0x36]
L_8f10fc:
	bl L_8c3414
L_8f1100:
	st_s r0,[r14,0x24]
L_8f1102:
	breq_s r0,0,L_8f1170
	.global L_8f1104
L_8f1104:
	ld_s r3,[r14,0x20]
L_8f1106:
	add_s r1,sp,0x8
L_8f1108:
	ld_s r0,[r14,0x24]
L_8f110a:
	bl.d L_8f9e88
L_8f110e:
	ld_s r2,[r3,0x18]
L_8f1110:
	mov r7,0x31fb0
L_8f1118:
	ldw r4,[sp, 0x8]
L_8f111c:
	st r17,[sp]
L_8f1120:
	ld_s r0,[r14,0x20]
L_8f1122:
	mov_s r1,0x0
L_8f1124:
	mov_s r2,0x1
L_8f1126:
	ld_s r3,[r14,0x24]
L_8f1128:
	mov r5,0x7
L_8f112c:
	bl.d L_8e5a28
L_8f1130:
	mov r6,0x50
L_8f1134:
	ld_s r1,[r14,0x20]
L_8f1136:
	mov_s r0,r14
L_8f1138:
	ldb_s r1,[r1,0x8]
L_8f113a:
	mov_s r3,0x5
L_8f113c:
	ld_s r2,[sp,0x4]
L_8f113e:
	bl.d L_8de394
L_8f1142:
	mov r4,0x0
L_8f1146:
	bl.d L_8cb180
L_8f114a:
	mov_s r0,r13
L_8f114c:
	bl.d L_8cb15c
L_8f1150:
	mov_s r0,r13
L_8f1152:
	b_s L_8f1288
	.global L_8f1154
L_8f1154:
	mov_s r0,blink
L_8f1156:
	mov_s r1,0x11f7
L_8f115c:
	bl L_8c9b28
L_8f1160:
	b_s L_8f10bc
	.global L_8f1162
L_8f1162:
	mov_s r0,blink
L_8f1164:
	mov_s r1,0x11f8
L_8f116a:
	bl L_8c9b28
L_8f116e:
	b_s L_8f10c6
	.global L_8f1170
L_8f1170:
	mov_s r0,blink
L_8f1172:
	mov_s r1,0x11f9
L_8f1178:
	bl L_8c9b28
L_8f117c:
	b_s L_8f1104
	.global L_8f117e
L_8f117e:
	ld_s r0,[r13,0xc]
L_8f1180:
	ld r15,[r0, 0x9c]
L_8f1184:
	breq_s r15,0,L_8f11cc
L_8f1186:
	ld_s r0,[r14,0x20]
L_8f1188:
	ldb_s r3,[r15,0xa]
L_8f118a:
	ld_s r2,[r0,0x18]
L_8f118c:
	ldb_s r1,[r15,0xb]
L_8f118e:
	add3 r0,r2,0x9
L_8f1192:
	asl_s r1,r1,0x8
L_8f1194:
	or_s r3,r3,r1
L_8f1196:
	mov_s r1,0x0
L_8f1198:
	bl.d L_8e69e0
L_8f119c:
	ld_s r2,[r2,0x14]
L_8f119e:
	ld_s r1,[r14,0x20]
L_8f11a0:
	ldb_s r2,[r15,0xb]
L_8f11a2:
	ldb_s r0,[r15,0xa]
L_8f11a4:
	asl_s r2,r2,0x8
L_8f11a6:
	or_s r0,r0,r2
L_8f11a8:
	st_s r0,[r1,0x44]
L_8f11aa:
	mov_s r1,0x1011440
L_8f11b0:
	ldb_s r0,[r15,0x9]
L_8f11b2:
	ldb_s r2,[r15,0x8]
L_8f11b4:
	asl_s r0,r0,0x8
L_8f11b6:
	or_s r2,r2,r0
L_8f11b8:
	ldb_s r0,[r15,0xb]
L_8f11ba:
	ldb_s r3,[r15,0xa]
L_8f11bc:
	asl_s r0,r0,0x8
L_8f11be:
	ldb r4,[r15, 0x4]
L_8f11c2:
	or_s r3,r3,r0
L_8f11c4:
	bl.d L_8dcd00
L_8f11c8:
	mov_s r0,0x2a
L_8f11ca:
	b_s L_8f1232
	.global L_8f11cc
L_8f11cc:
	ld r1,[r0, 0xa4]
L_8f11d0:
	breq_s r1,0,L_8f1232
L_8f11d2:
	add3 r20,r0,0x14
L_8f11d6:
	add3 r15,r16,0x9
L_8f11da:
	mov_s r0,r15
L_8f11dc:
	bl.d L_8df888
L_8f11e0:
	mov_s r1,r20
L_8f11e2:
	mov_s r18,r0
L_8f11e4:
	mov_s r0,r15
L_8f11e6:
	bl.d L_8df824
L_8f11ea:
	mov_s r1,r20
L_8f11ec:
	mov_s r21,r0
L_8f11ee:
	mov_s r0,r15
L_8f11f0:
	bl.d L_8df8ec
L_8f11f4:
	mov_s r1,r20
L_8f11f6:
	mov.f r4,r0
L_8f11fa:
	mov_s r15,0x0
L_8f11fc:
	mov.ne r15,0x3
L_8f1200:
	bne_s L_8f120a
L_8f1202:
	cmp r18,0x0
L_8f1206:
	mov.ne r15,0x1
	.global L_8f120a
L_8f120a:
	ld_s r0,[r14,0x20]
L_8f120c:
	mov_s r1,0x1011484
L_8f1212:
	ld r16,[r0, 0x18]
L_8f1216:
	mov_s r0,0x2a
L_8f1218:
	mov_s r2,r21
L_8f121a:
	bl.d L_8dcd00
L_8f121e:
	mov_s r3,r18
L_8f1220:
	add3 r0,r16,0x9
L_8f1224:
	mov_s r1,r21
L_8f1226:
	bl.d L_8e73a0
L_8f122a:
	mov_s r2,r15
L_8f122c:
	ld_s r1,[r14,0x20]
L_8f122e:
	st r18,[r1, 0x44]
	.global L_8f1232
L_8f1232:
	bl.d L_8dc4ac
L_8f1236:
	ld_s r0,[r14,0x20]
L_8f1238:
	st_s r13,[r14,0x2c]
L_8f123a:
	bl.d L_8cb180
L_8f123e:
	mov_s r0,r13
L_8f1240:
	stw r17,[r14, 0x28]
	.global L_8f1244
L_8f1244:
	mov_s r1,0x10114c0
L_8f124a:
	mov_s r0,0x2a
L_8f124c:
	bl.d L_8dcc10
L_8f1250:
	ldb_s r2,[r14]
L_8f1252:
	ld_s r0,[r14,0x10]
L_8f1254:
	brne_s r0,0,L_8f126a
L_8f1256:
	ld_s r0,[r14,0x20]
L_8f1258:
	mov_s r1,r14
L_8f125a:
	ld_s r2,[r0,0x18]
L_8f125c:
	mov_s r0,0x22178
L_8f1262:
	bl.d L_8dca38
L_8f1266:
	ldb_s r2,[r2,0x10]
L_8f1268:
	st_s r0,[r14,0x10]
	.global L_8f126a
L_8f126a:
	ld_s r0,[r14,0x14]
L_8f126c:
	brne_s r0,0,L_8f1288
L_8f126e:
	mov_s r0,L_8f1054-0x8c0000
L_8f1274:
	mov_s r1,r14
L_8f1276:
	mov_s r2,0x0
L_8f1278:
	mov_s r3,0x1
L_8f127a:
	mov r4,r19
L_8f127e:
	mov_s r5,r2
L_8f1280:
	bl.d L_8e0c0c
L_8f1284:
	mov_s r6,r2
L_8f1286:
	st_s r0,[r14,0x14]
	.global L_8f1288
L_8f1288:
	b.d L_8c021c
L_8f128c:
	add_s sp,sp,0xc
L_8f128e:
	nop_s
