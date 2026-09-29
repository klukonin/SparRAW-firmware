/* l2mgr__init @ 0x8f55b8, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [L2MGR] R1 OOB mode: disable power management
 *   [L2MGR] R2 OOB mode
 * Зовут его: l2mgr__on_lmac_ready
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, boot__read_oob_strap_bits, fw_log_emit0, fw_sysassert_fatal, l2mgr__init_periodic_detector, l2mgr__mac_bringup, l2mgr__mac_started_log, l2mgr__oob_pair, l2mgr__reset_oob_rings, link_loss_detectors__init, mid_ctx__init_pools
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__init
l2mgr__init:
	.global L_8f55b8
L_8f55b8:
	push_s blink
L_8f55ba:
	bl.d L_8c01e4
L_8f55be:
	mov_s r0,0x0
L_8f55c0:
	st.as r0,[gp,-0x35]
L_8f55c4:
	mov_s r14,0x803c00
L_8f55ca:
	st_s r0,[r14,0xc]
L_8f55cc:
	bl.d L_8cc2ac
L_8f55d0:
	st_s r0,[r14,0x10]
L_8f55d2:
	mov_s r13,0x803b80
L_8f55d8:
	breq r0,0x2,L_8f55f6
L_8f55dc:
	brne r0,0x4,L_8f5606
L_8f55e0:
	mov_s r0,0x1
L_8f55e2:
	st_s r0,[r14,0xc]
L_8f55e4:
	mov_s r1,0x100f948
L_8f55ea:
	bl.d L_8dcba8
L_8f55ee:
	mov_s r0,0x2b
L_8f55f0:
	bl L_8c8fc0
L_8f55f4:
	b_s L_8f5606
	.global L_8f55f6
L_8f55f6:
	mov_s r0,0x1
L_8f55f8:
	st_s r0,[r14,0x10]
L_8f55fa:
	mov_s r1,0x100f978
L_8f5600:
	bl.d L_8dcba8
L_8f5604:
	mov_s r0,0x2b
	.global L_8f5606
L_8f5606:
	bl L_8d91f4
L_8f560a:
	bl L_8d94f0
L_8f560e:
	bl L_8f56b8
L_8f5612:
	bl L_8d8c7c
L_8f5616:
	mov_s r0,0x84e7e0
L_8f561c:
	bl L_8d8ce0
L_8f5620:
	mov_s r14,0x8004a4
L_8f5626:
	mov_s r0,0x0
L_8f5628:
	mov_s r1,r14
L_8f562a:
	add_s r2,r13,0x4
L_8f562c:
	bl.d L_8f972c
L_8f5630:
	ldw_s r3,[r13,0x26]
L_8f5632:
	breq_s r0,0,L_8f5668
	.global L_8f5634
L_8f5634:
	bl L_8f6ab8
L_8f5638:
	bl L_8f552c
L_8f563c:
	bl L_8d928c
L_8f5640:
	bl L_8e4058
L_8f5644:
	bl L_8fb480
L_8f5648:
	bl L_8d940c
L_8f564c:
	bl.d L_8c661c
L_8f5650:
	st.as r0,[gp,-0x1d]
L_8f5654:
	mov_s r0,r14
L_8f5656:
	bl.d L_8f5d60
L_8f565a:
	mov_s r1,0xff
L_8f565c:
	mov_s r0,0x0
L_8f565e:
	bl.d L_8e8a14
L_8f5662:
	mov_s r1,r0
L_8f5664:
	b L_8c0254
	.global L_8f5668
L_8f5668:
	mov_s r0,blink
L_8f566a:
	mov_s r1,0x11d8
L_8f5670:
	bl L_8c9b28
L_8f5674:
	b_s L_8f5634
L_8f5676:
	nop_s
