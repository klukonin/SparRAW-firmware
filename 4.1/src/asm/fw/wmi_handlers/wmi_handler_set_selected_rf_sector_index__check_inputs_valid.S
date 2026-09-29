/* wmi_handler_set_selected_rf_sector_index__check_inputs_valid @ 0x8c548c, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_set_selected_rf_sector_index::check_inputs_valid(): Bad wmi cmd payload pointer
 *   wmi_handlers.cpp
 *   wmi_handler_set_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_BUSY_ERROR. Previous command request still not completed, cid=%d, sector_type=%d
 *   wmi_handler_set_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_NOT_SUPPORTED_ERROR. Forcing RX sector index is not yet supported, cid=%d, sector_type=%d
 *   wmi_handler_set_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_BAD_PARAMETERS_ERROR. Bad cid=%d detected, should be in range [0,%d]
 *   wmi_handler_set_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_BAD_PARAMETERS_ERROR. Bad sector_type=%d detected, must be either %d(RX) or %d(TX)
 *   wmi_handler_set_selected_rf_sector_index::check_inputs_valid(): Bad sector_idx=%d detected, must be in range [0,%d]
 * Зовут его: wmi_handler_set_selected_rf_sector_index
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.wmi_handler_set_selected_rf_sector_index__check_inputs_valid,"ax",@progbits
	.global wmi_handler_set_selected_rf_sector_index__check_inputs_valid
wmi_handler_set_selected_rf_sector_index__check_inputs_valid:
	.global L_8c548c
L_8c548c:
	push_s blink
L_8c548e:
	bl L_8c02c4
L_8c5492:
	mov.f r13,r1
L_8c5496:
	mov_s r14,r0
L_8c5498:
	bne_s L_8c54be
L_8c549a:
	mov_s r2,0x1007d24
L_8c54a0:
	mov_s r0,0x5
L_8c54a2:
	bl.d L_8edfb0
L_8c54a6:
	mov_s r1,0x0
L_8c54a8:
	mov_s r0,blink
L_8c54aa:
	mov_s r2,0x100710c
L_8c54b0:
	mov_s r1,0x146a
L_8c54b6:
	bl.d L_8c82c0
L_8c54ba:
	mov r3,0x2ac
	.global L_8c54be
L_8c54be:
	ld_s r0,[r14,0x4]
L_8c54c0:
	mov_s r1,0x0
L_8c54c2:
	cmp_s r0,0x0
L_8c54c4:
	mov.eq r0,r1
L_8c54c8:
	beq_s L_8c54de
L_8c54ca:
	mov_s r2,0x1007d80
L_8c54d0:
	ldb r4,[r14, 0x1]
L_8c54d4:
	mov_s r0,0x5
L_8c54d6:
	bl.d L_8edff8
L_8c54da:
	ldb_s r3,[r14]
L_8c54dc:
	mov_s r0,0x2
	.global L_8c54de
L_8c54de:
	ldb_s r1,[r13,0x1]
L_8c54e0:
	brne_s r1,0,L_8c54f8
L_8c54e2:
	mov_s r2,0x1007e28
L_8c54e8:
	ldb r4,[r14, 0x1]
L_8c54ec:
	mov_s r0,0x5
L_8c54ee:
	mov_s r1,0x0
L_8c54f0:
	bl.d L_8edff8
L_8c54f4:
	ldb_s r3,[r14]
L_8c54f6:
	mov_s r0,0x3
	.global L_8c54f8
L_8c54f8:
	ldb_s r3,[r13]
L_8c54fa:
	brlt r3,0x8,L_8c5512
L_8c54fe:
	mov_s r2,0x1007ed8
L_8c5504:
	mov_s r0,0x5
L_8c5506:
	mov_s r1,0x0
L_8c5508:
	bl.d L_8edff8
L_8c550c:
	mov r4,0x7
L_8c5510:
	mov_s r0,0x1
	.global L_8c5512
L_8c5512:
	ldb_s r3,[r13,0x1]
L_8c5514:
	brlo r3,0x2,L_8c552e
L_8c5518:
	mov_s r2,0x1007f74
L_8c551e:
	mov_s r0,0x5
L_8c5520:
	mov_s r1,0x0
L_8c5522:
	mov_s r4,r1
L_8c5524:
	mov_s r14,0x1
L_8c5526:
	bl.d L_8ee034
L_8c552a:
	mov_s r5,r14
L_8c552c:
	mov_s r0,r14
	.global L_8c552e
L_8c552e:
	ldw_s r3,[r13,0x2]
L_8c5530:
	cmp_s r3,0x7f
L_8c5532:
	ble_s L_8c5550
L_8c5534:
	breq r3,0xffff,L_8c5550
L_8c553c:
	mov_s r2,0x100801c
L_8c5542:
	mov_s r0,0x5
L_8c5544:
	mov_s r1,0x0
L_8c5546:
	bl.d L_8edff8
L_8c554a:
	mov r4,0x7f
L_8c554e:
	mov_s r0,0x1
	.global L_8c5550
L_8c5550:
	b L_8c0334
