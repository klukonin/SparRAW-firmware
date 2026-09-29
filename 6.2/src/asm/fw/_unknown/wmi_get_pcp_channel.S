/* wmi_get_pcp_channel @ 0x8fb5ec, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_GET_PCP_CHANNEL_EVENTID for devid %d.
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, mem_pool__alloc_locked, mid_list__by_mid_fw, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_get_pcp_channel
wmi_get_pcp_channel:
	.global L_8fb5ec
L_8fb5ec:
	push_s blink
L_8fb5ee:
	bl L_8c01e0
L_8fb5f2:
	sub_s sp,sp,0x4
L_8fb5f4:
	mov_s r14,r0
L_8fb5f6:
	mov_s r15,r1
L_8fb5f8:
	bl.d L_8c33d0
L_8fb5fc:
	mov_s r0,r1
L_8fb5fe:
	mov_s r13,r0
L_8fb600:
	bl.d L_8cc3dc
L_8fb604:
	mov_s r0,r14
L_8fb606:
	breq_s r0,0,L_8fb60e
L_8fb608:
	ldb r0,[r0, 0x94]
L_8fb60c:
	b_s L_8fb616
	.global L_8fb60e
L_8fb60e:
	mov_s r0,0x803b80
L_8fb614:
	ld_s r0,[r0]
	.global L_8fb616
L_8fb616:
	stb_s r0,[r13]
L_8fb618:
	mov_s r1,0x100dc44
L_8fb61e:
	mov_s r0,0x2b
L_8fb620:
	bl.d L_8dcc10
L_8fb624:
	mov_s r2,r14
L_8fb626:
	mov_s r2,0x0
L_8fb628:
	st_s r2,[sp,0x0]
L_8fb62a:
	mov_s r0,r15
L_8fb62c:
	mov_s r1,r13
L_8fb62e:
	mov_s r3,0x182a
L_8fb634:
	mov r4,0x4
L_8fb638:
	mov_s r5,r14
L_8fb63a:
	mov_s r6,r2
L_8fb63c:
	bl.d L_8e4fc4
L_8fb640:
	mov_s r7,r2
L_8fb642:
	b.d L_8c024c
L_8fb646:
	add_s sp,sp,0x4
