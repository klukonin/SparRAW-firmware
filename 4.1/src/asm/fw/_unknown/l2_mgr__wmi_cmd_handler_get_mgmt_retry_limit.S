/* l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit @ 0x8e7628, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_get_mgmt_retry_limit
 *   <<---- [HOST EVENT] WMI_GET_MGMT_RETRY_LIMIT_EVENT
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit0, get_g_800240, memset0_words
 */
	.section .text.l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit,"ax",@progbits
	.global l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit
l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit:
	.global L_8e7628
L_8e7628:
	push_s blink
L_8e762a:
	bl L_8c02c0
L_8e762e:
	mov_s r15,r0
L_8e7630:
	mov_s r14,r1
L_8e7632:
	mov_s r2,0x100d25c
L_8e7638:
	mov_s r0,0xb
L_8e763a:
	bl.d L_8edfb0
L_8e763e:
	mov_s r1,0x2
L_8e7640:
	bl.d L_8c2c38
L_8e7644:
	mov_s r0,r14
L_8e7646:
	mov_s r13,r0
L_8e7648:
	bl.d L_8c1a78
L_8e764c:
	mov_s r1,0x4
L_8e764e:
	bl L_8ca1a4
L_8e7652:
	cmp r0,0xfe
L_8e7656:
	stb_s r0,[r13]
L_8e7658:
	bgt_s L_8e765e
L_8e765a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e765c:
	stb_s r0,[r13]
	.global L_8e765e
L_8e765e:
	mov_s r2,0x100d28c
L_8e7664:
	mov_s r0,0xb
L_8e7666:
	bl.d L_8edfb0
L_8e766a:
	mov_s r1,0x2
L_8e766c:
	mov_s r0,r14
L_8e766e:
	mov_s r1,r13
L_8e7670:
	mov_s r2,0x0
L_8e7672:
	mov_s r3,0x1931
L_8e7678:
	mov r4,0x4
L_8e767c:
	mov_s r5,r15
L_8e767e:
	mov_s r6,r2
L_8e7680:
	bl.d L_8e0460
L_8e7684:
	mov_s r7,r2
L_8e7686:
	b L_8c032c
L_8e768a:
	nop_s
