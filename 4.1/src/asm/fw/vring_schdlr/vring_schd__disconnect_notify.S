/* vring_schd__disconnect_notify @ 0x8c7b0c, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schd::disconnect_notify # %d
 *   vring_schdlr.cpp
 *   There is more data for stopped #%d V-ring -> moved to ready queue.
 *   Not found another to run, so #%d V-ring is re-connected now.
 * Зовут его: vring__teardown
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit1, fw_sysassert_fatal, hwd_dma__get_881c80, llist__insert, llist__pop_front, u_schd__add, vr_obj__update_connected_duration, vring__disable_and_ack, vring_hw__clear_enable_bit, vring_schd__bind_if_free
 */
	.section .text.vring_schd__disconnect_notify,"ax",@progbits
	.global vring_schd__disconnect_notify
vring_schd__disconnect_notify:
	.global L_8c7b0c
L_8c7b0c:
	push_s blink
L_8c7b0e:
	bl.d L_8c02b0
L_8c7b12:
	mov_s r1,0x2
L_8c7b14:
	mov_s r17,r0
L_8c7b16:
	mov_s r2,0x100a768
L_8c7b1c:
	mov_s r0,0x7
L_8c7b1e:
	mov_s r16,r1
L_8c7b20:
	bl.d L_8edfcc
L_8c7b24:
	mov_s r3,r17
L_8c7b26:
	mul64 r17,0x38
L_8c7b2a:
	mov_s r13,0x804580
L_8c7b30:
	add r0,r13,0x24
L_8c7b34:
	add r18,r0,mlo
L_8c7b38:
	ld r14,[r18, 0x14]
L_8c7b3c:
	breq_s r14,0,L_8c7b70
	.global L_8c7b3e
L_8c7b3e:
	mov_s r0,r14
L_8c7b40:
	mov_s r15,0x0
L_8c7b42:
	bl.d L_8e5684
L_8c7b46:
	mov_s r1,r15
L_8c7b48:
	st r15,[r18, 0x14]
L_8c7b4c:
	breq r17,0x1,L_8c7c1a
L_8c7b50:
	mov_s r3,0x2
L_8c7b52:
	b_s L_8c7b66
	.global L_8c7b54
L_8c7b54:
	asl_s r1,r3,0x2
L_8c7b56:
	add1_s r1,r1,r1
L_8c7b58:
	add r0,r13,0xc
L_8c7b5c:
	add r4,r0,r1
L_8c7b60:
	ld r15,[r4, 0x4]
L_8c7b64:
	brne_s r15,0,L_8c7b88
	.global L_8c7b66
L_8c7b66:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_8c7b68:
	cmp r3,-0x1
L_8c7b6c:
	bne_s L_8c7b54
L_8c7b6e:
	b_s L_8c7ba2
	.global L_8c7b70
L_8c7b70:
	mov_s r0,blink
L_8c7b72:
	mov_s r2,0x100a584
L_8c7b78:
	mov_s r1,0x12af
L_8c7b7e:
	bl.d L_8c82c0
L_8c7b82:
	mov r3,0x20f
L_8c7b86:
	b_s L_8c7b3e
	.global L_8c7b88
L_8c7b88:
	mov_s r0,r13
L_8c7b8a:
	bl.d L_8c588c
L_8c7b8e:
	ldb_s r1,[r15,0xa]
L_8c7b90:
	brne_s r0,0,L_8c7b66
L_8c7b92:
	bl.d L_8de2d4
L_8c7b96:
	mov_s r0,r4
L_8c7b98:
	mov_s r0,r13
L_8c7b9a:
	mov_s r1,r15
L_8c7b9c:
	bl.d L_8c6300
L_8c7ba0:
	mov_s r2,r18
	.global L_8c7ba2
L_8c7ba2:
	ld_s r0,[r14,0x20]
L_8c7ba4:
	cmp_s r0,0x1
L_8c7ba6:
	mov_s r0,0x1
L_8c7ba8:
	sub_s.ne r0,r0,r0
L_8c7baa:
	ldb r19,[r14, 0x9]
L_8c7bae:
	brne r0,0x1,L_8c7c0c
L_8c7bb2:
	bl.d L_8cdae8
L_8c7bb6:
	mov_s r0,r19
L_8c7bb8:
	brne r0,0x1,L_8c7c0c
L_8c7bbc:
	brne_s r15,0,L_8c7bc8
L_8c7bbe:
	mov_s r0,r13
L_8c7bc0:
	bl.d L_8c588c
L_8c7bc4:
	ldb_s r1,[r14,0xa]
L_8c7bc6:
	breq_s r0,0,L_8c7bf0
	.global L_8c7bc8
L_8c7bc8:
	mov_s r2,0x100a78c
L_8c7bce:
	mov_s r0,0x7
L_8c7bd0:
	mov_s r1,0x2
L_8c7bd2:
	bl.d L_8edfcc
L_8c7bd6:
	mov_s r3,r19
L_8c7bd8:
	ldb_s r1,[r14,0xb]
L_8c7bda:
	add r0,r13,0xc
L_8c7bde:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8c7be0:
	add1_s r1,r1,r1
L_8c7be2:
	add_s r0,r0,r1
L_8c7be4:
	bl.d L_8c1fc4
L_8c7be8:
	mov_s r1,r14
L_8c7bea:
	st r16,[r14, 0x24]
L_8c7bee:
	b_s L_8c7c1a
	.global L_8c7bf0
L_8c7bf0:
	mov_s r2,0x100a7d0
L_8c7bf6:
	mov_s r0,0x7
L_8c7bf8:
	mov_s r1,0x2
L_8c7bfa:
	bl.d L_8edfcc
L_8c7bfe:
	ldb_s r3,[r14,0x9]
L_8c7c00:
	mov_s r0,r13
L_8c7c02:
	mov_s r1,r14
L_8c7c04:
	bl.d L_8c6300
L_8c7c08:
	mov_s r2,r18
L_8c7c0a:
	b_s L_8c7c1a
	.global L_8c7c0c
L_8c7c0c:
	mov_s r0,r13
L_8c7c0e:
	bl.d L_8c1fc4
L_8c7c12:
	mov_s r1,r14
L_8c7c14:
	bl.d L_8d5244
L_8c7c18:
	mov_s r0,r14
	.global L_8c7c1a
L_8c7c1a:
	mov_s r0,0x1dfc0
L_8c7c20:
	ldb_s r1,[r14,0x9]
L_8c7c22:
	mov_s r2,0x0
L_8c7c24:
	bl.d L_8c2ac8
L_8c7c28:
	mov_s r3,0x1
L_8c7c2a:
	ld r0,[r18, 0x14]
L_8c7c2e:
	cmp_s r0,0x0
L_8c7c30:
	bl.eq.d L_8cdf50
L_8c7c34:
	mov.eq r0,r17
L_8c7c38:
	b L_8c030c
