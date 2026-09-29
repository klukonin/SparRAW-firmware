/* mac__program_tx_rate @ 0x9372dc, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_flows__program_mac_tx, tx_initiator_step, tx_mtp_queue_gate, txop_initiator_open_txop_flow
 */
	.section .text.mac__program_tx_rate,"ax",@progbits
	.global mac__program_tx_rate
mac__program_tx_rate:
	.global L_9372dc
L_9372dc:
	push_s r13
L_9372de:
	mov_s r13,blink
L_9372e0:
	stb r0,[gp, -0xe9]
L_9372e4:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9372e6:
	or r0,r0,0x31000000
L_9372ee:
	asl_s r1,r1,0x9
L_9372f0:
	or_s r0,r0,r1
L_9372f2:
	mov_s r32,r0
L_9372f4:
	st.ab r0,[r25,0x4]
L_9372f8:
	bclr r25,r25,0xa
L_9372fc:
	mov_s blink,r13
L_9372fe:
	j_s.d [blink]
L_937300:
	pop_s r13
L_937302:
	nop_s
