/* lmac_if__ucode_event_dispatch @ 0x8df07c, 904 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Ucode->EVENT_UCODE_READY: type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->EVENT_ECHO       : type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->NEW_LINK_EVT     : type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->EVENT_FLUSH_Q_DONE: type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->QUEUE_DELETED_EVT: type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->LINK_LOST_EVT    : type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->STA_UPDATE_FIELD_RSP: type 0x0%x, curr tsf 0x%08x %08x
 *   Ucode->RS_STARTED_EVT   : type 0x0%x, curr tsf 0x%08x %08x
 * Зовёт сам: LMAC_IF__rs_started, __ld_r17_to_r13_ret, __st_r17_to_r13, ba__on_uc_timeout_evt, brd_if_multi_array__get_section_info, event_flush_q_done, evt_fixed_scheduling_enabled, evt_get_selected_rf_sector_index_done, evt_set_selected_rf_sector_index_done, ftm__responder_rx_req__with_ctx, fw_log_emit3, fw_sysapi_mgr__complete_pending_request
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__ucode_event_dispatch
lmac_if__ucode_event_dispatch:
L_8df07c:
	st_s r2,[r1]
L_8df07e:
	b.d L_8c023c
L_8df082:
	add_s sp,sp,0x8
L_8df084:
	push_s blink
L_8df086:
	bl L_8c01d8
L_8df08a:
	sub_s sp,sp,0x8
L_8df08c:
	mov_s r16,r0
L_8df08e:
	mov_s r15,r1
L_8df090:
	add r14,r1,0x10
L_8df094:
	mov r17,sp
L_8df098:
	mov_s r13,0x0
L_8df09a:
	mov_s r0,r13
L_8df09c:
	mov_s r1,r17
L_8df09e:
	bl.d L_8e9900
L_8df0a2:
	mov_s r2,r13
L_8df0a4:
	ldw_s r1,[r15,0x4]
L_8df0a6:
	cmp_s r1,0x30
L_8df0a8:
	bhi L_8df3dc
L_8df0ac:
	ldw.x.as r1,[0x801f40,r1]
L_8df0b4:
	add r0,pcl,0x8
L_8df0b8:
	add1_s r0,r0,r1
L_8df0ba:
	j_s [r0]
L_8df0bc:
	mov_s r1,0x1004200
L_8df0c2:
	ld r4,[sp]
L_8df0c6:
	mov_s r0,0x20
L_8df0c8:
	mov_s r2,r13
L_8df0ca:
	bl.d L_8dcd00
L_8df0ce:
	ld_s r3,[sp,0x4]
L_8df0d0:
	bl L_8f61b0
L_8df0d4:
	b L_8df3e6
L_8df0d8:
	bl.d L_8cd288
L_8df0dc:
	mov_s r0,r13
L_8df0de:
	b L_8df3e6
L_8df0e2:
	mov_s r1,0x100423c
L_8df0e8:
	ld r4,[sp]
L_8df0ec:
	mov_s r0,0x20
L_8df0ee:
	mov_s r2,0x2
L_8df0f0:
	bl.d L_8dcd00
L_8df0f4:
	ld_s r3,[sp,0x4]
L_8df0f6:
	bl.d L_8db768
L_8df0fa:
	mov_s r0,r14
L_8df0fc:
	b L_8df3e6
L_8df100:
	mov_s r0,0x8042c8
L_8df106:
	bl L_8ccb1c
L_8df10a:
	bl.d L_8ce910
L_8df10e:
	mov_s r1,r13
L_8df110:
	bl.d L_8cd288
L_8df114:
	mov_s r0,0x1
L_8df116:
	b L_8df3e6
L_8df11a:
	mov_s r1,0x1004278
L_8df120:
	ld r4,[sp]
L_8df124:
	mov_s r0,0x20
L_8df126:
	mov_s r2,0x5
L_8df128:
	bl.d L_8dcd00
L_8df12c:
	ld_s r3,[sp,0x4]
L_8df12e:
	bl L_8cc158
L_8df132:
	mov_s r1,r0
L_8df134:
	bl.d L_8db518
L_8df138:
	mov_s r0,r14
L_8df13a:
	b L_8df3e6
L_8df13e:
	bl.d L_8db330
L_8df142:
	mov_s r0,r14
L_8df144:
	b L_8df3e6
L_8df148:
	ld_s r1,[sp,0x0]
L_8df14a:
	stw_s r1,[r14,0x1a]
L_8df14c:
	lsr_s r1,r1,0x10
L_8df14e:
	stw_s r1,[r14,0x1c]
L_8df150:
	bl.d L_8dbbe4
L_8df154:
	mov_s r0,r14
L_8df156:
	b L_8df3e6
L_8df15a:
	mov_s r1,0x10042b4
L_8df160:
	ld r4,[sp]
L_8df164:
	mov_s r0,0x20
L_8df166:
	mov_s r2,0x4
L_8df168:
	bl.d L_8dcd00
L_8df16c:
	ld_s r3,[sp,0x4]
L_8df16e:
	bl.d L_8db7f0
L_8df172:
	mov_s r0,r14
L_8df174:
	b L_8df3e6
L_8df178:
	mov_s r1,0x10042f0
L_8df17e:
	ld r4,[sp]
L_8df182:
	mov_s r0,0x20
L_8df184:
	mov_s r2,0x8
L_8df186:
	bl.d L_8dcd00
L_8df18a:
	ld_s r3,[sp,0x4]
L_8df18c:
	bl.d L_8dc4a4
L_8df190:
	mov_s r0,r14
L_8df192:
	b L_8df3e6
L_8df196:
	mov_s r1,0x100432c
L_8df19c:
	ld r4,[sp]
L_8df1a0:
	mov_s r0,0x20
L_8df1a2:
	mov_s r2,0x9
L_8df1a4:
	bl.d L_8dcd00
L_8df1a8:
	ld_s r3,[sp,0x4]
L_8df1aa:
	bl.d L_8db960
L_8df1ae:
	mov_s r0,r14
L_8df1b0:
	b L_8df3e6
L_8df1b4:
	mov_s r1,0x1004368
L_8df1ba:
	ld r4,[sp]
L_8df1be:
	mov_s r0,0x20
L_8df1c0:
	mov_s r2,0x11
L_8df1c2:
	bl.d L_8dcd00
L_8df1c6:
	ld_s r3,[sp,0x4]
L_8df1c8:
	bl.d L_8dc14c
L_8df1cc:
	mov_s r0,r14
L_8df1ce:
	b L_8df3e6
L_8df1d2:
	mov_s r1,0x10043a8
L_8df1d8:
	ld r4,[sp]
L_8df1dc:
	mov_s r0,0x20
L_8df1de:
	mov_s r2,0x13
L_8df1e0:
	bl.d L_8dcd00
L_8df1e4:
	ld_s r3,[sp,0x4]
L_8df1e6:
	bl.d L_8dbc6c
L_8df1ea:
	mov_s r0,r14
L_8df1ec:
	b L_8df3e6
L_8df1f0:
	mov_s r1,0x10043e4
L_8df1f6:
	ld r4,[sp]
L_8df1fa:
	mov_s r0,0x20
L_8df1fc:
	mov_s r2,0x15
L_8df1fe:
	bl.d L_8dcd00
L_8df202:
	ld_s r3,[sp,0x4]
L_8df204:
	bl.d L_8dc10c
L_8df208:
	mov_s r0,r14
L_8df20a:
	b L_8df3e6
L_8df20e:
	bl L_8cc158
L_8df212:
	mov_s r1,r0
L_8df214:
	bl.d L_8db240
L_8df218:
	mov_s r0,r14
L_8df21a:
	b_s L_8df3e6
L_8df21c:
	bl.d L_8db9c0
L_8df220:
	mov_s r0,r14
L_8df222:
	b_s L_8df3e6
L_8df224:
	mov_s r1,0x1004428
L_8df22a:
	ld r4,[sp]
L_8df22e:
	mov_s r0,0x20
L_8df230:
	mov_s r2,0x18
L_8df232:
	bl.d L_8dcd00
L_8df236:
	ld_s r3,[sp,0x4]
L_8df238:
	bl.d L_8dc218
L_8df23c:
	mov_s r0,r14
L_8df23e:
	b_s L_8df3e6
L_8df240:
	mov_s r1,0x1004470
L_8df246:
	ld r4,[sp]
L_8df24a:
	mov_s r0,0x20
L_8df24c:
	mov_s r2,0x19
L_8df24e:
	bl.d L_8dcd00
L_8df252:
	ld_s r3,[sp,0x4]
L_8df254:
	bl.d L_8dc224
L_8df258:
	mov_s r0,r14
L_8df25a:
	b_s L_8df3e6
L_8df25c:
	mov_s r1,0x10044ac
L_8df262:
	ld r4,[sp]
L_8df266:
	mov_s r0,0x20
L_8df268:
	mov_s r2,0x24
L_8df26a:
	bl.d L_8dcd00
L_8df26e:
	ld_s r3,[sp,0x4]
L_8df270:
	bl.d L_8db1b0
L_8df274:
	mov_s r0,r14
L_8df276:
	ld r4,[sp]
L_8df27a:
	mov_s r1,0x10044e4
L_8df280:
	ldw_s r2,[r15,0x4]
L_8df282:
	mov_s r0,0x20
L_8df284:
	bl.d L_8dcd00
L_8df288:
	ld_s r3,[sp,0x4]
L_8df28a:
	mov_s r0,0x805170
L_8df290:
	ld_s r1,[r14]
	.global L_8df292
L_8df292:
	bl.d L_8f1c50
L_8df296:
	mov_s r2,0x0
L_8df298:
	b_s L_8df3e6
L_8df29a:
	mov_s r1,0x1004530
L_8df2a0:
	ld r4,[sp]
L_8df2a4:
	mov_s r0,0x20
L_8df2a6:
	mov_s r2,0x21
L_8df2a8:
	bl.d L_8dcd00
L_8df2ac:
	ld_s r3,[sp,0x4]
L_8df2ae:
	mov_s r0,0x805170
L_8df2b4:
	add_s r2,r14,0x4
L_8df2b6:
	bl.d L_8f1c50
L_8df2ba:
	ldb_s r1,[r14]
L_8df2bc:
	b_s L_8df3e6
L_8df2be:
	bl.d L_8db8c4
L_8df2c2:
	mov_s r0,r14
L_8df2c4:
	b_s L_8df3e6
L_8df2c6:
	mov_s r1,0x1004580
L_8df2cc:
	ld r4,[sp]
L_8df2d0:
	mov_s r0,0x20
L_8df2d2:
	mov_s r2,0x23
L_8df2d4:
	bl.d L_8dcd00
L_8df2d8:
	ld_s r3,[sp,0x4]
L_8df2da:
	mov_s r0,0x805170
L_8df2e0:
	ldb r1,[r14, 0x23]
	.global L_8df2e4
L_8df2e4:
	bl.d L_8f1c50
L_8df2e8:
	mov_s r2,r14
L_8df2ea:
	b_s L_8df3e6
L_8df2ec:
	mov_s r1,0x10045c4
L_8df2f2:
	ld r4,[sp]
L_8df2f6:
	mov_s r0,0x20
L_8df2f8:
	mov_s r2,0x25
L_8df2fa:
	bl.d L_8dcd00
L_8df2fe:
	ld_s r3,[sp,0x4]
L_8df300:
	bl.d L_8eadb4
L_8df304:
	mov_s r0,r14
L_8df306:
	b_s L_8df3e6
L_8df308:
	mov_s r2,0x26
L_8df30a:
	mov_s r1,0x1004604
	.global L_8df310
L_8df310:
	ld_s r3,[sp,0x4]
L_8df312:
	ld r4,[sp]
L_8df316:
	bl.d L_8dcd00
L_8df31a:
	mov_s r0,0x20
L_8df31c:
	mov_s r0,0x805170
L_8df322:
	mov_s r1,0x1
L_8df324:
	b_s L_8df2e4
L_8df326:
	mov_s r1,0x100464c
L_8df32c:
	ld r4,[sp]
L_8df330:
	mov_s r0,0x20
L_8df332:
	mov_s r2,0x27
L_8df334:
	bl.d L_8dcd00
L_8df338:
	ld_s r3,[sp,0x4]
L_8df33a:
	mov_s r0,0x804914
L_8df340:
	bl.d L_8cd534
L_8df344:
	mov_s r1,r14
L_8df346:
	b_s L_8df3e6
L_8df348:
	mov_s r1,0x10046a0
L_8df34e:
	ld r4,[sp]
L_8df352:
	mov_s r0,0x20
L_8df354:
	mov_s r2,0x28
L_8df356:
	bl.d L_8dcd00
L_8df35a:
	ld_s r3,[sp,0x4]
L_8df35c:
	mov_s r0,0x80491c
L_8df362:
	bl.d L_8cd58c
L_8df366:
	mov_s r1,r14
L_8df368:
	b_s L_8df3e6
L_8df36a:
	mov_s r1,0x10046f4
L_8df370:
	ld r4,[sp]
L_8df374:
	mov_s r0,0x20
L_8df376:
	mov_s r2,0x29
L_8df378:
	bl.d L_8dcd00
L_8df37c:
	ld_s r3,[sp,0x4]
L_8df37e:
	bl L_8ccb7c
L_8df382:
	bl L_8e1cd8
L_8df386:
	ld r4,[sp]
L_8df38a:
	mov_s r1,0x100474c
L_8df390:
	ldw_s r2,[r15,0x4]
L_8df392:
	mov_s r0,0x20
L_8df394:
	bl.d L_8dcd00
L_8df398:
	ld_s r3,[sp,0x4]
L_8df39a:
	mov_s r0,0x805170
L_8df3a0:
	ldb_s r1,[r14]
L_8df3a2:
	b_s L_8df292
L_8df3a4:
	mov_s r1,0x1004794
L_8df3aa:
	mov_s r2,0x2c
L_8df3ac:
	b_s L_8df310
L_8df3ae:
	bl.d L_8dc430
L_8df3b2:
	mov_s r0,r14
L_8df3b4:
	b_s L_8df3e6
L_8df3b6:
	mov_s r1,0x10047d4
L_8df3bc:
	mov_s r2,0x2f
L_8df3be:
	b_s L_8df310
L_8df3c0:
	mov_s r1,0x1004820
L_8df3c6:
	ld r4,[sp]
L_8df3ca:
	mov_s r0,0x20
L_8df3cc:
	mov_s r2,0x30
L_8df3ce:
	bl.d L_8dcd00
L_8df3d2:
	ld_s r3,[sp,0x4]
L_8df3d4:
	bl.d L_8db7bc
L_8df3d8:
	mov_s r0,r14
L_8df3da:
	b_s L_8df3e6
	.global L_8df3dc
L_8df3dc:
	mov_s r0,blink
L_8df3de:
	mov_s r1,0x47
L_8df3e0:
	bl.d L_8c9b28
L_8df3e4:
	bset_s r1,r1,0xc
	.global L_8df3e6
L_8df3e6:
	mov_s r0,0x0
L_8df3e8:
	mov_s r1,r17
L_8df3ea:
	bl.d L_8e9900
L_8df3ee:
	mov_s r2,r0
L_8df3f0:
	add r0,r16,0x24
L_8df3f4:
	ld_s r1,[r0]
L_8df3f6:
	bl.d L_8d86c0
L_8df3fa:
	st_s r13,[r1]
L_8df3fc:
	b.d L_8c023c
L_8df400:
	add_s sp,sp,0x8
L_8df402:
	nop_s
