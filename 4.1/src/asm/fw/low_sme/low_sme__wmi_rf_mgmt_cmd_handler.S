/* low_sme__wmi_rf_mgmt_cmd_handler @ 0x8e7a9c, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   low_sme::wmi_rf_mgmt_cmd_handler (cmd->rf_mgmt_type=%d)
 *   low_sme.cpp
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit1, fw_sysassert_fatal, low_sme__send_rf_mgmt_status
 */
	.section .text.low_sme__wmi_rf_mgmt_cmd_handler,"ax",@progbits
	.global low_sme__wmi_rf_mgmt_cmd_handler
low_sme__wmi_rf_mgmt_cmd_handler:
	.global L_8e7a9c
L_8e7a9c:
	push_s blink
L_8e7a9e:
	push_s r13
L_8e7aa0:
	mov_s r13,r0
L_8e7aa2:
	mov_s r2,0x100a1fc
L_8e7aa8:
	mov_s r0,0x0
L_8e7aaa:
	mov_s r1,0x2
L_8e7aac:
	bl.d L_8edfcc
L_8e7ab0:
	ld_s r3,[r13]
L_8e7ab2:
	ld_s r0,[r13]
L_8e7ab4:
	breq_s r0,0,L_8e7ad4
L_8e7ab6:
	breq r0,0x1,L_8e7ae8
L_8e7aba:
	breq r0,0x2,L_8e7af2
L_8e7abe:
	mov_s r0,blink
L_8e7ac0:
	mov_s r2,0x100a1b4
L_8e7ac6:
	mov_s r1,0x7c
L_8e7ac8:
	bset_s r1,r1,0xc
L_8e7aca:
	bl.d L_8c82c0
L_8e7ace:
	mov r3,0x20d
L_8e7ad2:
	b_s L_8e7af6
	.global L_8e7ad4
L_8e7ad4:
	mov_s r0,0x8043d4
L_8e7ada:
	mov_s r1,0x1
	.global L_8e7adc
L_8e7adc:
	mov_s r2,0x1
L_8e7ade:
	mov_s r3,0x0
L_8e7ae0:
	bl.d L_8d6a1c
L_8e7ae4:
	mov_s r4,r3
L_8e7ae6:
	b_s L_8e7af6
	.global L_8e7ae8
L_8e7ae8:
	mov_s r0,0x8043d4
L_8e7aee:
	mov_s r1,0x0
L_8e7af0:
	b_s L_8e7adc
	.global L_8e7af2
L_8e7af2:
	bl L_8e1048
	.global L_8e7af6
L_8e7af6:
	b L_8c033c
L_8e7afa:
	nop_s
