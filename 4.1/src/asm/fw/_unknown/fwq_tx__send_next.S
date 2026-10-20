/* fwq_tx__send_next @ 0x8e0a28, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx::send_next tx_metadata_p=0x%06x
 * Зовут его: fwq_tx__enable_queue, fwq_tx__enqueue, fwq_tx__handle_completion
 * Зовёт сам: FWQ_TX_AVAILABILITY__add_packet, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, llist__insert, llist__pop_front
 */
	.section .text.fwq_tx__send_next,"ax",@progbits
	.global fwq_tx__send_next
fwq_tx__send_next:
	.global L_8e0a28
L_8e0a28:
	push_s blink
L_8e0a2a:
	bl L_8c02c0
L_8e0a2e:
	mov_s r14,r0
	.global L_8e0a30
L_8e0a30:
	ld_s r0,[r14,0x4c]
L_8e0a32:
	ld_s r1,[r0,0x8]
L_8e0a34:
	jl_s.d [r1]
L_8e0a36:
	mov_s r0,r14
L_8e0a38:
	mov_s r15,r0
L_8e0a3a:
	brne r0,0x1,L_8e0a78
L_8e0a3e:
	bl.d L_8de2d4
L_8e0a42:
	ld_s r0,[r14,0x30]
L_8e0a44:
	mov_s r13,r0
L_8e0a46:
	add r0,r14,0x34
L_8e0a4a:
	bl.d L_8c1fc4
L_8e0a4e:
	mov_s r1,r13
L_8e0a50:
	mov_s r2,0x101573c
L_8e0a56:
	mov_s r0,0x7
L_8e0a58:
	mov_s r1,0x2
L_8e0a5a:
	bl.d L_8edfcc
L_8e0a5e:
	mov_s r3,r13
L_8e0a60:
	ld_s r0,[r14,0x4]
L_8e0a62:
	brne r0,0x1,L_8e0a70
L_8e0a66:
	ldb_s r1,[r13,0xb]
L_8e0a68:
	ldb_s r0,[r13,0xa]
L_8e0a6a:
	bl.d L_8c23b8
L_8e0a6e:
	bmsk_s r1,r1,0x5
	.global L_8e0a70
L_8e0a70:
	ld_s r1,[r14]
L_8e0a72:
	ld_s r0,[r1,0x4]
L_8e0a74:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e0a76:
	st_s r0,[r1,0x4]
	.global L_8e0a78
L_8e0a78:
	breq r15,0x1,L_8e0a30
L_8e0a7c:
	b.d L_8c032c
