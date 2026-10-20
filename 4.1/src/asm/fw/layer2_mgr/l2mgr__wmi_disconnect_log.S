/* l2mgr__wmi_disconnect_log @ 0x8eb448, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI Disconnect MID:[%d] reason = %d  protocol %d
 * Зовут его: discovery_handle_probe_req, dpal__cpl_timeout_evt, low_sme__handle_rf_kill
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit3, mid_list__by_mid, mid_list__disconnect_all
 */
	.section .text.l2mgr__wmi_disconnect_log,"ax",@progbits
	.global l2mgr__wmi_disconnect_log
l2mgr__wmi_disconnect_log:
	.global L_8eb448
L_8eb448:
	push_s blink
L_8eb44a:
	bl L_8c02c0
L_8eb44e:
	mov.f r15,r0
L_8eb452:
	mov.ne r15,0x1
L_8eb456:
	mov_s r13,0x0
L_8eb458:
	b_s L_8eb48a
	.global L_8eb45a
L_8eb45a:
	bl.d L_8ca1b0
L_8eb45e:
	mov_s r0,r13
L_8eb460:
	mov.f r14,r0
L_8eb464:
	beq_s L_8eb488
L_8eb466:
	mov_s r2,0x100c6f0
L_8eb46c:
	mov_s r0,0xb
L_8eb46e:
	mov_s r1,0x2
L_8eb470:
	mov_s r3,r13
L_8eb472:
	add r4,r15,0x1
L_8eb476:
	bl.d L_8ee034
L_8eb47a:
	mov r5,0x3
L_8eb47e:
	mov_s r0,r14
L_8eb480:
	add_s r1,r15,0x1
L_8eb482:
	bl.d L_8c7a60
L_8eb486:
	mov_s r2,0x3
	.global L_8eb488
L_8eb488:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8eb48a
L_8eb48a:
	brlt r13,0x1,L_8eb45a
L_8eb48e:
	b L_8c032c
L_8eb492:
	nop_s
