/* UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler @ 0x8faf34, 1044 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler ut_subtype_id=0x%x
 *   -->> [UT CMD] UT_HW_SYSAPI_SUBTYPE_GET_RX_PACKET_PHY_DATA cmd
 *   UT_HW_SYSAPI_SUBTYPE_RS_TRIGGER: connection ID [%d] out of range
 *   UT_HW_SYSAPI_SUBTYPE_SET_FREQ_RATIO: channel num [%d] out of range [1...4]
 *   UT_HW_SYSAPI_SUBTYPE_SET_FREQ_RATIO: channel num [%d] int val [%d] fract val [%d]
 *   -->> [UT CMD] UT_HW_SYSAPI_SUBTYPE_RFC_READ_RGF cmd
 *   -->> [UT CMD] UT_HW_SYSAPI_SUBTYPE_RFC_WRITE_RGF cmd
 *   UT_HW_SYSAPI_SUBTYPE_RFC. mask: 0X%X, reg count: %d
 * Зовут его: wmi_ut_handler
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysapi__start_ampdu_stats, fw_sysapi__start_phy_rx_stats, fw_sysapi__start_rx_pkt_phy_data, hw_cfg__set_8004fc_and_levels, hw_sysapi__set_freq_ratio, hw_sysapi_channel_estimation
 * Глобалы (через gp): 0x800358, 0x80038c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler:
	.global L_8faf34
L_8faf34:
	push_s blink
L_8faf36:
	bl L_8c01d4
L_8faf3a:
	sub_s sp,sp,0x10
L_8faf3c:
	mov_s r16,r0
L_8faf3e:
	mov_s r14,r1
L_8faf40:
	mov_s r1,0x101ae34
L_8faf46:
	mov_s r0,0x20
L_8faf48:
	bl.d L_8dcc10
L_8faf4c:
	ldw_s r2,[r14,0x2]
L_8faf4e:
	mov_s r0,0x8035f8
L_8faf54:
	ld_s r1,[r0]
L_8faf56:
	ld_s r0,[r0,0x4]
L_8faf58:
	st_s r1,[sp,0x0]
L_8faf5a:
	st_s r0,[sp,0x4]
L_8faf5c:
	ldw_s r0,[r14]
L_8faf5e:
	stw r0,[sp]
L_8faf62:
	ldw_s r0,[r14,0x2]
L_8faf64:
	st r16,[sp, 0x4]
L_8faf68:
	stw r0,[sp, 0x2]
L_8faf6c:
	ldw_s r2,[r14,0x2]
L_8faf6e:
	sub_s r1,r2,0x1
L_8faf70:
	cmp_s r1,0x48
L_8faf72:
	bhi.d L_8fb336
L_8faf76:
	mov_s r13,0x0
L_8faf78:
	ldw.x.as r1,[0x803600,r1]
L_8faf80:
	add r0,pcl,0x8
L_8faf84:
	add1_s r0,r0,r1
L_8faf86:
	j_s [r0]
L_8faf88:
	mov_s r17,r13
L_8faf8a:
	b_s L_8fb14e
L_8faf8c:
	mov_s r0,r16
L_8faf8e:
	mov_s r1,0xa
L_8faf90:
	bl.d L_8eae60
L_8faf94:
	mov_s r2,0x1
L_8faf96:
	mov_s r13,r0
L_8faf98:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8faf9a:
	bl.d L_8c1cd8
L_8faf9e:
	mov_s r1,0xec
L_8fafa0:
	add_s r0,sp,0x8
L_8fafa2:
	bl.d L_8c1cd8
L_8fafa6:
	mov_s r1,0x8
L_8fafa8:
	bl.d L_8cded0
L_8fafac:
	add_s r0,sp,0x8
L_8fafae:
	ld_s r1,[sp,0xc]
L_8fafb0:
	ld_s r2,[sp,0x8]
L_8fafb2:
	st_s r1,[r13,0xc]
L_8fafb4:
	st_s r0,[r13,0x4]
L_8fafb6:
	st_s r2,[r13,0x8]
L_8fafb8:
	mov_s r0,r16
L_8fafba:
	mov_s r1,r13
L_8fafbc:
	bl.d L_8eae78
L_8fafc0:
	mov_s r2,0x10
L_8fafc2:
	b L_8fb342
L_8fafc6:
	ldb r4,[r14, 0x14]
L_8fafca:
	mov r7,sp
L_8fafce:
	ld r5,[r14, 0x18]
L_8fafd2:
	ld r6,[r14, 0x1c]
L_8fafd6:
	ldb_s r0,[r14,0x4]
L_8fafd8:
	ldb_s r1,[r14,0x8]
L_8fafda:
	ldb_s r2,[r14,0xc]
L_8fafdc:
	bl.d L_8cdf70
L_8fafe0:
	ldb_s r3,[r14,0x10]
L_8fafe2:
	b L_8fb342
L_8fafe6:
	ldb r4,[r14, 0x14]
L_8fafea:
	mov r6,sp
L_8fafee:
	ld r5,[r14, 0x18]
L_8faff2:
	ldb_s r0,[r14,0x4]
L_8faff4:
	ldb_s r1,[r14,0x8]
L_8faff6:
	ldb_s r2,[r14,0xc]
L_8faff8:
	bl.d L_8ce120
L_8faffc:
	ldb_s r3,[r14,0x10]
L_8faffe:
	b L_8fb342
L_8fb002:
	mov_s r1,0x101ae70
L_8fb008:
	bl.d L_8dcba8
L_8fb00c:
	mov_s r0,0x20
L_8fb00e:
	ldb r4,[r14, 0x14]
L_8fb012:
	ld r5,[r14, 0x18]
L_8fb016:
	ld r6,[sp]
L_8fb01a:
	ld r7,[sp, 0x4]
L_8fb01e:
	ldb_s r0,[r14,0x4]
L_8fb020:
	ldb_s r1,[r14,0x8]
L_8fb022:
	ldb_s r2,[r14,0xc]
L_8fb024:
	bl.d L_8ce018
L_8fb028:
	ldb_s r3,[r14,0x10]
L_8fb02a:
	b L_8fb342
L_8fb02e:
	mov_s r0,r16
L_8fb030:
	mov_s r1,0xa
L_8fb032:
	bl.d L_8eae60
L_8fb036:
	mov_s r2,0x5
L_8fb038:
	mov_s r13,r0
L_8fb03a:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8fb03c:
	bl.d L_8c1cd8
L_8fb040:
	mov_s r1,0xec
L_8fb042:
	ld_s r0,[r14,0x4]
L_8fb044:
	bl.d L_8ce4e8
L_8fb048:
	ld_s r1,[r14,0x8]
L_8fb04a:
	mov_s r0,0x1
L_8fb04c:
	b_s L_8fb0b8
L_8fb04e:
	mov_s r0,r16
L_8fb050:
	mov_s r1,0xa
L_8fb052:
	bl.d L_8eae60
L_8fb056:
	mov_s r2,0x6
L_8fb058:
	mov_s r13,r0
L_8fb05a:
	ldb_s r0,[r14,0x4]
L_8fb05c:
	ldb_s r1,[r14,0x8]
L_8fb05e:
	bl.d L_8cdde8
L_8fb062:
	ldb_s r2,[r14,0xc]
L_8fb064:
	b_s L_8fb0b8
L_8fb066:
	mov_s r0,r16
L_8fb068:
	mov_s r1,0xa
L_8fb06a:
	bl.d L_8eae60
L_8fb06e:
	mov_s r2,0x7
L_8fb070:
	mov_s r15,r0
L_8fb072:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8fb074:
	bl.d L_8c1cd8
L_8fb078:
	mov_s r1,0xec
L_8fb07a:
	ldb_s r2,[r14,0x4]
L_8fb07c:
	brlt r2,0x8,L_8fb08e
L_8fb080:
	mov_s r1,0x101aeb0
L_8fb086:
	bl.d L_8dcc10
L_8fb08a:
	mov_s r0,r13
L_8fb08c:
	b_s L_8fb096
	.global L_8fb08e
L_8fb08e:
	bl.d L_8ce408
L_8fb092:
	mov_s r0,r2
L_8fb094:
	mov_s r13,0x1
	.global L_8fb096
L_8fb096:
	st_s r13,[r15,0x4]
L_8fb098:
	mov_s r0,r16
L_8fb09a:
	mov_s r1,r15
L_8fb09c:
	b_s L_8fb0be
L_8fb09e:
	mov_s r0,r16
L_8fb0a0:
	mov_s r1,0xa
L_8fb0a2:
	bl.d L_8eae60
L_8fb0a6:
	mov_s r2,0x8
L_8fb0a8:
	mov_s r13,r0
L_8fb0aa:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8fb0ac:
	bl.d L_8c1cd8
L_8fb0b0:
	mov_s r1,0xec
L_8fb0b2:
	bl.d L_8ce40c
L_8fb0b6:
	ld_s r0,[r14,0x4]
	.global L_8fb0b8
L_8fb0b8:
	st_s r0,[r13,0x4]
L_8fb0ba:
	mov_s r0,r16
L_8fb0bc:
	mov_s r1,r13
	.global L_8fb0be
L_8fb0be:
	bl.d L_8eae78
L_8fb0c2:
	mov_s r2,0x8
L_8fb0c4:
	b L_8fb342
L_8fb0c8:
	mov_s r0,r16
L_8fb0ca:
	mov_s r1,0xa
L_8fb0cc:
	bl.d L_8eae60
L_8fb0d0:
	mov_s r2,r1
L_8fb0d2:
	mov_s r17,r0
L_8fb0d4:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8fb0d6:
	bl.d L_8c1cd8
L_8fb0da:
	mov_s r1,0xec
L_8fb0dc:
	ldb_s r15,[r14,0x4]
L_8fb0de:
	breq_s r15,0,L_8fb0e4
L_8fb0e0:
	brlo r15,0x5,L_8fb0f4
	.global L_8fb0e4
L_8fb0e4:
	mov_s r1,0x101aef4
L_8fb0ea:
	mov_s r0,0x0
L_8fb0ec:
	bl.d L_8dcc10
L_8fb0f0:
	mov_s r2,r15
L_8fb0f2:
	b_s L_8fb114
	.global L_8fb0f4
L_8fb0f4:
	mov_s r1,0x101af40
L_8fb0fa:
	ld r4,[r14, 0xc]
L_8fb0fe:
	mov_s r0,r13
L_8fb100:
	mov_s r2,r15
L_8fb102:
	bl.d L_8dcd00
L_8fb106:
	ld_s r3,[r14,0x8]
L_8fb108:
	sub_s r0,r15,0x1
L_8fb10a:
	ld_s r1,[r14,0x8]
L_8fb10c:
	bl.d L_8ce484
L_8fb110:
	ld_s r2,[r14,0xc]
L_8fb112:
	mov_s r13,0x1
	.global L_8fb114
L_8fb114:
	st r13,[r17, 0x4]
L_8fb118:
	mov_s r0,r16
L_8fb11a:
	mov_s r1,r17
L_8fb11c:
	b_s L_8fb0be
L_8fb11e:
	ldb r4,[r14, 0x14]
L_8fb122:
	ld r5,[r14, 0x18]
L_8fb126:
	ld r6,[sp]
L_8fb12a:
	ldb_s r0,[r14,0x4]
L_8fb12c:
	ldb_s r1,[r14,0x8]
L_8fb12e:
	ldb_s r2,[r14,0xc]
L_8fb130:
	ldb_s r3,[r14,0x10]
L_8fb132:
	bl.d L_8ce0d4
L_8fb136:
	mov r7,r16
L_8fb13a:
	b L_8fb342
L_8fb13e:
	mov_s r1,0x101af94
L_8fb144:
	bl.d L_8dcba8
L_8fb148:
	mov_s r0,0x20
L_8fb14a:
	mov r17,0x1
	.global L_8fb14e
L_8fb14e:
	mov_s r1,0x101afc8
L_8fb154:
	bl.d L_8dcba8
L_8fb158:
	mov_s r0,0x20
L_8fb15a:
	mov_s r0,r16
L_8fb15c:
	mov_s r1,0xa
L_8fb15e:
	bl.d L_8eae60
L_8fb162:
	ldw_s r2,[r14,0x2]
L_8fb164:
	mov_s r13,0x80669c
L_8fb16a:
	st r16,[r13]
L_8fb16e:
	st_s r0,[r13,0x4]
L_8fb170:
	ldb_s r2,[r14,0x4]
L_8fb172:
	mov_s r15,r0
L_8fb174:
	st_s r2,[r13,0x8]
L_8fb176:
	ld_s r3,[r14,0x4]
L_8fb178:
	mov r18,0x0
L_8fb17c:
	and r3,r3,0xff00
L_8fb184:
	lsr_s r3,r3,0x8
L_8fb186:
	st_s r3,[r13,0xc]
L_8fb188:
	st r18,[r13, 0x10]
L_8fb18c:
	st r17,[r13, 0x14]
L_8fb190:
	mov_s r1,0x101b000
L_8fb196:
	bl.d L_8dcc80
L_8fb19a:
	mov_s r0,0x20
L_8fb19c:
	add r0,r13,0x18
L_8fb1a0:
	add r1,r14,0x8
L_8fb1a4:
	bl.d L_8c0380
L_8fb1a8:
	mov_s r2,0x5c
L_8fb1aa:
	add2 r0,r13,0x1d
L_8fb1ae:
	bl.d L_8c1cd8
L_8fb1b2:
	mov_s r1,0x5c
L_8fb1b4:
	mov_s r0,0x64
L_8fb1b6:
	cmp r17,0x0
L_8fb1ba:
	mov.ne r14,r0
L_8fb1be:
	mov.eq r14,0x8
L_8fb1c2:
	bl.d L_8ce330
L_8fb1c6:
	mov_s r0,r13
L_8fb1c8:
	breq r0,0x5,L_8fb1ea
L_8fb1cc:
	st_s r0,[r15,0x4]
L_8fb1ce:
	breq r17,0x0,L_8fb1e0
L_8fb1d2:
	add r0,r15,0x8
L_8fb1d6:
	add2 r1,r13,0x1d
L_8fb1da:
	bl.d L_8c0380
L_8fb1de:
	mov_s r2,0x5c
	.global L_8fb1e0
L_8fb1e0:
	extw_s r2,r14
L_8fb1e2:
	mov_s r0,r16
L_8fb1e4:
	bl.d L_8eae78
L_8fb1e8:
	mov_s r1,r15
	.global L_8fb1ea
L_8fb1ea:
	mov_s r1,0x101b034
	.global L_8fb1f0
L_8fb1f0:
	bl.d L_8dcba8
L_8fb1f4:
	mov_s r0,0x20
L_8fb1f6:
	b_s L_8fb342
L_8fb1f8:
	ldb r4,[r14, 0x14]
L_8fb1fc:
	ld r5,[r14, 0x18]
L_8fb200:
	ld r6,[sp]
L_8fb204:
	ldb_s r0,[r14,0x4]
L_8fb206:
	ldb_s r1,[r14,0x8]
L_8fb208:
	ldb_s r2,[r14,0xc]
L_8fb20a:
	ldb_s r3,[r14,0x10]
L_8fb20c:
	bl.d L_8ce088
L_8fb210:
	mov r7,r16
L_8fb214:
	b_s L_8fb342
L_8fb216:
	ld r4,[r14, 0xc]
L_8fb21a:
	mov_s r1,0x101b070
L_8fb220:
	ld_s r2,[r14,0x4]
L_8fb222:
	mov_s r0,0x20
L_8fb224:
	bl.d L_8dcd00
L_8fb228:
	ld_s r3,[r14,0x8]
L_8fb22a:
	ldb_s r0,[r14,0x4]
L_8fb22c:
	ldb_s r1,[r14,0x8]
L_8fb22e:
	bl.d L_8ce060
L_8fb232:
	ldb_s r2,[r14,0xc]
L_8fb234:
	b_s L_8fb342
L_8fb236:
	mov_s r0,r16
L_8fb238:
	bl.d L_8cde44
L_8fb23c:
	mov_s r1,r14
L_8fb23e:
	b_s L_8fb342
L_8fb240:
	ld_s r0,[gp,0x1d4]
L_8fb242:
	ldw_s r1,[r14,0x4]
L_8fb244:
	brne_s r0,0,L_8fb270
L_8fb246:
	brne_s r1,0,L_8fb250
L_8fb248:
	bl.d L_8cddc8
L_8fb24c:
	mov_s r0,r1
L_8fb24e:
	b_s L_8fb342
	.global L_8fb250
L_8fb250:
	mul64 r1,0x3e8
L_8fb254:
	mov_s r0,L_8cddc8-0x8c0000
L_8fb25a:
	mov_s r2,r13
L_8fb25c:
	mov_s r3,r13
L_8fb25e:
	mov r4,mlo
L_8fb262:
	mov_s r5,r13
L_8fb264:
	bl.d L_8e0c0c
L_8fb268:
	mov_s r6,r13
L_8fb26a:
	st.as r0,[gp,0x75]
L_8fb26e:
	b_s L_8fb342
	.global L_8fb270
L_8fb270:
	mov_s r1,0x101b0d0
L_8fb276:
	b_s L_8fb1f0
L_8fb278:
	mov_s r1,0x101b110
L_8fb27e:
	bl.d L_8dcba8
L_8fb282:
	mov_s r0,0x20
L_8fb284:
	mov_s r0,r16
L_8fb286:
	mov_s r1,0xa
L_8fb288:
	bl.d L_8eae60
L_8fb28c:
	ldw_s r2,[r14,0x2]
L_8fb28e:
	mov_s r13,r0
L_8fb290:
	ld_s r0,[gp,0x208]
L_8fb292:
	mov_s r1,0x80114c
L_8fb298:
	st_s r0,[r13,0x4]
L_8fb29a:
	add r0,r13,0x8
L_8fb29e:
	bl.d L_8c0380
L_8fb2a2:
	mov_s r2,0x24
L_8fb2a4:
	mov_s r1,0x101b154
L_8fb2aa:
	mov_s r0,0x20
L_8fb2ac:
	bl.d L_8dcc10
L_8fb2b0:
	mov_s r2,0x2c
L_8fb2b2:
	mov_s r0,r16
L_8fb2b4:
	mov_s r1,r13
L_8fb2b6:
	bl.d L_8eae78
L_8fb2ba:
	mov_s r2,0x2c
L_8fb2bc:
	b_s L_8fb342
L_8fb2be:
	mov_s r1,0x101b1a4
L_8fb2c4:
	bl.d L_8dcba8
L_8fb2c8:
	mov_s r0,0x20
L_8fb2ca:
	ldb r4,[r14, 0x14]
L_8fb2ce:
	ld r5,[r14, 0x18]
L_8fb2d2:
	ld r6,[sp]
L_8fb2d6:
	ld r7,[sp, 0x4]
L_8fb2da:
	ldb_s r0,[r14,0x4]
L_8fb2dc:
	ldb_s r1,[r14,0x8]
L_8fb2de:
	ldb_s r2,[r14,0xc]
L_8fb2e0:
	bl.d L_8cdcdc
L_8fb2e4:
	ldb_s r3,[r14,0x10]
L_8fb2e6:
	b_s L_8fb342
L_8fb2e8:
	mov_s r1,0x101b1e0
L_8fb2ee:
	bl.d L_8dcba8
L_8fb2f2:
	mov_s r0,0x20
L_8fb2f4:
	bl.d L_8ebbbc
L_8fb2f8:
	mov_s r0,sp
L_8fb2fa:
	b_s L_8fb342
L_8fb2fc:
	mov_s r1,sp
L_8fb2fe:
	mov_s r0,r14
L_8fb300:
	bl.d L_8cdd60
L_8fb304:
	mov_s r2,0x28
L_8fb306:
	b_s L_8fb342
	.global L_8fb308
L_8fb308:
	mov_s r0,0x0
L_8fb30a:
	bl.d L_8d3588
L_8fb30e:
	mov_s r1,r13
L_8fb310:
	mov_s r16,r0
L_8fb312:
	add_s r1,r13,0x4
L_8fb314:
	bl.d L_8d3588
L_8fb318:
	mov_s r0,0x0
L_8fb31a:
	mov_s r4,r0
L_8fb31c:
	mov_s r1,0x101b218
L_8fb322:
	mov_s r0,0x25
L_8fb324:
	mov_s r2,r13
L_8fb326:
	bl.d L_8dcd00
L_8fb32a:
	mov_s r3,r16
L_8fb32c:
	add_s r13,r13,0x8
L_8fb32e:
	cmp r13,0x600
L_8fb332:
	blo_s L_8fb308
L_8fb334:
	b_s L_8fb342
	.global L_8fb336
L_8fb336:
	mov_s r0,r16
L_8fb338:
	mov_s r1,0x9
L_8fb33a:
	asl_s r1,r1,0x8
L_8fb33c:
	bl.d L_8e5728
L_8fb340:
	ldw_s r3,[r14]
	.global L_8fb342
L_8fb342:
	b.d L_8c0234
L_8fb346:
	add_s sp,sp,0x10
