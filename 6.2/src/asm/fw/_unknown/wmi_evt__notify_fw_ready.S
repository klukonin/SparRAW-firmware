/* wmi_evt__notify_fw_ready @ 0x8f5d60, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HOST EVENT (WMI_READY_EVENTID=0x1001): Notify FW ready (OOB mode = %d) Local MAC: ADDR-%04X%08X
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit3, host_if__send_pair, hwd_rfc_read_get_result, low_sme__send_evt2sw, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_evt__notify_fw_ready
wmi_evt__notify_fw_ready:
	.global L_8f5d60
L_8f5d60:
	push_s blink
L_8f5d62:
	bl L_8c01dc
L_8f5d66:
	mov_s r13,r0
L_8f5d68:
	bl.d L_8c32d8
L_8f5d6c:
	mov_s r16,r1
L_8f5d6e:
	mov_s r14,r0
L_8f5d70:
	add_s r0,r0,0x8
L_8f5d72:
	mov_s r1,r13
L_8f5d74:
	bl.d L_8c0380
L_8f5d78:
	mov_s r2,0x6
L_8f5d7a:
	mov r0,0x3e8
L_8f5d7e:
	st_s r0,[r14]
L_8f5d80:
	mov_s r15,0x0
L_8f5d82:
	bl.d L_8f41ac
L_8f5d86:
	stb_s r15,[r14,0xf]
L_8f5d88:
	stb_s r0,[r14,0x10]
L_8f5d8a:
	mov_s r2,0x803c00
L_8f5d90:
	ld_s r0,[r2,0xc]
L_8f5d92:
	mov_s r1,0x100f7e4
L_8f5d98:
	brne_s r0,0,L_8f5da4
L_8f5d9a:
	ld_s r0,[r2,0x10]
L_8f5d9c:
	cmp_s r0,0x0
L_8f5d9e:
	mov.eq r2,r15
L_8f5da2:
	beq_s L_8f5da6
	.global L_8f5da4
L_8f5da4:
	mov_s r2,0x1
	.global L_8f5da6
L_8f5da6:
	extb_s r2,r2
L_8f5da8:
	ld r4,[r13]
L_8f5dac:
	mov_s r0,0x2b
L_8f5dae:
	bl.d L_8dcd00
L_8f5db2:
	ldw_s r3,[r13,0x4]
L_8f5db4:
	mov_s r0,r14
L_8f5db6:
	mov_s r1,0x1
L_8f5db8:
	bset_s r1,r1,0xc
L_8f5dba:
	mov_s r2,0x14
L_8f5dbc:
	mov_s r3,r16
L_8f5dbe:
	mov r4,0x0
L_8f5dc2:
	mov r5,r4
L_8f5dc6:
	bl.d L_8e5474
L_8f5dca:
	mov r6,r4
L_8f5dce:
	b L_8c0244
L_8f5dd2:
	nop_s
