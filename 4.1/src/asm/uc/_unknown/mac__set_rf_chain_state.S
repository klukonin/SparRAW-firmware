/* mac__set_rf_chain_state @ 0x92b934, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__rx_flow_body, cf_end__tx_flow, get_g_80087c, internal_tx_step, mac_mode_program_a, mac_mode_program_b, rx_rfc_step, shallow_sleep_rfc_step, tx_flows__program_mac_tx, tx_mtp_queue_gate
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc
 */
	.section .text.mac__set_rf_chain_state,"ax",@progbits
	.global mac__set_rf_chain_state
mac__set_rf_chain_state:
	.global L_92b934
L_92b934:
	push_s blink
L_92b936:
	bl L_920214
L_92b93a:
	mov_s r14,r0
L_92b93c:
	mov_s r13,r1
L_92b93e:
	mov_s r0,0x1f003000
L_92b944:
	mov_s r32,r0
L_92b946:
	st.ab r0,[r25,0x4]
L_92b94a:
	bclr r25,r25,0xa
L_92b94e:
	mov_s r0,0x3c000300
L_92b954:
	mov_s r32,r0
L_92b956:
	st.ab r0,[r25,0x4]
L_92b95a:
	bclr r25,r25,0xa
L_92b95e:
	mov_s r0,0x3a00000f
L_92b964:
	mov_s r32,r0
L_92b966:
	st.ab r0,[r25,0x4]
L_92b96a:
	bclr r25,r25,0xa
L_92b96e:
	asl_s r0,r14,0x4
L_92b970:
	bset_s r0,r0,0x9
L_92b972:
	bset_s r0,r0,0x19
L_92b974:
	bset_s r0,r0,0x1a
L_92b976:
	mov_s r32,r0
L_92b978:
	st.ab r0,[r25,0x4]
L_92b97c:
	bclr r25,r25,0xa
L_92b980:
	mov_s r0,0x3b000001
L_92b986:
	mov_s r32,r0
L_92b988:
	st.ab r0,[r25,0x4]
L_92b98c:
	bclr r25,r25,0xa
L_92b990:
	mov_s r0,0x3b000006
L_92b996:
	mov_s r32,r0
L_92b998:
	st.ab r0,[r25,0x4]
L_92b99c:
	bclr r25,r25,0xa
L_92b9a0:
	bset r0,r13,0x1e
L_92b9a4:
	mov_s r32,r0
L_92b9a6:
	st.ab r0,[r25,0x4]
L_92b9aa:
	bclr r25,r25,0xa
L_92b9ae:
	b.d L_920284
L_92b9b2:
	st.as r13,[gp,-0xc]
L_92b9b6:
	nop_s
