/* wmi_handler_set_rf_sector_params__verify_inputs @ 0x8c60d0, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_set_rf_sector_params::verify_inputs: Bad sector_type=%d detected, must be either %d(RX) or %d(TX)
 *   wmi_handler_det_rf_sector_params::check_inputs_valid(): Bad pointer detected p_cmd=0x%X, p_host_if=0x%X, dummy=%d
 *   wmi_handler_set_rf_sector_params::verify_inputs: Bad sector_idx=%d detected, must be in range [0,%d]
 *   wmi_handler_set_rf_sector_params::verify_inputs: Bad rf_modules_vec=0x%X detected, should specify at least one attached&enabled destination RF module rfc_enabled=0x%X
 * Зовут его: wmi_handler_set_rf_sector_params__set
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, rf_cfg__get_rf_mask_45e
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_handler_set_rf_sector_params__verify_inputs
wmi_handler_set_rf_sector_params__verify_inputs:
	.global L_8c60d0
L_8c60d0:
	push_s blink
L_8c60d2:
	bl.d L_8c01e4
L_8c60d6:
	mov_s r3,r2
L_8c60d8:
	mov.f r13,r1
L_8c60dc:
	cmp.ne r3,0x0
L_8c60e0:
	beq_s L_8c6102
	.global L_8c60e2
L_8c60e2:
	ldb_s r2,[r13,0x2]
L_8c60e4:
	cmp_s r2,0x0
L_8c60e6:
	cmp.ne r2,0x1
L_8c60ea:
	beq_s L_8c6120
L_8c60ec:
	mov_s r1,0x1008160
L_8c60f2:
	mov_s r0,0x25
L_8c60f4:
	mov_s r14,0x0
L_8c60f6:
	mov_s r3,r14
L_8c60f8:
	bl.d L_8dcd00
L_8c60fc:
	mov r4,0x1
L_8c6100:
	b_s L_8c615a
	.global L_8c6102
L_8c6102:
	mov_s r1,0x10081d0
L_8c6108:
	mov_s r0,0x0
L_8c610a:
	mov_s r2,r13
L_8c610c:
	bl.d L_8dcd00
L_8c6110:
	mov_s r4,r0
L_8c6112:
	mov_s r0,blink
L_8c6114:
	mov_s r1,0x1467
L_8c611a:
	bl L_8c9b28
L_8c611e:
	b_s L_8c60e2
	.global L_8c6120
L_8c6120:
	ldw_s r2,[r13]
L_8c6122:
	cmp_s r2,0x40
L_8c6124:
	mov.lt r14,0x1
L_8c6128:
	blt_s L_8c613a
L_8c612a:
	mov_s r1,0x1008244
L_8c6130:
	mov_s r0,0x25
L_8c6132:
	bl.d L_8dcc80
L_8c6136:
	mov_s r3,0x40
L_8c6138:
	mov_s r14,0x0
	.global L_8c613a
L_8c613a:
	mov_s r0,0x8042c8
L_8c6140:
	bl L_8ccb3c
L_8c6144:
	ldb_s r2,[r13,0x3]
L_8c6146:
	tst_s r2,r0
L_8c6148:
	mov_s r3,r0
L_8c614a:
	bne_s L_8c615a
L_8c614c:
	mov_s r1,0x10082ac
L_8c6152:
	bl.d L_8dcc80
L_8c6156:
	mov_s r0,0x25
L_8c6158:
	mov_s r14,0x0
	.global L_8c615a
L_8c615a:
	b.d L_8c0254
L_8c615e:
	mov_s r0,r14
