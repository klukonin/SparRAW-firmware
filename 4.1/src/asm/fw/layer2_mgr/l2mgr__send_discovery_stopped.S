/* l2mgr__send_discovery_stopped @ 0x8f05d0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_DISCOVERY_STOPPED_EVENTID for midid %d.
 * Зовут его: find_sm__stop_discovery
 * Зовёт сам: L2MGR__system_state_evt_handler, __ld_r13_ret, fw_log__emit1, l2_mgr__chk_sys_idle, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_discovery_stopped,"ax",@progbits
	.global l2mgr__send_discovery_stopped
l2mgr__send_discovery_stopped:
	.global L_8f05d0
L_8f05d0:
	push_s blink
L_8f05d2:
	push_s r13
L_8f05d4:
	bl.d L_8c5838
L_8f05d8:
	mov_s r13,r0
L_8f05da:
	mov_s r0,0x10
L_8f05dc:
	bl.d L_8e3a08
L_8f05e0:
	mov_s r1,0x0
L_8f05e2:
	mov_s r2,0x100d534
L_8f05e8:
	mov_s r0,0xb
L_8f05ea:
	mov_s r1,0x2
L_8f05ec:
	bl.d L_8edfcc
L_8f05f0:
	mov_s r3,r13
L_8f05f2:
	bl L_8c2b68
L_8f05f6:
	mov_s r1,0x1917
L_8f05fc:
	mov_s r2,0x0
L_8f05fe:
	mov_s r3,r13
L_8f0600:
	mov r4,0x0
L_8f0604:
	bl.d L_8e0874
L_8f0608:
	mov r5,0x0
L_8f060c:
	b L_8c033c
