/* low_sme__send_rf_mgmt_status @ 0x8e5ce0, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_RF_MGMT_STATUS_EVENTID rf_status=%d
 * Зовут его: low_sme__wmi_rf_mgmt_cmd_handler, rf_mgmt_sm__action_8c6010, rf_mgmt_sm__action_8e247c, rf_mgmt_sm__action_8e248c
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, fw_sysassert_fatal, host_if__send_pair, low_sme__send_evt2sw, oob__mode_flags_default
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global low_sme__send_rf_mgmt_status
low_sme__send_rf_mgmt_status:
	.global L_8e5ce0
L_8e5ce0:
	push_s blink
L_8e5ce2:
	bl.d L_8c32d8
L_8e5ce6:
	push_s r13
L_8e5ce8:
	bl.d L_8ccaf0
L_8e5cec:
	mov_s r13,r0
L_8e5cee:
	breq_s r0,0,L_8e5d08
L_8e5cf0:
	breq r0,0x1,L_8e5d0c
L_8e5cf4:
	breq r0,0x2,L_8e5d10
L_8e5cf8:
	breq r0,0x3,L_8e5d14
L_8e5cfc:
	mov_s r0,blink
L_8e5cfe:
	mov_s r1,0x7e
L_8e5d00:
	bl.d L_8c9b28
L_8e5d04:
	bset_s r1,r1,0xc
L_8e5d06:
	b_s L_8e5d18
	.global L_8e5d08
L_8e5d08:
	mov_s r0,0x0
L_8e5d0a:
	b_s L_8e5d16
	.global L_8e5d0c
L_8e5d0c:
	mov_s r0,0x1
L_8e5d0e:
	b_s L_8e5d16
	.global L_8e5d10
L_8e5d10:
	mov_s r0,0x2
L_8e5d12:
	b_s L_8e5d16
	.global L_8e5d14
L_8e5d14:
	mov_s r0,0x3
	.global L_8e5d16
L_8e5d16:
	st_s r0,[r13]
	.global L_8e5d18
L_8e5d18:
	mov_s r1,0x100b760
L_8e5d1e:
	mov_s r0,0x20
L_8e5d20:
	bl.d L_8dcc10
L_8e5d24:
	ld_s r2,[r13]
L_8e5d26:
	mov_s r0,r13
L_8e5d28:
	mov_s r1,0x1853
L_8e5d2e:
	mov_s r2,0x4
L_8e5d30:
	mov_s r3,0xff
L_8e5d32:
	mov r4,0x0
L_8e5d36:
	mov r5,r4
L_8e5d3a:
	bl.d L_8e5474
L_8e5d3e:
	mov r6,r4
L_8e5d42:
	b L_8c025c
L_8e5d46:
	nop_s
