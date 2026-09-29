/* bi_tx__check_idle_and_start_uc @ 0x93696c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__flow_exit, bi_manager__start_tx_or_initiator, bi_rx__slot_handler, internal_tx_isr, tx_slot__dispatch, txop_initiator_open_txop_flow, uc_res_vote__release
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac__set_chain_modes
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_tx__check_idle_and_start_uc
bi_tx__check_idle_and_start_uc:
	.global L_93696c
L_93696c:
	push_s blink
L_93696e:
	bl L_920234
L_936972:
	mov_s r14,r0
L_936974:
	ld_s r0,[gp,-0x44]
L_936976:
	and r0,r0,0xffff0fff
L_93697e:
	st.as r0,[gp,-0x11]
L_936982:
	or r0,r0,0x1d000000
L_93698a:
	mov_s r32,r0
L_93698c:
	st.ab r0,[r25,0x4]
L_936990:
	bclr r25,r25,0xa
L_936994:
	nop_s
L_936996:
	nop_s
L_936998:
	nop_s
	.global L_93699a
L_93699a:
	mov_s r13,r40
L_93699c:
	lsr r0,r40,0x10
L_9369a0:
	bmsk_s r0,r0,0x3
L_9369a2:
	lsr r2,r40,0x14
L_9369a6:
	bmsk_s r2,r2,0x3
L_9369a8:
	lsr r1,r40,0x18
L_9369ac:
	bmsk_s r1,r1,0x3
L_9369ae:
	lsr r3,r40,0x1c
L_9369b2:
	cmp_s r0,0x0
L_9369b4:
	cmp.ne r2,0x0
L_9369b8:
	cmp.ne r1,0x0
L_9369bc:
	cmp.ne r3,0x0
L_9369c0:
	bne_s L_9369d2
L_9369c2:
	mov_s r0,0x1f000601
L_9369c8:
	mov_s r32,r0
L_9369ca:
	st.ab r0,[r25,0x4]
L_9369ce:
	bclr r25,r25,0xa
	.global L_9369d2
L_9369d2:
	brne r13,r40,L_93699a
L_9369d6:
	bl.d L_9369e0
L_9369da:
	mov_s r0,r14
L_9369dc:
	b L_9202a4
