/* direct_tx__issue_cmd_33 @ 0x924e6c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   direct_tx.c
 * Зовут его: abft__send_ssw_feedback, direct_tx__send_short_frame, direct_tx_rx_step, direct_tx_step, direct_tx_substep, mac_mode__send_direct_frame, rx__send_response_frame, rx_flow__send_imm_response, rx_funcs__send_direct_frame, txop_tx_step
 * Зовёт сам: uc_sysassert
 */
	.section .text.direct_tx__issue_cmd_33,"ax",@progbits
	.global direct_tx__issue_cmd_33
direct_tx__issue_cmd_33:
	.global L_924e6c
L_924e6c:
	push_s r13
L_924e6e:
	mov_s r13,blink
L_924e70:
	mov_s r0,0x33000002
L_924e76:
	mov_s r32,r0
L_924e78:
	st.ab r0,[r25,0x4]
L_924e7c:
	bclr r25,r25,0xa
L_924e80:
	ld.as r3,[gp,-0x6]
L_924e84:
	brne r3,0x0,L_924e90
	.global L_924e88
L_924e88:
	mov_s blink,r13
L_924e8a:
	j_s.d [blink]
L_924e8c:
	ld.ab r13,[sp,0x4]
	.global L_924e90
L_924e90:
	mov_s r0,blink
L_924e92:
	mov_s r2,0x1000fb4
L_924e98:
	mov r1,0x36
L_924e9c:
	bl.d L_925548
L_924ea0:
	mov r3,0x25
L_924ea4:
	b_s L_924e88
L_924ea6:
	nop_s
