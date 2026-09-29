/* vring__wait_drain @ 0x8c4554, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Wait start_b_idx != tail_idx ...
 *   Wait prp_avail_vec_val ...
 * Зовут его: STREAM_MGR__2, l2mgr__data_port_open_and_keys
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, macq_desc__read_t1_w0_n2, macq_desc__read_t1_w2_n1, macq_desc__read_t1_w3_n3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__wait_drain
vring__wait_drain:
	.global L_8c4554
L_8c4554:
	push_s blink
L_8c4556:
	bl L_8c01e0
L_8c455a:
	mov_s r14,r0
L_8c455c:
	mov_s r13,0x847fe8
L_8c4562:
	mov_s r1,0x1018fd4
L_8c4568:
	bl.d L_8dcba8
L_8c456c:
	mov_s r0,0x27
	.global L_8c456e
L_8c456e:
	mov_s r0,r13
L_8c4570:
	bl.d L_8e4424
L_8c4574:
	ldb_s r1,[r14]
L_8c4576:
	mov_s r15,0x847fc8
L_8c457c:
	mov_s r0,r15
L_8c457e:
	bl.d L_8e4430
L_8c4582:
	ldb_s r1,[r14]
L_8c4584:
	add3 r0,r15,0xa
L_8c4588:
	bl.d L_8e443c
L_8c458c:
	ldb_s r1,[r14]
L_8c458e:
	mov_s r0,0xa0
L_8c4590:
	mov lp_count,r0
L_8c4594:
	nop_s
L_8c4596:
	lp L_8c459e
L_8c459a:
	nop_s
L_8c459c:
	nop_s
	.global L_8c459e
L_8c459e:
	ldb_s r1,[r13,0xd]
L_8c45a0:
	ldb_s r0,[r13,0xb]
L_8c45a2:
	brne r1,r0,L_8c456e
L_8c45a6:
	mov_s r1,0x1018ff8
L_8c45ac:
	bl.d L_8dcba8
L_8c45b0:
	mov_s r0,0x27
	.global L_8c45b2
L_8c45b2:
	mov_s r0,0x886800
L_8c45b8:
	ld_s r13,[r0,0x2c]
L_8c45ba:
	mov_s r0,0xa0
L_8c45bc:
	mov lp_count,r0
L_8c45c0:
	nop_s
L_8c45c2:
	lp L_8c45ca
L_8c45c6:
	nop_s
L_8c45c8:
	nop_s
	.global L_8c45ca
L_8c45ca:
	ldb_s r0,[r14]
L_8c45cc:
	bbit1 r13,r0,L_8c45b2
L_8c45d0:
	b L_8c024c
