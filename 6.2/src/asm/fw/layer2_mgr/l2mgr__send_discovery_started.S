/* l2mgr__send_discovery_started @ 0x8f88d4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_DISCOVERY_STARTED_EVENTID for midid %d.
 * Зовут его: find_mngr__session_start
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, host_if__send_pair, low_sme__send_evt2sw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_discovery_started
l2mgr__send_discovery_started:
	.global L_8f88d4
L_8f88d4:
	push_s blink
L_8f88d6:
	push_s r13
L_8f88d8:
	mov_s r13,r0
L_8f88da:
	mov_s r1,0x100ec10
L_8f88e0:
	mov_s r0,0x2b
L_8f88e2:
	bl.d L_8dcc10
L_8f88e6:
	mov_s r2,r13
L_8f88e8:
	bl L_8c32d8
L_8f88ec:
	mov_s r1,0x1916
L_8f88f2:
	mov_s r2,0x0
L_8f88f4:
	mov_s r3,r13
L_8f88f6:
	mov_s r4,r2
L_8f88f8:
	mov_s r5,r2
L_8f88fa:
	bl.d L_8e5474
L_8f88fe:
	mov_s r6,r2
L_8f8900:
	b L_8c025c
