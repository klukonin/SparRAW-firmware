/* ba_sm__send_addba_req @ 0x8e0560, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending ADDBA REQ.
 *   ba_sm.cpp
 * Зовут его: ba_setup_sm__on_tx_permitted
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r20_to_r13_ret, __st_r20_to_r13, frame__build_addba_req, fw_log__emit2, fw_sysassert_fatal, mgmt_tx__begin_frame, mid_list__first_of_field8, tx_api__send_mgmt
 */
	.section .text.ba_sm__send_addba_req,"ax",@progbits
	.global ba_sm__send_addba_req
ba_sm__send_addba_req:
L_8e0560:
	/* b_s 0x008e04ee */
	.byte 0xc7,0xf1
	.global fwlog_Sending_ADDBA_REQ
fwlog_Sending_ADDBA_REQ:
L_8e0562:
	nop_s
	.global L_8e0564
L_8e0564:
	push_s blink
L_8e0566:
	bl L_8c02ac
L_8e056a:
	sub_s sp,sp,0x4
L_8e056c:
	mov_s r17,r0
L_8e056e:
	mov_s r16,r1
L_8e0570:
	mov_s r19,r2
L_8e0572:
	mov_s r18,r3
L_8e0574:
	bl.d L_8c2c80
L_8e0578:
	mov r20,r4
L_8e057c:
	mov_s r14,r0
L_8e057e:
	add3 r13,r17,0x10
L_8e0582:
	bl.d L_8ca1f0
L_8e0586:
	ld_s r0,[r13,0x2c]
L_8e0588:
	mov.f r17,r0
L_8e058c:
	beq_s L_8e0604
	.global L_8e058e
L_8e058e:
	mov_s r15,0x0
L_8e0590:
	st_s r15,[sp,0x0]
L_8e0592:
	ld_s r3,[r13,0x2c]
L_8e0594:
	mov_s r1,sp
L_8e0596:
	ld_s r3,[r3]
L_8e0598:
	mov_s r0,r14
L_8e059a:
	mov_s r2,r17
L_8e059c:
	bl.d L_8e4be4
L_8e05a0:
	mov r4,0xd
L_8e05a4:
	ld_s r0,[sp,0x0]
L_8e05a6:
	ld_s r3,[r13,0x2c]
L_8e05a8:
	add_s r0,r0,r14
L_8e05aa:
	ldw r5,[r3, 0xc8]
L_8e05ae:
	sub.f r6,r20,0x0
L_8e05b2:
	ldb_s r3,[r3,0x4]
L_8e05b4:
	extb r1,r16
L_8e05b8:
	mov.ne r6,0x1
L_8e05bc:
	mov_s r2,r19
L_8e05be:
	bl.d L_8ec5fc
L_8e05c2:
	mov r4,r18
L_8e05c6:
	ld_s r1,[sp,0x0]
L_8e05c8:
	ld_s r3,[r13,0x2c]
L_8e05ca:
	add_s r0,r0,r1
L_8e05cc:
	st_s r0,[sp,0x0]
L_8e05ce:
	ldb r4,[r3, 0x4]
L_8e05d2:
	mov_s r2,0x1010224
L_8e05d8:
	mov_s r0,0xb
L_8e05da:
	mov_s r1,0x2
L_8e05dc:
	bl.d L_8edff8
L_8e05e0:
	ldb_s r3,[r3,0x7]
L_8e05e2:
	ld_s r0,[r13,0x2c]
L_8e05e4:
	mov r5,0x28ec
L_8e05ec:
	ldw r4,[sp]
L_8e05f0:
	mov_s r1,r15
L_8e05f2:
	ld_s r0,[r0]
L_8e05f4:
	mov_s r2,0x1
L_8e05f6:
	mov_s r3,r14
L_8e05f8:
	bl.d L_8e0c44
L_8e05fc:
	mov_s r6,r15
L_8e05fe:
	b.d L_8c0304
L_8e0602:
	add_s sp,sp,0x4
	.global L_8e0604
L_8e0604:
	mov_s r0,blink
L_8e0606:
	mov_s r2,0x10101f0
L_8e060c:
	mov_s r1,0x1283
L_8e0612:
	bl.d L_8c82c0
L_8e0616:
	mov r3,0x14e
L_8e061a:
	b_s L_8e058e
