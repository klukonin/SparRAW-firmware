/* mac_mode__send_direct_frame @ 0x92b444, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode_program_a, mac_mode_program_b
 * Зовёт сам: direct_tx__issue_cmd_33, direct_tx__push_payload, uc_wait_direct_tx_ready
 */
	.section .text.mac_mode__send_direct_frame,"ax",@progbits
	.global mac_mode__send_direct_frame
mac_mode__send_direct_frame:
	.global L_92b444
L_92b444:
	push_s blink
L_92b446:
	mov_s r0,0x800764
L_92b44c:
	bl.d L_924ef4
L_92b450:
	mov_s r1,0xa
L_92b452:
	ld_s r0,[gp,-0x18]
L_92b454:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_92b456:
	st.as r0,[gp,-0x6]
L_92b45a:
	mov_s r0,0x33000443
L_92b460:
	mov_s r32,r0
L_92b462:
	st.ab r0,[r25,0x4]
L_92b466:
	bclr r25,r25,0xa
L_92b46a:
	bl L_924f7c
L_92b46e:
	ld_s r0,[gp,-0x18]
L_92b470:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_92b472:
	st.as r0,[gp,-0x6]
L_92b476:
	mov_s r0,0x33000123
L_92b47c:
	mov_s r32,r0
L_92b47e:
	st.ab r0,[r25,0x4]
L_92b482:
	bclr r25,r25,0xa
L_92b486:
	bl L_924f7c
L_92b48a:
	mov_s r0,0x800764
L_92b490:
	ldw_s r0,[r0,0x16]
L_92b492:
	bset r34,r0,0x18
L_92b496:
	ld_s r0,[gp,-0x18]
L_92b498:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_92b49a:
	st.as r0,[gp,-0x6]
L_92b49e:
	mov_s r0,0x80077c
L_92b4a4:
	bl.d L_924ef4
L_92b4a8:
	mov_s r1,0xe
L_92b4aa:
	bl L_924e6c
L_92b4ae:
	pop_s blink
L_92b4b0:
	j_s [blink]
L_92b4b2:
	nop_s
