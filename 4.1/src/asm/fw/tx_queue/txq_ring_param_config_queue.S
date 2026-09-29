/* txq_ring_param_config_queue @ 0x8e516c, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_queue.c
 *   txq_ring_param_config_queue (payload_length_lines %d)(max_msdu_size_bytes %d)(PTP_PAYLOAD_PIPE_LEN_BYTE %d)
 * Зовут его: tx_macq__config_ring_params
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_w_s0_w12, bf_w_s0_w4, bf_w_s12_w12, bf_w_s16_w12, bf_w_s28_w4, bf_w_s4_w12, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.txq_ring_param_config_queue,"ax",@progbits
	.global txq_ring_param_config_queue
txq_ring_param_config_queue:
	.global L_8e516c
L_8e516c:
	push_s blink
L_8e516e:
	bl L_8c02bc
L_8e5172:
	mov_s r14,r0
L_8e5174:
	mov_s r15,r1
L_8e5176:
	mov_s r13,r2
L_8e5178:
	ldw_s r1,[r2,0x4]
L_8e517a:
	brne r3,0x4,L_8e5208
L_8e517e:
	brlt r1,0x3000,L_8e51f8
L_8e5186:
	ldw_s r0,[r13,0x6]
L_8e5188:
	add_s r0,r0,r1
L_8e518a:
	brlt 0x5200,r0,L_8e51f8
	.global L_8e5192
L_8e5192:
	/* add_s r15,0x7 */
	.byte 0x07,0xe7
L_8e5194:
	lsr r16,r15,0x3
L_8e5198:
	ldw_s r3,[r13,0x6]
L_8e519a:
	add r0,r16,0x9
L_8e519e:
	brhs r0,r3,L_8e5230
	.global L_8e51a2
L_8e51a2:
	ldw_s r0,[r13,0xa]
L_8e51a4:
	brlt r0,0x6,L_8e525a
	.global L_8e51a8
L_8e51a8:
	ldw_s r0,[r13,0x4]
L_8e51aa:
	bmsk r1,r16,0xb
L_8e51ae:
	stw_s r0,[r14]
L_8e51b0:
	ldw_s r0,[r13,0x4]
L_8e51b2:
	stw_s r0,[r14,0x2]
L_8e51b4:
	ldw_s r0,[r13,0x4]
L_8e51b6:
	stw_s r0,[r14,0x6]
L_8e51b8:
	ldw_s r0,[r13,0x6]
L_8e51ba:
	stw_s r0,[r14,0x4]
L_8e51bc:
	add r0,r14,0x8
L_8e51c0:
	bl L_8e8318
L_8e51c4:
	ldw_s r1,[r13,0x8]
L_8e51c6:
	bmsk_s r1,r1,0xb
L_8e51c8:
	bl L_8e8378
L_8e51cc:
	ldw_s r0,[r13,0x8]
L_8e51ce:
	stb_s r0,[r14,0xb]
L_8e51d0:
	ldw_s r1,[r13,0x8]
L_8e51d2:
	add r0,r14,0xc
L_8e51d6:
	lsr_s r1,r1,0x8
L_8e51d8:
	bmsk_s r1,r1,0x3
L_8e51da:
	bl L_8e8348
L_8e51de:
	ldw_s r1,[r13,0x8]
L_8e51e0:
	bmsk_s r1,r1,0xb
L_8e51e2:
	bl L_8e83c0
L_8e51e6:
	ldw_s r1,[r13,0xa]
L_8e51e8:
	bmsk_s r1,r1,0xb
L_8e51ea:
	bl L_8e84c8
L_8e51ee:
	mov_s r1,0x0
L_8e51f0:
	bl L_8e8480
L_8e51f4:
	b L_8c0324
	.global L_8e51f8
L_8e51f8:
	mov_s r0,blink
L_8e51fa:
	mov_s r2,0x10100b0
L_8e5200:
	mov_s r1,0x20
L_8e5202:
	bset_s r1,r1,0xc
L_8e5204:
	mov_s r3,0x72
L_8e5206:
	b_s L_8e522a
	.global L_8e5208
L_8e5208:
	brlt r1,0x2000,L_8e521c
L_8e5210:
	ldw_s r0,[r13,0x6]
L_8e5212:
	add_s r0,r0,r1
L_8e5214:
	brge 0x5200,r0,L_8e5192
	.global L_8e521c
L_8e521c:
	mov_s r0,blink
L_8e521e:
	mov_s r2,0x10100b0
L_8e5224:
	mov_s r1,0x20
L_8e5226:
	bset_s r1,r1,0xc
L_8e5228:
	mov_s r3,0x77
	.global L_8e522a
L_8e522a:
	bl L_8c82c0
L_8e522e:
	b_s L_8e5192
	.global L_8e5230
L_8e5230:
	mov_s r2,0x10100bc
L_8e5236:
	mov_s r0,0x0
L_8e5238:
	mov_s r1,r0
L_8e523a:
	mov r4,r16
L_8e523e:
	bl.d L_8ee034
L_8e5242:
	mov r5,0x9
L_8e5246:
	mov_s r0,blink
L_8e5248:
	mov_s r2,0x10100b0
L_8e524e:
	mov_s r1,0x24
L_8e5250:
	bset_s r1,r1,0xc
L_8e5252:
	bl.d L_8c82c0
L_8e5256:
	mov_s r3,0x7d
L_8e5258:
	b_s L_8e51a2
	.global L_8e525a
L_8e525a:
	mov_s r0,blink
L_8e525c:
	mov_s r2,0x10100b0
L_8e5262:
	mov_s r1,0x21
L_8e5264:
	bset_s r1,r1,0xc
L_8e5266:
	bl.d L_8c82c0
L_8e526a:
	mov_s r3,0x7f
L_8e526c:
	b_s L_8e51a8
L_8e526e:
	nop_s
