/* mem_pool__allocate @ 0x8c354c, 372 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mem_pool::allocate failed (m_allocated == m_num_of_cells) (m_allocated=%d)
 *   mem_pool::allocate failed 1 (this=0x%08X)
 *   mem_pool::allocate BLINK=0x%08X
 *   mem_pool::allocate failed 3 (this=0x%08X)
 *   mem_pool::allocate m_p_last_freed=0x%08X
 *   mem_pool::allocate m_p_buffer=0x%08X
 *   mem_pool::allocate m_cell_size=0x%08X
 *   mem_pool::allocate failed 4 (this=0x%08X)
 * Зовут его: STREAM_MGR__ADD, TX_API__alloc_tx_payload, add_bcon, add_discovery_bcon, alloc_dband_info, ba_sm__prepare_ba_td, calib_engine__on_lock_radio, conn_mgr__add_to_rinking_list, conn_mgr__alloc_cid, mem_pool__alloc_cell
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_divmod_unsigned, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mem_pool__allocate
mem_pool__allocate:
	.global L_8c354c
L_8c354c:
	push_s blink
L_8c354e:
	bl L_8c01e4
L_8c3552:
	mov_s r14,r0
L_8c3554:
	ld_s r0,[r0,0x4]
L_8c3556:
	breq_s r0,0,L_8c356c
	.global L_8c3558
L_8c3558:
	ld_s r2,[r14,0xc]
L_8c355a:
	ld_s r0,[r14,0x10]
L_8c355c:
	brne r2,r0,L_8c3576
L_8c3560:
	mov_s r1,0x1001b90
L_8c3566:
	mov_s r13,0x0
L_8c3568:
	mov_s r0,0x0
L_8c356a:
	b_s L_8c36b4
	.global L_8c356c
L_8c356c:
	mov_s r0,blink
L_8c356e:
	bl.d L_8c9b28
L_8c3572:
	mov_s r1,0xe2
L_8c3574:
	b_s L_8c3558
	.global L_8c3576
L_8c3576:
	ld_s r0,[r14,0x4]
L_8c3578:
	ld_s r13,[r14]
L_8c357a:
	rsub r0,r0,r13
L_8c357e:
	bl.d L_8c02d4
L_8c3582:
	ld_s r1,[r14,0x8]
L_8c3584:
	breq_s r1,0,L_8c35aa
L_8c3586:
	mov_s r1,0x1001bdc
L_8c358c:
	mov_s r0,0x0
L_8c358e:
	bl.d L_8dcc10
L_8c3592:
	mov_s r2,r14
L_8c3594:
	mov_s r2,blink
L_8c3596:
	mov_s r1,0x1001c08
L_8c359c:
	bl.d L_8dcc10
L_8c35a0:
	mov_s r0,0x0
L_8c35a2:
	mov_s r0,blink
L_8c35a4:
	bl.d L_8c9b28
L_8c35a8:
	mov_s r1,0xe3
	.global L_8c35aa
L_8c35aa:
	ld_s r0,[r14,0x4]
L_8c35ac:
	brlo r13,r0,L_8c36a0
L_8c35b0:
	ld_s r2,[r14,0x8]
L_8c35b2:
	ld_s r1,[r14,0x10]
L_8c35b4:
	mulu64 r2,r1
L_8c35b8:
	add_s r0,r0,mlo
L_8c35ba:
	brhs r13,r0,L_8c36a0
	.global L_8c35be
L_8c35be:
	breq_s r13,0,L_8c35ca
L_8c35c0:
	ld_s r0,[r13]
L_8c35c2:
	st_s r0,[r14]
L_8c35c4:
	ld_s r0,[r14,0xc]
L_8c35c6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c35c8:
	st_s r0,[r14,0xc]
	.global L_8c35ca
L_8c35ca:
	ld_s r1,[r14]
L_8c35cc:
	breq r1,0x0,L_8c36aa
L_8c35d0:
	ld_s r0,[r14,0x4]
L_8c35d2:
	rsub r0,r0,r1
L_8c35d6:
	bl.d L_8c02d4
L_8c35da:
	ld_s r1,[r14,0x8]
L_8c35dc:
	breq_s r1,0,L_8c362c
L_8c35de:
	mov_s r1,0x1001c28
L_8c35e4:
	mov_s r0,0x0
L_8c35e6:
	bl.d L_8dcc10
L_8c35ea:
	mov_s r2,r14
L_8c35ec:
	mov_s r1,0x1001c54
L_8c35f2:
	mov_s r0,0x0
L_8c35f4:
	bl.d L_8dcc10
L_8c35f8:
	ld_s r2,[r14]
L_8c35fa:
	mov_s r1,0x1001c80
L_8c3600:
	mov_s r0,0x0
L_8c3602:
	bl.d L_8dcc10
L_8c3606:
	ld_s r2,[r14,0x4]
L_8c3608:
	mov_s r1,0x1001ca8
L_8c360e:
	mov_s r0,0x0
L_8c3610:
	bl.d L_8dcc10
L_8c3614:
	ld_s r2,[r14,0x8]
L_8c3616:
	mov_s r2,blink
L_8c3618:
	mov_s r1,0x1001c08
L_8c361e:
	bl.d L_8dcc10
L_8c3622:
	mov_s r0,0x0
L_8c3624:
	mov_s r0,blink
L_8c3626:
	bl.d L_8c9b28
L_8c362a:
	mov_s r1,0xe5
	.global L_8c362c
L_8c362c:
	ld_s r2,[r14]
L_8c362e:
	ld_s r0,[r14,0x4]
L_8c3630:
	brlo r2,r0,L_8c3642
L_8c3634:
	ld_s r3,[r14,0x8]
L_8c3636:
	ld_s r1,[r14,0x10]
L_8c3638:
	mulu64 r3,r1
L_8c363c:
	add_s r0,r0,mlo
L_8c363e:
	brlo r2,r0,L_8c36b8
	.global L_8c3642
L_8c3642:
	mov_s r1,0x1001cd0
L_8c3648:
	mov_s r0,0x0
L_8c364a:
	bl.d L_8dcc10
L_8c364e:
	mov_s r2,r14
L_8c3650:
	mov_s r1,0x1001cfc
L_8c3656:
	mov_s r0,0x0
L_8c3658:
	bl.d L_8dcc10
L_8c365c:
	ld_s r2,[r14]
L_8c365e:
	mov_s r1,0x1001d28
L_8c3664:
	mov_s r0,0x0
L_8c3666:
	bl.d L_8dcc10
L_8c366a:
	ld_s r2,[r14,0x4]
L_8c366c:
	mov_s r1,0x1001d54
L_8c3672:
	mov_s r0,0x0
L_8c3674:
	bl.d L_8dcc10
L_8c3678:
	ld_s r2,[r14,0x8]
L_8c367a:
	mov_s r1,0x1001d80
L_8c3680:
	mov_s r0,0x0
L_8c3682:
	bl.d L_8dcc10
L_8c3686:
	ld_s r2,[r14,0x10]
L_8c3688:
	mov_s r2,blink
L_8c368a:
	mov_s r1,0x1001c08
L_8c3690:
	bl.d L_8dcc10
L_8c3694:
	mov_s r0,0x0
L_8c3696:
	mov_s r0,blink
L_8c3698:
	bl.d L_8c9b28
L_8c369c:
	mov_s r1,0xe6
L_8c369e:
	b_s L_8c36b8
	.global L_8c36a0
L_8c36a0:
	mov_s r0,blink
L_8c36a2:
	bl.d L_8c9b28
L_8c36a6:
	mov_s r1,0xe4
L_8c36a8:
	b_s L_8c35be
	.global L_8c36aa
L_8c36aa:
	mov_s r1,0x1001dac
L_8c36b0:
	mov_s r0,0x10
L_8c36b2:
	mov_s r2,r14
	.global L_8c36b4
L_8c36b4:
	bl L_8dcc10
	.global L_8c36b8
L_8c36b8:
	b.d L_8c0254
L_8c36bc:
	mov_s r0,r13
L_8c36be:
	nop_s
