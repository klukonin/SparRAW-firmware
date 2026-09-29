/* wmi_get_assoc_list @ 0x8ec68c, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_GET_ASSOC_LIST_RES_EVENT
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, conn_mgr__by_cid, fw_log_emit0, mem_pool__alloc_locked, memcpy_fw, memset0_words, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_get_assoc_list
wmi_get_assoc_list:
	.global L_8ec68c
L_8ec68c:
	push_s blink
L_8ec68e:
	bl L_8c01c8
L_8ec692:
	sub_s sp,sp,0x4
L_8ec694:
	mov_s r20,r0
L_8ec696:
	bl.d L_8c33d0
L_8ec69a:
	mov_s r21,r1
L_8ec69c:
	mov_s r16,r0
L_8ec69e:
	bl.d L_8c1cd8
L_8ec6a2:
	mov_s r1,0x40
L_8ec6a4:
	mov r19,0x0
L_8ec6a8:
	add3 r17,r16,0x8
L_8ec6ac:
	stb r19,[r17]
L_8ec6b0:
	mov_s r13,r19
L_8ec6b2:
	b_s L_8ec6ec
	.global L_8ec6b4
L_8ec6b4:
	bl.d L_8cbffc
L_8ec6b8:
	mov_s r0,r13
L_8ec6ba:
	mov.f r14,r0
L_8ec6be:
	beq_s L_8ec6ea
L_8ec6c0:
	ldb r0,[r14, 0xf0]
L_8ec6c4:
	brne r0,0x2,L_8ec6ea
L_8ec6c8:
	ldb r18,[r17]
L_8ec6cc:
	add r1,r14,0x1c
L_8ec6d0:
	add3 r15,r16,r18
L_8ec6d4:
	mov_s r0,r15
L_8ec6d6:
	bl.d L_8c0380
L_8ec6da:
	mov_s r2,0x6
L_8ec6dc:
	ldw_s r0,[r14,0xc]
L_8ec6de:
	add r1,r18,0x1
L_8ec6e2:
	stb_s r0,[r15,0x6]
L_8ec6e4:
	extb_s r1,r1
L_8ec6e6:
	stb r1,[r17]
	.global L_8ec6ea
L_8ec6ea:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8ec6ec
L_8ec6ec:
	brlo r13,0x8,L_8ec6b4
L_8ec6f0:
	mov_s r1,0x1006914
L_8ec6f6:
	bl.d L_8dcba8
L_8ec6fa:
	mov_s r0,0x20
L_8ec6fc:
	st r19,[sp]
L_8ec700:
	mov_s r0,r20
L_8ec702:
	mov_s r1,r16
L_8ec704:
	mov_s r2,0x0
L_8ec706:
	mov_s r3,0x1a06
L_8ec70c:
	mov r4,0x44
L_8ec710:
	mov r5,r21
L_8ec714:
	mov_s r6,r2
L_8ec716:
	bl.d L_8e4fc4
L_8ec71a:
	mov_s r7,r2
L_8ec71c:
	b.d L_8c021c
L_8ec720:
	add_s sp,sp,0x4
L_8ec722:
	nop_s
