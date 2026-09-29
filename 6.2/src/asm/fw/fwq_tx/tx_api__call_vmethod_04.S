/* tx_api__call_vmethod_04 @ 0x8cc748, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__handle_completed_packets
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, fw_sysassert_fatal, fwq_tx__long_retry_failures, fwq_tx__on_flush_done, fwq_tx__queue_step, sm__null_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__call_vmethod_04
tx_api__call_vmethod_04:
	.global L_8cc748
L_8cc748:
	push_s blink
L_8cc74a:
	bl L_8c01dc
L_8cc74e:
	mov_s r13,r0
L_8cc750:
	ld_s r0,[r0,0x4c]
L_8cc752:
	mov_s r16,r1
L_8cc754:
	ld_s r2,[r0,0x4]
L_8cc756:
	sub_s sp,sp,0x4
L_8cc758:
	jl_s.d [r2]
L_8cc75a:
	mov_s r0,r13
L_8cc75c:
	mov_s r0,r13
L_8cc75e:
	bl.d L_8c66ac
L_8cc762:
	mov_s r1,r16
L_8cc764:
	mov_s r14,sp
L_8cc766:
	mov_s r0,r14
L_8cc768:
	bl.d L_8e5dfc
L_8cc76c:
	ld_s r1,[r13,0x14]
L_8cc76e:
	b_s L_8cc780
	.global L_8cc770
L_8cc770:
	bl.d L_8df444
L_8cc774:
	mov_s r0,r14
L_8cc776:
	mov_s r1,r0
L_8cc778:
	mov_s r0,r13
L_8cc77a:
	bl.d L_8e9838
L_8cc77e:
	mov_s r2,r16
	.global L_8cc780
L_8cc780:
	bl.d L_8cdcc4
L_8cc784:
	mov_s r0,r14
L_8cc786:
	brne_s r0,0,L_8cc770
L_8cc788:
	ld_s r0,[r13,0x8]
L_8cc78a:
	breq_s r0,0,L_8cc7be
L_8cc78c:
	breq r0,0x1,L_8cc7a2
L_8cc790:
	breq r0,0x2,L_8cc7aa
L_8cc794:
	mov_s r0,blink
L_8cc796:
	mov_s r1,0x1211
L_8cc79c:
	bl L_8c9b28
L_8cc7a0:
	b_s L_8cc7be
	.global L_8cc7a2
L_8cc7a2:
	bl.d L_8e5620
L_8cc7a6:
	mov_s r0,r13
L_8cc7a8:
	b_s L_8cc7be
	.global L_8cc7aa
L_8cc7aa:
	ld_s r0,[r13,0x34]
L_8cc7ac:
	cmp_s r0,0x0
L_8cc7ae:
	mov_s r0,0x1
L_8cc7b0:
	sub_s.ne r0,r0,r0
L_8cc7b2:
	extb.f 0x0,r0
L_8cc7b6:
	bl.ne.d L_8df4f0
L_8cc7ba:
	mov.ne r0,r13
	.global L_8cc7be
L_8cc7be:
	b.d L_8c0244
L_8cc7c2:
	add_s sp,sp,0x4
