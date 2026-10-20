/* UT_HW_DRIVERS_cmd_handler @ 0x8eaec8, 3316 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UT_HW_DRIVERS_cmd_handler ut_subtype_id=0x%x
 *   UT_HW_DRIVERS_SUBTYPE_ABIF_SET_FREQ_RATIO: channel num [%d] out of range
 *   UT_HW_DRIVERS_SUBTYPE_ABIF_SET_FREQ_RATIO: channel num [%d] int val [%d] fract val [%d]
 * Зовут его: wmi_ut_handler
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, abif__get_rx_table_index_force_val, abif__power_up_analog, car__enable_pll3_and_wait_on, channel__check_range, field_set_0x00__8db5bc, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, hw__is_fpga_platform, hwd_PHY_STORE_TXRX_SWAP_IQ
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global UT_HW_DRIVERS_cmd_handler
UT_HW_DRIVERS_cmd_handler:
	.global L_8eaec8
L_8eaec8:
	push_s blink
L_8eaeca:
	bl L_8c01d0
L_8eaece:
	sub sp,sp,0xa8
L_8eaed2:
	mov_s r17,r0
L_8eaed4:
	mov_s r14,r1
L_8eaed6:
	mov_s r1,0xc
L_8eaed8:
	mov_s r19,r1
L_8eaeda:
	bl.d L_8eae60
L_8eaede:
	ldw_s r2,[r14,0x2]
L_8eaee0:
	mov_s r16,r0
L_8eaee2:
	mov_s r1,0x101f1d8
L_8eaee8:
	mov_s r0,0x20
L_8eaeea:
	mov_s r18,r0
L_8eaeec:
	bl.d L_8dcc10
L_8eaef0:
	ldw_s r2,[r14,0x2]
L_8eaef2:
	bl.d L_8da2c8
L_8eaef6:
	mov_s r15,0x8
L_8eaef8:
	mov_s r13,0x1
L_8eaefa:
	ldw_s r2,[r14,0x2]
L_8eaefc:
	breq_s r0,0,L_8eaf42
L_8eaefe:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8eaf00:
	st r2,[r16, 0x4]
L_8eaf04:
	ld_s r0,[r14,0x4]
L_8eaf06:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eaf08:
	st r0,[r16, 0x8]
L_8eaf0c:
	ld_s r0,[r14,0x8]
L_8eaf0e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eaf10:
	st r0,[r16, 0xc]
L_8eaf14:
	ld_s r0,[r14,0xc]
L_8eaf16:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eaf18:
	st r0,[r16, 0x10]
L_8eaf1c:
	ld_s r0,[r14,0x10]
L_8eaf1e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eaf20:
	st r0,[r16, 0x14]
L_8eaf24:
	ld_s r0,[r14,0x14]
L_8eaf26:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eaf28:
	st r0,[r16, 0x18]
L_8eaf2c:
	ld_s r0,[r14,0x18]
L_8eaf2e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eaf30:
	st r0,[r16, 0x1c]
L_8eaf34:
	ld_s r0,[r14,0x1c]
L_8eaf36:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eaf38:
	st r0,[r16, 0x20]
L_8eaf3c:
	b.d L_8ebb9c
L_8eaf40:
	mov_s r2,0x24
	.global L_8eaf42
L_8eaf42:
	cmp r2,0x401
L_8eaf46:
	beq L_8eb590
L_8eaf4a:
	bgt L_8eb044
L_8eaf4e:
	cmp r2,0x12d
L_8eaf52:
	beq L_8eb41c
L_8eaf56:
	bgt L_8eaf76
L_8eaf5a:
	mov_s r1,r2
L_8eaf5c:
	sub r1,r1,0x101
L_8eaf60:
	cmp_s r1,0x2b
L_8eaf62:
	bhi L_8ebba6
L_8eaf66:
	ldw.x.as r1,[0x8039f4,r1]
L_8eaf6e:
	add r0,pcl,0xa
L_8eaf72:
	add1_s r0,r0,r1
L_8eaf74:
	j_s [r0]
	.global L_8eaf76
L_8eaf76:
	cmp r2,0x152
L_8eaf7a:
	beq L_8eb490
L_8eaf7e:
	bgt L_8eaf9e
L_8eaf82:
	mov_s r1,r2
L_8eaf84:
	sub r1,r1,0x12e
L_8eaf88:
	cmp_s r1,0x23
L_8eaf8a:
	bhi L_8ebba6
L_8eaf8e:
	ldw.x.as r1,[0x803a4c,r1]
L_8eaf96:
	add r0,pcl,0xa
L_8eaf9a:
	add1_s r0,r0,r1
L_8eaf9c:
	j_s [r0]
	.global L_8eaf9e
L_8eaf9e:
	cmp r2,0x163
L_8eafa2:
	beq L_8eb39e
L_8eafa6:
	bgt L_8eafc6
L_8eafaa:
	mov_s r1,r2
L_8eafac:
	sub r1,r1,0x153
L_8eafb0:
	cmp_s r1,0xf
L_8eafb2:
	bhi L_8ebba6
L_8eafb6:
	ldw.x.as r1,[0x803a94,r1]
L_8eafbe:
	add r0,pcl,0xa
L_8eafc2:
	add1_s r0,r0,r1
L_8eafc4:
	j_s [r0]
	.global L_8eafc6
L_8eafc6:
	cmp r2,0x203
L_8eafca:
	beq L_8eb55c
L_8eafce:
	bgt L_8eb028
L_8eafd2:
	cmp r2,0x171
L_8eafd6:
	beq L_8eb548
L_8eafda:
	bgt_s L_8eb00e
L_8eafdc:
	cmp r2,0x164
L_8eafe0:
	beq L_8eb516
L_8eafe4:
	cmp r2,0x170
L_8eafe8:
	bne L_8ebba6
L_8eafec:
	ldb r18,[r14, 0x4]
L_8eaff0:
	breq r18,0x0,L_8eaffc
L_8eaff4:
	cmp r18,0x4
L_8eaff8:
	bls L_8eb3aa
	.global L_8eaffc
L_8eaffc:
	mov_s r1,0x101f208
L_8eb002:
	mov_s r0,0x0
L_8eb004:
	bl.d L_8dcc10
L_8eb008:
	mov_s r2,r18
L_8eb00a:
	b L_8eb842
	.global L_8eb00e
L_8eb00e:
	cmp r2,0x201
L_8eb012:
	beq L_8eb554
L_8eb016:
	cmp r2,0x202
L_8eb01a:
	bne L_8ebba6
L_8eb01e:
	bl.d L_8d041c
L_8eb022:
	ld_s r0,[r14,0x4]
L_8eb024:
	b L_8ebb94
	.global L_8eb028
L_8eb028:
	mov_s r1,r2
L_8eb02a:
	sub r1,r1,0x301
L_8eb02e:
	cmp_s r1,0x4
L_8eb030:
	bhi L_8ebba6
L_8eb034:
	ldw.x.as r1,[0x803ab4,r1]
L_8eb03c:
	add r0,pcl,0x8
L_8eb040:
	add1_s r0,r0,r1
L_8eb042:
	j_s [r0]
	.global L_8eb044
L_8eb044:
	cmp r2,0x42e
L_8eb048:
	beq L_8eb7d2
L_8eb04c:
	bgt L_8eb06c
L_8eb050:
	mov_s r1,r2
L_8eb052:
	sub r1,r1,0x402
L_8eb056:
	cmp_s r1,0x2b
L_8eb058:
	bhi L_8ebba6
L_8eb05c:
	ldw.x.as r1,[0x803ac0,r1]
L_8eb064:
	add r0,pcl,0x8
L_8eb068:
	add1_s r0,r0,r1
L_8eb06a:
	j_s [r0]
	.global L_8eb06c
L_8eb06c:
	cmp r2,0x50d
L_8eb070:
	beq L_8eb992
L_8eb074:
	bgt L_8eb0c2
L_8eb078:
	cmp r2,0x502
L_8eb07c:
	beq L_8eb8f0
L_8eb080:
	bgt_s L_8eb0a6
L_8eb082:
	cmp r2,0x501
L_8eb086:
	beq L_8eb8e6
L_8eb08a:
	mov_s r1,r2
L_8eb08c:
	sub r1,r1,0x430
L_8eb090:
	cmp_s r1,0x8
L_8eb092:
	bhi L_8ebba6
L_8eb096:
	ldw.x.as r1,[0x803b18,r1]
L_8eb09e:
	add r0,pcl,0xa
L_8eb0a2:
	add1_s r0,r0,r1
L_8eb0a4:
	j_s [r0]
	.global L_8eb0a6
L_8eb0a6:
	mov_s r1,r2
L_8eb0a8:
	sub r1,r1,0x503
L_8eb0ac:
	cmp_s r1,0x9
L_8eb0ae:
	bhi L_8ebba6
L_8eb0b2:
	ldw.x.as r1,[0x803b2c,r1]
L_8eb0ba:
	add r0,pcl,0xa
L_8eb0be:
	add1_s r0,r0,r1
L_8eb0c0:
	j_s [r0]
	.global L_8eb0c2
L_8eb0c2:
	cmp r2,0x518
L_8eb0c6:
	beq L_8eba7e
L_8eb0ca:
	bgt_s L_8eb0e8
L_8eb0cc:
	mov_s r1,r2
L_8eb0ce:
	sub r1,r1,0x50e
L_8eb0d2:
	cmp_s r1,0x9
L_8eb0d4:
	bhi L_8ebba6
L_8eb0d8:
	ldw.x.as r1,[0x803b40,r1]
L_8eb0e0:
	add r0,pcl,0x8
L_8eb0e4:
	add1_s r0,r0,r1
L_8eb0e6:
	j_s [r0]
	.global L_8eb0e8
L_8eb0e8:
	cmp r2,0x51e
L_8eb0ec:
	beq L_8eba8a
L_8eb0f0:
	bgt_s L_8eb10e
L_8eb0f2:
	mov_s r1,r2
L_8eb0f4:
	sub r1,r1,0x519
L_8eb0f8:
	cmp_s r1,0x4
L_8eb0fa:
	bhi L_8ebba6
L_8eb0fe:
	ldw.x.as r1,[0x803b54,r1]
L_8eb106:
	add r0,pcl,0xa
L_8eb10a:
	add1_s r0,r0,r1
L_8eb10c:
	j_s [r0]
	.global L_8eb10e
L_8eb10e:
	cmp r2,0x610
L_8eb112:
	beq L_8ebb76
L_8eb116:
	bgt_s L_8eb132
L_8eb118:
	cmp r2,0x601
L_8eb11c:
	beq L_8ebb6e
L_8eb120:
	cmp r2,0x602
L_8eb124:
	bne L_8ebba6
L_8eb128:
	bl.d L_8d18e8
L_8eb12c:
	ld_s r0,[r14,0x4]
L_8eb12e:
	b L_8ebb94
	.global L_8eb132
L_8eb132:
	cmp r2,0x611
L_8eb136:
	beq L_8ebb8a
L_8eb13a:
	cmp r2,0x700
L_8eb13e:
	bne L_8ebba6
L_8eb142:
	mov_s r0,r17
L_8eb144:
	bl.d L_8cdb18
L_8eb148:
	mov_s r1,r14
L_8eb14a:
	b L_8ebb94
L_8eb14e:
	bl.d L_8cec90
L_8eb152:
	ld_s r0,[r14,0x4]
L_8eb154:
	b L_8ebb94
L_8eb158:
	bl.d L_8ce4ec
L_8eb15c:
	ld_s r0,[r14,0x4]
L_8eb15e:
	b L_8ebb94
L_8eb162:
	bl.d L_8cffc4
L_8eb166:
	ld_s r0,[r14,0x4]
L_8eb168:
	b L_8ebb94
L_8eb16c:
	bl.d L_8ceddc
L_8eb170:
	ld_s r0,[r14,0x4]
L_8eb172:
	b L_8ebb94
L_8eb176:
	ld_s r0,[r14,0x4]
L_8eb178:
	/* bl.d 0x008cea38 */
	.byte 0xc2,0x08,0xef,0xf1
L_8eb17c:
	/* _sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8eb17e:
	b L_8ebb94
L_8eb182:
	bl L_8cea04
L_8eb186:
	b L_8ebb94
L_8eb18a:
	bl.d L_8ced74
L_8eb18e:
	ld_s r0,[r14,0x4]
L_8eb190:
	b L_8ebb94
L_8eb194:
	bl.d L_8ce648
L_8eb198:
	ld_s r0,[r14,0x4]
L_8eb19a:
	b L_8ebb94
L_8eb19e:
	bl.d L_8ce690
L_8eb1a2:
	ld_s r0,[r14,0x4]
L_8eb1a4:
	b L_8ebb94
L_8eb1a8:
	bl.d L_8ce5e8
L_8eb1ac:
	ld_s r0,[r14,0x4]
L_8eb1ae:
	b L_8ebb94
L_8eb1b2:
	bl.d L_8ce518
L_8eb1b6:
	ld_s r0,[r14,0x4]
L_8eb1b8:
	b L_8ebb94
L_8eb1bc:
	bl.d L_8ce5c0
L_8eb1c0:
	ld_s r0,[r14,0x4]
L_8eb1c2:
	b L_8ebb94
L_8eb1c6:
	ldb_s r0,[r14,0x4]
L_8eb1c8:
	ldb_s r1,[r14,0x8]
L_8eb1ca:
	bl.d L_8cf718
L_8eb1ce:
	ldb_s r2,[r14,0xc]
L_8eb1d0:
	b L_8eb9c4
L_8eb1d4:
	ldb_s r0,[r14,0x4]
L_8eb1d6:
	ldb_s r1,[r14,0x8]
L_8eb1d8:
	bl.d L_8cf2cc
L_8eb1dc:
	ldb_s r2,[r14,0xc]
L_8eb1de:
	b L_8ebb94
L_8eb1e2:
	ldb_s r0,[r14,0x4]
L_8eb1e4:
	bl.d L_8cf6b0
L_8eb1e8:
	ldb_s r1,[r14,0x8]
L_8eb1ea:
	b L_8eb9c4
L_8eb1ee:
	ldb_s r0,[r14,0x4]
L_8eb1f0:
	add_s r15,sp,0x8
L_8eb1f2:
	bl.d L_8cf5fc
L_8eb1f6:
	mov_s r1,r15
L_8eb1f8:
	add r0,r16,0x8
L_8eb1fc:
	mov_s r1,r15
L_8eb1fe:
	bl.d L_8c0380
L_8eb202:
	mov_s r2,0xc
	.global L_8eb204
L_8eb204:
	mov_s r2,0x14
L_8eb206:
	b.d L_8ebb98
L_8eb20a:
	mov_s r0,r13
L_8eb20c:
	ld_s r0,[r14,0x8]
L_8eb20e:
	add_s r1,sp,0x8
L_8eb210:
	st_s r0,[sp,0x8]
L_8eb212:
	ld_s r0,[r14,0xc]
L_8eb214:
	st_s r0,[sp,0xc]
L_8eb216:
	ld_s r0,[r14,0x10]
L_8eb218:
	st_s r0,[sp,0x10]
L_8eb21a:
	bl.d L_8cf8c0
L_8eb21e:
	ldb_s r0,[r14,0x4]
L_8eb220:
	b L_8ebb94
L_8eb224:
	bl L_8cfeec
L_8eb228:
	b L_8eb9c4
L_8eb22c:
	bl L_8cff3c
L_8eb230:
	b L_8eb9c4
L_8eb234:
	ldb_s r0,[r14,0x4]
L_8eb236:
	ldb_s r1,[r14,0x8]
L_8eb238:
	bl.d L_8cfa24
L_8eb23c:
	ldb_s r2,[r14,0xc]
L_8eb23e:
	b L_8ebb94
L_8eb242:
	ldb_s r0,[r14,0x4]
L_8eb244:
	bl.d L_8cff68
L_8eb248:
	ldb_s r1,[r14,0x8]
L_8eb24a:
	b L_8ebb94
L_8eb24e:
	ldb_s r0,[r14,0x4]
L_8eb250:
	ldb_s r1,[r14,0x8]
L_8eb252:
	bl.d L_8ceb2c
L_8eb256:
	ldb_s r2,[r14,0xc]
L_8eb258:
	b L_8ebb94
L_8eb25c:
	ld_s r0,[r14,0x4]
L_8eb25e:
	bl.d L_8cfef8
L_8eb262:
	ldb_s r1,[r14,0x8]
L_8eb264:
	b L_8ebb94
L_8eb268:
	ld_s r0,[r14,0x4]
L_8eb26a:
	bl.d L_8cf5a8
L_8eb26e:
	ldb_s r1,[r14,0x8]
L_8eb270:
	b L_8ebb94
L_8eb274:
	bl.d L_8cf91c
L_8eb278:
	ld_s r0,[r14,0x4]
L_8eb27a:
	b L_8ebb94
L_8eb27e:
	ldb_s r0,[r14,0x4]
L_8eb280:
	ldb_s r1,[r14,0x8]
L_8eb282:
	ldb_s r2,[r14,0xc]
L_8eb284:
	bl.d L_8ceee0
L_8eb288:
	ldb_s r3,[r14,0x10]
L_8eb28a:
	b L_8ebb94
L_8eb28e:
	ldb_s r0,[r14,0x4]
L_8eb290:
	ldb_s r1,[r14,0x8]
L_8eb292:
	bl.d L_8cefdc
L_8eb296:
	ldb.x r2,[r14, 0xc]
L_8eb29a:
	b L_8ebb94
L_8eb29e:
	bl L_8cefc8
L_8eb2a2:
	b L_8ebb94
L_8eb2a6:
	ldb_s r0,[r14,0x4]
L_8eb2a8:
	ldb_s r1,[r14,0x8]
L_8eb2aa:
	bl.d L_8cefa0
L_8eb2ae:
	ldb_s r2,[r14,0xc]
L_8eb2b0:
	b L_8ebb94
L_8eb2b4:
	bl L_8cf900
L_8eb2b8:
	b L_8ebb94
L_8eb2bc:
	ldb_s r0,[r14,0x4]
L_8eb2be:
	ldb_s r1,[r14,0x8]
L_8eb2c0:
	ldb_s r2,[r14,0xc]
L_8eb2c2:
	bl.d L_8cef50
L_8eb2c6:
	ldb_s r3,[r14,0x10]
L_8eb2c8:
	b L_8ebb94
L_8eb2cc:
	ldb r4,[r14, 0x14]
L_8eb2d0:
	ldb_s r0,[r14,0x4]
L_8eb2d2:
	ldb_s r1,[r14,0x8]
L_8eb2d4:
	ldb_s r2,[r14,0xc]
L_8eb2d6:
	bl.d L_8cf19c
L_8eb2da:
	ldb_s r3,[r14,0x10]
L_8eb2dc:
	b L_8ebb94
L_8eb2e0:
	ldb_s r0,[r14,0x4]
L_8eb2e2:
	ldb_s r1,[r14,0x8]
L_8eb2e4:
	ldb_s r2,[r14,0xc]
L_8eb2e6:
	bl.d L_8cf418
L_8eb2ea:
	ldb_s r3,[r14,0x10]
L_8eb2ec:
	b L_8ebb94
L_8eb2f0:
	ldb_s r0,[r14,0x4]
L_8eb2f2:
	ldb_s r1,[r14,0x8]
L_8eb2f4:
	ldb_s r2,[r14,0xc]
L_8eb2f6:
	bl.d L_8cf36c
L_8eb2fa:
	ldb_s r3,[r14,0x10]
L_8eb2fc:
	b L_8ebb94
L_8eb300:
	ldb_s r0,[r14,0x4]
L_8eb302:
	bl.d L_8cf3e0
L_8eb306:
	ldb_s r1,[r14,0x8]
L_8eb308:
	b L_8ebb94
L_8eb30c:
	ldb_s r0,[r14,0x4]
L_8eb30e:
	ldb_s r1,[r14,0x8]
L_8eb310:
	bl.d L_8cf0f8
L_8eb314:
	ldb_s r2,[r14,0xc]
L_8eb316:
	b L_8ebb94
L_8eb31a:
	ldb_s r0,[r14,0x4]
L_8eb31c:
	bl.d L_8cf15c
L_8eb320:
	ldb_s r1,[r14,0x8]
L_8eb322:
	b L_8ebb94
L_8eb326:
	add_s r1,sp,0x8
L_8eb328:
	bl.d L_8cff4c
L_8eb32c:
	ldb_s r0,[r14,0x4]
L_8eb32e:
	ld_s r1,[sp,0x8]
	.global L_8eb330
L_8eb330:
	b.d L_8eb9c8
L_8eb334:
	st r1,[r16, 0x8]
L_8eb338:
	ldb_s r0,[r14,0x4]
L_8eb33a:
	bl.d L_8cfc80
L_8eb33e:
	ldb_s r1,[r14,0x8]
L_8eb340:
	b L_8ebb94
L_8eb344:
	ldb_s r0,[r14,0x4]
L_8eb346:
	bl.d L_8cfe24
L_8eb34a:
	ldb_s r1,[r14,0x8]
L_8eb34c:
	b L_8ebb94
L_8eb350:
	ldb_s r0,[r14,0x4]
L_8eb352:
	ldb_s r1,[r14,0x8]
L_8eb354:
	bl.d L_8cfdbc
L_8eb358:
	ldb_s r2,[r14,0xc]
L_8eb35a:
	b L_8ebb94
L_8eb35e:
	ldb_s r0,[r14,0x4]
L_8eb360:
	ldb_s r1,[r14,0x8]
L_8eb362:
	bl.d L_8cfd50
L_8eb366:
	ldb_s r2,[r14,0xc]
L_8eb368:
	b L_8ebb94
L_8eb36c:
	ldb_s r0,[r14,0x4]
L_8eb36e:
	ldb_s r1,[r14,0x8]
L_8eb370:
	bl.d L_8cfcb4
L_8eb374:
	ldb_s r2,[r14,0xc]
L_8eb376:
	b L_8ebb94
L_8eb37a:
	ldb_s r0,[r14,0x4]
L_8eb37c:
	bl.d L_8cfd18
L_8eb380:
	ldb_s r1,[r14,0x8]
L_8eb382:
	b L_8ebb94
L_8eb386:
	ldb_s r0,[r14,0x4]
L_8eb388:
	bl.d L_8cfe9c
L_8eb38c:
	ldb_s r1,[r14,0x8]
L_8eb38e:
	b L_8ebb94
L_8eb392:
	ldb_s r0,[r14,0x4]
L_8eb394:
	bl.d L_8cfe5c
L_8eb398:
	ldb_s r1,[r14,0x8]
L_8eb39a:
	b L_8ebb94
	.global L_8eb39e
L_8eb39e:
	ldb_s r0,[r14,0x4]
L_8eb3a0:
	bl.d L_8cfc0c
L_8eb3a4:
	ldb_s r1,[r14,0x8]
L_8eb3a6:
	b L_8ebb94
	.global L_8eb3aa
L_8eb3aa:
	mov_s r1,0x101f254
L_8eb3b0:
	ld r4,[r14, 0xc]
L_8eb3b4:
	mov_s r0,0x0
L_8eb3b6:
	mov_s r2,r18
L_8eb3b8:
	bl.d L_8dcd00
L_8eb3bc:
	ld_s r3,[r14,0x8]
L_8eb3be:
	mov_s r0,r18
L_8eb3c0:
	ld_s r1,[r14,0x8]
L_8eb3c2:
	bl.d L_8cfadc
L_8eb3c6:
	ld_s r2,[r14,0xc]
L_8eb3c8:
	b L_8ebb94
L_8eb3cc:
	bl.d L_8cfaac
L_8eb3d0:
	ld_s r0,[r14,0x4]
L_8eb3d2:
	b L_8ebb94
L_8eb3d6:
	bl.d L_8cf9e4
L_8eb3da:
	ld_s r0,[r14,0x4]
L_8eb3dc:
	b L_8ebb94
L_8eb3e0:
	bl.d L_8cfaa0
L_8eb3e4:
	ld_s r0,[r14,0x4]
L_8eb3e6:
	b L_8ebb94
L_8eb3ea:
	bl L_8cf9b0
L_8eb3ee:
	b L_8eb9c4
L_8eb3f2:
	bl L_8cf948
L_8eb3f6:
	b L_8eb9c4
L_8eb3fa:
	bl L_8cf59c
L_8eb3fe:
	b L_8eb9c4
L_8eb402:
	bl L_8cf5ec
L_8eb406:
	b L_8eb9c4
L_8eb40a:
	bl.d L_8cee2c
L_8eb40e:
	ldb_s r0,[r14,0x4]
L_8eb410:
	b L_8ebb94
L_8eb414:
	bl L_8ceec0
L_8eb418:
	b L_8eb9c4
	.global L_8eb41c
L_8eb41c:
	bl.d L_8cee94
L_8eb420:
	ldb_s r0,[r14,0x4]
L_8eb422:
	b L_8ebb94
L_8eb426:
	bl L_8ceed0
L_8eb42a:
	b L_8eb9c4
L_8eb42e:
	ldb_s r0,[r14,0x4]
L_8eb430:
	ldb_s r1,[r14,0x8]
L_8eb432:
	ldb_s r2,[r14,0xc]
L_8eb434:
	bl.d L_8cf250
L_8eb438:
	ldb_s r3,[r14,0x10]
L_8eb43a:
	b L_8ebb94
L_8eb43e:
	ldb_s r0,[r14,0x4]
L_8eb440:
	ldb_s r1,[r14,0x8]
L_8eb442:
	bl.d L_8cf640
L_8eb446:
	ldb_s r2,[r14,0xc]
L_8eb448:
	b L_8eb9c4
L_8eb44c:
	ldb_s r0,[r14,0x4]
L_8eb44e:
	ldb_s r1,[r14,0x8]
L_8eb450:
	bl.d L_8cf4f8
L_8eb454:
	ldb_s r2,[r14,0xc]
L_8eb456:
	b L_8ebb94
L_8eb45a:
	ldb_s r0,[r14,0x4]
L_8eb45c:
	bl.d L_8cf848
L_8eb460:
	ldb_s r1,[r14,0x8]
L_8eb462:
	b L_8eb9c4
L_8eb466:
	ld_s r0,[r14,0x4]
L_8eb468:
	bl.d L_8ce534
L_8eb46c:
	ld_s r1,[r14,0x8]
L_8eb46e:
	b L_8ebb94
L_8eb472:
	ldb_s r0,[r14,0x4]
L_8eb474:
	ldb_s r1,[r14,0x8]
L_8eb476:
	bl.d L_8cf788
L_8eb47a:
	ldb_s r2,[r14,0xc]
L_8eb47c:
	b L_8eb9c4
L_8eb480:
	bl L_8cfed8
L_8eb484:
	b L_8ebb94
L_8eb488:
	bl L_8cf588
L_8eb48c:
	b L_8ebb94
	.global L_8eb490
L_8eb490:
	ld_s r0,[r14,0x8]
L_8eb492:
	add_s r1,sp,0xc
L_8eb494:
	stb_s r0,[sp,0xc]
L_8eb496:
	ld_s r0,[r14,0xc]
L_8eb498:
	stb r0,[sp, 0xd]
L_8eb49c:
	ld_s r0,[r14,0x10]
L_8eb49e:
	stb r0,[sp, 0xe]
L_8eb4a2:
	ld_s r0,[r14,0x14]
L_8eb4a4:
	stb r0,[sp, 0xf]
L_8eb4a8:
	bl.d L_8cf0ac
L_8eb4ac:
	ldb_s r0,[r14,0x4]
L_8eb4ae:
	b L_8ebb94
L_8eb4b2:
	ld_s r0,[r14,0xc]
L_8eb4b4:
	add_s r2,sp,0xc
L_8eb4b6:
	stb_s r0,[sp,0xc]
L_8eb4b8:
	ld_s r0,[r14,0x10]
L_8eb4ba:
	stb r0,[sp, 0xd]
L_8eb4be:
	ld_s r0,[r14,0x14]
L_8eb4c0:
	stb r0,[sp, 0xe]
L_8eb4c4:
	ld_s r0,[r14,0x18]
L_8eb4c6:
	stb r0,[sp, 0xf]
L_8eb4ca:
	ldb_s r0,[r14,0x4]
L_8eb4cc:
	bl.d L_8cf080
L_8eb4d0:
	ldb_s r1,[r14,0x8]
L_8eb4d2:
	b L_8ebb94
L_8eb4d6:
	ldb_s r0,[r14,0x4]
L_8eb4d8:
	ldb_s r1,[r14,0x8]
L_8eb4da:
	bl.d L_8cf550
L_8eb4de:
	ldb_s r2,[r14,0xc]
L_8eb4e0:
	b L_8ebb94
L_8eb4e4:
	ldb_s r0,[r14,0x4]
L_8eb4e6:
	ldb_s r1,[r14,0x8]
L_8eb4e8:
	ldb_s r2,[r14,0xc]
L_8eb4ea:
	bl.d L_8cf33c
L_8eb4ee:
	ldb_s r3,[r14,0x10]
L_8eb4f0:
	b L_8ebb94
L_8eb4f4:
	bl.d L_8ce838
L_8eb4f8:
	ldb_s r0,[r14,0x4]
L_8eb4fa:
	b L_8ebb94
L_8eb4fe:
	ld_s r0,[r14,0x4]
L_8eb500:
	bl.d L_8ce89c
L_8eb504:
	ldb_s r1,[r14,0x8]
L_8eb506:
	b L_8ebb94
L_8eb50a:
	ldb_s r0,[r14,0x4]
L_8eb50c:
	bl.d L_8ce910
L_8eb510:
	mov_s r1,0x0
L_8eb512:
	b L_8ebb94
	.global L_8eb516
L_8eb516:
	bl L_8ce9c4
L_8eb51a:
	b L_8eb9c4
L_8eb51e:
	bl.d L_8ce6b8
L_8eb522:
	ldb_s r0,[r14,0x4]
L_8eb524:
	b L_8ebb94
L_8eb528:
	bl.d L_8ce794
L_8eb52c:
	ldb_s r0,[r14,0x4]
L_8eb52e:
	b L_8ebb94
L_8eb532:
	ld_s r0,[r14,0x4]
L_8eb534:
	bl.d L_8ce6fc
L_8eb538:
	ldb_s r1,[r14,0x8]
L_8eb53a:
	b L_8ebb94
L_8eb53e:
	bl.d L_8ce9d4
L_8eb542:
	ldb_s r0,[r14,0x4]
L_8eb544:
	b L_8ebb94
	.global L_8eb548
L_8eb548:
	ld_s r0,[r14,0x4]
L_8eb54a:
	bl.d L_8cebdc
L_8eb54e:
	ldb_s r1,[r14,0x8]
L_8eb550:
	b L_8ebb94
	.global L_8eb554
L_8eb554:
	bl L_8d03ec
L_8eb558:
	b L_8ebb94
	.global L_8eb55c
L_8eb55c:
	bl L_8d03d8
L_8eb560:
	b L_8ebb94
L_8eb564:
	bl.d L_8d1008
L_8eb568:
	ldb_s r0,[r14,0x4]
L_8eb56a:
	b L_8ebb94
L_8eb56e:
	bl L_8d0ff8
L_8eb572:
	b L_8ebb94
L_8eb576:
	bl L_8d0fe0
L_8eb57a:
	b L_8ebb94
L_8eb57e:
	bl L_8d1044
L_8eb582:
	b L_8ebb94
L_8eb586:
	bl.d L_8db5bc
L_8eb58a:
	ld_s r0,[r14,0x4]
L_8eb58c:
	b L_8ebb94
	.global L_8eb590
L_8eb590:
	bl L_8d2be4
L_8eb594:
	b L_8ebb94
L_8eb598:
	bl L_8d2ba4
L_8eb59c:
	b L_8ebb94
L_8eb5a0:
	bl L_8d2b38
L_8eb5a4:
	b L_8ebb94
L_8eb5a8:
	bl.d L_8d2b0c
L_8eb5ac:
	ld_s r0,[r14,0x4]
L_8eb5ae:
	b L_8ebb94
L_8eb5b2:
	bl.d L_8d1bc0
L_8eb5b6:
	ld_s r0,[r14,0x4]
L_8eb5b8:
	b L_8ebb94
L_8eb5bc:
	bl.d L_8d21d0
L_8eb5c0:
	ld_s r0,[r14,0x4]
L_8eb5c2:
	b L_8ebb94
L_8eb5c6:
	ldw_s r0,[r14,0x4]
L_8eb5c8:
	ld_s r1,[r14,0x8]
L_8eb5ca:
	ldb_s r2,[r14,0xc]
L_8eb5cc:
	bl.d L_8d2f88
L_8eb5d0:
	ld_s r3,[r14,0x10]
L_8eb5d2:
	b L_8ebb94
L_8eb5d6:
	bl L_8d3024
L_8eb5da:
	b L_8ebb94
L_8eb5de:
	ld_s r0,[r14,0x4]
L_8eb5e0:
	ld_s r1,[r14,0x8]
L_8eb5e2:
	bl.d L_8d3090
L_8eb5e6:
	ldb_s r2,[r14,0xc]
L_8eb5e8:
	b L_8ebb94
L_8eb5ec:
	bl.d L_8d3100
L_8eb5f0:
	ld_s r0,[r14,0x4]
L_8eb5f2:
	b L_8ebb94
L_8eb5f6:
	ldb_s r0,[r14,0x4]
L_8eb5f8:
	ld_s r1,[r14,0x8]
L_8eb5fa:
	bl.d L_8d2d40
L_8eb5fe:
	ld_s r2,[r14,0xc]
L_8eb600:
	b L_8ebb94
L_8eb604:
	bl L_8d2e18
L_8eb608:
	b L_8ebb94
L_8eb60c:
	ld_s r0,[r14,0x4]
L_8eb60e:
	ldw_s.x r1,[r14,0x8]
L_8eb610:
	bl.d L_8d2f1c
L_8eb614:
	ldw_s.x r2,[r14,0xc]
L_8eb616:
	b L_8ebb94
L_8eb61a:
	ld_s r0,[r14,0x4]
L_8eb61c:
	ldb_s r1,[r14,0x8]
L_8eb61e:
	bl.d L_8d2e48
L_8eb622:
	ldb_s r2,[r14,0xc]
L_8eb624:
	b L_8ebb94
L_8eb628:
	ld_s r0,[r14,0x4]
L_8eb62a:
	ldw_s.x r1,[r14,0x8]
L_8eb62c:
	bl.d L_8d2eb8
L_8eb630:
	ldw_s.x r2,[r14,0xc]
L_8eb632:
	b L_8ebb94
L_8eb636:
	bl.d L_8d219c
L_8eb63a:
	ld_s r0,[r14,0x4]
L_8eb63c:
	b L_8ebb94
L_8eb640:
	ld_s r0,[r14,0x4]
L_8eb642:
	brhs r0,0x4,L_8eb650
	.global L_8eb646
L_8eb646:
	bl.d L_8d2630
L_8eb64a:
	ld_s r0,[r14,0x4]
L_8eb64c:
	b L_8eb842
	.global L_8eb650
L_8eb650:
	mov_s r0,blink
L_8eb652:
	mov_s r1,0xd
L_8eb654:
	bl.d L_8c9b28
L_8eb658:
	bset_s r1,r1,0xc
L_8eb65a:
	b_s L_8eb646
L_8eb65c:
	bl.d L_8d2260
L_8eb660:
	ld_s r0,[r14,0x4]
L_8eb662:
	b L_8ebb94
L_8eb666:
	ld_s r0,[r14,0x4]
L_8eb668:
	bl.d L_8d2218
L_8eb66c:
	ldb_s r1,[r14,0x8]
L_8eb66e:
	b L_8ebb94
L_8eb672:
	ld_s r0,[r14,0x4]
L_8eb674:
	/* bl.d 0x008d24fc */
	.byte 0x8a,0x0e,0x6f,0xf3
L_8eb678:
	/* _sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8eb67a:
	b L_8ebb94
L_8eb67e:
	bl.d L_8d26d0
L_8eb682:
	ld_s r0,[r14,0x4]
L_8eb684:
	b L_8ebb94
L_8eb688:
	bl.d L_8d2700
L_8eb68c:
	ld_s r0,[r14,0x4]
L_8eb68e:
	b L_8ebb94
L_8eb692:
	ldb_s r0,[r14,0x4]
L_8eb694:
	ldb_s r1,[r14,0x8]
L_8eb696:
	bl.d L_8d2784
L_8eb69a:
	ldb.x r2,[r14, 0xc]
L_8eb69e:
	b L_8ebb94
L_8eb6a2:
	bl.d L_8d2758
L_8eb6a6:
	ld_s r0,[r14,0x4]
L_8eb6a8:
	b L_8ebb94
L_8eb6ac:
	ldb.x r0,[r14, 0x4]
L_8eb6b0:
	bl.d L_8d2728
L_8eb6b4:
	ldb.x r1,[r14, 0x8]
L_8eb6b8:
	b L_8ebb94
L_8eb6bc:
	ld_s r0,[r14,0x4]
L_8eb6be:
	brhs r0,0x8,L_8eb6d8
	.global L_8eb6c2
L_8eb6c2:
	ldw r4,[r14, 0x14]
L_8eb6c6:
	ldb r5,[r14, 0x18]
L_8eb6ca:
	ld_s r0,[r14,0x4]
L_8eb6cc:
	ldb_s r1,[r14,0x8]
L_8eb6ce:
	ldb_s r2,[r14,0xc]
L_8eb6d0:
	bl.d L_8d1df0
L_8eb6d4:
	ldw_s r3,[r14,0x10]
L_8eb6d6:
	b_s L_8eb842
	.global L_8eb6d8
L_8eb6d8:
	mov_s r0,blink
L_8eb6da:
	mov_s r1,0x16
L_8eb6dc:
	bl.d L_8c9b28
L_8eb6e0:
	bset_s r1,r1,0xc
L_8eb6e2:
	b_s L_8eb6c2
L_8eb6e4:
	bl L_8d1e34
L_8eb6e8:
	b L_8ebb94
L_8eb6ec:
	bl L_8d1e58
L_8eb6f0:
	b.d L_8ebb98
L_8eb6f4:
	mov_s r2,r15
L_8eb6f6:
	add_s r1,sp,0xc
L_8eb6f8:
	bl.d L_8d1d94
L_8eb6fc:
	ldb_s r0,[r14,0x4]
L_8eb6fe:
	b.d L_8eb330
L_8eb702:
	ld_s r1,[sp,0xc]
L_8eb704:
	add_s r1,sp,0xc
L_8eb706:
	bl.d L_8d1dc8
L_8eb70a:
	ldb_s r0,[r14,0x4]
L_8eb70c:
	b.d L_8eb330
L_8eb710:
	ld_s r1,[sp,0xc]
L_8eb712:
	bl L_8d2b00
L_8eb716:
	b L_8ebb94
L_8eb71a:
	bl L_8d2ae4
L_8eb71e:
	b L_8ebb94
L_8eb722:
	add_s r14,sp,0xc
L_8eb724:
	bl.d L_8d25e8
L_8eb728:
	mov_s r0,r14
L_8eb72a:
	add r0,r16,0x8
L_8eb72e:
	mov_s r1,r14
L_8eb730:
	bl.d L_8c0380
L_8eb734:
	mov_s r2,0x38
L_8eb736:
	mov_s r2,0x40
L_8eb738:
	b.d L_8ebb98
L_8eb73c:
	mov_s r0,r13
L_8eb73e:
	ld_s r0,[r14,0x4]
L_8eb740:
	ldb_s r1,[r14,0x8]
L_8eb742:
	bl.d L_8d2418
L_8eb746:
	ld_s r2,[r14,0xc]
L_8eb748:
	b L_8ebb94
L_8eb74c:
	bl.d L_8d23a0
L_8eb750:
	add_s r0,sp,0xc
L_8eb752:
	ld_s r1,[sp,0x10]
L_8eb754:
	mov_s r0,r16
L_8eb756:
	ld_s r2,[sp,0xc]
L_8eb758:
	st_s r2,[r0,0x8]
	.global L_8eb75a
L_8eb75a:
	st_s r1,[r0,0xc]
	.global L_8eb75c
L_8eb75c:
	mov_s r2,0x10
L_8eb75e:
	b.d L_8ebb98
L_8eb762:
	mov_s r0,0x1
L_8eb764:
	ld_s r0,[r14,0x4]
L_8eb766:
	brhs r0,0x8,L_8eb780
	.global L_8eb76a
L_8eb76a:
	ld r4,[r14, 0x10]
L_8eb76e:
	mov_s r0,0x1
L_8eb770:
	ld r5,[r14, 0x14]
L_8eb774:
	ld_s r1,[r14,0x4]
L_8eb776:
	ldb_s r2,[r14,0x8]
L_8eb778:
	bl.d L_8d28ec
L_8eb77c:
	ldb_s r3,[r14,0xc]
L_8eb77e:
	b_s L_8eb842
	.global L_8eb780
L_8eb780:
	mov_s r0,blink
L_8eb782:
	mov_s r1,0x1f
L_8eb784:
	bl.d L_8c9b28
L_8eb788:
	bset_s r1,r1,0xc
L_8eb78a:
	b_s L_8eb76a
L_8eb78c:
	bl L_8d2958
L_8eb790:
	b L_8ebb94
L_8eb794:
	bl L_8d2920
L_8eb798:
	b L_8ebb94
L_8eb79c:
	ldb_s r0,[r14,0x4]
L_8eb79e:
	add_s r15,sp,0x14
L_8eb7a0:
	bl.d L_8d2474
L_8eb7a4:
	mov_s r1,r15
L_8eb7a6:
	add r0,r16,0x8
L_8eb7aa:
	mov_s r1,r15
L_8eb7ac:
	bl.d L_8c0380
L_8eb7b0:
	mov_s r2,0x10
	.global L_8eb7b2
L_8eb7b2:
	mov_s r2,0x18
L_8eb7b4:
	b.d L_8ebb98
L_8eb7b8:
	mov_s r0,r13
L_8eb7ba:
	ldb_s r0,[r14,0x4]
L_8eb7bc:
	add_s r15,sp,0x14
L_8eb7be:
	bl.d L_8d24bc
L_8eb7c2:
	mov_s r1,r15
L_8eb7c4:
	add r0,r16,0x8
L_8eb7c8:
	mov_s r1,r15
L_8eb7ca:
	bl.d L_8c0380
L_8eb7ce:
	mov_s r2,0x10
L_8eb7d0:
	b_s L_8eb7b2
	.global L_8eb7d2
L_8eb7d2:
	add_s r1,sp,0x14
L_8eb7d4:
	bl.d L_8d2968
L_8eb7d8:
	ld_s r0,[r14,0x4]
L_8eb7da:
	b.d L_8eb330
L_8eb7de:
	ld_s r1,[sp,0x14]
L_8eb7e0:
	ldw.x r4,[r14, 0x14]
L_8eb7e4:
	add r18,sp,0x14
L_8eb7e8:
	ldw.x r5,[r14, 0x18]
L_8eb7ec:
	ldb_s r0,[r14,0x4]
L_8eb7ee:
	ldw_s.x r1,[r14,0x8]
L_8eb7f0:
	ldw_s.x r2,[r14,0xc]
L_8eb7f2:
	ldw_s.x r3,[r14,0x10]
L_8eb7f4:
	bl.d L_8d2314
L_8eb7f8:
	mov r6,r18
L_8eb7fc:
	add r0,r16,0x8
L_8eb800:
	mov_s r1,r18
L_8eb802:
	bl.d L_8c0380
L_8eb806:
	mov_s r2,0xc
L_8eb808:
	b L_8eb204
L_8eb80c:
	ld_s r0,[r14,0x10]
L_8eb80e:
	brhs r0,0xd,L_8eb82a
	.global L_8eb812
L_8eb812:
	ld_s r0,[r14,0x14]
L_8eb814:
	brhs r0,0x20,L_8eb836
	.global L_8eb818
L_8eb818:
	ld r4,[r14, 0x14]
L_8eb81c:
	ldb_s r0,[r14,0x4]
L_8eb81e:
	ld_s r1,[r14,0x8]
L_8eb820:
	ld_s r2,[r14,0xc]
L_8eb822:
	bl.d L_8d1fc8
L_8eb826:
	ld_s r3,[r14,0x10]
L_8eb828:
	b_s L_8eb842
	.global L_8eb82a
L_8eb82a:
	mov_s r0,blink
L_8eb82c:
	mov_s r1,0x25
L_8eb82e:
	bl.d L_8c9b28
L_8eb832:
	bset_s r1,r1,0xc
L_8eb834:
	b_s L_8eb812
	.global L_8eb836
L_8eb836:
	mov_s r0,blink
L_8eb838:
	mov_s r1,0x2e
L_8eb83a:
	bl.d L_8c9b28
L_8eb83e:
	bset_s r1,r1,0xc
L_8eb840:
	b_s L_8eb818
	.global L_8eb842
L_8eb842:
	mov_s r2,0x8
L_8eb844:
	b.d L_8ebb98
L_8eb848:
	mov_s r0,0x1
L_8eb84a:
	ld_s r0,[r14,0x4]
L_8eb84c:
	add_s r13,sp,0x20
L_8eb84e:
	ld_s r1,[r14,0x8]
L_8eb850:
	bl.d L_8d1f24
L_8eb854:
	mov_s r2,r13
L_8eb856:
	add r0,r16,0x8
L_8eb85a:
	mov_s r1,r13
L_8eb85c:
	bl.d L_8c0380
L_8eb860:
	mov_s r2,0x88
L_8eb862:
	ld_s r0,[sp,0x20]
L_8eb864:
	mov_s r2,0x90
L_8eb866:
	cmp_s r0,0x1
L_8eb868:
	mov_s r0,0x1
L_8eb86a:
	b.d L_8ebb98
L_8eb86e:
	sub_s.ne r0,r0,r0
L_8eb870:
	add_s r0,sp,0x20
L_8eb872:
	bl.d L_8c1cd8
L_8eb876:
	mov_s r1,0x4
L_8eb878:
	bl.d L_8d1b28
L_8eb87c:
	add_s r0,sp,0x20
L_8eb87e:
	b.d L_8eb330
L_8eb882:
	ld_s r1,[sp,0x20]
L_8eb884:
	bl L_8d2d10
L_8eb888:
	b L_8ebb94
L_8eb88c:
	bl.d L_8d2c98
L_8eb890:
	ld_s r0,[r14,0x4]
L_8eb892:
	b L_8ebb94
L_8eb896:
	bl.d L_8d2c1c
L_8eb89a:
	ld_s r0,[r14,0x4]
L_8eb89c:
	b L_8ebb94
L_8eb8a0:
	bl L_8d263c
L_8eb8a4:
	b_s L_8eb9c4
L_8eb8a6:
	bl L_8d1c20
L_8eb8aa:
	b_s L_8eb9c4
L_8eb8ac:
	bl L_8d1e48
L_8eb8b0:
	b L_8ebb94
L_8eb8b4:
	bl L_8d1de0
L_8eb8b8:
	b L_8ebb94
L_8eb8bc:
	ldb r4,[r14, 0x14]
L_8eb8c0:
	ldb_s r0,[r14,0x4]
L_8eb8c2:
	ldb_s r1,[r14,0x8]
L_8eb8c4:
	ldb_s r2,[r14,0xc]
L_8eb8c6:
	bl.d L_8d2a50
L_8eb8ca:
	ldb_s r3,[r14,0x10]
L_8eb8cc:
	b_s L_8eb9c4
L_8eb8ce:
	bl L_8d46ac
L_8eb8d2:
	bl.d L_8d46a0
L_8eb8d6:
	st_s r0,[sp,0x24]
L_8eb8d8:
	ld_s r2,[sp,0x24]
L_8eb8da:
	st_s r0,[sp,0x28]
L_8eb8dc:
	st r2,[r16, 0x8]
L_8eb8e0:
	st r0,[r16, 0xc]
L_8eb8e4:
	b_s L_8eb75c
	.global L_8eb8e6
L_8eb8e6:
	bl.d L_8d31dc
L_8eb8ea:
	ld_s r0,[r14,0x4]
L_8eb8ec:
	b L_8ebb94
	.global L_8eb8f0
L_8eb8f0:
	ldb_s r0,[r14,0x4]
L_8eb8f2:
	ldb_s r1,[r14,0x8]
L_8eb8f4:
	ld_s r2,[r14,0xc]
L_8eb8f6:
	bl.d L_8d415c
L_8eb8fa:
	ld_s r3,[r14,0x10]
L_8eb8fc:
	b L_8ebb94
L_8eb900:
	ld_s r1,[r14,0x4]
L_8eb902:
	mov_s r0,0x0
L_8eb904:
	bl.d L_8d4308
L_8eb908:
	ld_s r2,[r14,0x8]
L_8eb90a:
	b L_8ebb94
L_8eb90e:
	mov_s r0,0x0
L_8eb910:
	bl.d L_8d3588
L_8eb914:
	ld_s r1,[r14,0x4]
L_8eb916:
	b_s L_8eb9c4
L_8eb918:
	mov_s r0,0x0
L_8eb91a:
	bl.d L_8d37dc
L_8eb91e:
	ldb_s r1,[r14,0x4]
L_8eb920:
	b L_8ebb94
L_8eb924:
	mov_s r0,0x0
L_8eb926:
	bl.d L_8d40d8
L_8eb92a:
	ldb_s r1,[r14,0x4]
L_8eb92c:
	b L_8ebb94
L_8eb930:
	ldb_s r1,[r14,0x4]
L_8eb932:
	mov_s r0,0x0
L_8eb934:
	bl.d L_8d3808
L_8eb938:
	ldb_s r2,[r14,0x8]
L_8eb93a:
	b L_8ebb94
L_8eb93e:
	ldb_s r1,[r14,0x4]
L_8eb940:
	mov_s r0,0x0
L_8eb942:
	bl.d L_8d4104
L_8eb946:
	ldb_s r2,[r14,0x8]
L_8eb948:
	b L_8ebb94
L_8eb94c:
	bl.d L_8d33ec
L_8eb950:
	mov_s r0,0x0
L_8eb952:
	b L_8ebb94
L_8eb956:
	ld_s r0,[r14,0x4]
L_8eb958:
	brne r0,0x1,L_8eb964
L_8eb95c:
	bl.d L_8d33f8
L_8eb960:
	mov_s r0,0x0
L_8eb962:
	b_s L_8eb968
	.global L_8eb964
L_8eb964:
	bl L_8d3460
	.global L_8eb968
L_8eb968:
	mov_s r0,0x1
L_8eb96a:
	b.d L_8ebb98
L_8eb96e:
	mov_s r2,0x8
L_8eb970:
	bl.d L_8d37a8
L_8eb974:
	mov_s r0,0x0
L_8eb976:
	b L_8ebb94
L_8eb97a:
	ldb r4,[r14, 0x14]
L_8eb97e:
	ldb r5,[r14, 0x18]
L_8eb982:
	ldb_s r0,[r14,0x4]
L_8eb984:
	ldb_s r1,[r14,0x8]
L_8eb986:
	ldb_s r2,[r14,0xc]
L_8eb988:
	bl.d L_8d39f8
L_8eb98c:
	ldb_s r3,[r14,0x10]
L_8eb98e:
	b L_8ebb94
	.global L_8eb992
L_8eb992:
	ldb_s r0,[r14,0x4]
L_8eb994:
	ldb_s r1,[r14,0x8]
L_8eb996:
	ldb_s r2,[r14,0xc]
L_8eb998:
	bl.d L_8d3954
L_8eb99c:
	ldb_s r3,[r14,0x10]
L_8eb99e:
	b_s L_8eb9c4
L_8eb9a0:
	ldb r4,[r14, 0x14]
L_8eb9a4:
	ldb r5,[r14, 0x18]
L_8eb9a8:
	ldb_s r0,[r14,0x4]
L_8eb9aa:
	ldb_s r1,[r14,0x8]
L_8eb9ac:
	ldb_s r2,[r14,0xc]
L_8eb9ae:
	bl.d L_8d3c04
L_8eb9b2:
	ldb_s r3,[r14,0x10]
L_8eb9b4:
	b L_8ebb94
L_8eb9b8:
	ldb_s r0,[r14,0x4]
L_8eb9ba:
	ldb_s r1,[r14,0x8]
L_8eb9bc:
	ldb_s r2,[r14,0xc]
L_8eb9be:
	bl.d L_8d3b90
L_8eb9c2:
	ldb_s r3,[r14,0x10]
	.global L_8eb9c4
L_8eb9c4:
	st r0,[r16, 0x8]
	.global L_8eb9c8
L_8eb9c8:
	mov_s r2,r19
L_8eb9ca:
	mov_s r0,r13
L_8eb9cc:
	b_s L_8ebb98
L_8eb9ce:
	ldb r4,[r14, 0x14]
L_8eb9d2:
	ldb r5,[r14, 0x18]
L_8eb9d6:
	ldb_s r0,[r14,0x4]
L_8eb9d8:
	ldb_s r1,[r14,0x8]
L_8eb9da:
	ldb_s r2,[r14,0xc]
L_8eb9dc:
	bl.d L_8d3888
L_8eb9e0:
	ldb_s r3,[r14,0x10]
L_8eb9e2:
	b_s L_8ebb94
L_8eb9e4:
	ldb_s r0,[r14,0x4]
L_8eb9e6:
	ldb_s r1,[r14,0x8]
L_8eb9e8:
	ldb_s r2,[r14,0xc]
L_8eb9ea:
	bl.d L_8d3850
L_8eb9ee:
	ldb_s r3,[r14,0x10]
L_8eb9f0:
	b_s L_8eb9c4
L_8eb9f2:
	ldb r4,[r14, 0x14]
L_8eb9f6:
	ldb r5,[r14, 0x18]
L_8eb9fa:
	ldb_s r0,[r14,0x4]
L_8eb9fc:
	ldb_s r1,[r14,0x8]
L_8eb9fe:
	ldb_s r2,[r14,0xc]
L_8eba00:
	bl.d L_8d3da0
L_8eba04:
	ldb_s r3,[r14,0x10]
L_8eba06:
	b_s L_8ebb94
L_8eba08:
	ldb_s r0,[r14,0x4]
L_8eba0a:
	ldb_s r1,[r14,0x8]
L_8eba0c:
	ldb_s r2,[r14,0xc]
L_8eba0e:
	bl.d L_8d3d64
L_8eba12:
	ldb_s r3,[r14,0x10]
L_8eba14:
	b_s L_8eb9c4
L_8eba16:
	ld r4,[r14, 0x14]
L_8eba1a:
	ld r5,[r14, 0x18]
L_8eba1e:
	ld_s r0,[r14,0x24]
L_8eba20:
	ld r7,[r14, 0x20]
L_8eba24:
	st_s r0,[sp,0x0]
L_8eba26:
	ldb r0,[r14, 0x28]
L_8eba2a:
	ld r6,[r14, 0x1c]
L_8eba2e:
	st_s r0,[sp,0x4]
L_8eba30:
	ldb_s r0,[r14,0x4]
L_8eba32:
	ld_s r1,[r14,0x8]
L_8eba34:
	ldb_s r2,[r14,0xc]
L_8eba36:
	bl.d L_8d4338
L_8eba3a:
	ld_s r3,[r14,0x10]
L_8eba3c:
	b_s L_8ebb94
L_8eba3e:
	add_s r0,sp,0x2c
L_8eba40:
	mov_s r1,0x80399c
L_8eba46:
	bl.d L_8c0380
L_8eba4a:
	mov_s r2,0x18
L_8eba4c:
	add_s r0,sp,0x40
L_8eba4e:
	st_s r0,[sp,0x0]
L_8eba50:
	ldb_s r0,[r14,0x4]
L_8eba52:
	add_s r3,sp,0x2c
L_8eba54:
	ld_s r1,[r14,0x8]
L_8eba56:
	add r4,sp,0x30
L_8eba5a:
	add r5,sp,0x34
L_8eba5e:
	add r6,sp,0x38
L_8eba62:
	add r7,sp,0x3c
L_8eba66:
	bl.d L_8d3678
L_8eba6a:
	ldb_s r2,[r14,0xc]
L_8eba6c:
	add r0,r16,0x8
L_8eba70:
	add_s r1,sp,0x2c
L_8eba72:
	bl.d L_8c0380
L_8eba76:
	mov_s r2,0x18
L_8eba78:
	mov_s r2,r18
L_8eba7a:
	mov_s r0,r13
L_8eba7c:
	b_s L_8ebb98
	.global L_8eba7e
L_8eba7e:
	ld_s r0,[r14,0x4]
L_8eba80:
	ld_s r1,[r14,0x8]
L_8eba82:
	bl.d L_8d4670
L_8eba86:
	ld_s r2,[r14,0xc]
L_8eba88:
	b_s L_8ebb94
	.global L_8eba8a
L_8eba8a:
	bl.d L_8f3f7c
L_8eba8e:
	ld_s r0,[r14,0x4]
L_8eba90:
	b_s L_8ebb94
L_8eba92:
	mov_s r0,0x0
L_8eba94:
	stb_s r0,[sp,0x2c]
L_8eba96:
	add_s r1,sp,0x2c
L_8eba98:
	bl.d L_8d3fb4
L_8eba9c:
	ldb_s r0,[r14,0x4]
L_8eba9e:
	b.d L_8eb330
L_8ebaa2:
	ldb_s r1,[sp,0x2c]
L_8ebaa4:
	add_s r15,sp,0x2c
L_8ebaa6:
	mov_s r0,r15
L_8ebaa8:
	mov_s r1,0x8039b4
L_8ebaae:
	bl.d L_8c0380
L_8ebab2:
	mov_s r2,0x40
L_8ebab4:
	ldb_s r0,[r14,0x4]
L_8ebab6:
	bl.d L_8d4010
L_8ebaba:
	mov_s r1,r15
L_8ebabc:
	add r0,r16,0x8
L_8ebac0:
	mov_s r1,r15
L_8ebac2:
	bl.d L_8c0380
L_8ebac6:
	mov_s r2,0x40
L_8ebac8:
	mov_s r2,0x48
L_8ebaca:
	mov_s r0,r13
L_8ebacc:
	b_s L_8ebb98
L_8ebace:
	ld_s r0,[r14,0x4]
L_8ebad0:
	bl.d L_8d4660
L_8ebad4:
	ld_s r1,[r14,0x8]
L_8ebad6:
	b_s L_8eb9c4
L_8ebad8:
	ld_s r0,[r14,0x4]
L_8ebada:
	ld_s r1,[r14,0x8]
L_8ebadc:
	bl.d L_8d4650
L_8ebae0:
	ld_s r2,[r14,0xc]
L_8ebae2:
	b_s L_8ebb94
L_8ebae4:
	ld_s r0,[r14,0x4]
L_8ebae6:
	bl.d L_8d4640
L_8ebaea:
	ld_s r1,[r14,0x8]
L_8ebaec:
	b_s L_8eb9c4
L_8ebaee:
	mov_s r0,0x0
L_8ebaf0:
	bl.d L_8d3588
L_8ebaf4:
	mov r1,0x504
L_8ebaf8:
	ld_s r1,[r14,0x4]
L_8ebafa:
	cmp_s r1,0x0
L_8ebafc:
	lsr.eq r0,r0,0x4
L_8ebb00:
	bmsk_s r0,r0,0x3
L_8ebb02:
	st r0,[r16, 0x8]
L_8ebb06:
	mov_s r2,0xc
L_8ebb08:
	mov_s r0,0x1
L_8ebb0a:
	b_s L_8ebb98
L_8ebb0c:
	ld_s r1,[r14,0x4]
L_8ebb0e:
	ld_s r0,[r14,0x8]
L_8ebb10:
	bic r0,r0,0xf
L_8ebb14:
	breq_s r1,0,L_8ebb48
L_8ebb16:
	brne_s r0,0,L_8ebb2a
	.global L_8ebb18
L_8ebb18:
	mov_s r0,0x0
L_8ebb1a:
	bl.d L_8d3588
L_8ebb1e:
	mov r1,0x504
L_8ebb22:
	bic r2,r0,0xf
L_8ebb26:
	ld_s r3,[r14,0x8]
L_8ebb28:
	b_s L_8ebb38
	.global L_8ebb2a
L_8ebb2a:
	mov_s r0,blink
L_8ebb2c:
	mov_s r1,0x1545
L_8ebb32:
	bl L_8c9b28
L_8ebb36:
	b_s L_8ebb18
	.global L_8ebb38
L_8ebb38:
	mov_s r0,0x0
L_8ebb3a:
	mov r1,0x504
L_8ebb3e:
	bl.d L_8d4308
L_8ebb42:
	or_s r2,r2,r3
L_8ebb44:
	b L_8eb842
	.global L_8ebb48
L_8ebb48:
	brne_s r0,0,L_8ebb60
	.global L_8ebb4a
L_8ebb4a:
	mov_s r0,0x0
L_8ebb4c:
	bl.d L_8d3588
L_8ebb50:
	mov r1,0x504
L_8ebb54:
	mov_s r2,r0
L_8ebb56:
	bic r2,r2,0xf0
L_8ebb5a:
	ld_s r3,[r14,0x8]
L_8ebb5c:
	/* asl_s r3,r3,0x4 */
	.byte 0x04,0xbb
L_8ebb5e:
	b_s L_8ebb38
	.global L_8ebb60
L_8ebb60:
	mov_s r0,blink
L_8ebb62:
	mov_s r1,0x1545
L_8ebb68:
	bl L_8c9b28
L_8ebb6c:
	b_s L_8ebb4a
	.global L_8ebb6e
L_8ebb6e:
	bl.d L_8d1a00
L_8ebb72:
	ld_s r0,[r14,0x4]
L_8ebb74:
	b_s L_8ebb94
	.global L_8ebb76
L_8ebb76:
	add_s r0,sp,0x2c
L_8ebb78:
	bl.d L_8f3ed8
L_8ebb7c:
	add_s r1,sp,0x30
L_8ebb7e:
	ld_s r1,[sp,0x2c]
L_8ebb80:
	mov_s r0,r16
L_8ebb82:
	st_s r1,[r0,0x8]
L_8ebb84:
	b.d L_8eb75a
L_8ebb88:
	ld_s r1,[sp,0x30]
	.global L_8ebb8a
L_8ebb8a:
	ld_s r0,[r14,0x4]
L_8ebb8c:
	ld_s r1,[r14,0x8]
L_8ebb8e:
	bl.d L_8f3f1c
L_8ebb92:
	ld_s r2,[r14,0xc]
	.global L_8ebb94
L_8ebb94:
	mov_s r2,r15
L_8ebb96:
	mov_s r0,r13
	.global L_8ebb98
L_8ebb98:
	st r0,[r16, 0x4]
	.global L_8ebb9c
L_8ebb9c:
	mov_s r0,r17
L_8ebb9e:
	bl.d L_8eae78
L_8ebba2:
	mov_s r1,r16
L_8ebba4:
	b_s L_8ebbb2
	.global L_8ebba6
L_8ebba6:
	mov_s r0,r17
L_8ebba8:
	mov_s r1,0x9
L_8ebbaa:
	asl_s r1,r1,0x8
L_8ebbac:
	bl.d L_8e5728
L_8ebbb0:
	ldw_s r3,[r14]
	.global L_8ebbb2
L_8ebbb2:
	b.d L_8c022c
L_8ebbb6:
	add sp,sp,0xa8
L_8ebbba:
	nop_s
