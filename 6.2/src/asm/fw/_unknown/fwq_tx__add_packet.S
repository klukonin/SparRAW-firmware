/* fwq_tx__add_packet @ 0x8c2af4, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx::add_packet: (m_channel = %d, m_type = %d; channel= %d): send_next() failure
 *   fwq_tx::add_packet: send_next() wasn't called; m_state=%d, m_channel %d, channel %d
 * Зовут его: TX_API__awake_peer_ntf, TX_API__send_dband_bcon, TX_API__send_packet, fwq_tx__long_retry_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, brd_if_multi_array__get_chunk_8cbbc4, fw_log_emit3, fwq_tx__queue_step, list__find_entry_d
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__add_packet
fwq_tx__add_packet:
	.global L_8c2af4
L_8c2af4:
	push_s blink
L_8c2af6:
	bl L_8c01dc
L_8c2afa:
	mov_s r14,r0
L_8c2afc:
	mov_s r16,r1
L_8c2afe:
	mov_s r15,r2
L_8c2b00:
	bl.d L_8cbbc4
L_8c2b04:
	mov_s r1,r2
L_8c2b06:
	bl.d L_8c25f4
L_8c2b0a:
	mov_s r1,r16
L_8c2b0c:
	ld_s r1,[r14]
L_8c2b0e:
	ld_s r0,[r1]
L_8c2b10:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c2b12:
	st_s r0,[r1]
L_8c2b14:
	ld_s r3,[r14,0xc]
L_8c2b16:
	ld_s r2,[r14,0x8]
L_8c2b18:
	cmp_s r15,r3
L_8c2b1a:
	cmp.eq r2,0x1
L_8c2b1e:
	bne_s L_8c2b3a
L_8c2b20:
	bl.d L_8e5620
L_8c2b24:
	mov_s r0,r14
L_8c2b26:
	mov.f r13,r0
L_8c2b2a:
	bne_s L_8c2b4a
L_8c2b2c:
	ld_s r2,[r14,0xc]
L_8c2b2e:
	mov_s r1,0x1018ac0
L_8c2b34:
	ld_s r3,[r14,0x4]
L_8c2b36:
	mov_s r0,0x17
L_8c2b38:
	b_s L_8c2b44
	.global L_8c2b3a
L_8c2b3a:
	mov_s r1,0x1018b14
L_8c2b40:
	mov_s r0,0x27
L_8c2b42:
	mov_s r13,0x0
	.global L_8c2b44
L_8c2b44:
	bl.d L_8dcd00
L_8c2b48:
	mov_s r4,r15
	.global L_8c2b4a
L_8c2b4a:
	b.d L_8c0244
L_8c2b4e:
	mov_s r0,r13
