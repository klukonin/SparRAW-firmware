/* wmi_handler_set_selected_rf_sector_index__check_inputs_valid @ 0x8c61d4, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_set_selected_rf_sector_index::check_inputs_valid(): Bad wmi cmd payload pointer
 *   wmi_handler_set_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_BUSY_ERROR. Previous command request still not completed, cid=%d, sector_type=%d
 *   wmi_handler_set_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_BAD_PARAMETERS_ERROR. Bad cid=%d detected, should be in range [0,%d]
 *   wmi_handler_set_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_BAD_PARAMETERS_ERROR. Bad sector_type=%d detected, must be either %d(RX) or %d(TX)
 *   wmi_handler_set_selected_rf_sector_index::check_inputs_valid(): Bad sector_idx=%d detected, must be in range [0,%d]
 * Зовут его: wmi_set_selected_rf_sector_index
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_handler_set_selected_rf_sector_index__check_inputs_valid
wmi_handler_set_selected_rf_sector_index__check_inputs_valid:
	.global L_8c61d4
L_8c61d4:
	push_s blink
L_8c61d6:
	bl L_8c01e4
L_8c61da:
	mov.f r13,r1
L_8c61de:
	mov_s r14,r0
L_8c61e0:
	bne_s L_8c61fa
L_8c61e2:
	mov_s r1,0x1008860
L_8c61e8:
	bl.d L_8dcba8
L_8c61ec:
	mov_s r0,0x5
L_8c61ee:
	mov_s r0,blink
L_8c61f0:
	mov_s r1,0x146a
L_8c61f6:
	bl L_8c9b28
	.global L_8c61fa
L_8c61fa:
	ld_s r1,[r14,0x4]
L_8c61fc:
	mov_s r0,0x0
L_8c61fe:
	breq_s r1,0,L_8c6212
L_8c6200:
	ldb_s r2,[r14]
L_8c6202:
	mov_s r1,0x10088bc
L_8c6208:
	mov_s r0,0x5
L_8c620a:
	bl.d L_8dcc80
L_8c620e:
	ldb_s r3,[r14,0x1]
L_8c6210:
	mov_s r0,0x2
	.global L_8c6212
L_8c6212:
	ldb_s r2,[r13]
L_8c6214:
	brlt r2,0x8,L_8c6228
L_8c6218:
	mov_s r1,0x1008964
L_8c621e:
	mov_s r0,0x5
L_8c6220:
	bl.d L_8dcc80
L_8c6224:
	mov_s r3,0x7
L_8c6226:
	mov_s r0,0x1
	.global L_8c6228
L_8c6228:
	ldb_s r2,[r13,0x1]
L_8c622a:
	brlo r2,0x2,L_8c6242
L_8c622e:
	mov_s r1,0x1008a00
L_8c6234:
	mov_s r0,0x5
L_8c6236:
	mov_s r3,0x0
L_8c6238:
	mov_s r14,0x1
L_8c623a:
	bl.d L_8dcd00
L_8c623e:
	mov_s r4,r14
L_8c6240:
	mov_s r0,r14
	.global L_8c6242
L_8c6242:
	ldw_s r2,[r13,0x2]
L_8c6244:
	cmp_s r2,0x7f
L_8c6246:
	ble_s L_8c6260
L_8c6248:
	breq r2,0xffff,L_8c6260
L_8c6250:
	mov_s r1,0x1008aa8
L_8c6256:
	mov_s r0,0x5
L_8c6258:
	bl.d L_8dcc80
L_8c625c:
	mov_s r3,0x7f
L_8c625e:
	mov_s r0,0x1
	.global L_8c6260
L_8c6260:
	b L_8c0254
