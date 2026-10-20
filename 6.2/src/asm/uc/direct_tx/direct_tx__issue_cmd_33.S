/* direct_tx__issue_cmd_33 @ 0x925774, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft__send_ssw_feedback, direct_tx__send_after_delay, direct_tx__send_from_desc, direct_tx__send_short_frame, direct_tx__send_with_seq, direct_tx_step, mac_mode__send_direct_frame, rx__send_dmg_cts, rx__send_response_frame, rx_flow__send_imm_response
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global direct_tx__issue_cmd_33
direct_tx__issue_cmd_33:
	.global L_925774
L_925774:
	push_s r13
L_925776:
	mov_s r13,blink
L_925778:
	mov_s r0,0x33000002
L_92577e:
	mov_s r32,r0
L_925780:
	st.ab r0,[r25,0x4]
L_925784:
	bclr r25,r25,0xa
L_925788:
	ld.as r1,[gp,-0x5]
L_92578c:
	brne r1,0x0,L_925798
	.global L_925790
L_925790:
	mov_s blink,r13
L_925792:
	j_s.d [blink]
L_925794:
	ld.ab r13,[sp,0x4]
	.global L_925798
L_925798:
	mov r0,blink
L_92579c:
	bl.d L_926618
L_9257a0:
	mov r1,0x36
L_9257a4:
	b_s L_925790
L_9257a6:
	nop_s
