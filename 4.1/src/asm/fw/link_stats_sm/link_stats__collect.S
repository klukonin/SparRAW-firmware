/* link_stats__collect @ 0x8d98f8, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   link_stats_sm.cpp
 * Зовут его: link_stats_sm__on_latency_timer
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bf_w_s8_w24, fw_sysassert_fatal, link_stats__get_cid, sta_ctx__reset, sta_trace__push_record, tail_sm_pring__free_slots, tail_sm_pring__used_slots
 * Глобалы (через gp): 0x8003a0
 */
	.section .text.link_stats__collect,"ax",@progbits
	.global link_stats__collect
link_stats__collect:
	.global L_8d98f8
L_8d98f8:
	push_s blink
L_8d98fa:
	bl L_8c02b8
L_8d98fe:
	mov_s r17,r0
L_8d9900:
	mov_s r16,r1
L_8d9902:
	mov_s r15,0x805c84
L_8d9908:
	mov_s r14,0x805d04
L_8d990e:
	ldb_s r13,[r14,0x2]
L_8d9910:
	bl.d L_8ca190
L_8d9914:
	bmsk_s r13,r13,0x4
L_8d9916:
	add2 r13,r15,r13
L_8d991a:
	st_s r0,[r13]
L_8d991c:
	bl.d L_8ca194
L_8d9920:
	mov_s r0,r17
L_8d9922:
	mov_s r13,r0
L_8d9924:
	bl.d L_8c9d7c
L_8d9928:
	ld r0,[r16, 0x34]
L_8d992c:
	ldb_s r2,[r14,0x2]
L_8d992e:
	extb r16,r0
L_8d9932:
	ldb_s r0,[r14,0x1]
L_8d9934:
	breq r2,r0,L_8d995c
L_8d9938:
	sub r1,r2,r0
L_8d993c:
	extb lp_count,r1
L_8d9940:
	lp L_8d995c
L_8d9944:
	bmsk r1,r0,0x4
L_8d9948:
	ld.as r3,[r15,r1]
L_8d994c:
	sub r1,r3,r13
L_8d9950:
	bbit1 r1,0x1f,L_8d9958
L_8d9954:
	brne r13,r3,L_8d995c
	.global L_8d9958
L_8d9958:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d995a:
	extb_s r0,r0
	.global L_8d995c
L_8d995c:
	stb_s r0,[r14,0x1]
L_8d995e:
	sub r3,r2,r0
L_8d9962:
	add_s r1,r2,0x1
L_8d9964:
	extb_s r1,r1
L_8d9966:
	stb_s r1,[r14,0x2]
L_8d9968:
	sub_s r1,r1,r0
L_8d996a:
	bmsk.f 0x0,r1,0x4
L_8d996e:
	extb_s r3,r3
L_8d9970:
	stb_s r3,[r14]
L_8d9972:
	bne_s L_8d997a
L_8d9974:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d9976:
	extb_s r0,r0
L_8d9978:
	stb_s r0,[r14,0x1]
	.global L_8d997a
L_8d997a:
	brlt r3,0x1,L_8d99a4
L_8d997e:
	bl.d L_8e34e4
L_8d9982:
	mov_s r0,0x7
L_8d9984:
	mov_s r2,r0
L_8d9986:
	mov_s r0,0x2
L_8d9988:
	stb_s r0,[r2,0xc]
L_8d998a:
	ldb_s r1,[r14]
L_8d998c:
	ld_s r0,[gp,0x230]
L_8d998e:
	mulu64 r0,r1
L_8d9992:
	add r0,r2,0xc
L_8d9996:
	bmsk r1,mlo,0x17
L_8d999a:
	bl L_8e854c
L_8d999e:
	bl.d L_8e3488
L_8d99a2:
	mov_s r0,0x7
	.global L_8d99a4
L_8d99a4:
	brge r16,0x8,L_8d99c6
	.global L_8d99a8
L_8d99a8:
	ld_s r0,[gp,0x230]
L_8d99aa:
	ldb_s r1,[r14]
L_8d99ac:
	mulu64 r0,r1
L_8d99b0:
	asl r0,r16,0x4
L_8d99b4:
	add3_s r0,r0,r0
L_8d99b6:
	add r1,r0,0x854910
L_8d99be:
	b.d L_8c031c
L_8d99c2:
	st mlo,[r1]
	.global L_8d99c6
L_8d99c6:
	mov_s r0,blink
L_8d99c8:
	mov_s r2,0x1011b18
L_8d99ce:
	mov_s r1,0x125b
L_8d99d4:
	bl.d L_8c82c0
L_8d99d8:
	mov r3,0x20c
L_8d99dc:
	b_s L_8d99a8
L_8d99de:
	nop_s
