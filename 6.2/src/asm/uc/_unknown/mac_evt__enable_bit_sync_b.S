/* mac_evt__enable_bit_sync_b @ 0x936544, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw, bcon_txss_sweep_step, bi_rx__start_rx_window, brp_init__tx_request, brp_responder_transmission_flow, direct_tx__send_from_desc, direct_tx_step, internal_tx__flow_sm2, internal_tx__flow_sm4, internal_tx__flow_sm6
 * Зовёт сам: uc_spin_until_event
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_evt__enable_bit_sync_b
mac_evt__enable_bit_sync_b:
	.global L_936544
L_936544:
	asl r1,0x1,r0
L_93654c:
	asl_s r1,r1,0x8
L_93654e:
	or r2,r1,0x27000000
L_936556:
	ld.as r1,[gp,-0x12]
L_93655a:
	or_s r1,r1,r2
L_93655c:
	mov r32,r1
L_936560:
	st.ab r1,[r25,0x4]
L_936564:
	bclr r25,r25,0xa
L_936568:
	mov_s r2,0x2004000
L_93656e:
	mov_s r32,r2
L_936570:
	st.ab r2,[r25,0x4]
L_936574:
	bclr r25,r25,0xa
L_936578:
	nop_s
L_93657a:
	nop_s
L_93657c:
	nop_s
L_93657e:
	mov_s r0,0x0
L_936580:
	b.d L_9366dc
L_936584:
	bset_s r0,r0,0xe
L_936586:
	nop_s
