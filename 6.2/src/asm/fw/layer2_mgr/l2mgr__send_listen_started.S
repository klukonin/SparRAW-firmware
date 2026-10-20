/* l2mgr__send_listen_started @ 0x8f89a4, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_LISTEN_STARTED_EVENTID for midid %d.
 * Зовут его: find_mngr__listen_end, l2_mgr__wmi_cmd_handler_start_listen
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, host_if__send_pair, low_sme__send_evt2sw, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_listen_started
l2mgr__send_listen_started:
	.global L_8f89a4
L_8f89a4:
	push_s blink
L_8f89a6:
	bl L_8c01e0
L_8f89aa:
	mov_s r14,r0
L_8f89ac:
	bl.d L_8c32d8
L_8f89b0:
	mov_s r15,r1
L_8f89b2:
	mov_s r13,r0
L_8f89b4:
	bl.d L_8c1cd8
L_8f89b8:
	mov_s r1,0x4
L_8f89ba:
	stb_s r14,[r13]
L_8f89bc:
	mov_s r1,0x100e0e8
L_8f89c2:
	mov_s r0,0x2b
L_8f89c4:
	bl.d L_8dcc10
L_8f89c8:
	mov_s r2,r15
L_8f89ca:
	mov_s r0,r13
L_8f89cc:
	mov_s r1,0x1914
L_8f89d2:
	mov_s r2,0x4
L_8f89d4:
	mov_s r3,r15
L_8f89d6:
	mov r4,0x0
L_8f89da:
	mov r5,r4
L_8f89de:
	bl.d L_8e5474
L_8f89e2:
	mov r6,r4
L_8f89e6:
	b L_8c024c
L_8f89ea:
	nop_s
