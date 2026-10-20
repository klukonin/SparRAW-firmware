/* low_sme__send_rf_mgmt_status @ 0x8e1048, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   low_sme.cpp
 *   <<---- [HOST EVENT] WMI_RF_MGMT_STATUS_EVENTID rf_status=%d
 * Зовут его: low_sme__wmi_rf_mgmt_cmd_handler, rf_kill_sm__on_w_disable__disabled, rf_kill_sm__on_w_enable__disabled, rf_kill_sm__on_w_enable__enabled
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, fw_sysassert_fatal, operational_if__alloc_evt, operational_if__send_evt, rw_g_8043d4
 */
	.section .text.low_sme__send_rf_mgmt_status,"ax",@progbits
	.global low_sme__send_rf_mgmt_status
low_sme__send_rf_mgmt_status:
	.global L_8e1048
L_8e1048:
	push_s blink
L_8e104a:
	bl.d L_8c2b68
L_8e104e:
	push_s r13
L_8e1050:
	bl.d L_8ca800
L_8e1054:
	mov_s r13,r0
L_8e1056:
	breq_s r0,0,L_8e107a
L_8e1058:
	breq r0,0x1,L_8e107e
L_8e105c:
	breq r0,0x2,L_8e1082
L_8e1060:
	breq r0,0x3,L_8e1086
L_8e1064:
	mov_s r0,blink
L_8e1066:
	mov_s r2,0x100a1b4
L_8e106c:
	mov_s r1,0x7e
L_8e106e:
	bset_s r1,r1,0xc
L_8e1070:
	bl.d L_8c82c0
L_8e1074:
	mov r3,0x279
L_8e1078:
	b_s L_8e108a
	.global L_8e107a
L_8e107a:
	mov_s r0,0x0
L_8e107c:
	b_s L_8e1088
	.global L_8e107e
L_8e107e:
	mov_s r0,0x1
L_8e1080:
	b_s L_8e1088
	.global L_8e1082
L_8e1082:
	mov_s r0,0x2
L_8e1084:
	b_s L_8e1088
	.global L_8e1086
L_8e1086:
	mov_s r0,0x3
	.global L_8e1088
L_8e1088:
	st_s r0,[r13]
	.global L_8e108a
L_8e108a:
	mov_s r2,0x100a1c0
L_8e1090:
	mov_s r0,0x0
L_8e1092:
	mov_s r1,0x2
L_8e1094:
	bl.d L_8edfcc
L_8e1098:
	ld_s r3,[r13]
L_8e109a:
	mov_s r0,r13
L_8e109c:
	mov_s r1,0x1853
L_8e10a2:
	mov_s r2,0x4
L_8e10a4:
	mov_s r3,0xff
L_8e10a6:
	mov r4,0x0
L_8e10aa:
	bl.d L_8e0874
L_8e10ae:
	mov r5,0x0
L_8e10b2:
	.byte 0x8d,0x02
