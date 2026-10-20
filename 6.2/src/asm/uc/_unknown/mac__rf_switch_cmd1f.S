/* mac__rf_switch_cmd1f @ 0x92c5e4, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__tx_request, brp_responder_transmission_flow, fsched_ap__start_slot, grant_detect_step, mac__set_chain_mask_924f00, mac__set_slot_mask_924000, mac_mode__switch_core_and_rf, pm__event_mask_restore, pm__event_mask_save_all_on, ucode_cmd_0x01_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__rf_switch_cmd1f
mac__rf_switch_cmd1f:
	.global L_92c5e4
L_92c5e4:
	st.a r13,[sp,-0x8]
L_92c5e8:
	st_s r14,[sp,0x4]
L_92c5ea:
	mov_s r14,blink
L_92c5ec:
	mov r13,r0
L_92c5f0:
	mov r4,0x1f000601
L_92c5f8:
	mov r32,r4
L_92c5fc:
	st.ab r4,[r25,0x4]
L_92c600:
	bclr r25,r25,0xa
L_92c604:
	ld.as r2,[gp,-0x11]
L_92c608:
	and r2,r2,0xffff0fff
L_92c610:
	st.as r2,[gp,-0x11]
L_92c614:
	or r2,r2,0x1d000000
L_92c61c:
	mov r32,r2
L_92c620:
	st.ab r2,[r25,0x4]
L_92c624:
	bclr r25,r25,0xa
L_92c628:
	nop_s
L_92c62a:
	nop_s
L_92c62c:
	mov 0x0,0x0
	.global L_92c630
L_92c630:
	mov_s r1,0x800630
L_92c636:
	ld_s r0,[r1]
L_92c638:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92c63a:
	st_s r0,[r1]
L_92c63c:
	bmsk r1,r40,0x2
L_92c640:
	brne r1,0x5,L_92c630
L_92c644:
	brne r13,0x1,L_92c658
L_92c648:
	mov_s r3,0x1f003000
L_92c64e:
	mov_s r32,r3
L_92c650:
	st.ab r3,[r25,0x4]
L_92c654:
	bclr r25,r25,0xa
	.global L_92c658
L_92c658:
	mov_s r3,0x0
L_92c65a:
	st r3,[0x800630]
L_92c662:
	mov_s blink,r14
L_92c664:
	ld_s r14,[sp,0x4]
L_92c666:
	j_s.d [blink]
L_92c668:
	ld.ab r13,[sp,0x8]
