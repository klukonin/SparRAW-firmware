/* find_mngr__enter_search @ 0x8f852c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   search()
 * Зовут его: l2_mgr__wmi_cmd_handler_start_search
 * Зовёт сам: __ld_r13_to_r13_ret, find_mng__search, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mngr__enter_search
find_mngr__enter_search:
	.global L_8f852c
L_8f852c:
	push_s blink
L_8f852e:
	push_s r13
L_8f8530:
	mov_s r13,r0
L_8f8532:
	mov_s r1,0x1016fe0
L_8f8538:
	bl.d L_8dcba8
L_8f853c:
	mov_s r0,0x2c
L_8f853e:
	ld_s r0,[r13,0x8]
L_8f8540:
	ld_s r0,[r0,0x78]
L_8f8542:
	brne_s r0,0,L_8f8558
	.global L_8f8544
L_8f8544:
	ld_s r0,[r13,0x4]
L_8f8546:
	ld_s r0,[r0,0x4c]
L_8f8548:
	brne r0,0x1,L_8f8566
	.global L_8f854c
L_8f854c:
	bl.d L_8e4b8c
L_8f8550:
	add r0,r13,0xc
L_8f8554:
	b L_8c025c
	.global L_8f8558
L_8f8558:
	mov_s r0,blink
L_8f855a:
	mov_s r1,0x1239
L_8f8560:
	bl L_8c9b28
L_8f8564:
	b_s L_8f8544
	.global L_8f8566
L_8f8566:
	mov_s r0,blink
L_8f8568:
	mov_s r1,0x123a
L_8f856e:
	bl L_8c9b28
L_8f8572:
	b_s L_8f854c
