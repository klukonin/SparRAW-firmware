/* mac_evt__enable_bit_sync @ 0x9361bc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw, bcon_txss_sweep_step, internal_tx__flow_sm2, internal_tx__flow_sm4, internal_tx__flow_sm6, txss_init__send_fdbk_wait_ack
 * Зовёт сам: uc_spin_until_event
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_evt__enable_bit_sync
mac_evt__enable_bit_sync:
	.global L_9361bc
L_9361bc:
	asl r1,0x1,r0
L_9361c4:
	asl_s r1,r1,0x8
L_9361c6:
	or r2,r1,0x27000000
L_9361ce:
	ld.as r1,[gp,-0x12]
L_9361d2:
	or_s r1,r1,r2
L_9361d4:
	mov r32,r1
L_9361d8:
	st.ab r1,[r25,0x4]
L_9361dc:
	bclr r25,r25,0xa
L_9361e0:
	mov_s r2,0x2004000
L_9361e6:
	mov_s r32,r2
L_9361e8:
	st.ab r2,[r25,0x4]
L_9361ec:
	bclr r25,r25,0xa
L_9361f0:
	nop_s
L_9361f2:
	nop_s
L_9361f4:
	nop_s
L_9361f6:
	mov_s r0,0x0
L_9361f8:
	b.d L_9366dc
L_9361fc:
	bset_s r0,r0,0xe
L_9361fe:
	nop_s
