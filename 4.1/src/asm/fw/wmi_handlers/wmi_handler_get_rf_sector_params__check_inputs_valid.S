/* wmi_handler_get_rf_sector_params__check_inputs_valid @ 0x8c52b0, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_get_rf_sector_params::check_inputs_valid(): Bad sector_type=%d detected, must be either %d(RX) or %d(TX)
 *   wmi_handler_get_rf_sector_params::check_inputs_valid(): Bad pointer detected p_cmd=0x%X, p_host_if=0x%X, dummy=%d
 *   wmi_handlers.cpp
 *   wmi_handler_get_rf_sector_params::check_inputs_valid(): Bad sector_idx=%d detected, must be in range [0,%d]
 *   wmi_handler_get_rf_sector_params::check_inputs_valid(): Bad rf_modules_vec=0x%X detected, should specify at least one attached&enabled destination RF module rfc_enabled=0x%X
 * Зовут его: wmi_handler_get_rf_sector_params__set
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, get_g_800227
 */
	.section .text.wmi_handler_get_rf_sector_params__check_inputs_valid,"ax",@progbits
	.global wmi_handler_get_rf_sector_params__check_inputs_valid
wmi_handler_get_rf_sector_params__check_inputs_valid:
	.global L_8c52b0
L_8c52b0:
	push_s blink
L_8c52b2:
	bl.d L_8c02c4
L_8c52b6:
	mov_s r4,r2
L_8c52b8:
	mov.f r13,r1
L_8c52bc:
	cmp.ne r4,0x0
L_8c52c0:
	beq_s L_8c52e4
	.global L_8c52c2
L_8c52c2:
	ldb_s r3,[r13,0x2]
L_8c52c4:
	cmp_s r3,0x0
L_8c52c6:
	cmp.ne r3,0x1
L_8c52ca:
	beq_s L_8c530e
L_8c52cc:
	mov_s r2,0x10071c4
L_8c52d2:
	mov_s r0,0x5
L_8c52d4:
	mov_s r1,0x2
L_8c52d6:
	mov_s r14,0x0
L_8c52d8:
	mov_s r4,r14
L_8c52da:
	bl.d L_8ee034
L_8c52de:
	mov r5,0x1
L_8c52e2:
	b_s L_8c5350
	.global L_8c52e4
L_8c52e4:
	mov_s r2,0x100723c
L_8c52ea:
	mov_s r0,0x0
L_8c52ec:
	mov_s r1,r0
L_8c52ee:
	mov_s r3,r13
L_8c52f0:
	bl.d L_8ee034
L_8c52f4:
	mov_s r5,r0
L_8c52f6:
	mov_s r0,blink
L_8c52f8:
	mov_s r2,0x100710c
L_8c52fe:
	mov_s r1,0x1469
L_8c5304:
	bl.d L_8c82c0
L_8c5308:
	mov r3,0x15d
L_8c530c:
	b_s L_8c52c2
	.global L_8c530e
L_8c530e:
	ldw_s r3,[r13]
L_8c5310:
	cmp r3,0x80
L_8c5314:
	mov.lt r14,0x1
L_8c5318:
	blt_s L_8c532e
L_8c531a:
	mov_s r2,0x10072b0
L_8c5320:
	mov_s r0,0x5
L_8c5322:
	mov_s r1,0x2
L_8c5324:
	bl.d L_8edff8
L_8c5328:
	mov r4,0x80
L_8c532c:
	mov_s r14,0x0
	.global L_8c532e
L_8c532e:
	mov_s r0,0x803e84
L_8c5334:
	bl L_8ca80c
L_8c5338:
	ldb_s r3,[r13,0x3]
L_8c533a:
	tst_s r3,r0
L_8c533c:
	mov_s r4,r0
L_8c533e:
	bne_s L_8c5350
L_8c5340:
	mov_s r2,0x100731c
L_8c5346:
	mov_s r0,0x5
L_8c5348:
	bl.d L_8edff8
L_8c534c:
	mov_s r1,0x2
L_8c534e:
	mov_s r14,0x0
	.global L_8c5350
L_8c5350:
	b.d L_8c0334
L_8c5354:
	mov_s r0,r14
L_8c5356:
	nop_s
