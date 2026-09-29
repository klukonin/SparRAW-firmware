/* ftm_main_sm__action_pop_ch_and_tune @ 0x8f080c, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] ftm_main_sm::action_pop_ch_and_tune()
 *   [TOF] ftm_main_sm::action_pop_ch_and_tune() - new channel
 *   [TOF] ftm_main_sm::action_pop_ch_and_tune() - same channel
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, ftm_main_sm__radio_args, fw_log_emit0, radio_mgr__get_current_channel, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm_main_sm__action_pop_ch_and_tune
ftm_main_sm__action_pop_ch_and_tune:
	.global L_8f080c
L_8f080c:
	push_s blink
L_8f080e:
	bl L_8c01e4
L_8f0812:
	sub_s sp,sp,0x4
L_8f0814:
	mov_s r13,r0
L_8f0816:
	mov_s r1,0x1019e58
L_8f081c:
	bl.d L_8dcba8
L_8f0820:
	mov_s r0,0x20
L_8f0822:
	ld_s r0,[r13,0xc]
L_8f0824:
	mov_s r14,0x0
L_8f0826:
	breq_s r0,0,L_8f082e
L_8f0828:
	bl L_8c8de0
L_8f082c:
	st_s r14,[r13,0xc]
	.global L_8f082e
L_8f082e:
	bl.d L_8cc130
L_8f0832:
	mov_s r0,sp
L_8f0834:
	ld_s r1,[r13,0x18]
L_8f0836:
	ld_s r0,[sp,0x0]
L_8f0838:
	breq r1,r0,L_8f086c
L_8f083c:
	mov_s r1,0x1019e84
L_8f0842:
	bl.d L_8dcba8
L_8f0846:
	mov_s r0,0x20
L_8f0848:
	ld_s r2,[r13,0x8]
L_8f084a:
	cmp_s r2,0x0
L_8f084c:
	mov.eq r0,r13
L_8f0850:
	mov_s r1,0x1
L_8f0852:
	beq_s L_8f087c
L_8f0854:
	mov_s r0,0x318ec
L_8f085a:
	ld r4,[r13, 0x18]
L_8f085e:
	mov_s r1,r13
L_8f0860:
	mov_s r3,0x1
L_8f0862:
	bl.d L_8e4e18
L_8f0866:
	mov r5,0x0
L_8f086a:
	b_s L_8f0886
	.global L_8f086c
L_8f086c:
	mov_s r1,0x1019ec0
L_8f0872:
	bl.d L_8dcba8
L_8f0876:
	mov_s r0,0x20
L_8f0878:
	mov_s r0,r13
L_8f087a:
	mov_s r1,0x4
	.global L_8f087c
L_8f087c:
	mov_s r2,0x0
L_8f087e:
	mov_s r3,r2
L_8f0880:
	bl.d L_8d9b6c
L_8f0884:
	mov_s r4,r2
	.global L_8f0886
L_8f0886:
	b.d L_8c0254
L_8f088a:
	add_s sp,sp,0x4
