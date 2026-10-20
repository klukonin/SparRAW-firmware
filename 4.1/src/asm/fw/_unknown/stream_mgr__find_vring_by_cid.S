/* stream_mgr__find_vring_by_cid @ 0x8cab10, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__addba_req_tx_complete, stream_mgr__ba_teardown, stream_mgr__on_delba, stream_mgr__on_delba_rx
 */
	.section .text.stream_mgr__find_vring_by_cid,"ax",@progbits
	.global stream_mgr__find_vring_by_cid
stream_mgr__find_vring_by_cid:
	.global L_8cab10
L_8cab10:
	push_s r13
L_8cab12:
	mov_s r13,0x0
L_8cab14:
	b_s L_8cab18
	.global L_8cab16
L_8cab16:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8cab18
L_8cab18:
	brhs r13,0xa,L_8cab46
L_8cab1c:
	mov_s r2,0x8485dc
L_8cab22:
	sub3 r2,r2,0x100
L_8cab26:
	add2_s r2,r2,r13
L_8cab28:
	ld r2,[r2,0x818]
L_8cab30:
	breq_s r2,0,L_8cab16
L_8cab32:
	ld_s r3,[r2,0xc]
L_8cab34:
	brne_s r3,0,L_8cab16
L_8cab36:
	ldb_s r3,[r2,0x4]
L_8cab38:
	brne r0,r3,L_8cab16
L_8cab3c:
	ld_s r3,[r2]
L_8cab3e:
	ldb_s r3,[r3,0x8]
L_8cab40:
	brne r1,r3,L_8cab16
L_8cab44:
	b_s L_8cab48
	.global L_8cab46
L_8cab46:
	mov_s r2,0x0
	.global L_8cab48
L_8cab48:
	mov_s r0,r2
L_8cab4a:
	j_s.d [blink]
L_8cab4c:
	pop_s r13
L_8cab4e:
	nop_s
