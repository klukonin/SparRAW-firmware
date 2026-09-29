/* wmi_handler_set_selected_rf_sector_index @ 0x8e12f4, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SET_SELECTED_RF_SECTOR_INDEX_DONE_EVENTID: Command execution aborted, error_status=%d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit1, memcpy_fw, memset0_words, wmi_handler_set_selected_rf_sector_index__check_inputs_valid
 */
	.section .text.wmi_handler_set_selected_rf_sector_index,"ax",@progbits
	.global wmi_handler_set_selected_rf_sector_index
wmi_handler_set_selected_rf_sector_index:
	.global L_8e12f4
L_8e12f4:
	push_s blink
L_8e12f6:
	bl L_8c02b8
L_8e12fa:
	mov_s r13,r0
L_8e12fc:
	mov_s r17,r1
L_8e12fe:
	bl.d L_8c548c
L_8e1302:
	mov_s r14,r2
L_8e1304:
	mov.f r16,r0
L_8e1308:
	bne_s L_8e131a
L_8e130a:
	mov_s r0,r13
L_8e130c:
	mov_s r1,r17
L_8e130e:
	bl.d L_8c0460
L_8e1312:
	mov_s r2,0x4
L_8e1314:
	st_s r14,[r13,0x4]
L_8e1316:
	mov_s r0,0x1
L_8e1318:
	b_s L_8e135a
	.global L_8e131a
L_8e131a:
	bl.d L_8c2c38
L_8e131e:
	mov_s r0,r14
L_8e1320:
	mov_s r13,r0
L_8e1322:
	bl.d L_8c1a78
L_8e1326:
	mov_s r1,0x4
L_8e1328:
	stb r16,[r13]
L_8e132c:
	mov_s r2,0x1008090
L_8e1332:
	mov_s r15,0x0
L_8e1334:
	mov_s r0,r15
L_8e1336:
	mov_s r1,r15
L_8e1338:
	bl.d L_8edfcc
L_8e133c:
	mov_s r3,r16
L_8e133e:
	mov_s r0,r14
L_8e1340:
	mov_s r1,r13
L_8e1342:
	mov_s r2,r15
L_8e1344:
	mov_s r3,0x19a3
L_8e134a:
	mov r4,0x4
L_8e134e:
	mov_s r5,r15
L_8e1350:
	mov_s r6,r15
L_8e1352:
	bl.d L_8e0460
L_8e1356:
	mov_s r7,r15
L_8e1358:
	mov_s r0,r15
	.global L_8e135a
L_8e135a:
	b L_8c031c
L_8e135e:
	nop_s
