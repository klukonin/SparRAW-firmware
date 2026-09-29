/* abft__send_ssw_feedback @ 0x935990, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw
 * Зовёт сам: direct_tx__issue_cmd_33, direct_tx__program_cmd34, direct_tx__push_payload, uc_wait_direct_tx_ready
 */
	.section .text.abft__send_ssw_feedback,"ax",@progbits
	.global abft__send_ssw_feedback
abft__send_ssw_feedback:
	.global L_935990
L_935990:
	push_s blink
L_935992:
	mov_s r0,0x10
L_935994:
	bl.d L_924ea8
L_935998:
	mov_s r1,0x16
L_93599a:
	mov_s r0,0x801b90
L_9359a0:
	bl.d L_924ef4
L_9359a4:
	mov_s r1,0xa
L_9359a6:
	ld_s r0,[gp,-0x18]
L_9359a8:
	sub_s r0,r0,0x9
L_9359aa:
	st.as r0,[gp,-0x6]
L_9359ae:
	mov_s r0,0x330004c3
L_9359b4:
	mov_s r32,r0
L_9359b6:
	st.ab r0,[r25,0x4]
L_9359ba:
	bclr r25,r25,0xa
L_9359be:
	bl L_924f7c
L_9359c2:
	mov_s r0,0x801b9c
L_9359c8:
	ldb r34,[r0, 0x7]
L_9359cc:
	mov_s r0,0x801b9c
L_9359d2:
	ldb r34,[r0, 0x8]
L_9359d6:
	mov_s r0,0x801b9c
L_9359dc:
	ldb r34,[r0, 0x9]
L_9359e0:
	ld_s r0,[gp,-0x18]
L_9359e2:
	/* sub_s r0,r0,0x3 */
	.byte 0x63,0xb8
L_9359e4:
	bl.d L_924e6c
L_9359e8:
	st.as r0,[gp,-0x6]
L_9359ec:
	pop_s blink
L_9359ee:
	j_s [blink]
