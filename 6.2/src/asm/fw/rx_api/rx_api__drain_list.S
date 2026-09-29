/* rx_api__drain_list @ 0x8e39dc, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_api__drain_all_lists
 * Зовёт сам: __ld_r15_to_r13_ret, __ld_r16_to_r13_ret, __st_r15_to_r13, __st_r16_to_r13, fw_sysassert_fatal, fwq_tx__handle_completion_thunk, llist__init, llist__pop_front, memset0_words, rx_pkt_srvs__dispatch_default
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_api__drain_list
rx_api__drain_list:
	.global L_8e39dc
L_8e39dc:
	push_s blink
L_8e39de:
	bl L_8c01dc
L_8e39e2:
	mov_s r13,r0
L_8e39e4:
	mov_s r14,r1
L_8e39e6:
	mov_s r15,r2
L_8e39e8:
	mov_s r16,r3
L_8e39ea:
	bl.d L_8c1cd8
L_8e39ee:
	mov_s r1,0x20
L_8e39f0:
	st_s r14,[r13,0x14]
L_8e39f2:
	ld_s r1,[r13,0x10]
L_8e39f4:
	st_s r15,[r13,0x18]
L_8e39f6:
	bclr_s r1,r1,0xa
L_8e39f8:
	bset r0,r1,0xa
L_8e39fc:
	st_s r0,[r13,0x10]
L_8e39fe:
	stw r16,[r13, 0x1e]
L_8e3a02:
	or r1,r1,0x600
L_8e3a06:
	b.d L_8c0244
L_8e3a0a:
	st_s r1,[r13,0x10]
L_8e3a0c:
	push_s blink
L_8e3a0e:
	bl L_8c01e0
L_8e3a12:
	sub_s sp,sp,0x18
L_8e3a14:
	brne r0,0x4,L_8e3a2e
	.global L_8e3a18
L_8e3a18:
	mov_s r15,sp
L_8e3a1a:
	bl.d L_8e293c
L_8e3a1e:
	mov_s r0,r15
L_8e3a20:
	mov_s r0,0x805fe4
L_8e3a26:
	bl.d L_8cc740
L_8e3a2a:
	mov_s r1,r15
L_8e3a2c:
	b_s L_8e3a84
	.global L_8e3a2e
L_8e3a2e:
	mov_s r0,blink
L_8e3a30:
	mov_s r1,0x1215
L_8e3a36:
	bl L_8c9b28
L_8e3a3a:
	b_s L_8e3a18
	.global L_8e3a3c
L_8e3a3c:
	bl.d L_8e2674
L_8e3a40:
	mov_s r0,r15
L_8e3a42:
	mov.f r13,r0
L_8e3a46:
	add_s r14,sp,0xc
L_8e3a48:
	beq_s L_8e3a72
	.global L_8e3a4a
L_8e3a4a:
	st_s r13,[r14]
L_8e3a4c:
	add r0,r13,0x28
L_8e3a50:
	st_s r0,[r14,0x8]
L_8e3a52:
	add r0,r13,0x38
L_8e3a56:
	st_s r0,[r14,0x4]
L_8e3a58:
	ldb r0,[r13, 0x34]
L_8e3a5c:
	cmp_s r0,0x0
L_8e3a5e:
	cmp.ne r0,0x1
L_8e3a62:
	beq_s L_8e3a7e
L_8e3a64:
	mov_s r0,blink
L_8e3a66:
	mov_s r1,0x1216
L_8e3a6c:
	bl L_8c9b28
L_8e3a70:
	b_s L_8e3a84
	.global L_8e3a72
L_8e3a72:
	mov_s r0,blink
L_8e3a74:
	mov_s r1,0x1
L_8e3a76:
	bl.d L_8c9b28
L_8e3a7a:
	bset_s r1,r1,0xc
L_8e3a7c:
	b_s L_8e3a4a
	.global L_8e3a7e
L_8e3a7e:
	bl.d L_8e3a90
L_8e3a82:
	mov_s r0,r13
	.global L_8e3a84
L_8e3a84:
	ld_s r0,[sp,0x0]
L_8e3a86:
	brne_s r0,0,L_8e3a3c
L_8e3a88:
	b.d L_8c024c
L_8e3a8c:
	add_s sp,sp,0x18
L_8e3a8e:
	nop_s
