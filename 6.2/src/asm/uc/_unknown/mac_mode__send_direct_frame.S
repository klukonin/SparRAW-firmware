/* mac_mode__send_direct_frame @ 0x92e978, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__tx_request, brp_responder_transmission_flow
 * Зовёт сам: direct_tx__issue_cmd_33, tx_fifo__write_bytes, uc_wait_direct_tx_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_mode__send_direct_frame
mac_mode__send_direct_frame:
	.global L_92e978
L_92e978:
	push_s blink
L_92e97a:
	mov_s r0,0x800898
L_92e980:
	bl.d L_9257f4
L_92e984:
	mov_s r1,0xa
L_92e986:
	ld_s r0,[gp,-0x14]
L_92e988:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_92e98a:
	st.as r0,[gp,-0x5]
L_92e98e:
	mov_s r0,0x33000443
L_92e994:
	mov_s r32,r0
L_92e996:
	st.ab r0,[r25,0x4]
L_92e99a:
	bclr r25,r25,0xa
L_92e99e:
	bl L_925874
L_92e9a2:
	ld_s r0,[gp,-0x14]
L_92e9a4:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_92e9a6:
	st.as r0,[gp,-0x5]
L_92e9aa:
	mov_s r0,0x33000123
L_92e9b0:
	mov_s r32,r0
L_92e9b2:
	st.ab r0,[r25,0x4]
L_92e9b6:
	bclr r25,r25,0xa
L_92e9ba:
	bl L_925874
L_92e9be:
	mov_s r0,0x800898
L_92e9c4:
	ldw_s r0,[r0,0x16]
L_92e9c6:
	bset r34,r0,0x18
L_92e9ca:
	ld_s r0,[gp,-0x14]
L_92e9cc:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_92e9ce:
	st.as r0,[gp,-0x5]
L_92e9d2:
	mov_s r0,0x8008b0
L_92e9d8:
	bl.d L_9257f4
L_92e9dc:
	mov_s r1,0xe
L_92e9de:
	bl L_925774
L_92e9e2:
	pop_s blink
L_92e9e4:
	j_s [blink]
L_92e9e6:
	nop_s
