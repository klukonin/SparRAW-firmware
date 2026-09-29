/* wmi_handler_get_selected_rf_sector_index__check_inputs_valid @ 0x8c6160, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_get_selected_rf_sector_index::check_inputs_valid(): Bad wmi cmd payload pointer
 *   wmi_handler_get_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_BUSY_ERROR. Previous command request still not completed, cid=%d, sector_type=%d
 *   wmi_handler_get_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_BAD_PARAMETERS_ERROR. Bad cid=%d detected, should be in range [0,%d]
 *   wmi_handler_get_selected_rf_sector_index::check_inputs_valid(): WMI_RF_SECTOR_STATUS_BAD_PARAMETERS_ERROR. Bad sector_type=%d detected, must be either %d(RX) or %d(TX)
 * Зовут его: wmi_get_selected_rf_sector_index
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_handler_get_selected_rf_sector_index__check_inputs_valid
wmi_handler_get_selected_rf_sector_index__check_inputs_valid:
	.global L_8c6160
L_8c6160:
	push_s blink
L_8c6162:
	bl L_8c01e4
L_8c6166:
	mov.f r13,r1
L_8c616a:
	mov_s r14,r0
L_8c616c:
	bne_s L_8c6186
L_8c616e:
	mov_s r1,0x1008544
L_8c6174:
	bl.d L_8dcba8
L_8c6178:
	mov_s r0,0x5
L_8c617a:
	mov_s r0,blink
L_8c617c:
	mov_s r1,0x146b
L_8c6182:
	bl L_8c9b28
	.global L_8c6186
L_8c6186:
	ld_s r1,[r14,0x4]
L_8c6188:
	mov_s r0,0x0
L_8c618a:
	breq_s r1,0,L_8c619e
L_8c618c:
	ldb_s r2,[r14]
L_8c618e:
	mov_s r1,0x10085a0
L_8c6194:
	mov_s r0,0x5
L_8c6196:
	bl.d L_8dcc80
L_8c619a:
	ldb_s r3,[r14,0x1]
L_8c619c:
	mov_s r0,0x2
	.global L_8c619e
L_8c619e:
	ldb_s r2,[r13]
L_8c61a0:
	brlt r2,0x8,L_8c61b4
L_8c61a4:
	mov_s r1,0x1008648
L_8c61aa:
	mov_s r0,0x5
L_8c61ac:
	bl.d L_8dcc80
L_8c61b0:
	mov_s r3,0x7
L_8c61b2:
	mov_s r0,0x1
	.global L_8c61b4
L_8c61b4:
	ldb_s r2,[r13,0x1]
L_8c61b6:
	brlo r2,0x2,L_8c61ce
L_8c61ba:
	mov_s r1,0x10086e4
L_8c61c0:
	mov_s r0,0x5
L_8c61c2:
	mov_s r3,0x0
L_8c61c4:
	mov_s r14,0x1
L_8c61c6:
	bl.d L_8dcd00
L_8c61ca:
	mov_s r4,r14
L_8c61cc:
	mov_s r0,r14
	.global L_8c61ce
L_8c61ce:
	b L_8c0254
L_8c61d2:
	nop_s
