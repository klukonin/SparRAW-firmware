/* conn_mgr__set_link_maintain_cfg @ 0x8e67d0, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::set_link_maintain_cfg(): cfg_type = %d, cid = %d
 *   conn_mgr::set_link_maintain_cfg(): Configuration failed due to bad destination cid = %d
 *   conn_mgr::set_link_maintain_cfg(): Configuration failed due to unknown cfg_type=%d
 * Зовут его: wmi_link_maintain_cfg_write
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, conn_mgr__by_cid, conn_mgr__print_link_maintain_cfg, conn_mgr__stop_link_loss_monitoring, fw_log_emit1, fw_log_emit2, link_maintain_cfg__copy, lm_if__start_link_loss_monitoring, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__set_link_maintain_cfg
conn_mgr__set_link_maintain_cfg:
	.global L_8e67d0
L_8e67d0:
	push_s blink
L_8e67d2:
	bl L_8c01d8
L_8e67d6:
	sub_s sp,sp,0x24
L_8e67d8:
	mov_s r14,r0
L_8e67da:
	mov_s r13,r1
L_8e67dc:
	mov_s r16,r2
L_8e67de:
	mov_s r1,0x100c1ec
L_8e67e4:
	mov_s r0,0x2b
L_8e67e6:
	mov_s r2,r14
L_8e67e8:
	bl.d L_8dcc80
L_8e67ec:
	mov_s r3,r13
L_8e67ee:
	mov r17,-0x1
L_8e67f2:
	breq r13,r17,L_8e680c
L_8e67f6:
	brlo r13,0x8,L_8e680c
L_8e67fa:
	mov_s r1,0x100c228
L_8e6800:
	mov_s r0,0xb
L_8e6802:
	mov_s r2,r13
	.global L_8e6804
L_8e6804:
	bl L_8dcc10
L_8e6808:
	mov_s r0,0x1
L_8e680a:
	b_s L_8e6894
	.global L_8e680c
L_8e680c:
	breq r14,0x4,L_8e681e
L_8e6810:
	mov_s r15,sp
L_8e6812:
	mov_s r0,r14
L_8e6814:
	bl.d L_8cc170
L_8e6818:
	mov_s r1,r15
L_8e681a:
	breq_s r0,0,L_8e682c
L_8e681c:
	mov_s r16,r15
	.global L_8e681e
L_8e681e:
	bl.d L_8e105c
L_8e6822:
	mov_s r0,r16
L_8e6824:
	breq r13,r17,L_8e6838
L_8e6828:
	mov_s r0,r13
L_8e682a:
	b_s L_8e683c
	.global L_8e682c
L_8e682c:
	mov_s r1,0x100c280
L_8e6832:
	mov_s r0,0xb
L_8e6834:
	mov_s r2,r14
L_8e6836:
	b_s L_8e6804
	.global L_8e6838
L_8e6838:
	mov_s r13,0x0
L_8e683a:
	mov_s r0,0x7
	.global L_8e683c
L_8e683c:
	brlo r0,r13,L_8e6892
L_8e6840:
	sub_s r0,r0,r13
L_8e6842:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8e6844
L_8e6844:
	mov_s r17,r0
L_8e6846:
	bl.d L_8cbffc
L_8e684a:
	mov_s r0,r13
L_8e684c:
	mov.f r14,r0
L_8e6850:
	mov.eq r15,0x0
L_8e6854:
	beq_s L_8e6860
L_8e6856:
	ldb r0,[r14, 0xf0]
L_8e685a:
	mov_s r15,0x1
L_8e685c:
	cmp_s r0,0x2
L_8e685e:
	sub_s.ne r15,r15,r15
	.global L_8e6860
L_8e6860:
	cmp_s r15,0x0
L_8e6862:
	bl.ne.d L_8e7fb4
L_8e6866:
	mov.ne r0,r14
L_8e686a:
	asl_s r0,r13,0x2
L_8e686c:
	add3_s r0,r0,r0
L_8e686e:
	add_s r0,r0,0x857060
L_8e6874:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8e6876:
	mov_s r1,r16
L_8e6878:
	bl.d L_8c0380
L_8e687c:
	mov_s r2,0x24
L_8e687e:
	cmp_s r15,0x0
L_8e6880:
	bl.ne.d L_8e7a7c
L_8e6884:
	mov.ne r0,r14
L_8e6888:
	sub r0,r17,0x1
L_8e688c:
	brhs.d r0,0x1,L_8e6844
L_8e6890:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8e6892
L_8e6892:
	mov_s r0,0x0
	.global L_8e6894
L_8e6894:
	b.d L_8c023c
L_8e6898:
	add_s sp,sp,0x24
L_8e689a:
	nop_s
