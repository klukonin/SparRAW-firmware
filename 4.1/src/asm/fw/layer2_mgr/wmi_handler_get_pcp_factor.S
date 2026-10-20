/* wmi_handler_get_pcp_factor @ 0x8f2cdc, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_PCP_FACTOR_EVENTID for devid %d.
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, mid_list__by_mid, operational_if__alloc_evt, operational_if__send_evt, pcp_factor_evt_step
 */
	.section .text.wmi_handler_get_pcp_factor,"ax",@progbits
	.global wmi_handler_get_pcp_factor
wmi_handler_get_pcp_factor:
	.global L_8f2cdc
L_8f2cdc:
	push_s blink
L_8f2cde:
	bl L_8c02c4
L_8f2ce2:
	bl.d L_8c2b68
L_8f2ce6:
	mov_s r13,r0
L_8f2ce8:
	mov_s r14,r0
L_8f2cea:
	bl.d L_8ca1b0
L_8f2cee:
	mov_s r0,r13
L_8f2cf0:
	add_s r0,r0,0x48
L_8f2cf2:
	add1 r1,r0,0x2f
L_8f2cf6:
	ld.as r2,[gp,-0x17]
L_8f2cfa:
	bl.d L_8c4a40
L_8f2cfe:
	mov_s r3,r14
L_8f2d00:
	mov_s r2,0x100d010
L_8f2d06:
	mov_s r0,0xb
L_8f2d08:
	mov_s r1,0x2
L_8f2d0a:
	bl.d L_8edfcc
L_8f2d0e:
	mov_s r3,r13
L_8f2d10:
	mov_s r0,r14
L_8f2d12:
	mov_s r1,0x191a
L_8f2d18:
	mov_s r2,0x4
L_8f2d1a:
	mov_s r3,r13
L_8f2d1c:
	mov r4,0x0
L_8f2d20:
	bl.d L_8e0874
L_8f2d24:
	mov r5,r4
L_8f2d28:
	b L_8c0334
