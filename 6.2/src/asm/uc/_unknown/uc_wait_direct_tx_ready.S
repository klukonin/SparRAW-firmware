/* uc_wait_direct_tx_ready @ 0x925874, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft__send_ssw_feedback, direct_tx__send_after_delay, direct_tx__send_from_desc, direct_tx__send_short_frame, direct_tx__send_with_seq, direct_tx_step, mac_mode__send_direct_frame, rx__send_dmg_cts, rx__send_response_frame, rx_flow__send_imm_response
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_wait_direct_tx_ready
uc_wait_direct_tx_ready:
	.global L_925874
L_925874:
	push_s r13
L_925876:
	ld_s r0,[gp,-0x44]
L_925878:
	mov_s r13,blink
L_92587a:
	and r0,r0,0xfff0ffff
L_925882:
	st.as r0,[gp,-0x11]
L_925886:
	or r0,r0,0x1d000000
L_92588e:
	mov_s r32,r0
L_925890:
	st.ab r0,[r25,0x4]
L_925894:
	bclr r25,r25,0xa
L_925898:
	nop_s
L_92589a:
	nop_s
L_92589c:
	mov 0x0,0x0
	.global L_9258a0
L_9258a0:
	mov_s r1,r47
L_9258a2:
	bbit0 r1,0x0,L_9258a0
L_9258a6:
	mov_s blink,r13
L_9258a8:
	j.d [blink]
L_9258ac:
	pop_s r13
L_9258ae:
	nop_s
