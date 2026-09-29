/* tx_fifo__write_bytes @ 0x9257f4, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft__send_ssw_feedback, direct_tx__send_from_desc, direct_tx__send_short_frame, direct_tx_step, mac_mode__send_direct_frame, rx__send_dmg_cts, rx__send_response_frame, rx_funcs__send_direct_frame, tx_fifo__push_frame_3ies, txss_init__send_ssw_fdbk
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_fifo__write_bytes
tx_fifo__write_bytes:
	.global L_9257f4
L_9257f4:
	st.a r13,[sp,-0xc]
L_9257f8:
	st_s r14,[sp,0x8]
L_9257fa:
	mov_s r14,r1
L_9257fc:
	bmsk r1,r0,0x1
L_925800:
	rsub.f r1,r1,0x1
L_925804:
	mov.cs r1,0x0
L_925808:
	st blink,[sp, 0x4]
L_92580c:
	brne.d r1,0x1,L_925864
L_925810:
	mov r13,r0
	.global L_925814
L_925814:
	lsr.f r7,r14,0x2
L_925818:
	bmsk r5,r14,0x1
L_92581c:
	mov.ne lp_count,r7
L_925820:
	mov 0x0,0x0
L_925824:
	lpne L_925830
L_925828:
	ld.ab r33,[r13,0x4]
L_92582c:
	mov 0x0,0x0
	.global L_925830
L_925830:
	breq r5,0x0,L_92584c
L_925834:
	breq r5,0x1,L_925848
L_925838:
	breq r5,0x2,L_925844
L_92583c:
	brne r5,0x3,L_92584c
L_925840:
	ldb.ab r34,[r13,0x1]
	.global L_925844
L_925844:
	ldb.ab r34,[r13,0x1]
	.global L_925848
L_925848:
	ldb r34,[r13]
	.global L_92584c
L_92584c:
	ld.as r2,[gp,-0x5]
L_925850:
	ld blink,[sp, 0x4]
L_925854:
	sub_s r2,r2,r14
L_925856:
	st.as r2,[gp,-0x5]
L_92585a:
	ld_s r14,[sp,0x8]
L_92585c:
	j.d [blink]
L_925860:
	ld.ab r13,[sp,0xc]
	.global L_925864
L_925864:
	mov r0,blink
L_925868:
	bl.d L_926618
L_92586c:
	mov r1,0x37
L_925870:
	b_s L_925814
L_925872:
	nop_s
