/* stream_mgr__send_info_response @ 0x8d885c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: perform_first_measurement_operations, stream_mgr__info_req
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal, ieee80211_mgt_information_response_construct, tx_api__send_mgmt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__send_info_response
stream_mgr__send_info_response:
	.global L_8d885c
L_8d885c:
	push_s blink
L_8d885e:
	bl L_8c01d4
L_8d8862:
	mov_s r18,r0
L_8d8864:
	mov_s r16,r1
L_8d8866:
	mov_s r1,0x802424
L_8d886c:
	ld_s r0,[r1]
L_8d886e:
	mov_s r17,r3
L_8d8870:
	st.a r0,[sp,-0x8]
L_8d8874:
	ldw_s r0,[r1,0x4]
L_8d8876:
	mov.f r14,r2
L_8d887a:
	stw r0,[sp, 0x4]
L_8d887e:
	mov.eq r14,sp
L_8d8882:
	bl L_8c3414
L_8d8886:
	mov.f r13,r0
L_8d888a:
	beq_s L_8d88b6
	.global L_8d888c
L_8d888c:
	mov_s r0,r13
L_8d888e:
	mov_s r1,r18
L_8d8890:
	mov_s r2,r16
L_8d8892:
	mov_s r3,r14
L_8d8894:
	bl.d L_8d7e78
L_8d8898:
	mov r4,r17
L_8d889c:
	extw r4,r0
L_8d88a0:
	mov_s r0,r16
L_8d88a2:
	mov_s r1,0x0
L_8d88a4:
	mov_s r2,0x1
L_8d88a6:
	mov_s r3,r13
L_8d88a8:
	mov_s r5,r1
L_8d88aa:
	bl.d L_8e5874
L_8d88ae:
	mov_s r6,r1
L_8d88b0:
	b.d L_8c0234
L_8d88b4:
	add_s sp,sp,0x8
	.global L_8d88b6
L_8d88b6:
	mov_s r0,blink
L_8d88b8:
	mov_s r1,0x12ea
L_8d88be:
	bl L_8c9b28
L_8d88c2:
	b_s L_8d888c
