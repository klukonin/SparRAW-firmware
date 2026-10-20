/* rx__switch_to_rx_mode @ 0x924fc4, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame, rx_flow_step, rx_funcs__handle_ppdu_report
 * Зовёт сам: mac__set_mode_a000
 * Глобалы (через gp): 0x80052c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__switch_to_rx_mode
rx__switch_to_rx_mode:
	.global L_924fc4
L_924fc4:
	push_s r13
L_924fc6:
	mov_s r13,blink
L_924fc8:
	bl L_92a754
L_924fcc:
	mov_s r2,0x4d
L_924fce:
	asl_s r2,r2,0x18
L_924fd0:
	mov r32,r2
L_924fd4:
	st.ab r2,[r25,0x4]
L_924fd8:
	bclr r25,r25,0xa
L_924fdc:
	nop_s
L_924fde:
	nop_s
L_924fe0:
	nop_s
L_924fe2:
	mov_s r1,r55
L_924fe4:
	cmp r1,0x500
L_924fe8:
	st r1,[0x802448]
L_924ff0:
	bhi_s L_924ff4
L_924ff2:
	brne_s r1,0,L_92500c
	.global L_924ff4
L_924ff4:
	mov_s r3,0x1f000601
L_924ffa:
	mov_s r32,r3
L_924ffc:
	st.ab r3,[r25,0x4]
L_925000:
	bclr r25,r25,0xa
L_925004:
	ld_s r0,[gp,0x4]
L_925006:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_925008:
	st.as r0,[gp,0x1]
	.global L_92500c
L_92500c:
	mov_s blink,r13
L_92500e:
	j_s.d [blink]
L_925010:
	pop_s r13
L_925012:
	nop_s
