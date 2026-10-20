/* scan_mngr__system_state_evt_handler @ 0x8e89f0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::system_state_evt_handler: evt=SYS_STATE_EVT_UNASSOC_DONE cid=%d
 * Зовут его: sys_state__broadcast
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, scan_mngr__handle_unassoc_start_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__system_state_evt_handler
scan_mngr__system_state_evt_handler:
	.global L_8e89f0
L_8e89f0:
	push_s blink
L_8e89f2:
	push_s r13
L_8e89f4:
	mov_s r13,r1
L_8e89f6:
	brne r0,0x7,L_8e8a0e
L_8e89fa:
	mov_s r1,0x10163fc
L_8e8a00:
	mov_s r0,0x2b
L_8e8a02:
	bl.d L_8dcc10
L_8e8a06:
	mov_s r2,r13
L_8e8a08:
	bl.d L_8cdc80
L_8e8a0c:
	mov_s r0,r13
	.global L_8e8a0e
L_8e8a0e:
	b L_8c025c
L_8e8a12:
	nop_s
