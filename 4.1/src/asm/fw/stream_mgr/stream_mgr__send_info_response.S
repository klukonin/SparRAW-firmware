/* stream_mgr__send_info_response @ 0x8d54ec, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stream_mgr.cpp
 * Зовут его: info_flow__start_periodic, stream_mgr__info_req
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal, ieee80211_mgt_information_response_construct, tx_api__send_mgmt
 */
	.section .text.stream_mgr__send_info_response,"ax",@progbits
	.global stream_mgr__send_info_response
stream_mgr__send_info_response:
	.global L_8d54ec
L_8d54ec:
	push_s blink
L_8d54ee:
	bl L_8c02b4
L_8d54f2:
	mov_s r18,r0
L_8d54f4:
	mov_s r16,r1
L_8d54f6:
	mov_s r1,0x801f08
L_8d54fc:
	ld_s r0,[r1]
L_8d54fe:
	mov_s r17,r3
L_8d5500:
	st.a r0,[sp,-0x8]
L_8d5504:
	ldw_s r0,[r1,0x4]
L_8d5506:
	mov.f r14,r2
L_8d550a:
	stw r0,[sp, 0x4]
L_8d550e:
	mov.eq r14,sp
L_8d5512:
	bl L_8c2c80
L_8d5516:
	mov.f r13,r0
L_8d551a:
	beq_s L_8d5546
	.global L_8d551c
L_8d551c:
	mov_s r0,r13
L_8d551e:
	mov_s r1,r18
L_8d5520:
	mov_s r2,r16
L_8d5522:
	mov_s r3,r14
L_8d5524:
	bl.d L_8ec920
L_8d5528:
	mov r4,r17
L_8d552c:
	extw r4,r0
L_8d5530:
	mov_s r0,r16
L_8d5532:
	mov_s r1,0x0
L_8d5534:
	mov_s r2,0x1
L_8d5536:
	mov_s r3,r13
L_8d5538:
	mov_s r5,r1
L_8d553a:
	bl.d L_8e0c44
L_8d553e:
	mov_s r6,r1
L_8d5540:
	b.d L_8c0314
L_8d5544:
	add_s sp,sp,0x8
	.global L_8d5546
L_8d5546:
	mov_s r0,blink
L_8d5548:
	mov_s r2,0x100e398
L_8d554e:
	mov_s r1,0x12ea
L_8d5554:
	bl.d L_8c82c0
L_8d5558:
	mov r3,0x2dd
L_8d555c:
	b_s L_8d551c
L_8d555e:
	nop_s
