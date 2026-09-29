/* l2mgr__send_discovery_started @ 0x8f05a0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_DISCOVERY_STARTED_EVENTID for midid %d.
 * Зовут его: find_mngr__session_start
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_discovery_started,"ax",@progbits
	.global l2mgr__send_discovery_started
l2mgr__send_discovery_started:
	.global L_8f05a0
L_8f05a0:
	push_s blink
L_8f05a2:
	push_s r13
L_8f05a4:
	mov_s r13,r0
L_8f05a6:
	mov_s r2,0x100d4f4
L_8f05ac:
	mov_s r0,0xb
L_8f05ae:
	mov_s r1,0x2
L_8f05b0:
	bl.d L_8edfcc
L_8f05b4:
	mov_s r3,r13
L_8f05b6:
	bl L_8c2b68
L_8f05ba:
	mov_s r1,0x1916
L_8f05c0:
	mov_s r2,0x0
L_8f05c2:
	mov_s r3,r13
L_8f05c4:
	mov_s r4,r2
L_8f05c6:
	bl.d L_8e0874
L_8f05ca:
	mov_s r5,r2
L_8f05cc:
	b L_8c033c
