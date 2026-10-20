/* tx_list__remove @ 0x8e2884, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__awake_peer_ntf, TX_API__callback_and_release, conn_mgr__find_reusable_cid, conn_mgr__ranking_remove, fwq_tx__flush_list_packets_by_cid, fwq_tx__long_retry_failures, fwq_tx__long_retry_handler, mid_list__remove_entry, radio_mgr__unlink_request, rm_main_sm__primary_handle_free
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_list__remove
tx_list__remove:
	.global L_8e2884
L_8e2884:
	push_s blink
L_8e2886:
	bl L_8c01e4
L_8e288a:
	mov.f r14,r1
L_8e288e:
	mov_s r13,r0
L_8e2890:
	beq_s L_8e28b2
	.global L_8e2892
L_8e2892:
	ld_s r0,[r14,0x4]
L_8e2894:
	brne r13,r0,L_8e28bc
	.global L_8e2898
L_8e2898:
	ld_s r0,[r13]
L_8e289a:
	breq_s r0,0,L_8e28c6
	.global L_8e289c
L_8e289c:
	ld_s r1,[r13,0x4]
L_8e289e:
	brne r14,r1,L_8e28d2
L_8e28a2:
	ld_s r0,[r13,0x8]
L_8e28a4:
	brne r14,r0,L_8e28ac
L_8e28a8:
	mov_s r0,0x0
L_8e28aa:
	st_s r0,[r13,0x8]
	.global L_8e28ac
L_8e28ac:
	ld_s r0,[r14]
L_8e28ae:
	st_s r0,[r13,0x4]
L_8e28b0:
	b_s L_8e28f2
	.global L_8e28b2
L_8e28b2:
	mov_s r0,blink
L_8e28b4:
	bl.d L_8c9b28
L_8e28b8:
	mov_s r1,0xda
L_8e28ba:
	b_s L_8e2892
	.global L_8e28bc
L_8e28bc:
	mov_s r0,blink
L_8e28be:
	bl.d L_8c9b28
L_8e28c2:
	mov_s r1,0xdb
L_8e28c4:
	b_s L_8e2898
	.global L_8e28c6
L_8e28c6:
	mov_s r0,blink
L_8e28c8:
	bl.d L_8c9b28
L_8e28cc:
	mov_s r1,0xdc
L_8e28ce:
	b_s L_8e289c
	.global L_8e28d0
L_8e28d0:
	mov_s r1,r0
	.global L_8e28d2
L_8e28d2:
	breq_s r1,0,L_8e28da
L_8e28d4:
	ld_s r0,[r1]
L_8e28d6:
	brne r14,r0,L_8e28d0
	.global L_8e28da
L_8e28da:
	brne_s r1,0,L_8e28e6
L_8e28dc:
	mov_s r0,blink
L_8e28de:
	bl.d L_8c9b28
L_8e28e2:
	mov_s r1,0xdd
L_8e28e4:
	b_s L_8e28fe
	.global L_8e28e6
L_8e28e6:
	ld_s r0,[r14]
L_8e28e8:
	st_s r0,[r1]
L_8e28ea:
	ld_s r0,[r13,0x8]
L_8e28ec:
	brne r14,r0,L_8e28f2
L_8e28f0:
	st_s r1,[r13,0x8]
	.global L_8e28f2
L_8e28f2:
	mov_s r0,0x0
L_8e28f4:
	st_s r0,[r14]
L_8e28f6:
	st_s r0,[r14,0x4]
L_8e28f8:
	ld_s r0,[r13]
L_8e28fa:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8e28fc:
	st_s r0,[r13]
	.global L_8e28fe
L_8e28fe:
	b L_8c0254
L_8e2902:
	nop_s
