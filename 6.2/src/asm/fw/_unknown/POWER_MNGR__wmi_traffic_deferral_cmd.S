/* POWER_MNGR__wmi_traffic_deferral_cmd @ 0x8ecf1c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    POWER_MNGR::wmi_traffic_deferral_cmd (wakeup_trigger = %d)
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, power_mngr__set_traffic_deferral
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global POWER_MNGR__wmi_traffic_deferral_cmd
POWER_MNGR__wmi_traffic_deferral_cmd:
	.global L_8ecf1c
L_8ecf1c:
	push_s blink
L_8ecf1e:
	bl L_8c01e4
L_8ecf22:
	mov_s r13,r0
L_8ecf24:
	mov_s r14,r1
L_8ecf26:
	mov_s r1,0x1001ff4
L_8ecf2c:
	mov_s r0,0x2e
L_8ecf2e:
	bl.d L_8dcc10
L_8ecf32:
	ldb_s r2,[r13]
L_8ecf34:
	mov_s r0,0x803d10
L_8ecf3a:
	ldb_s r1,[r13]
L_8ecf3c:
	bl.d L_8e04e8
L_8ecf40:
	mov_s r2,r14
L_8ecf42:
	b L_8c0254
L_8ecf46:
	nop_s
