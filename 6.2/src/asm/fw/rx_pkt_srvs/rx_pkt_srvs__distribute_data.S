/* rx_pkt_srvs__distribute_data @ 0x8e3af4, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RX PKT SRVS: CID %d stype %x pkt len %d
 *   RX PKT SRVS: Distribute data RX failed stype %x
 * Зовут его: rx_pkt_srvs__dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, mem_pool__free_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_pkt_srvs__distribute_data
rx_pkt_srvs__distribute_data:
	.global L_8e3af4
L_8e3af4:
	push_s blink
L_8e3af6:
	bl L_8c01e4
L_8e3afa:
	mov.f r14,r1
L_8e3afe:
	beq_s L_8e3b5e
	.global L_8e3b00
L_8e3b00:
	ld_s r0,[r14,0x14]
L_8e3b02:
	breq_s r0,0,L_8e3b6c
	.global L_8e3b04
L_8e3b04:
	ld_s r13,[r14,0x14]
L_8e3b06:
	ld r4,[r14, 0x30]
L_8e3b0a:
	ldw_s r3,[r13]
L_8e3b0c:
	mov_s r1,0x1013fd4
L_8e3b12:
	ldb r2,[r14, 0x36]
L_8e3b16:
	lsr_s r3,r3,0x4
L_8e3b18:
	mov_s r0,0x1d
L_8e3b1a:
	bl.d L_8dcd00
L_8e3b1e:
	bmsk_s r3,r3,0x3
L_8e3b20:
	ldw_s r2,[r13]
L_8e3b22:
	lsr r0,r2,0x2
L_8e3b26:
	bmsk_s r0,r0,0x1
L_8e3b28:
	breq r0,0x2,L_8e3b38
L_8e3b2c:
	mov_s r0,blink
L_8e3b2e:
	mov_s r1,0x23
L_8e3b30:
	bl.d L_8c9b28
L_8e3b34:
	/* _asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8e3b36:
	ldw_s r2,[r13]
	.global L_8e3b38
L_8e3b38:
	mov_s r1,0x1014000
L_8e3b3e:
	lsr_s r2,r2,0x4
L_8e3b40:
	mov_s r0,0x1d
L_8e3b42:
	bl.d L_8dcc10
L_8e3b46:
	bmsk_s r2,r2,0x3
L_8e3b48:
	mov_s r1,0x842c40
L_8e3b4e:
	ld_s r0,[r1,0x30]
L_8e3b50:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e3b52:
	st_s r0,[r1,0x30]
L_8e3b54:
	bl.d L_8cb15c
L_8e3b58:
	mov_s r0,r14
L_8e3b5a:
	b L_8c0254
	.global L_8e3b5e
L_8e3b5e:
	mov_s r0,blink
L_8e3b60:
	mov_s r1,0x117e
L_8e3b66:
	bl L_8c9b28
L_8e3b6a:
	b_s L_8e3b00
	.global L_8e3b6c
L_8e3b6c:
	mov_s r0,blink
L_8e3b6e:
	mov_s r1,0x117f
L_8e3b74:
	bl L_8c9b28
L_8e3b78:
	b_s L_8e3b04
L_8e3b7a:
	nop_s
