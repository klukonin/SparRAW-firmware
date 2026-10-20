/* mlme_sm__tx_complete_cb @ 0x8ea8ec, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mlme_sm.cpp
 * Зовёт сам: TX_API__free_memory, __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__inject_event, fw_sysassert_fatal, tx_api__post_tx_payload
 */
	.section .text.mlme_sm__tx_complete_cb,"ax",@progbits
	.global mlme_sm__tx_complete_cb
mlme_sm__tx_complete_cb:
L_8ea8ec:
	add_s sp,sp,0x20
	.global sub_8ea8ee
sub_8ea8ee:
L_8ea8ee:
	nop_s
L_8ea8f0:
	push_s blink
L_8ea8f2:
	bl L_8c02bc
L_8ea8f6:
	mov_s r16,r0
L_8ea8f8:
	mov_s r12,0xb0
L_8ea8fa:
	add.f r13,r2,r12
L_8ea8fe:
	mov_s r14,r1
L_8ea900:
	mov_s r15,r2
L_8ea902:
	beq_s L_8ea91e
	.global L_8ea904
L_8ea904:
	ld_s r0,[r13,0x3c]
L_8ea906:
	ld_s r0,[r0,0xc]
L_8ea908:
	ld_s r0,[r0,0x50]
L_8ea90a:
	cmp_s r0,0x1
L_8ea90c:
	mov_s r0,0x1
L_8ea90e:
	sub_s.ne r0,r0,r0
L_8ea910:
	extb.f 0x0,r0
L_8ea914:
	beq_s L_8ea93c
L_8ea916:
	brne_s r14,0,L_8ea936
L_8ea918:
	mov_s r0,0x1
L_8ea91a:
	st_s r0,[r13,0x30]
L_8ea91c:
	b_s L_8ea966
	.global L_8ea91e
L_8ea91e:
	mov_s r0,blink
L_8ea920:
	mov_s r2,0x100f220
L_8ea926:
	mov_s r1,0x11ff
L_8ea92c:
	bl.d L_8c82c0
L_8ea930:
	mov r3,0x38f
L_8ea934:
	b_s L_8ea904
	.global L_8ea936
L_8ea936:
	mov_s r0,0x0
L_8ea938:
	st_s r0,[r13,0x30]
L_8ea93a:
	b_s L_8ea966
	.global L_8ea93c
L_8ea93c:
	ld_s r0,[r13,0x30]
L_8ea93e:
	ldw r1,[r13, 0x44]
L_8ea942:
	brne r0,0x1,L_8ea966
L_8ea946:
	mov_s r0,0x0
L_8ea948:
	cmp_s r14,0x0
L_8ea94a:
	mov.eq r0,r13
L_8ea94e:
	mov.eq r1,0x4
L_8ea952:
	beq_s L_8ea95c
L_8ea954:
	st_s r0,[r13,0x30]
L_8ea956:
	brne_s r1,0,L_8ea966
L_8ea958:
	mov_s r0,r13
L_8ea95a:
	mov_s r1,0x5
	.global L_8ea95c
L_8ea95c:
	mov_s r2,r14
L_8ea95e:
	mov_s r3,0x0
L_8ea960:
	bl.d L_8d6a1c
L_8ea964:
	mov_s r4,r3
	.global L_8ea966
L_8ea966:
	brne_s r14,0,L_8ea974
L_8ea968:
	ld_s r1,[r15,0xc]
L_8ea96a:
	mov_s r0,r16
L_8ea96c:
	bl.d L_8dca18
L_8ea970:
	ldb_s r1,[r1,0x10]
L_8ea972:
	b_s L_8ea97a
	.global L_8ea974
L_8ea974:
	bl.d L_8c94c4
L_8ea978:
	mov_s r0,r16
	.global L_8ea97a
L_8ea97a:
	mov_s r0,0x0
L_8ea97c:
	b.d L_8c0324
L_8ea980:
	st_s r0,[r13,0x40]
L_8ea982:
	nop_s
