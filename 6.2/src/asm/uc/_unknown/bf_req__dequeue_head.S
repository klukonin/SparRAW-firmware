/* bf_req__dequeue_head @ 0x921b38, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__reset_sta, bf_sm__process_request_fifo
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf__abort_step, sta__apply_bf_result
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_req__dequeue_head
bf_req__dequeue_head:
	.global L_921b38
L_921b38:
	push_s blink
L_921b3a:
	bl L_92022c
L_921b3e:
	push_s r0
L_921b40:
	mov_s r16,r1
L_921b42:
	lr r13,[0xa]
L_921b46:
	bclr r0,r13,0x1
L_921b4a:
	flag r0
L_921b4e:
	mov_s r1,0x80207c
L_921b54:
	ld_s r0,[r1,0x40]
L_921b56:
	mov_s r2,0x8020b4
L_921b5c:
	bmsk r14,r0,0x2
L_921b60:
	ldb_s r14,[r2,r14]
L_921b62:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_921b64:
	st_s r0,[r1,0x40]
L_921b66:
	ld_s r0,[r1,0x34]
L_921b68:
	asl_s r15,r14,0x2
L_921b6a:
	bclr r0,r0,r14
L_921b6e:
	st_s r0,[r1,0x34]
L_921b70:
	add2_s r15,r15,r15
L_921b72:
	mov_s r0,0x0
L_921b74:
	add r3,r15,0x801ffc
L_921b7c:
	st_s r0,[r3]
L_921b7e:
	ld_s r0,[r1,0x34]
L_921b80:
	breq_s r0,0,L_921ba4
L_921b82:
	ld_s r0,[r1,0x40]
L_921b84:
	bmsk_s r0,r0,0x2
L_921b86:
	ldb_s r0,[r2,r0]
L_921b88:
	mov_s r2,0x80217c
L_921b8e:
	asl_s r1,r0,0x4
L_921b90:
	add2_s r1,r1,r1
L_921b92:
	add_s r1,r1,0x801124
L_921b98:
	ld_s r3,[r1,0x10]
L_921b9a:
	ldw_s r1,[r1,0x14]
L_921b9c:
	st_s r3,[r2,0xc]
L_921b9e:
	bl.d L_921824
L_921ba2:
	stw_s r1,[r2,0x10]
	.global L_921ba4
L_921ba4:
	brne r16,0x0,L_921bc0
L_921ba8:
	ld_s r0,[sp,0x0]
L_921baa:
	bl.d L_921ca8
L_921bae:
	mov_s r1,r14
L_921bb0:
	mov_s r1,0x8020fc
L_921bb6:
	ld_s r0,[r1,0x20]
L_921bb8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_921bba:
	st_s r0,[r1,0x20]
L_921bbc:
	st.as r0,[gp,-0xc]
	.global L_921bc0
L_921bc0:
	lr r0,[0xa]
L_921bc4:
	bic r13,r13,-0x3
L_921bc8:
	or_s r13,r13,r0
L_921bca:
	flag r13
L_921bce:
	b.d L_920294
L_921bd2:
	add_s sp,sp,0x4
