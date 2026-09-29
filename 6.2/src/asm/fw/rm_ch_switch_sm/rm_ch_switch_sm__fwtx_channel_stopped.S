/* rm_ch_switch_sm__fwtx_channel_stopped @ 0x8cb6a8, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm__null_handler
 * Зовёт сам: rm_main_sm__inject_lock_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_ch_switch_sm__fwtx_channel_stopped
rm_ch_switch_sm__fwtx_channel_stopped:
	.global L_8cb6a8
L_8cb6a8:
	push_s blink
L_8cb6aa:
	ld_s r0,[gp,-0x1c]
L_8cb6ac:
	brne r0,0x1,L_8cb6e4
L_8cb6b0:
	mov_s r0,0x842148
L_8cb6b6:
	ld_s r0,[r0,0x14]
L_8cb6b8:
	cmp_s r0,0x0
L_8cb6ba:
	mov_s r0,0x1
L_8cb6bc:
	sub_s.ne r0,r0,r0
L_8cb6be:
	extb.f 0x0,r0
L_8cb6c2:
	beq_s L_8cb6e4
L_8cb6c4:
	mov_s r0,0x842274
L_8cb6ca:
	ld_s r0,[r0,0x8]
L_8cb6cc:
	cmp_s r0,0x0
L_8cb6ce:
	mov_s r0,0x1
L_8cb6d0:
	sub_s.ne r0,r0,r0
L_8cb6d2:
	extb.f 0x0,r0
L_8cb6d6:
	beq_s L_8cb6e4
L_8cb6d8:
	mov_s r0,0x0
L_8cb6da:
	st.as r0,[gp,-0x7]
L_8cb6de:
	bl.d L_8cd288
L_8cb6e2:
	mov_s r0,0x3
	.global L_8cb6e4
L_8cb6e4:
	pop_s blink
L_8cb6e6:
	j_s [blink]
