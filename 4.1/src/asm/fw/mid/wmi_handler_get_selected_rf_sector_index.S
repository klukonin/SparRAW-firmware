/* wmi_handler_get_selected_rf_sector_index @ 0x8e1288, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_GET_SELECTED_RF_SECTOR_INDEX_DONE_EVENT: Command execution aborted, error_status=%d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit1, memcpy_fw, memset0_words, wmi_handler_get_selected_rf_sector_index__check_inputs_valid
 */
	.section .text.wmi_handler_get_selected_rf_sector_index,"ax",@progbits
	.global wmi_handler_get_selected_rf_sector_index
wmi_handler_get_selected_rf_sector_index:
	.global L_8e1288
L_8e1288:
	push_s blink
L_8e128a:
	bl L_8c02b8
L_8e128e:
	mov_s r13,r0
L_8e1290:
	mov_s r17,r1
L_8e1292:
	bl.d L_8c5400
L_8e1296:
	mov_s r14,r2
L_8e1298:
	mov.f r16,r0
L_8e129c:
	bne_s L_8e12ae
L_8e129e:
	mov_s r0,r13
L_8e12a0:
	mov_s r1,r17
L_8e12a2:
	bl.d L_8c0460
L_8e12a6:
	mov_s r2,0x4
L_8e12a8:
	st_s r14,[r13,0x4]
L_8e12aa:
	mov_s r0,0x1
L_8e12ac:
	b_s L_8e12ee
	.global L_8e12ae
L_8e12ae:
	bl.d L_8c2c38
L_8e12b2:
	mov_s r0,r14
L_8e12b4:
	mov_s r13,r0
L_8e12b6:
	bl.d L_8c1a78
L_8e12ba:
	mov_s r1,0x10
L_8e12bc:
	stb r16,[r13, 0x2]
L_8e12c0:
	mov_s r2,0x1007c50
L_8e12c6:
	mov_s r15,0x0
L_8e12c8:
	mov_s r0,r15
L_8e12ca:
	mov_s r1,r15
L_8e12cc:
	bl.d L_8edfcc
L_8e12d0:
	mov_s r3,r16
L_8e12d2:
	mov_s r0,r14
L_8e12d4:
	mov_s r1,r13
L_8e12d6:
	mov_s r2,r15
L_8e12d8:
	mov_s r3,0x19a2
L_8e12de:
	mov r4,0x10
L_8e12e2:
	mov_s r5,r15
L_8e12e4:
	mov_s r6,r15
L_8e12e6:
	bl.d L_8e0460
L_8e12ea:
	mov_s r7,r15
L_8e12ec:
	mov_s r0,r15
	.global L_8e12ee
L_8e12ee:
	b L_8c031c
L_8e12f2:
	nop_s
