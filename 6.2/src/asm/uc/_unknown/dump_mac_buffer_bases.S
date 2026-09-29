/* dump_mac_buffer_bases @ 0x925c0c, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MAC buffer: base 0x%x mac 0x%x pal 0x%x
 *   MAC desc  : base 0x%x mac 0x%x pal 0x%x
 * Зовут его: fixed_sched__slot_prepare, macq__kick_queue_tx, vring__disconnect_flush
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, dump_vring_pring_info, qh__read_desc_window, uc_log__emit3, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dump_mac_buffer_bases
dump_mac_buffer_bases:
	.global L_925c0c
L_925c0c:
	push_s blink
L_925c0e:
	bl L_920234
L_925c12:
	sub_s sp,sp,0x10
L_925c14:
	bl.d L_929320
L_925c18:
	mov_s r13,r1
L_925c1a:
	mov_s r0,sp
L_925c1c:
	mov_s r1,r13
L_925c1e:
	mov_s r2,0x2
L_925c20:
	mov_s r3,0x0
L_925c22:
	bl.d L_92449c
L_925c26:
	mov r4,0x1
L_925c2a:
	ldw r2,[sp, 0x6]
L_925c2e:
	mov_s r1,0x1001ac8
L_925c34:
	ldw r3,[sp]
L_925c38:
	mov_s r0,0x21
L_925c3a:
	ldw r13,[sp, 0x2]
L_925c3e:
	bl.d L_92d338
L_925c42:
	mov_s r4,r13
L_925c44:
	ld_s r14,[sp,0xc]
L_925c46:
	mov_s r1,0x1001af0
L_925c4c:
	lsr r2,r14,0x10
L_925c50:
	ld_s r3,[sp,0x8]
L_925c52:
	bmsk_s r2,r2,0xb
L_925c54:
	lsr_s r3,r3,0xc
L_925c56:
	bmsk_s r3,r3,0xb
L_925c58:
	bmsk_s r14,r14,0x3
L_925c5a:
	asl_s r14,r14,0x8
L_925c5c:
	ldb r13,[sp, 0xb]
L_925c60:
	mov_s r0,0x21
L_925c62:
	bl.d L_92d338
L_925c66:
	or r4,r13,r14
L_925c6a:
	ldw r0,[sp, 0x6]
L_925c6e:
	brne r0,0x2000,L_925c7c
	.global L_925c76
L_925c76:
	b.d L_9202a4
L_925c7a:
	add_s sp,sp,0x10
	.global L_925c7c
L_925c7c:
	mov_s r0,blink
L_925c7e:
	mov_s r1,0x1583
L_925c84:
	bl L_926618
L_925c88:
	b_s L_925c76
L_925c8a:
	nop_s
