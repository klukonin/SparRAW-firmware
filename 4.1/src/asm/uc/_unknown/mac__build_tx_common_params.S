/* mac__build_tx_common_params @ 0x92bb2c, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_txss_sweep_step, bi_manager__rx_flow_body, cf_end__tx_flow, direct_tx_step, internal_tx_step, tx_mtp__open_window, tx_rate_select_and_program, txop__open_window
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc
 */
	.section .text.mac__build_tx_common_params,"ax",@progbits
	.global mac__build_tx_common_params
mac__build_tx_common_params:
	.global L_92bb2c
L_92bb2c:
	push_s blink
L_92bb2e:
	bl L_920210
L_92bb32:
	mov_s r14,r0
L_92bb34:
	mov_s r13,r1
L_92bb36:
	mov_s r15,r2
L_92bb38:
	mov_s r0,0x1f006000
L_92bb3e:
	mov_s r32,r0
L_92bb40:
	st.ab r0,[r25,0x4]
L_92bb44:
	bclr r25,r25,0xa
L_92bb48:
	mov_s r0,0x38000300
L_92bb4e:
	mov_s r32,r0
L_92bb50:
	st.ab r0,[r25,0x4]
L_92bb54:
	bclr r25,r25,0xa
L_92bb58:
	mov_s r0,0x3600003f
L_92bb5e:
	mov_s r32,r0
L_92bb60:
	st.ab r0,[r25,0x4]
L_92bb64:
	bclr r25,r25,0xa
L_92bb68:
	bset_s r14,r14,0x8
L_92bb6a:
	bset_s r14,r14,0x19
L_92bb6c:
	bset_s r14,r14,0x1a
L_92bb6e:
	mov_s r32,r14
L_92bb70:
	st.ab r14,[r25,0x4]
L_92bb74:
	bclr r25,r25,0xa
L_92bb78:
	mov_s r0,0x37000005
L_92bb7e:
	mov_s r32,r0
L_92bb80:
	st.ab r0,[r25,0x4]
L_92bb84:
	bclr r25,r25,0xa
L_92bb88:
	mov_s r0,0x37000002
L_92bb8e:
	mov_s r32,r0
L_92bb90:
	st.ab r0,[r25,0x4]
L_92bb94:
	bclr r25,r25,0xa
L_92bb98:
	or r13,r13,0x3f000000
L_92bba0:
	mov_s r32,r13
L_92bba2:
	st.ab r13,[r25,0x4]
L_92bba6:
	bclr r25,r25,0xa
L_92bbaa:
	/* asl_s r15,r15,0x4 */
	.byte 0x04,0xbf
L_92bbac:
	or r15,r15,0x3e000000
L_92bbb4:
	mov_s r32,r15
L_92bbb6:
	st.ab r15,[r25,0x4]
L_92bbba:
	bclr r25,r25,0xa
L_92bbbe:
	mov_s r0,0x37000020
L_92bbc4:
	mov_s r32,r0
L_92bbc6:
	st.ab r0,[r25,0x4]
L_92bbca:
	bclr r25,r25,0xa
L_92bbce:
	mov_s r1,0x801458
L_92bbd4:
	ld_s r0,[r1,0xc]
L_92bbd6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92bbd8:
	b.d L_92027c
L_92bbdc:
	st_s r0,[r1,0xc]
L_92bbde:
	nop_s
