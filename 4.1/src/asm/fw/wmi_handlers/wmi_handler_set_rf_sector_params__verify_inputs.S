/* wmi_handler_set_rf_sector_params__verify_inputs @ 0x8c5358, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_set_rf_sector_params::verify_inputs: Bad sector_type=%d detected, must be either %d(RX) or %d(TX)
 *   wmi_handler_det_rf_sector_params::check_inputs_valid(): Bad pointer detected p_cmd=0x%X, p_host_if=0x%X, dummy=%d
 *   wmi_handlers.cpp
 *   wmi_handler_set_rf_sector_params::verify_inputs: Bad sector_idx=%d detected, must be in range [0,%d]
 *   wmi_handler_set_rf_sector_params::verify_inputs: Bad rf_modules_vec=0x%X detected, should specify at least one attached&enabled destination RF module rfc_enabled=0x%X
 * Зовут его: wmi_handler_set_rf_sector_params__set
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, get_g_800227
 */
	.section .text.wmi_handler_set_rf_sector_params__verify_inputs,"ax",@progbits
	.global wmi_handler_set_rf_sector_params__verify_inputs
wmi_handler_set_rf_sector_params__verify_inputs:
	.global L_8c5358
L_8c5358:
	push_s blink
L_8c535a:
	bl.d L_8c02c4
L_8c535e:
	mov_s r4,r2
L_8c5360:
	mov.f r13,r1
L_8c5364:
	cmp.ne r4,0x0
L_8c5368:
	beq_s L_8c538c
	.global L_8c536a
L_8c536a:
	ldb_s r3,[r13,0x2]
L_8c536c:
	cmp_s r3,0x0
L_8c536e:
	cmp.ne r3,0x1
L_8c5372:
	beq_s L_8c53b6
L_8c5374:
	mov_s r2,0x1007624
L_8c537a:
	mov_s r0,0x5
L_8c537c:
	mov_s r1,0x2
L_8c537e:
	mov_s r14,0x0
L_8c5380:
	mov_s r4,r14
L_8c5382:
	bl.d L_8ee034
L_8c5386:
	mov r5,0x1
L_8c538a:
	b_s L_8c53f8
	.global L_8c538c
L_8c538c:
	mov_s r2,0x1007694
L_8c5392:
	mov_s r0,0x0
L_8c5394:
	mov_s r1,r0
L_8c5396:
	mov_s r3,r13
L_8c5398:
	bl.d L_8ee034
L_8c539c:
	mov_s r5,r0
L_8c539e:
	mov_s r0,blink
L_8c53a0:
	mov_s r2,0x100710c
L_8c53a6:
	mov_s r1,0x1467
L_8c53ac:
	bl.d L_8c82c0
L_8c53b0:
	mov r3,0x1fa
L_8c53b4:
	b_s L_8c536a
	.global L_8c53b6
L_8c53b6:
	ldw_s r3,[r13]
L_8c53b8:
	cmp r3,0x80
L_8c53bc:
	mov.lt r14,0x1
L_8c53c0:
	blt_s L_8c53d6
L_8c53c2:
	mov_s r2,0x1007708
L_8c53c8:
	mov_s r0,0x5
L_8c53ca:
	mov_s r1,0x2
L_8c53cc:
	bl.d L_8edff8
L_8c53d0:
	mov r4,0x80
L_8c53d4:
	mov_s r14,0x0
	.global L_8c53d6
L_8c53d6:
	mov_s r0,0x803e84
L_8c53dc:
	bl L_8ca80c
L_8c53e0:
	ldb_s r3,[r13,0x3]
L_8c53e2:
	tst_s r3,r0
L_8c53e4:
	mov_s r4,r0
L_8c53e6:
	bne_s L_8c53f8
L_8c53e8:
	mov_s r2,0x1007770
L_8c53ee:
	mov_s r0,0x5
L_8c53f0:
	bl.d L_8edff8
L_8c53f4:
	mov_s r1,0x2
L_8c53f6:
	mov_s r14,0x0
	.global L_8c53f8
L_8c53f8:
	b.d L_8c0334
L_8c53fc:
	mov_s r0,r14
L_8c53fe:
	nop_s
