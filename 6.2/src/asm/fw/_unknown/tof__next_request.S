/* tof__next_request @ 0x8e0b58, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] Non-associated state...
 * Зовут его: tof_mgr, tof_mgr__ftm_error_handler, tof_mgr__ftm_req_done, tof_mgr__ftm_req_handle, tof_mgr__ftm_req_handle_8cb350
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit0, llist__pop_front, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof__next_request
tof__next_request:
	.global L_8e0b58
L_8e0b58:
	push_s blink
L_8e0b5a:
	bl L_8c01e4
L_8e0b5e:
	ld_s r1,[r0]
L_8e0b60:
	sub.f r1,r1,0x0
L_8e0b64:
	mov.ne r1,0x1
L_8e0b68:
	extb.f 0x0,r1
L_8e0b6c:
	beq_s L_8e0bc2
L_8e0b6e:
	bl L_8e2674
L_8e0b72:
	mov.f r14,r0
L_8e0b76:
	beq_s L_8e0bc2
L_8e0b78:
	ldb_s r0,[r14,0x8]
L_8e0b7a:
	mov_s r13,0x806518
L_8e0b80:
	st_s r0,[r13,0x18]
L_8e0b82:
	add r0,r14,0x10
L_8e0b86:
	st_s r0,[r13,0x1c]
L_8e0b88:
	st_s r14,[r13,0x20]
L_8e0b8a:
	bl.d L_8cc3dc
L_8e0b8e:
	mov_s r0,0x0
L_8e0b90:
	ld_s r0,[r0,0x4c]
L_8e0b92:
	cmp_s r0,0x2
L_8e0b94:
	mov_s r0,0x1
L_8e0b96:
	sub_s.ne r0,r0,r0
L_8e0b98:
	extb.f 0x0,r0
L_8e0b9c:
	mov.ne r0,r13
L_8e0ba0:
	mov_s r1,0x0
L_8e0ba2:
	bne_s L_8e0bb4
L_8e0ba4:
	mov_s r1,0x1019810
L_8e0baa:
	bl.d L_8dcba8
L_8e0bae:
	mov_s r0,0x2b
L_8e0bb0:
	mov_s r0,r13
L_8e0bb2:
	mov_s r1,0x3
	.global L_8e0bb4
L_8e0bb4:
	mov_s r2,r14
L_8e0bb6:
	mov_s r3,0x0
L_8e0bb8:
	bl.d L_8d9b6c
L_8e0bbc:
	mov_s r4,r3
L_8e0bbe:
	mov_s r0,0x1
L_8e0bc0:
	b_s L_8e0bc4
	.global L_8e0bc2
L_8e0bc2:
	mov_s r0,0x0
	.global L_8e0bc4
L_8e0bc4:
	b L_8c0254
