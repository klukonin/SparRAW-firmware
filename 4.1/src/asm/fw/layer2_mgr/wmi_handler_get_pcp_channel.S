/* wmi_handler_get_pcp_channel @ 0x8f2c88, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_GET_PCP_CHANNEL_EVENTID for devid %d.
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, mid_list__by_mid, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.wmi_handler_get_pcp_channel,"ax",@progbits
	.global wmi_handler_get_pcp_channel
wmi_handler_get_pcp_channel:
	.global L_8f2c88
L_8f2c88:
	push_s blink
L_8f2c8a:
	bl L_8c02c4
L_8f2c8e:
	bl.d L_8c2b68
L_8f2c92:
	mov_s r14,r0
L_8f2c94:
	mov_s r13,r0
L_8f2c96:
	bl.d L_8ca1b0
L_8f2c9a:
	mov_s r0,r14
L_8f2c9c:
	breq_s r0,0,L_8f2ca4
L_8f2c9e:
	ldb r0,[r0, 0x94]
L_8f2ca2:
	b_s L_8f2cac
	.global L_8f2ca4
L_8f2ca4:
	mov_s r0,0x8033dc
L_8f2caa:
	ld_s r0,[r0]
	.global L_8f2cac
L_8f2cac:
	stb_s r0,[r13]
L_8f2cae:
	mov_s r2,0x100ccdc
L_8f2cb4:
	mov_s r0,0xb
L_8f2cb6:
	mov_s r1,0x2
L_8f2cb8:
	bl.d L_8edfcc
L_8f2cbc:
	mov_s r3,r14
L_8f2cbe:
	mov_s r0,r13
L_8f2cc0:
	mov_s r1,0x182a
L_8f2cc6:
	mov_s r2,0x4
L_8f2cc8:
	mov_s r3,r14
L_8f2cca:
	mov r4,0x0
L_8f2cce:
	bl.d L_8e0874
L_8f2cd2:
	mov r5,r4
L_8f2cd6:
	b L_8c0334
L_8f2cda:
	nop_s
