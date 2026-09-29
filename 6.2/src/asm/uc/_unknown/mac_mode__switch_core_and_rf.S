/* mac_mode__switch_core_and_rf @ 0x92e0e4, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sls__rx_ssw_frame, txss_init__send_fdbk_wait_ack, txss_init__wait_rss, txss_resp__wait_iss_end
 * Зовёт сам: __ld_r13_to_r13_ret, mac__rf_switch_cmd1f, mac__set_mode_a000
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_mode__switch_core_and_rf
mac_mode__switch_core_and_rf:
	.global L_92e0e4
L_92e0e4:
	push_s blink
L_92e0e6:
	push_s r13
L_92e0e8:
	bl.d L_92a754
L_92e0ec:
	mov_s r13,r0
L_92e0ee:
	bl.d L_92c5e4
L_92e0f2:
	mov_s r0,0x0
L_92e0f4:
	mov_s r0,0x1f006000
L_92e0fa:
	mov_s r32,r0
L_92e0fc:
	st.ab r0,[r25,0x4]
L_92e100:
	bclr r25,r25,0xa
L_92e104:
	mov_s r0,0x38000300
L_92e10a:
	mov_s r32,r0
L_92e10c:
	st.ab r0,[r25,0x4]
L_92e110:
	bclr r25,r25,0xa
L_92e114:
	mov_s r0,0x3600003f
L_92e11a:
	mov_s r32,r0
L_92e11c:
	st.ab r0,[r25,0x4]
L_92e120:
	bclr r25,r25,0xa
L_92e124:
	mov_s r0,0x6000101
L_92e12a:
	mov_s r32,r0
L_92e12c:
	st.ab r0,[r25,0x4]
L_92e130:
	bclr r25,r25,0xa
L_92e134:
	mov_s r0,0x37000005
L_92e13a:
	mov_s r32,r0
L_92e13c:
	st.ab r0,[r25,0x4]
L_92e140:
	bclr r25,r25,0xa
L_92e144:
	mov_s r0,0x37000002
L_92e14a:
	mov_s r32,r0
L_92e14c:
	st.ab r0,[r25,0x4]
L_92e150:
	bclr r25,r25,0xa
L_92e154:
	or r13,r13,0x3f000000
L_92e15c:
	mov_s r32,r13
L_92e15e:
	st.ab r13,[r25,0x4]
L_92e162:
	bclr r25,r25,0xa
L_92e166:
	b L_9202ac
L_92e16a:
	nop_s
