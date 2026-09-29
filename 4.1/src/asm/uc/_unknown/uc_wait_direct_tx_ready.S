/* uc_wait_direct_tx_ready @ 0x924f7c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft__send_ssw_feedback, direct_tx__send_short_frame, direct_tx_rx_step, direct_tx_step, direct_tx_substep, mac_mode__send_direct_frame, rx__send_response_frame, rx_flow__send_imm_response, rx_funcs__send_direct_frame, txop_tx_step
 */
	.section .text.uc_wait_direct_tx_ready,"ax",@progbits
	.global uc_wait_direct_tx_ready
uc_wait_direct_tx_ready:
	.global L_924f7c
L_924f7c:
	push_s r13
L_924f7e:
	ld_s r0,[gp,-0x44]
L_924f80:
	mov_s r13,blink
L_924f82:
	and r0,r0,0xfff0ffff
L_924f8a:
	st.as r0,[gp,-0x11]
L_924f8e:
	or r0,r0,0x1d000000
L_924f96:
	mov_s r32,r0
L_924f98:
	st.ab r0,[r25,0x4]
L_924f9c:
	bclr r25,r25,0xa
L_924fa0:
	nop_s
L_924fa2:
	nop_s
L_924fa4:
	mov 0x0,0x0
	.global L_924fa8
L_924fa8:
	mov_s r1,r47
L_924faa:
	bbit0 r1,0x0,L_924fa8
L_924fae:
	mov_s blink,r13
L_924fb0:
	j.d [blink]
L_924fb4:
	pop_s r13
L_924fb6:
	nop_s
