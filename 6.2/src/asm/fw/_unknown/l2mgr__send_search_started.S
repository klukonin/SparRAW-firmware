/* l2mgr__send_search_started @ 0x8f8d74, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SEARCH_STARTED_EVENTID for midid %d (status %d).
 * Зовут его: find_mngr__search_end, l2_mgr__wmi_cmd_handler_start_search
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, host_if__send_pair, low_sme__send_evt2sw, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_search_started
l2mgr__send_search_started:
	.global L_8f8d74
L_8f8d74:
	push_s blink
L_8f8d76:
	bl L_8c01e0
L_8f8d7a:
	mov_s r14,r0
L_8f8d7c:
	bl.d L_8c32d8
L_8f8d80:
	mov_s r15,r1
L_8f8d82:
	mov_s r13,r0
L_8f8d84:
	bl.d L_8c1cd8
L_8f8d88:
	mov_s r1,0x4
L_8f8d8a:
	stb_s r14,[r13]
L_8f8d8c:
	mov_s r1,0x100e188
L_8f8d92:
	mov_s r0,0x2b
L_8f8d94:
	mov_s r2,r15
L_8f8d96:
	bl.d L_8dcc80
L_8f8d9a:
	mov_s r3,r14
L_8f8d9c:
	mov_s r0,r13
L_8f8d9e:
	mov_s r1,0x1915
L_8f8da4:
	mov_s r2,0x4
L_8f8da6:
	mov_s r3,r15
L_8f8da8:
	mov r4,0x0
L_8f8dac:
	mov r5,r4
L_8f8db0:
	bl.d L_8e5474
L_8f8db4:
	mov r6,r4
L_8f8db8:
	b L_8c024c
