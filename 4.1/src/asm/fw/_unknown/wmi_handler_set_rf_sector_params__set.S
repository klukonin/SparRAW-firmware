/* wmi_handler_set_rf_sector_params__set @ 0x8e11c4, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_set_rf_sector_params::set: Cannot execute command since radio is still locked by previous request. m_radio_handle=0x%X
 *   wmi_handler_set_rf_sector_params::set: Cannot execute command due to BAD_PARAMETERS_ERROR
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit0, fw_log__emit1, memcpy_fw, memset0_words, wmi_handler_set_rf_sector_params__verify_inputs
 */
	.section .text.wmi_handler_set_rf_sector_params__set,"ax",@progbits
	.global wmi_handler_set_rf_sector_params__set
wmi_handler_set_rf_sector_params__set:
	.global L_8e11c4
L_8e11c4:
	push_s blink
L_8e11c6:
	bl L_8c02b8
L_8e11ca:
	mov_s r16,r0
L_8e11cc:
	add3 r15,r0,0x10
L_8e11d0:
	ld_s r3,[r15,0x48]
L_8e11d2:
	mov_s r14,r2
L_8e11d4:
	mov_s r17,r1
L_8e11d6:
	mov_s r13,0x0
L_8e11d8:
	breq_s r3,0,L_8e11ec
L_8e11da:
	mov_s r2,0x1007818
L_8e11e0:
	mov_s r0,0x5
L_8e11e2:
	bl.d L_8edfcc
L_8e11e6:
	mov_s r1,0x2
L_8e11e8:
	mov_s r13,0x2
L_8e11ea:
	b_s L_8e1212
	.global L_8e11ec
L_8e11ec:
	bl L_8c5358
L_8e11f0:
	breq_s r0,0,L_8e1202
L_8e11f2:
	mov_s r0,r16
L_8e11f4:
	mov_s r1,r17
L_8e11f6:
	bl.d L_8c0460
L_8e11fa:
	mov_s r2,0xc4
L_8e11fc:
	st_s r13,[r15,0x48]
L_8e11fe:
	st_s r14,[r15,0x44]
L_8e1200:
	b_s L_8e1212
	.global L_8e1202
L_8e1202:
	mov_s r2,0x100789c
L_8e1208:
	mov_s r0,0x5
L_8e120a:
	bl.d L_8edfb0
L_8e120e:
	mov_s r1,0x2
L_8e1210:
	mov_s r13,0x1
	.global L_8e1212
L_8e1212:
	mov_s r0,0x1
L_8e1214:
	breq_s r13,0,L_8e1244
L_8e1216:
	bl.d L_8c2c38
L_8e121a:
	mov_s r0,r14
L_8e121c:
	mov_s r15,r0
L_8e121e:
	bl.d L_8c1a78
L_8e1222:
	mov_s r1,0x1
L_8e1224:
	stb_s r13,[r15]
L_8e1226:
	mov_s r0,r14
L_8e1228:
	mov_s r1,r15
L_8e122a:
	mov_s r13,0x0
L_8e122c:
	mov_s r2,r13
L_8e122e:
	mov_s r3,0x19a1
L_8e1234:
	mov r4,0x1
L_8e1238:
	mov_s r5,r13
L_8e123a:
	mov_s r6,r13
L_8e123c:
	bl.d L_8e0460
L_8e1240:
	mov_s r7,r13
L_8e1242:
	mov_s r0,r13
	.global L_8e1244
L_8e1244:
	b L_8c031c
