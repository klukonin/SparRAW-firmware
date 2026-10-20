/* mac__select_all_sectors_and_wait @ 0x936870, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_txss_sweep_step, bi_rx__start_rx_window, direct_tx__send_from_desc, internal_tx__flow_sm2, internal_tx__flow_sm4, internal_tx__flow_sm6, mac__set_sector_arg_and_select_all, tx__cca_check_and_send, tx_bcast_flow, tx_initiator_flow_fixed_scheduling
 * Зовёт сам: uc_wait_event_busy
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__select_all_sectors_and_wait
mac__select_all_sectors_and_wait:
	.global L_936870
L_936870:
	ld.as r1,[gp,-0x12]
L_936874:
	or r1,r1,0x27007e00
L_93687c:
	mov r32,r1
L_936880:
	st.ab r1,[r25,0x4]
L_936884:
	bclr r25,r25,0xa
L_936888:
	mov_s r0,0x2004002
L_93688e:
	mov_s r32,r0
L_936890:
	st.ab r0,[r25,0x4]
L_936894:
	bclr r25,r25,0xa
L_936898:
	nop_s
L_93689a:
	nop_s
L_93689c:
	nop_s
L_93689e:
	mov_s r0,0x2
L_9368a0:
	bset r0,r0,0xe
L_9368a4:
	b.d L_9366e8
L_9368a8:
	mov_s r1,0x0
L_9368aa:
	nop_s
