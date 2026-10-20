/* l2mgr__send_search_started @ 0x8f0a4c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SEARCH_STARTED_EVENTID for midid %d (status %d).
 * Зовут его: find_sm__report_search_started, l2_mgr__wmi_cmd_handler_start_search_8f33b8
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, memset0_words, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_search_started,"ax",@progbits
	.global l2mgr__send_search_started
l2mgr__send_search_started:
	.global L_8f0a4c
L_8f0a4c:
	push_s blink
L_8f0a4e:
	bl L_8c02c0
L_8f0a52:
	mov_s r15,r0
L_8f0a54:
	bl.d L_8c2b68
L_8f0a58:
	mov_s r14,r1
L_8f0a5a:
	mov_s r13,r0
L_8f0a5c:
	bl.d L_8c1a78
L_8f0a60:
	mov_s r1,0x4
L_8f0a62:
	stb_s r15,[r13]
L_8f0a64:
	mov_s r2,0x100d0ec
L_8f0a6a:
	mov_s r0,0xb
L_8f0a6c:
	mov_s r1,0x2
L_8f0a6e:
	mov_s r3,r14
L_8f0a70:
	bl.d L_8edff8
L_8f0a74:
	mov_s r4,r15
L_8f0a76:
	mov_s r0,r13
L_8f0a78:
	mov_s r1,0x1915
L_8f0a7e:
	mov_s r2,0x4
L_8f0a80:
	mov_s r3,r14
L_8f0a82:
	mov r4,0x0
L_8f0a86:
	bl.d L_8e0874
L_8f0a8a:
	mov r5,r4
L_8f0a8e:
	b L_8c032c
L_8f0a92:
	nop_s
