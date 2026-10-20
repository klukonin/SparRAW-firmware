/* vring_tbl__find_by_tid_cid @ 0x8cce44, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__addba_req_handler, stream_mgr__addba_rsp_handler, stream_mgr__delba_handler, stream_mgr__delba_tx_complete
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_tbl__find_by_tid_cid
vring_tbl__find_by_tid_cid:
	.global L_8cce44
L_8cce44:
	push_s r13
L_8cce46:
	mov_s r13,0x0
L_8cce48:
	b_s L_8cce4c
	.global L_8cce4a
L_8cce4a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8cce4c
L_8cce4c:
	brhs r13,0xa,L_8cce7a
L_8cce50:
	mov_s r2,0x847f34
L_8cce56:
	sub r2,r2,0x400
L_8cce5a:
	add2_s r2,r2,r13
L_8cce5c:
	ld r2,[r2,0x44c]
L_8cce64:
	breq_s r2,0,L_8cce4a
L_8cce66:
	ld_s r3,[r2,0xc]
L_8cce68:
	brne_s r3,0,L_8cce4a
L_8cce6a:
	ldb_s r3,[r2,0x4]
L_8cce6c:
	brne r0,r3,L_8cce4a
L_8cce70:
	ld_s r3,[r2]
L_8cce72:
	ldb_s r3,[r3,0x8]
L_8cce74:
	brne r1,r3,L_8cce4a
L_8cce78:
	b_s L_8cce7c
	.global L_8cce7a
L_8cce7a:
	mov_s r2,0x0
	.global L_8cce7c
L_8cce7c:
	mov_s r0,r2
L_8cce7e:
	j_s.d [blink]
L_8cce80:
	pop_s r13
L_8cce82:
	nop_s
