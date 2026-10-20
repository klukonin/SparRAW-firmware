/* direct_tx__send_short_frame @ 0x935920, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_direct_tx__send_short_frame, tail_direct_tx__send_short_frame_9359f4
 * Зовёт сам: __ld_r13_ret_uc, direct_tx__issue_cmd_33, direct_tx__program_cmd34, direct_tx__push_payload, uc_wait_direct_tx_ready
 */
	.section .text.direct_tx__send_short_frame,"ax",@progbits
	.global direct_tx__send_short_frame
direct_tx__send_short_frame:
	.global L_935920
L_935920:
	push_s blink
L_935922:
	push_s r13
L_935924:
	mov_s r13,r0
L_935926:
	mov_s r0,0x10
L_935928:
	bl.d L_924ea8
L_93592c:
	mov_s r1,0x16
L_93592e:
	mov_s r0,0x801b90
L_935934:
	bl.d L_924ef4
L_935938:
	mov_s r1,0x4
L_93593a:
	ld_s r0,[gp,-0x18]
L_93593c:
	sub_s r0,r0,0xf
L_93593e:
	st.as r0,[gp,-0x6]
L_935942:
	asl r0,r13,0x8
L_935946:
	asl_s r13,r13,0xa
L_935948:
	or r0,r0,0x330000e3
L_935950:
	or_s r13,r13,r0
L_935952:
	mov_s r32,r13
L_935954:
	st.ab r13,[r25,0x4]
L_935958:
	bclr r25,r25,0xa
L_93595c:
	bl L_924f7c
L_935960:
	mov_s r0,0x801b9c
L_935966:
	ldb r34,[r0, 0x7]
L_93596a:
	mov_s r0,0x801b9c
L_935970:
	ldb r34,[r0, 0x8]
L_935974:
	mov_s r0,0x801b9c
L_93597a:
	ldb r34,[r0, 0x9]
L_93597e:
	ld_s r0,[gp,-0x18]
L_935980:
	/* sub_s r0,r0,0x3 */
	.byte 0x63,0xb8
L_935982:
	bl.d L_924e6c
L_935986:
	st.as r0,[gp,-0x6]
L_93598a:
	b L_92028c
L_93598e:
	nop_s
