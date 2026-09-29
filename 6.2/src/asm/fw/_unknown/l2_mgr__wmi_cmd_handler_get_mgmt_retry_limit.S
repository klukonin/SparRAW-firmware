/* l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit @ 0x8ec200, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_get_mgmt_retry_limit
 *   <<---- [HOST EVENT] WMI_GET_MGMT_RETRY_LIMIT_EVENT
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, mem_pool__alloc_locked, memset0_words, tx_api__get_mgmt_retry_limit, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit
l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit:
	.global L_8ec200
L_8ec200:
	push_s blink
L_8ec202:
	bl L_8c01e0
L_8ec206:
	sub_s sp,sp,0x4
L_8ec208:
	mov_s r15,r0
L_8ec20a:
	mov_s r14,r1
L_8ec20c:
	mov_s r1,0x100e3c4
L_8ec212:
	bl.d L_8dcba8
L_8ec216:
	mov_s r0,0x2b
L_8ec218:
	bl.d L_8c33d0
L_8ec21c:
	mov_s r0,r14
L_8ec21e:
	mov_s r13,r0
L_8ec220:
	bl.d L_8c1cd8
L_8ec224:
	mov_s r1,0x4
L_8ec226:
	bl L_8cc3d0
L_8ec22a:
	cmp r0,0xfe
L_8ec22e:
	stb_s r0,[r13]
L_8ec230:
	bgt_s L_8ec236
L_8ec232:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ec234:
	stb_s r0,[r13]
	.global L_8ec236
L_8ec236:
	mov_s r1,0x100e3f4
L_8ec23c:
	bl.d L_8dcba8
L_8ec240:
	mov_s r0,0x2b
L_8ec242:
	mov_s r2,0x0
L_8ec244:
	st_s r2,[sp,0x0]
L_8ec246:
	mov_s r0,r14
L_8ec248:
	mov_s r1,r13
L_8ec24a:
	mov_s r3,0x1931
L_8ec250:
	mov r4,0x4
L_8ec254:
	mov_s r5,r15
L_8ec256:
	mov_s r6,r2
L_8ec258:
	bl.d L_8e4fc4
L_8ec25c:
	mov_s r7,r2
L_8ec25e:
	b.d L_8c024c
L_8ec262:
	add_s sp,sp,0x4
