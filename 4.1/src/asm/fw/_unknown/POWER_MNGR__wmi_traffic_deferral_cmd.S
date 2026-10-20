/* POWER_MNGR__wmi_traffic_deferral_cmd @ 0x8e7ea8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    POWER_MNGR::wmi_traffic_deferral_cmd (wakeup_trigger = %d)
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, set_g_800241
 */
	.section .text.POWER_MNGR__wmi_traffic_deferral_cmd,"ax",@progbits
	.global POWER_MNGR__wmi_traffic_deferral_cmd
POWER_MNGR__wmi_traffic_deferral_cmd:
	.global L_8e7ea8
L_8e7ea8:
	push_s blink
L_8e7eaa:
	bl L_8c02c4
L_8e7eae:
	mov_s r13,r0
L_8e7eb0:
	mov_s r14,r1
L_8e7eb2:
	mov_s r2,0x100220c
L_8e7eb8:
	mov_s r0,0xe
L_8e7eba:
	mov_s r1,0x2
L_8e7ebc:
	bl.d L_8edfcc
L_8e7ec0:
	ldb_s r3,[r13]
L_8e7ec2:
	mov_s r0,0x803510
L_8e7ec8:
	ldb_s r1,[r13]
L_8e7eca:
	bl.d L_8dc424
L_8e7ece:
	mov_s r2,r14
L_8e7ed0:
	b L_8c0334
