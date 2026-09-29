/* wmi_handler_get_rf_sector_params__check_inputs_valid @ 0x8c6040, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_get_rf_sector_params::check_inputs_valid(): Bad sector_type=%d detected, must be either %d(RX) or %d(TX)
 *   wmi_handler_get_rf_sector_params::check_inputs_valid(): Bad pointer detected p_cmd=0x%X, p_host_if=0x%X, dummy=%d
 *   wmi_handler_get_rf_sector_params::check_inputs_valid(): Bad sector_idx=%d detected, must be in range [0,%d]
 *   wmi_handler_get_rf_sector_params::check_inputs_valid(): Bad rf_modules_vec=0x%X detected, should specify at least one attached&enabled destination RF module rfc_enabled=0x%X
 * Зовут его: wmi_handler_get_rf_sector_params__set
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, rf_cfg__get_rf_mask_45e
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_handler_get_rf_sector_params__check_inputs_valid
wmi_handler_get_rf_sector_params__check_inputs_valid:
	.global L_8c6040
L_8c6040:
	push_s blink
L_8c6042:
	bl.d L_8c01e4
L_8c6046:
	mov_s r3,r2
L_8c6048:
	mov.f r13,r1
L_8c604c:
	cmp.ne r3,0x0
L_8c6050:
	beq_s L_8c6072
	.global L_8c6052
L_8c6052:
	ldb_s r2,[r13,0x2]
L_8c6054:
	cmp_s r2,0x0
L_8c6056:
	cmp.ne r2,0x1
L_8c605a:
	beq_s L_8c6090
L_8c605c:
	mov_s r1,0x1007d00
L_8c6062:
	mov_s r0,0x25
L_8c6064:
	mov_s r14,0x0
L_8c6066:
	mov_s r3,r14
L_8c6068:
	bl.d L_8dcd00
L_8c606c:
	mov r4,0x1
L_8c6070:
	b_s L_8c60ca
	.global L_8c6072
L_8c6072:
	mov_s r1,0x1007d78
L_8c6078:
	mov_s r0,0x0
L_8c607a:
	mov_s r2,r13
L_8c607c:
	bl.d L_8dcd00
L_8c6080:
	mov_s r4,r0
L_8c6082:
	mov_s r0,blink
L_8c6084:
	mov_s r1,0x1469
L_8c608a:
	bl L_8c9b28
L_8c608e:
	b_s L_8c6052
	.global L_8c6090
L_8c6090:
	ldw_s r2,[r13]
L_8c6092:
	cmp_s r2,0x40
L_8c6094:
	mov.lt r14,0x1
L_8c6098:
	blt_s L_8c60aa
L_8c609a:
	mov_s r1,0x1007dec
L_8c60a0:
	mov_s r0,0x25
L_8c60a2:
	bl.d L_8dcc80
L_8c60a6:
	mov_s r3,0x40
L_8c60a8:
	mov_s r14,0x0
	.global L_8c60aa
L_8c60aa:
	mov_s r0,0x8042c8
L_8c60b0:
	bl L_8ccb3c
L_8c60b4:
	ldb_s r2,[r13,0x3]
L_8c60b6:
	tst_s r2,r0
L_8c60b8:
	mov_s r3,r0
L_8c60ba:
	bne_s L_8c60ca
L_8c60bc:
	mov_s r1,0x1007e58
L_8c60c2:
	bl.d L_8dcc80
L_8c60c6:
	mov_s r0,0x25
L_8c60c8:
	mov_s r14,0x0
	.global L_8c60ca
L_8c60ca:
	b.d L_8c0254
L_8c60ce:
	mov_s r0,r14
