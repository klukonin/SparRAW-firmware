/* l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit @ 0x8e769c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_set_mgmt_retry_limit, mng_retry_limit:%d
 *   MGMT RETRY LIMIT[%d] out of range [1...254]
 *   <<---- [HOST EVENT] WMI_SET_MGMT_RETRY_LIMIT_EVENT
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit0, fw_log__emit1, memset0_words, set_g_800240
 */
	.section .text.l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit,"ax",@progbits
	.global l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit
l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit:
	.global L_8e769c
L_8e769c:
	push_s blink
L_8e769e:
	bl L_8c02bc
L_8e76a2:
	mov_s r14,r0
L_8e76a4:
	mov_s r16,r1
L_8e76a6:
	mov_s r15,r2
L_8e76a8:
	mov_s r2,0x100d1b8
L_8e76ae:
	mov_s r0,0xb
L_8e76b0:
	mov_s r1,0x2
L_8e76b2:
	bl.d L_8edfcc
L_8e76b6:
	ldb_s r3,[r14]
L_8e76b8:
	bl.d L_8c2c38
L_8e76bc:
	mov_s r0,r15
L_8e76be:
	mov_s r13,r0
L_8e76c0:
	bl.d L_8c1a78
L_8e76c4:
	mov_s r1,0x4
L_8e76c6:
	mov_s r0,0x1
L_8e76c8:
	stb_s r0,[r13]
L_8e76ca:
	ldb_s r3,[r14]
L_8e76cc:
	cmp r3,0xfe
L_8e76d0:
	mov_s r14,0x0
L_8e76d2:
	bgt_s L_8e76d6
L_8e76d4:
	brne_s r3,0,L_8e76e6
	.global L_8e76d6
L_8e76d6:
	mov_s r2,0x100d1fc
L_8e76dc:
	mov_s r0,0xb
L_8e76de:
	bl.d L_8edfcc
L_8e76e2:
	mov_s r1,0x0
L_8e76e4:
	b_s L_8e76f0
	.global L_8e76e6
L_8e76e6:
	sub_s r0,r3,0x1
L_8e76e8:
	bl.d L_8e1ab4
L_8e76ec:
	extb_s r0,r0
L_8e76ee:
	stb_s r14,[r13]
	.global L_8e76f0
L_8e76f0:
	mov_s r2,0x100d228
L_8e76f6:
	mov_s r0,0xb
L_8e76f8:
	bl.d L_8edfb0
L_8e76fc:
	mov_s r1,0x2
L_8e76fe:
	mov_s r0,r15
L_8e7700:
	mov_s r1,r13
L_8e7702:
	mov_s r2,0x0
L_8e7704:
	mov_s r3,0x1930
L_8e770a:
	mov r4,0x4
L_8e770e:
	mov r5,r16
L_8e7712:
	mov_s r6,r2
L_8e7714:
	bl.d L_8e0460
L_8e7718:
	mov_s r7,r2
L_8e771a:
	b L_8c0324
L_8e771e:
	nop_s
