/* discovery__rx_start @ 0x8f80b8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery::rx_start()
 * Зовут его: channels_switch_sm__action_allocate_radio, find_mng__listen, find_mng__search, find_mngr__session_start, state_sm_8034c0__action_8f058c
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, hwd_mac_parser__set_rx_filter, mac_parser__set_886260
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global discovery__rx_start
discovery__rx_start:
	.global L_8f80b8
L_8f80b8:
	push_s blink
L_8f80ba:
	push_s r13
L_8f80bc:
	mov_s r13,r0
L_8f80be:
	mov_s r1,0x1016f98
L_8f80c4:
	bl.d L_8dcba8
L_8f80c8:
	mov_s r0,0x2c
L_8f80ca:
	cmp_s r13,0x0
L_8f80cc:
	mov_s r1,0x1
L_8f80ce:
	sub_s.ne r1,r1,r1
L_8f80d0:
	asl_s r1,r1,0xb
L_8f80d2:
	or r1,r1,0x3702
L_8f80da:
	bl.d L_8dfbbc
L_8f80de:
	mov_s r0,0x2
L_8f80e0:
	mov_s r0,0x0
L_8f80e2:
	bl.d L_8dfd14
L_8f80e6:
	mov_s r1,0x1
L_8f80e8:
	b L_8c025c
