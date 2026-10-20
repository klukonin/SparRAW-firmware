/* wmi_handler_get_rf_sector_params__set @ 0x8e1144, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_get_rf_sector_params::set: Cannot execute command since radio is still locked by previous request. m_radio_handle=0x%X
 *   wmi_handler_get_rf_sector_params::set: Cannot execute command due to BAD_PARAMETERS_ERROR
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit0, fw_log__emit1, memcpy_fw, memset0_words, wmi_handler_get_rf_sector_params__check_inputs_valid
 */
	.section .text.wmi_handler_get_rf_sector_params__set,"ax",@progbits
	.global wmi_handler_get_rf_sector_params__set
wmi_handler_get_rf_sector_params__set:
	.global L_8e1144
L_8e1144:
	push_s blink
L_8e1146:
	bl L_8c02bc
L_8e114a:
	mov_s r15,r0
L_8e114c:
	ld_s r3,[r0,0x8]
L_8e114e:
	mov_s r14,r2
L_8e1150:
	mov_s r16,r1
L_8e1152:
	mov_s r13,0x0
L_8e1154:
	breq_s r3,0,L_8e1168
L_8e1156:
	mov_s r2,0x10073cc
L_8e115c:
	mov_s r0,0x5
L_8e115e:
	bl.d L_8edfcc
L_8e1162:
	mov_s r1,0x2
L_8e1164:
	mov_s r13,0x2
L_8e1166:
	b_s L_8e118e
	.global L_8e1168
L_8e1168:
	bl L_8c52b0
L_8e116c:
	breq_s r0,0,L_8e117e
L_8e116e:
	mov_s r0,r15
L_8e1170:
	mov_s r1,r16
L_8e1172:
	bl.d L_8c0460
L_8e1176:
	mov_s r2,0x4
L_8e1178:
	st_s r13,[r15,0x8]
L_8e117a:
	st_s r14,[r15,0x4]
L_8e117c:
	b_s L_8e118e
	.global L_8e117e
L_8e117e:
	mov_s r2,0x1007450
L_8e1184:
	mov_s r0,0x5
L_8e1186:
	bl.d L_8edfb0
L_8e118a:
	mov_s r1,0x2
L_8e118c:
	mov_s r13,0x1
	.global L_8e118e
L_8e118e:
	mov_s r0,0x1
L_8e1190:
	breq_s r13,0,L_8e11be
L_8e1192:
	bl.d L_8c2c38
L_8e1196:
	mov_s r0,r14
L_8e1198:
	mov_s r15,r0
L_8e119a:
	bl.d L_8c1a78
L_8e119e:
	mov_s r1,0xd0
L_8e11a0:
	stb_s r13,[r15]
L_8e11a2:
	mov_s r0,r14
L_8e11a4:
	mov_s r1,r15
L_8e11a6:
	mov_s r13,0x0
L_8e11a8:
	mov_s r2,r13
L_8e11aa:
	mov_s r3,0xcd
L_8e11ac:
	/* asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8e11ae:
	mov r4,0xd0
L_8e11b2:
	mov_s r5,r13
L_8e11b4:
	mov_s r6,r13
L_8e11b6:
	bl.d L_8e0460
L_8e11ba:
	mov_s r7,r13
L_8e11bc:
	mov_s r0,r13
	.global L_8e11be
L_8e11be:
	b L_8c0324
L_8e11c2:
	nop_s
