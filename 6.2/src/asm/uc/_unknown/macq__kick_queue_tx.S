/* macq__kick_queue_tx @ 0x925a48, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fixed_sched__check_slot_flag
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, dump_mac_buffer_bases, mac__program_tx_with_qid, mac_mem__addr_of_slot, macq__is_idle, qh__read_desc_window, qh__write_desc_window, tx_ctx__alloc_next, uc_sysassert
 * Глобалы (через gp): 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq__kick_queue_tx
macq__kick_queue_tx:
	.global L_925a48
L_925a48:
	push_s blink
L_925a4a:
	bl L_920230
L_925a4e:
	mov_s r13,r0
L_925a50:
	mov_s r15,r1
L_925a52:
	bl.d L_92609c
L_925a56:
	st.a r2,[sp,-0x18]
L_925a5a:
	brne_s r0,0,L_925a70
L_925a5c:
	mov_s r0,r13
L_925a5e:
	bl.d L_925c0c
L_925a62:
	mov_s r1,r13
L_925a64:
	mov_s r0,blink
L_925a66:
	mov_s r1,0x157a
L_925a6c:
	bl L_926618
	.global L_925a70
L_925a70:
	mov_s r1,0x886a00
L_925a76:
	ld_s r0,[r1,0x28]
L_925a78:
	or r0,r0,0x3
L_925a7c:
	st_s r0,[r1,0x28]
L_925a7e:
	sync
L_925a82:
	mov_s r1,0x886a00
L_925a88:
	ld_s r0,[r1,0x28]
L_925a8a:
	bic r0,r0,0x3
L_925a8e:
	st_s r0,[r1,0x28]
L_925a90:
	sync
L_925a94:
	add_s r14,sp,0x4
L_925a96:
	mov_s r0,r14
L_925a98:
	mov_s r1,r13
L_925a9a:
	mov_s r2,0x2
L_925a9c:
	mov_s r3,0x0
L_925a9e:
	bl.d L_92449c
L_925aa2:
	mov r4,0x1
L_925aa6:
	ldw r0,[sp, 0xa]
L_925aaa:
	mov_s r1,r13
L_925aac:
	stw r0,[sp, 0x4]
L_925ab0:
	stw r0,[sp, 0x6]
L_925ab4:
	ld_s r0,[sp,0x0]
L_925ab6:
	mov_s r2,0x2
L_925ab8:
	/* add_s r0,0x7 */
	.byte 0x07,0xe0
L_925aba:
	lsr_s r0,r0,0x3
L_925abc:
	stw r0,[sp, 0x8]
L_925ac0:
	mov_s r0,r14
L_925ac2:
	mov_s r3,0x0
L_925ac4:
	mov_s r4,r3
L_925ac6:
	mov_s r5,r3
L_925ac8:
	mov_s r6,r3
L_925aca:
	bl.d L_924348
L_925ace:
	mov r7,0x1
L_925ad2:
	bl.d L_9384d4
L_925ad6:
	mov_s r0,0x1
L_925ad8:
	st_s r13,[r0,0x4]
L_925ada:
	bl.d L_92d93c
L_925ade:
	mov_s r0,r13
	.global L_925ae0
L_925ae0:
	mov_s r0,r43
L_925ae2:
	bbit0 r0,0x1f,L_925ae0
L_925ae6:
	mov_s r0,r51
L_925ae8:
	bmsk r1,r0,0x3
L_925aec:
	st.as r1,[gp,0x38]
L_925af0:
	lsr_s r0,r0,0x4
L_925af2:
	st.as r0,[gp,0x39]
	.global L_925af6
L_925af6:
	mov_s r0,r45
L_925af8:
	bbit0 r0,0x1f,L_925af6
L_925afc:
	mov_s r0,r15
L_925afe:
	mov_s r1,0x0
L_925b00:
	bl.d L_928e68
L_925b04:
	mov_s r2,r13
L_925b06:
	mov_s r2,0x886a00
L_925b0c:
	ld_s r1,[r2,0x14]
L_925b0e:
	mov_s r0,0x1
L_925b10:
	mov_s r3,0x0
L_925b12:
	bset r3,r3,r13
L_925b16:
	bic_s r1,r1,r3
L_925b18:
	or_s r1,r1,r3
L_925b1a:
	st_s r1,[r2,0x14]
L_925b1c:
	st_s r3,[r2,0x18]
L_925b1e:
	st_s r3,[r2,0x1c]
L_925b20:
	st_s r0,[r2,0x20]
L_925b22:
	bl L_9384d4
L_925b26:
	st_s r13,[r0,0x4]
L_925b28:
	bl.d L_92d93c
L_925b2c:
	mov_s r0,r13
	.global L_925b2e
L_925b2e:
	mov_s r0,r43
L_925b30:
	bbit0 r0,0x1f,L_925b2e
L_925b34:
	mov_s r0,r51
L_925b36:
	bmsk r1,r0,0x3
L_925b3a:
	st.as r1,[gp,0x38]
L_925b3e:
	lsr_s r0,r0,0x4
L_925b40:
	st.as r0,[gp,0x39]
	.global L_925b44
L_925b44:
	mov_s r0,r45
L_925b46:
	bbit0 r0,0x1f,L_925b44
L_925b4a:
	b.d L_92029c
L_925b4e:
	add_s sp,sp,0x18
