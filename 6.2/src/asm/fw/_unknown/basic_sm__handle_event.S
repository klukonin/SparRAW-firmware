/* basic_sm__handle_event @ 0x8d9b6c, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__assoc_ntf, PS_CONNECTION__awake_peer_ntf, PS_CONNECTION__disassoc_ntf, PS_CONNECTION__psc_complete_8e1794, PS_NONASSOC_SM__ps_reenter_done, ba__retry_flow, ba_setup_sm__action_8f0c54, ba_setup_sm__action_8f7fdc, ba_setup_sm__addba_req_retry_timeout_cb, ba_setup_sm__addba_resp_timeout_cb
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, basic_sm__do_transition, fw_sysassert_fatal, stream_mgr__check_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global basic_sm__handle_event
basic_sm__handle_event:
	.global L_8d9b6c
L_8d9b6c:
	push_s blink
L_8d9b6e:
	bl L_8c01cc
L_8d9b72:
	mov_s r14,r0
L_8d9b74:
	mov_s r20,r1
L_8d9b76:
	mov_s r19,r2
L_8d9b78:
	mov_s r18,r3
L_8d9b7a:
	ldb_s r1,[r0,0x2]
L_8d9b7c:
	mov r17,0xff
L_8d9b80:
	mov r16,r4
L_8d9b84:
	mov_s r15,0x0
L_8d9b86:
	brne r1,r17,L_8d9bfc
	.global L_8d9b8a
L_8d9b8a:
	mov_s r0,r14
L_8d9b8c:
	mov_s r1,r20
L_8d9b8e:
	mov_s r2,r19
L_8d9b90:
	mov_s r3,r18
L_8d9b92:
	bl.d L_8ca2d0
L_8d9b96:
	mov r4,r16
L_8d9b9a:
	b_s L_8d9bf2
	.global L_8d9b9c
L_8d9b9c:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d9b9e:
	cmp_s r15,0x14
L_8d9ba0:
	mov.cc r0,blink
L_8d9ba4:
	mov.cc r1,0x31
L_8d9ba8:
	bl.cc.d L_8c9b28
L_8d9bac:
	bset.cc r1,r1,0xc
L_8d9bb0:
	ldb_s r0,[r14,0x2]
L_8d9bb2:
	cmp_s r0,0x4
L_8d9bb4:
	mov.ge r0,blink
L_8d9bb8:
	mov.ge r1,0x16b1
L_8d9bc0:
	bl.ge L_8c9b28
L_8d9bc4:
	ldb_s r1,[r14,0x2]
L_8d9bc6:
	mov r16,0x803cbc
L_8d9bce:
	add r13,r16,0x14
L_8d9bd2:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8d9bd4:
	mov_s r0,0xff
L_8d9bd6:
	stb_s r0,[r14,0x2]
L_8d9bd8:
	add_s r13,r13,r1
L_8d9bda:
	ld r4,[r13, 0xc]
L_8d9bde:
	mov_s r0,r14
L_8d9be0:
	ld_s r1,[r13]
L_8d9be2:
	ld_s r2,[r13,0x4]
L_8d9be4:
	bl.d L_8ca2d0
L_8d9be8:
	ld_s r3,[r13,0x8]
L_8d9bea:
	mov_s r0,r16
L_8d9bec:
	bl.d L_8caed0
L_8d9bf0:
	mov_s r1,r13
	.global L_8d9bf2
L_8d9bf2:
	ldb_s r0,[r14,0x2]
L_8d9bf4:
	brne r0,r17,L_8d9b9c
L_8d9bf8:
	b L_8c0224
	.global L_8d9bfc
L_8d9bfc:
	mov_s r0,blink
L_8d9bfe:
	mov_s r1,0x16a1
L_8d9c04:
	bl L_8c9b28
L_8d9c08:
	b_s L_8d9b8a
L_8d9c0a:
	nop_s
L_8d9c0c:
	mov_s r2,0x0
L_8d9c0e:
	st_s r2,[r0,0x8]
L_8d9c10:
	mov_s r1,0x1
L_8d9c12:
	mov_s r3,r2
L_8d9c14:
	b.d L_8d9b6c
L_8d9c18:
	mov_s r4,r2
L_8d9c1a:
	nop_s
L_8d9c1c:
	mov_s r2,0x0
L_8d9c1e:
	st_s r2,[r0,0x28]
L_8d9c20:
	mov_s r1,0x2
L_8d9c22:
	mov_s r3,r2
L_8d9c24:
	b.d L_8d9b6c
L_8d9c28:
	mov_s r4,r2
L_8d9c2a:
	nop_s
L_8d9c2c:
	mov_s r2,0x0
L_8d9c2e:
	st_s r2,[r0,0xc]
L_8d9c30:
	mov_s r1,0x2
L_8d9c32:
	mov_s r3,r2
L_8d9c34:
	b.d L_8d9b6c
L_8d9c38:
	mov_s r4,r2
L_8d9c3a:
	nop_s
