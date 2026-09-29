/* bi_tx__check_idle_and_start @ 0x931a78, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__release_sta, bi_manager__rx_bi_flow, bi_manager__start_tx_or_initiator, internal_tx__pending_sm, tx_initiator_flow, txop_initiator_open_txop_flow, uc_res_vote__release
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bi_tx__program_initiator
 */
	.section .text.bi_tx__check_idle_and_start,"ax",@progbits
	.global bi_tx__check_idle_and_start
bi_tx__check_idle_and_start:
	.global L_931a78
L_931a78:
	push_s blink
L_931a7a:
	bl L_920214
L_931a7e:
	mov_s r14,r0
L_931a80:
	ld_s r0,[gp,-0x44]
L_931a82:
	and r0,r0,0xffff0fff
L_931a8a:
	st.as r0,[gp,-0x11]
L_931a8e:
	or r0,r0,0x1d000000
L_931a96:
	mov_s r32,r0
L_931a98:
	st.ab r0,[r25,0x4]
L_931a9c:
	bclr r25,r25,0xa
L_931aa0:
	nop_s
L_931aa2:
	nop_s
L_931aa4:
	nop_s
	.global L_931aa6
L_931aa6:
	mov_s r13,r40
L_931aa8:
	lsr r0,r40,0x10
L_931aac:
	bmsk_s r0,r0,0x3
L_931aae:
	lsr r2,r40,0x14
L_931ab2:
	bmsk_s r2,r2,0x3
L_931ab4:
	lsr r1,r40,0x18
L_931ab8:
	bmsk_s r1,r1,0x3
L_931aba:
	lsr r3,r40,0x1c
L_931abe:
	cmp_s r0,0x0
L_931ac0:
	cmp.ne r2,0x0
L_931ac4:
	cmp.ne r1,0x0
L_931ac8:
	cmp.ne r3,0x0
L_931acc:
	bne_s L_931ade
L_931ace:
	mov_s r0,0x1f000601
L_931ad4:
	mov_s r32,r0
L_931ad6:
	st.ab r0,[r25,0x4]
L_931ada:
	bclr r25,r25,0xa
	.global L_931ade
L_931ade:
	brne r13,r40,L_931aa6
L_931ae2:
	bl.d L_931aec
L_931ae6:
	mov_s r0,r14
L_931ae8:
	b L_920284
