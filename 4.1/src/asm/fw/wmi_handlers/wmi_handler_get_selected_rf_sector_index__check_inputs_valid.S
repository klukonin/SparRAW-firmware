/* wmi_handler_get_selected_rf_sector_index__check_inputs_valid @ 0x8c5400, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_get_selected_rf_sector_index::check_inputs_valid(): Bad wmi cmd payload pointer
 *   wmi_handlers.cpp
 *   wmi_handler_get_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_BUSY_ERROR. Previous command request still not completed, cid=%d, sector_type=%d
 *   wmi_handler_get_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_BAD_PARAMETERS_ERROR. Bad cid=%d detected, should be in range [0,%d]
 *   wmi_handler_get_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_BAD_PARAMETERS_ERROR. Bad sector_type=%d detected, must be either %d(RX) or %d(TX)
 * Зовут его: wmi_handler_get_selected_rf_sector_index
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.wmi_handler_get_selected_rf_sector_index__check_inputs_valid,"ax",@progbits
	.global wmi_handler_get_selected_rf_sector_index__check_inputs_valid
wmi_handler_get_selected_rf_sector_index__check_inputs_valid:
	.global L_8c5400
L_8c5400:
	push_s blink
L_8c5402:
	bl L_8c02c4
L_8c5406:
	mov.f r13,r1
L_8c540a:
	mov_s r14,r0
L_8c540c:
	bne_s L_8c5432
L_8c540e:
	mov_s r2,0x1007a08
L_8c5414:
	mov_s r0,0x5
L_8c5416:
	bl.d L_8edfb0
L_8c541a:
	mov_s r1,0x0
L_8c541c:
	mov_s r0,blink
L_8c541e:
	mov_s r2,0x100710c
L_8c5424:
	mov_s r1,0x146b
L_8c542a:
	bl.d L_8c82c0
L_8c542e:
	mov r3,0x253
	.global L_8c5432
L_8c5432:
	ld_s r0,[r14,0x4]
L_8c5434:
	mov_s r1,0x0
L_8c5436:
	cmp_s r0,0x0
L_8c5438:
	mov.eq r0,r1
L_8c543c:
	beq_s L_8c5452
L_8c543e:
	mov_s r2,0x1007a64
L_8c5444:
	ldb r4,[r14, 0x1]
L_8c5448:
	mov_s r0,0x5
L_8c544a:
	bl.d L_8edff8
L_8c544e:
	ldb_s r3,[r14]
L_8c5450:
	mov_s r0,0x2
	.global L_8c5452
L_8c5452:
	ldb_s r3,[r13]
L_8c5454:
	brlt r3,0x8,L_8c546c
L_8c5458:
	mov_s r2,0x1007b0c
L_8c545e:
	mov_s r0,0x5
L_8c5460:
	mov_s r1,0x0
L_8c5462:
	bl.d L_8edff8
L_8c5466:
	mov r4,0x7
L_8c546a:
	mov_s r0,0x1
	.global L_8c546c
L_8c546c:
	ldb_s r3,[r13,0x1]
L_8c546e:
	brlo r3,0x2,L_8c5488
L_8c5472:
	mov_s r2,0x1007ba8
L_8c5478:
	mov_s r0,0x5
L_8c547a:
	mov_s r1,0x0
L_8c547c:
	mov_s r4,r1
L_8c547e:
	mov_s r13,0x1
L_8c5480:
	bl.d L_8ee034
L_8c5484:
	mov_s r5,r13
L_8c5486:
	mov_s r0,r13
	.global L_8c5488
L_8c5488:
	b L_8c0334
