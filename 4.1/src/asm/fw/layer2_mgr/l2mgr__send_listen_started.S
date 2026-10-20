/* l2mgr__send_listen_started @ 0x8f0610, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_LISTEN_STARTED_EVENTID for midid %d.
 * Зовут его: find_sm__report_listen_started, l2_mgr__wmi_cmd_handler_start_listen_8f3374
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, memset0_words, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_listen_started,"ax",@progbits
	.global l2mgr__send_listen_started
l2mgr__send_listen_started:
	.global L_8f0610
L_8f0610:
	push_s blink
L_8f0612:
	bl L_8c02c0
L_8f0616:
	mov_s r14,r0
L_8f0618:
	bl.d L_8c2b68
L_8f061c:
	mov_s r15,r1
L_8f061e:
	mov_s r13,r0
L_8f0620:
	bl.d L_8c1a78
L_8f0624:
	mov_s r1,0x4
L_8f0626:
	stb_s r14,[r13]
L_8f0628:
	mov_s r2,0x100d04c
L_8f062e:
	mov_s r0,0xb
L_8f0630:
	mov_s r1,0x2
L_8f0632:
	bl.d L_8edfcc
L_8f0636:
	mov_s r3,r15
L_8f0638:
	mov_s r0,r13
L_8f063a:
	mov_s r1,0x1914
L_8f0640:
	mov_s r2,0x4
L_8f0642:
	mov_s r3,r15
L_8f0644:
	mov r4,0x0
L_8f0648:
	bl.d L_8e0874
L_8f064c:
	mov r5,r4
L_8f0650:
	b L_8c032c
