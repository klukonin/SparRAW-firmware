/* macq__flush_queue @ 0x925b7c, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fixed_sched__slot_prepare, vring__disconnect_flush
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, dmaq_hw__read_ptr, macq__read_hw_queue_word, macq_hw__clear_2d8, macq_hw__read_rptr, macq_hw__read_wptr, macq_hw__sync_dma_wptr
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq__flush_queue
macq__flush_queue:
	.global L_925b7c
L_925b7c:
	push_s blink
L_925b7e:
	bl L_920230
L_925b82:
	sub_s sp,sp,0x4
L_925b84:
	mov_s r15,r0
L_925b86:
	mov_s r14,r1
L_925b88:
	bl.d L_92a69c
L_925b8c:
	mov_s r13,r2
L_925b8e:
	mov_s r0,0x886a00
L_925b94:
	ld_s r3,[r0,0x1c]
L_925b96:
	mov_s r2,0x1
L_925b98:
	mov_s r1,0x0
L_925b9a:
	bset r1,r1,r13
L_925b9e:
	bic_s r3,r3,r1
L_925ba0:
	st_s r1,[r0,0x18]
L_925ba2:
	st_s r3,[r0,0x1c]
L_925ba4:
	st_s r2,[r0,0x20]
L_925ba6:
	sync
L_925baa:
	bl.d L_929068
L_925bae:
	mov_s r0,r14
L_925bb0:
	st_s r0,[sp,0x0]
	.global L_925bb2
L_925bb2:
	mov_s r0,0xaaad00
L_925bb8:
	mov_s r32,r0
L_925bba:
	st.ab r0,[r25,0x4]
L_925bbe:
	bclr r25,r25,0xa
L_925bc2:
	mov_s r0,0x800738
L_925bc8:
	ld_s r0,[r0,0x10]
L_925bca:
	lr r0,[r0]
L_925bce:
	bmsk_s r0,r0,0x17
L_925bd0:
	mov_s r32,r0
L_925bd2:
	st.ab r0,[r25,0x4]
L_925bd6:
	bclr r25,r25,0xa
L_925bda:
	bl.d L_9290a8
L_925bde:
	mov_s r0,r15
L_925be0:
	ld_s r1,[sp,0x0]
L_925be2:
	cmp_s r1,r0
L_925be4:
	bne_s L_925bb2
L_925be6:
	bl.d L_9290bc
L_925bea:
	mov_s r0,r15
L_925bec:
	mov_s r13,r0
L_925bee:
	bl.d L_929088
L_925bf2:
	mov_s r0,r14
L_925bf4:
	cmp_s r13,r0
L_925bf6:
	bne_s L_925bb2
L_925bf8:
	sync
L_925bfc:
	bl.d L_928f78
L_925c00:
	mov_s r0,r14
L_925c02:
	sync
L_925c06:
	b.d L_92029c
L_925c0a:
	add_s sp,sp,0x4
